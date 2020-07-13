/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#include "PosRecTimeLikeAlg.h"
#include "SniperKernel/AlgFactory.h"
#include "FCNHelper.h"
#include "TFile.h"
#include "TH1D.h"
#include <boost/filesystem.hpp>

using std::endl;
namespace fs = boost::filesystem;

DECLARE_ALGORITHM(PosRecTimeLikeAlg);

PosRecTimeLikeAlg::PosRecTimeLikeAlg(const std::string & name) : AlgBase(name),
	m_iEvt(0), 
	clusterHits(1,-500,1750), 
	riseTimeFunctor(&(FCNHelper::FCN),4) { 
    declProp("MinimizerType", type= "Minuit2" );
    declProp("MinimizerAlgorithm", algorithm = "Migrad" );
	declProp("PrintLevel", printLevel = 1);
    declProp("File_path", File_path = "$RECTIMELIKEALGROOT/share/elec");
	declProp("Tolerance", tolerance = 0.1);
	declProp("UseFirstHitOnly", use_firstHitOnly = false);
};

PosRecTimeLikeAlg::~PosRecTimeLikeAlg() {
};

#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "SmartRecHelperSvc/SmartRecHelperSvc.h"
#include "Math/Factory.h"
bool PosRecTimeLikeAlg::initialize() {
	LoadPdf();

	//Event navigator
	LogInfo << objName()
		<< " Loading NavBuffer"
		<< endl;
	// SniperDataPtr is a wrapper of RefBase.(data(), invalid());
	// SniperDataPtr will check DataMemSvc.
	// they are both defined in SniperKernel
	SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
	if ( navBuf.invalid() ) {
		LogError << "cannot get the NavBuffer @ /Event" << std::endl;
		return false;
	}
	// NavBuffer is the DataBuffer of EvtNavigator, former defined in SniperUtil
	m_buf = navBuf.data();
	LogInfo << objName()
		<< " buffer loaded: "<<m_buf << " "
		<< m_buf->size() <<" entries" 
		<< endl;

	SniperPtr<SmartRecHelperSvc> helperSvc(getScope(), "SmartRecHelperSvc");
	if(helperSvc.invalid() ) {
		LogError << "can not find the service SmartRecHelperSvc"<<std::endl;
		return false;
	}
	m_helperSvc = helperSvc.data();
	LogInfo << objName()
		<< " SmartRecHelperSvc loaded: "<<m_helperSvc<< 
		endl;

	// SniperPtr<DataRegistritionSvc> drsSvc(getScope(),"DataRegistritionSvc");         
	// if ( ! drsSvc.valid() ) {
	// 	LogError << "Failed to get DataRegistritionSvc instance!" << endl;      
	// 	return false;
	// }   
	// LogInfo << objName()
	// 	<< " DataRegistritionSvc loaded: "<<drsSvc.data()
	// << endl;

	// drsSvc->registerData("JM::RecEvent","/Event/Rec");    
	// LogInfo << objName()
	// 	<< " /Event/Rec/JM::RecEvent registered"
	// 	<< endl;


	minimizer = ROOT::Math::Factory::CreateMinimizer(type, algorithm);
	minimizer->SetPrintLevel(printLevel);
	minimizer->SetStrategy(1);
	minimizer->SetMaxFunctionCalls(1000000);
	minimizer->SetMaxIterations(5000);
	minimizer->SetTolerance(tolerance);

	FCNHelper::SetAlg(this);

	LogInfo << objName()
		<< " initialized successfully"
		<< endl;
	return true;
};

#include "Identifier/Identifier.h"

bool PosRecTimeLikeAlg::execute() {
	++m_iEvt; 
	LogInfo << "---------------------------------------" << std::endl; 
	LogInfo << "Processing event " << m_iEvt << std::endl; 

	JM::EvtNavigator* nav = m_buf->curEvt(); 
	LogDebug << "Valid path size: "<<nav->getPath().size() << endl;
	for(unsigned int i = 0;i<nav->getPath().size();++i) {
		LogDebug << "N["<<i<<"] :"<<nav->getPath().at(i) << endl;
	}

	LogDebug << "trying to fetch the CalibHeader for this event."<< endl;
	JM::CalibHeader* chcol =(JM::CalibHeader*) nav->getHeader("/Event/Calib"); 
	if(chcol)
		LogDebug << "succeeded: "<< chcol <<endl;
	else {
		LogError << "got empty pointer EvtNavigator::getHeader(\"/Event/Calib\");"
			<<endl;
		return false;
	}
	chhlistptr = &(chcol->event()->calibPMTCol()); 
	LogDebug << chhlistptr->size() <<" CalibPMTChannel loaded."<<endl;

	originRecHeader = nullptr;
	FitRecPos(); // Fill recHeader

	JM::RecHeader *tmp_recHeader = dynamic_cast<JM::RecHeader*>(nav->getHeader("/Event/Rec"));
	if(tmp_recHeader) {
		*tmp_recHeader = *recHeader;
	} else {
		nav->addHeader("/Event/PosRecTimeLike", recHeader); 
	}
	return true;
};

bool PosRecTimeLikeAlg::finalize() {
	LogInfo << objName()
		<< " finalized successfully"
		<< endl;
	return true;
};

bool PosRecTimeLikeAlg::LoadInitialpos() {
	LogDebug << "trying to load the RecHeader for this event."<< endl;
	JM::EvtNavigator* nav = m_buf->curEvt(); 
	if(!originRecHeader) 
		originRecHeader=(JM::RecHeader*) nav->getHeader("/Event/Rec"); 
	if(originRecHeader) {
		LogDebug << "succeeded: "<< originRecHeader <<endl;
		LogDebug << "trying to load the recPos from the RecHeader."<< endl;
		rec_x = originRecHeader->x();
		rec_y = originRecHeader->y();
		rec_z = originRecHeader->z();
		// set sigma
		double rec_r = sqrt(rec_x*rec_x+rec_y*rec_y+rec_z*rec_z)/1000;
		sigma_x = sigma_y = sigma_z = (6+0.1*rec_r+0.02*rec_r*rec_r)*100;
	} else {
		LogError << "got empty pointer EvtNavigator::getHeader(\"/Event/Rec\");"
			<<" you must do time like rec first. otherwise this method won't work"
			<<endl;
		rec_x = rec_y = rec_z = 0;
		sigma_x = sigma_y = sigma_z = 17700/3.;
		return false;
	}

	recPos.SetXYZ(rec_x,rec_y,rec_z);
	m_helperSvc->CorrectTOFAndCollectHits(recPos,*chhlistptr,clusterHits); // automatically sorted
	bool found = FindPeakAndStart();
	if(!found) return false;
	peak_t = clusterHits.GetBinCenter(peak_i);
	sigma_t = 36*1.732*3*1.1+clusterHits.GetBinWidth();

	LogDebug << "succeeded: "<< rec_x<<" "<<rec_y<<" "<<rec_z <<" "<<peak_t<<
		" : "<<sigma_x<<" "<<rec_y<<" "<<rec_z <<" "<<sigma_t<<
		endl;
	return true;
}

#include "TStopwatch.h"
bool PosRecTimeLikeAlg::FitRecPos() {
	TStopwatch timer;
	timer.Start();

	PrepareInput();

	minimizer->Clear();
	minimizer->SetFunction(riseTimeFunctor);

	bool ok = LoadInitialpos();
	if(!ok) return false;

	minimizer->SetLimitedVariable(0,"rec_x",rec_x,sigma_x*3,rec_x-sigma_x*3,rec_x+sigma_x*3);
	minimizer->SetLimitedVariable(1,"rec_y",rec_y,sigma_y*3,rec_y-sigma_y*3,rec_y+sigma_y*3);
	minimizer->SetLimitedVariable(2,"rec_z",rec_z,sigma_z*3,rec_z-sigma_z*3,rec_z+sigma_z*3);
	minimizer->SetLimitedVariable(3,"t_0",peak_t,sigma_t*3,peak_t-sigma_t*3,peak_t+sigma_t*3);

	minimizer->Minimize();

	const double *rec = minimizer->X();

	recPos.SetX(rec[0]);
	recPos.SetY(rec[1]);
	recPos.SetZ(rec[2]);
	t0 = rec[3];
	const double goodness = minimizer->MinValue();

    timer.Stop();
    double time = timer.RealTime();
	LogInfo<<"==========================================================="<<std::endl;
	LogInfo<<"The initial guess x is "<<rec_x<<" ± "<<sigma_x<<std::endl;
	LogInfo<<"The initial guess y is "<<rec_y<<" ± "<<sigma_y<<std::endl;
	LogInfo<<"The initial guess z is "<<rec_z<<" ± "<<sigma_z<<std::endl;
	LogInfo<<"The initial guess t0 is "<<peak_t<<" ± "<<sigma_t<<std::endl;
	LogInfo<<"The initial goodness is "<<Form("%.12lf",originRecHeader->positionQuality())<<endl;
	LogInfo<<"The Reconstructed x is "<<recPos.X()<<std::endl;
	LogInfo<<"The Reconstructed y is "<<recPos.Y()<<std::endl;
	LogInfo<<"The Reconstructed z is "<<recPos.Z()<<std::endl;
	LogInfo<<"The Reconstructed t0 is "<<t0<<endl;
	LogInfo<<"The minimized goodness is "<<Form("%.12lf",goodness)<<endl;
    LogInfo<<"The Reconstruction Process Cost "<<time<<std::endl;
	LogInfo<<"==========================================================="<<std::endl;

	if(!originRecHeader)
		recHeader = new JM::RecHeader;
	else
		recHeader = originRecHeader;
	recHeader->setX(recPos.X());
	recHeader->setY(recPos.Y());
	recHeader->setZ(recPos.Z());
	recHeader->setPositionQuality(goodness);
	return true;
}

bool PosRecTimeLikeAlg::FindPeakAndStart() {
	unsigned int peak_N = 0;
	for(unsigned int scan = 1;scan<clusterHits.GetNbins()-1;++scan) {
		if(clusterHits.GetEntries(scan-1,scan+1)>peak_N) {
			peak_i = scan;
			peak_N = clusterHits.GetEntries(scan-1,scan+1);
		}
	}
	//	LogDebug<<"pk_i: "<<peak_i<<" --> "<<clusterHits.GetBinCenter(peak_i)<<endl;
	const double ns_to_s = 1e-9;
	const double N_dark_hit = m_helperSvc->GetExpectedDarkHit()*clusterHits.GetBinWidth()*ns_to_s;
	if(peak_N<=m_helperSvc->PoissonUpperLimit(N_dark_hit)) {
		LogWarn<<"no signal in this event."<<endl;
		return false;
	}
	start_i = peak_i;
	for(unsigned int scan = peak_i;scan>0;--scan) {
		if(clusterHits.GetEntries(scan-1)<=m_helperSvc->PoissonUpperLimit(N_dark_hit)) {
			start_i = scan;
			break;
		}
	}

	LogDebug <<" found the rise: "<<
		clusterHits.GetBinCenter(start_i)<<" to "<<
		clusterHits.GetBinCenter(peak_i)<<" (ns) "<<
		"darkhit "<<N_dark_hit<<
		" entries from ("<<clusterHits.GetEntries(start_i-1)<<") "
		<<clusterHits.GetEntries(start_i)<<
		" to "<<clusterHits.GetEntries(peak_i)<<
		" ("<<clusterHits.GetEntries(peak_i+1)<<")"<<
		endl;
	return true;
}

void PosRecTimeLikeAlg::LoadParameters(const double *params) {
	recPos.SetX(params[0]);
	recPos.SetY(params[1]);
	recPos.SetZ(params[2]);
	t0 = params[3];
}

bool PosRecTimeLikeAlg::LoadPdf() {
   fs::path s(File_path);
   Time_1hit = TFile::Open(TString((s/"pdf_n1.root").string()));
   Time_2hit = TFile::Open(TString((s/"pdf_n2.root").string()));
   Time_3hit = TFile::Open(TString((s/"pdf_n3.root").string()));
   Time_4hit = TFile::Open(TString((s/"pdf_n4.root").string()));
   Time_5hit = TFile::Open(TString((s/"pdf_n5.root").string()));
  
   if(!Time_1hit)
   LogError  << "Failed to get Likelihood Function File!" << std::endl;

   TH1D *tmp = new TH1D; // bug of root. see https://root.cern.ch/phpBB3/viewtopic.php?f=3&t=12358
   pdf_1hit = (TH1D*)Time_1hit->Get("tim");
   pdf_2hit = (TH1D*)Time_2hit->Get("tim");
   pdf_3hit = (TH1D*)Time_3hit->Get("tim");
   pdf_4hit = (TH1D*)Time_4hit->Get("tim");
   pdf_5hit = (TH1D*)Time_5hit->Get("tim");
   delete tmp;

   pdf_1hit->Scale(1./pdf_1hit->Integral("width"));
   pdf_2hit->Scale(1./pdf_2hit->Integral("width"));
   pdf_3hit->Scale(1./pdf_3hit->Integral("width"));
   pdf_4hit->Scale(1./pdf_4hit->Integral("width"));
   pdf_5hit->Scale(1./pdf_5hit->Integral("width"));
   
   LogDebug<<Time_5hit<<" "<<Time_5hit->Get("tim")<<endl;
   LogDebug<<pdf_5hit<<" "<<"pdf_5hit->GetRMS() "<<pdf_5hit->GetMean()<<endl;
   return true;
}

bool PosRecTimeLikeAlg::Goodness() {
	if(recPos.Mag()>17.7e3) {
		goodness = 4e10*recPos.Mag2();
		LogTest << "Current recPos: "<<recPos.X()<<" "<<recPos.Y()<<" "<<recPos.Z()<<" "<<t0<<" "<<goodness<<endl; 
		return true;
	}
	double sum = 0;
	unsigned int NDF = 0;
	list<double>::iterator time_vIt = time_v.begin();
	list<unsigned int>::iterator pmtId_vIt = pmtId_v.begin();
	list<double>::iterator charge_vIt = charge_v.begin();
	for(; time_vIt!=time_v.end(); ++time_vIt,++pmtId_vIt,++charge_vIt) {
		double delay = (*time_vIt)-t0-m_helperSvc->TOF(recPos,*pmtId_vIt);
		if(delay<-200||delay>500) continue;
		double charge = (*charge_vIt);
		double pdf;
//#define FAST_PDF
#ifdef FAST_PDF
		int bin = (int)((delay+200)*200/7);
#define VAR bin
#define CALCULATE(VAR) GetBinContent(VAR)
#else
#define VAR delay
#define CALCULATE(VAR) Interpolate(VAR)
#endif
		if( charge < 1. ) 
			pdf = pdf_1hit->CALCULATE(VAR);
		else if( charge < 2. ) 
			pdf = (2.-charge) * pdf_1hit->CALCULATE(VAR) + (charge-1.) * pdf_2hit->CALCULATE(VAR) ;
		else if( charge < 3. ) 
			pdf = (3.-charge) * pdf_2hit->CALCULATE(VAR) + (charge-2.) * pdf_3hit->CALCULATE(VAR);
		else if( charge < 4. )
			pdf = (4.-charge) * pdf_3hit->CALCULATE(VAR) + (charge-3.) * pdf_4hit->CALCULATE(VAR);
		else if( charge < 5. ) 
			pdf= (5.-charge) * pdf_4hit->CALCULATE(VAR) + (charge-4.) * pdf_5hit->CALCULATE(VAR);
		else 
			pdf = pdf_5hit->CALCULATE(VAR);
		if(pdf<0) {
			LogWarn <<"pdf <=0: "<<delay<<" "<<charge<<" "<<pdf<<endl;
			continue;
		}
		if(pdf>1e-3) {
			sum -= log(pdf);
			++NDF;
		}
	}
	if(NDF>0) {
		goodness = sum/NDF;
	} else {
		goodness = 1e10;
	}
	LogTest << "Current recPos: "<<recPos.X()<<" "<<recPos.Y()<<" "<<recPos.Z()<<" "<<t0<<" "<<goodness<<endl; 
	return true;
}

bool PosRecTimeLikeAlg::PrepareInput() {
	pmtId_v.clear();
	time_v.clear();
	charge_v.clear();
	if(use_firstHitOnly) {
		for(list<JM::CalibPMTChannel*>::const_iterator chhlistptrIt = chhlistptr->begin();
				chhlistptrIt != chhlistptr->end(); ++chhlistptrIt) {
			JM::CalibPMTChannel *channel = *chhlistptrIt;
			pmtId_v.push_back(CdID::module(Identifier(channel->pmtId())));
			time_v.push_back(channel->firstHitTime());
			charge_v.push_back(channel->nPE());
		}
	} else {
		for(list<JM::CalibPMTChannel*>::const_iterator chhlistptrIt = chhlistptr->begin();
				chhlistptrIt != chhlistptr->end(); ++chhlistptrIt) {
			JM::CalibPMTChannel *channel = *chhlistptrIt;
			for(unsigned int hit_i = 0; hit_i < channel->time().size(); ++hit_i) {
				pmtId_v.push_back(CdID::module(Identifier(channel->pmtId())));
				time_v.push_back(channel->time().at(hit_i));
				charge_v.push_back(channel->charge().at(hit_i));
			}
		}
	}
	return true;
}

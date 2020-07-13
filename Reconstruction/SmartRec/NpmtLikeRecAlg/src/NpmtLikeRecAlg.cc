/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#include "NpmtLikeRecAlg.h"
#include "SniperKernel/AlgFactory.h"
#include "FCNHelper.h"
#include "TFile.h"
#include "TH1D.h"
#include <boost/filesystem.hpp>
#include "Event/ClusterHeader.h"
#include "Event/ClusterEvent.h"

using std::endl;
namespace fs = boost::filesystem;

DECLARE_ALGORITHM(NpmtLikeRecAlg);

NpmtLikeRecAlg::NpmtLikeRecAlg(const std::string & name) : AlgBase(name),
	m_iEvt(0), 
	clusterHits(1,-500,1750), 
	riseTimeFunctor(&(FCNHelper::FCN),1) { 
    declProp("MinimizerType", type= "Minuit2" );
    declProp("MinimizerAlgorithm", algorithm = "Migrad" );
	declProp("PrintLevel", printLevel = 0);
	declProp("Tolerance", tolerance = 0.1);
	declProp("LY", ly = 2000);
	declProp("Use3inchPMT", use_3inchPMT= false);
	declProp("CalibInputPath",m_calibInputPath = "/Event/Calib"); 
	declProp("RecInputPath",m_recInputPath = "/Event/Rec"); 
	declProp("RecOutputPath",m_recOutputPath = "/Event/Rec"); 
	declProp("ClusterInputPath",m_clusterInputPath = "/Event/Cluster"); 
};

NpmtLikeRecAlg::~NpmtLikeRecAlg() {
};

#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "SmartRecHelperSvc/SmartRecHelperSvc.h"
#include "Math/Factory.h"
bool NpmtLikeRecAlg::initialize() {
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

bool NpmtLikeRecAlg::execute() {
	++m_iEvt; 
	LogDebug<< "---------------------------------------" << std::endl; 
	LogDebug<< "Processing event " << m_iEvt << std::endl; 

	JM::EvtNavigator* nav = m_buf->curEvt(); 
	LogDebug << "Valid path size: "<<nav->getPath().size() << endl;
	for(unsigned int i = 0;i<nav->getPath().size();++i) {
		LogDebug << "N["<<i<<"] :"<<nav->getPath().at(i) << endl;
	}

	LogDebug << "trying to fetch the CalibHeader for this event."<< endl;
	JM::CalibHeader* chcol =(JM::CalibHeader*) nav->getHeader(m_calibInputPath); 
	if(chcol)
		LogDebug << "succeeded: "<< chcol <<endl;
	else {
		LogError << "got empty pointer EvtNavigator::getHeader(\""<<m_calibInputPath<<"\");"
			<<endl;
		return false;
	}
	chhlistptr = &(chcol->event()->calibPMTCol()); 
	LogDebug << chhlistptr->size() <<" CalibPMTChannel loaded."<<endl;

	LogDebug << "trying to fetch the ClusterHeader for this event."<< endl;
	JM::ClusterHeader* clusterHeader =(JM::ClusterHeader*) nav->getHeader(m_clusterInputPath); 
	if(clusterHeader)
		LogDebug << "succeeded: "<< clusterHeader <<endl;
	else {
		LogError << "got empty pointer EvtNavigator::getHeader(\""<<m_clusterInputPath<<"\");"
			<<endl;
		return false;
	}
  m_clusterLength = clusterHeader->event()->length();
	LogDebug << "Cluster length loaded: "<<m_clusterLength<<" (ns)"<<endl;

	originRecHeader = nullptr;
	bool ok = FitRecPos(); // Fill recHeader
	if(!ok) {
		npe = -1;
		goodness = 1e20;
	}

	if(m_recOutputPath!=m_recInputPath) {
		nav->addHeader(m_recOutputPath, recHeader); 
	}
	return true;
};

bool NpmtLikeRecAlg::finalize() {
	LogInfo << objName()
		<< " finalized successfully"
		<< endl;
	return true;
};

double NpmtLikeRecAlg::originX() { return originRecHeader->cdEvent()->x(); };
double NpmtLikeRecAlg::originY() { return originRecHeader->cdEvent()->y(); };
double NpmtLikeRecAlg::originZ() { return originRecHeader->cdEvent()->z(); };
double NpmtLikeRecAlg::originPosQuality() { return originRecHeader->cdEvent()->positionQuality(); };

bool NpmtLikeRecAlg::LoadInitialpos() {
	LogDebug << "trying to load the RecHeader for this event."<< endl;
	JM::EvtNavigator* nav = m_buf->curEvt(); 
	if(!originRecHeader) 
		originRecHeader=(JM::RecHeader*) nav->getHeader(m_recInputPath);
	if(originRecHeader) {
		LogDebug << "succeeded: "<< originRecHeader <<endl;
		LogDebug << "trying to load the recPos from the RecHeader."<< endl;
		recPos.SetXYZ(originX(),originY(),originZ());
	} else {
		LogError << "got empty pointer EvtNavigator::getHeader(\"/Event/Rec\");"
			<<" you must do time like rec first. otherwise this method won't work"
			<<endl;
		return false;
	}
	npe0 = 2000;
	npe_sigma = 2000;

	LogDebug << "succeeded: "<< recPos.X() <<" "<<recPos.Y()<<" "<<recPos.Z()<<endl;
	return true;
}

#include "TStopwatch.h"
bool NpmtLikeRecAlg::FitRecPos() {
	TStopwatch timer;
	timer.Start();

	bool ok = LoadInitialpos();
	if(!ok) return false;

	bool prepared = PrepareInput();
	if(!prepared) return false;

	minimizer->Clear();
	minimizer->SetFunction(riseTimeFunctor);


	//minimizer->SetLimitedVariable(0,"npe",npe0,npe_sigma*3,(npe0>npe_sigma*3?npe0-npe_sigma*3:0),npe0+npe_sigma*3);
	minimizer->SetLimitedVariable(0,"npe",2000,200,0,200000000);

	minimizer->Minimize();

	const double *rec_npe = minimizer->X();
	npe = rec_npe[0];

	const double goodness = minimizer->MinValue();

    timer.Stop();
    double time = timer.RealTime();
	LogInfo<<"==========================================================="<<std::endl;
	LogInfo<<"The x is fixed from pos rec to "<<recPos.X()<<std::endl;
	LogInfo<<"The y is fixed from pos rec to "<<recPos.Y()<<std::endl;
	LogInfo<<"The z is fixed from pos rec to "<<recPos.Z()<<std::endl;
	LogInfo<<"The pos rec goodness is "<<Form("%.12lf",originPosQuality())<<std::endl;
	LogInfo<<"The initial guess for npe is "<<npe0<<" ± "<<npe_sigma<<std::endl;
	LogInfo<<"The reconstructed        npe is "<<npe<<std::endl;
	LogInfo<<"The reconstructed qch energy is "<<npe/ly<<std::endl;
	LogInfo<<"The reconstructed     energy is "<<npe/qch(npe)/ly<<std::endl;
	LogInfo<<"The energy reconstructon goodness is "<<goodness<<std::endl;
    LogInfo<<"The Reconstruction Process Cost "<<time<<std::endl;
	LogInfo<<"==========================================================="<<std::endl;

	if(m_recOutputPath!=m_recInputPath) {
		recHeader = new JM::RecHeader;
    JM::CDRecEvent *CD_event = new JM::CDRecEvent();
		CD_event->setX(recPos.X());
		CD_event->setY(recPos.Y());
		CD_event->setZ(recPos.Z());
		CD_event->setPositionQuality(originPosQuality());
    recHeader->setCDEvent(CD_event);
	} else
		recHeader = originRecHeader;
  JM::CDRecEvent *CD_event = recHeader->cdEvent();
	CD_event->setPESum(npe);
	CD_event->setEnergy(npe/ly);
	//recHeader->SetErec(npe/qch(npe)/ly);
	CD_event->setEnergyQuality(goodness);
	return true;
}

//bool NpmtLikeRecAlg::FindStartAndEnd() {
//	unsigned int peak_N = 0;
//	unsigned int peak_i = 0;
//	for(unsigned int scan = 1;scan<clusterHits.GetNbins()-1;++scan) {
//		if(clusterHits.GetEntries(scan-1,scan+1)>peak_N) {
//			peak_i = scan;
//			peak_N = clusterHits.GetEntries(scan-1,scan+1);
//		}
//	}
//	//	LogDebug<<"pk_i: "<<peak_i<<" --> "<<clusterHits.GetBinCenter(peak_i)<<endl;
//	const double ns_to_s = 1e-9;
//	const double N_dark_hit = m_helperSvc->GetExpectedDarkHit()*clusterHits.GetBinWidth()*ns_to_s;
//	if(peak_N<=m_helperSvc->PoissonUpperLimit(N_dark_hit)) {
//		LogWarn<<"no signal in this event."<<endl;
//		return false;
//	}
//	start_i = peak_i;
//	for(unsigned int scan = peak_i;scan>0;--scan) {
//		if(clusterHits.GetEntries(scan)==0) {
//			start_i = scan;
//			break;
//		}
//	}
//	if((peak_i-start_i)*clusterHits.GetBinWidth()>5)
//		start_i += 5./clusterHits.GetBinWidth();
//	else
//		return false;
//	end_i = peak_i;
//	for(unsigned int scan = peak_i;scan>0;++scan) {
//		if(clusterHits.GetEntries(scan)==0) {
//			end_i = scan;
//			break;
//		}
//	}
//	if((end_i-peak_i)*clusterHits.GetBinWidth()>5)
//		end_i -= 5./clusterHits.GetBinWidth();
//	else
//		return false;
//
//	LogDebug <<" found the rise: "<<
//		clusterHits.GetBinCenter(start_i)<<" to "<<
//		clusterHits.GetBinCenter(end_i)<<" (ns) "<<
//		"darkhit "<<N_dark_hit<<
//		" entries from ("<<clusterHits.GetEntries(start_i-1)<<") "
//		<<clusterHits.GetEntries(start_i)<<
//		" to "<<clusterHits.GetEntries(end_i)<<
//		" ("<<clusterHits.GetEntries(end_i+1)<<")"<<
//		endl;
//	return true;
//}

void NpmtLikeRecAlg::LoadParameters(const double *params) {
	npe = params[0];
}

bool NpmtLikeRecAlg::Goodness() {
	double logLikelihood = 0;
	for(int pmtId = 0; pmtId< CdID::module20inchNumber(); ++pmtId) {
		if(darkzone[pmtId]) continue;
		double mu = npe*weight[pmtId]+Ndarkhits;
//		LogTest<<pmtId<<" "<<npe<<" "<<weight[pmtId]<<" "<<Ndarkhits<<" "<<npe*weight[pmtId]<<" "
//			<<mu<<endl;
		//LogTest<<fired[pmtId]<<" "<<mu<<" "<<log(1-exp(-mu))<<" "
		//	<<m_helperSvc->AbsWeight(recPos,pmtId)<<" "
		//	<<m_helperSvc->AccWeight(recPos,pmtId)<<" "
		//	<<endl;
		if(fired[pmtId])
			logLikelihood -= log(1-exp(-mu));
		else
			logLikelihood += mu;
	}
	if(use_3inchPMT)
		for(int pmtId = CdID::module20inchNumber(); pmtId< CdID::module20inchNumber()+CdID::module3inchNumber(); ++pmtId) {
		}
	goodness = logLikelihood;
	LogTest<<npe<<" "<<goodness<<endl;
	return true;
}

#include "SmartRecHelperSvc/Cluster.h"
bool NpmtLikeRecAlg::PrepareInput() {
//	m_helperSvc->CorrectTOFAndCollectHits(recPos,*chhlistptr,clusterHits); // automatically sorted
//	bool found = FindStartAndEnd();
//	if(!found) return false;
	const double ns_to_s = 1e-9;
	Ndarkhits = m_helperSvc->GetDarkRate()*m_helperSvc->GetWaveformRecEff()
		*clusterHits.GetBinWidth()*ns_to_s*m_clusterLength;
	Ndarkhits_3inch = m_helperSvc->GetDarkRate3inch()*m_helperSvc->GetWaveformRecEff()
		*clusterHits.GetBinWidth()*ns_to_s*m_clusterLength;
//	vector<Cluster*> clusters;
//	m_helperSvc->WrapOneCluster(clusterHits,start_i,end_i,clusters);
//	const std::list<JM::CalibPMTChannel*> *chhlistptr = &(clusters.at(0)->calibPMTCol()); 
	std::fill(fired,fired+60000,false);
	std::fill(darkzone,darkzone+60000,false);
	std::fill(weight,weight+60000,0);
	for(int pmtId = 0; pmtId<CdID::module20inchNumber(); ++pmtId)
		if(!(darkzone[pmtId] = m_helperSvc->IsInDarkZone(recPos,pmtId)))
			weight[pmtId] = m_helperSvc->AbsWeight(recPos,pmtId)*m_helperSvc->AccWeight(recPos,pmtId)/CdID::module20inchNumber();
	for(list<JM::CalibPMTChannel*>::const_iterator chhlistptrIt = chhlistptr->begin();
			chhlistptrIt != chhlistptr->end(); ++chhlistptrIt) {
		JM::CalibPMTChannel *channel = *chhlistptrIt;
		int pmtId = CdID::module(Identifier(channel->pmtId()));
		if((pmtId>=CdID::module20inchNumber())||darkzone[pmtId]) continue;
		fired[pmtId] = true;
	}
	return true;
}
double NpmtLikeRecAlg::qch(__attribute__((unused))double npe) {
	return 1;
}

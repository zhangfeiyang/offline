/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#include "SteepRiseAlg.h"
#include "SniperKernel/AlgFactory.h"

using std::endl;

DECLARE_ALGORITHM(SteepRiseAlg);

SteepRiseAlg *FCNHelper::fAlg = nullptr;

SteepRiseAlg::SteepRiseAlg(const std::string & name) : AlgBase(name),
	m_iEvt(0), 
	clusterHits(1,-500,1750), 
	riseTimeFunctor(&(FCNHelper::FCN),3) { 
    declProp("MinimizerType", type= "Minuit2" );
    declProp("MinimizerAlgorithm", algorithm = "Migrad" );
	declProp("PrintLevel", printLevel = 1);
};

SteepRiseAlg::~SteepRiseAlg() {
};

#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "SmartRecHelperSvc/SmartRecHelperSvc.h"
#include "Math/Factory.h"
bool SteepRiseAlg::initialize() {
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

	SniperPtr<DataRegistritionSvc> drsSvc(getScope(),"DataRegistritionSvc");         
	if ( ! drsSvc.valid() ) {
		LogError << "Failed to get DataRegistritionSvc instance!" << endl;      
		return false;
	}   
	LogInfo << objName()
		<< " DataRegistritionSvc loaded: "<<drsSvc.data()
	<< endl;

	drsSvc->registerData("JM::RecEvent","/Event/Rec");    
	LogInfo << objName()
		<< " /Event/Rec/JM::RecEvent registered"
		<< endl;

   minimizer = ROOT::Math::Factory::CreateMinimizer(type, algorithm);
   minimizer->SetPrintLevel(printLevel);
   minimizer->SetMaxFunctionCalls(1000000);
   minimizer->SetMaxIterations(5000);
   minimizer->SetTolerance(0.001);

   FCNHelper::SetAlg(this);

	LogInfo << objName()
		<< " initialized successfully"
		<< endl;
	return true;
};

#include "Identifier/Identifier.h"

bool SteepRiseAlg::execute() {
	++m_iEvt; 
	LogDebug << "---------------------------------------" << std::endl; 
	LogDebug << "Processing event " << m_iEvt << std::endl; 

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

	FindSteepestRiseTime();
    nav->addHeader("/Event/SteepRise", recHeader); 

	return true;
};

bool SteepRiseAlg::finalize() {
	LogInfo << objName()
		<< " finalized successfully"
		<< endl;
	return true;
};

void SteepRiseAlg::LoadInitialpos() {
	LogDebug << "trying to load the RecHeader for this event."<< endl;
	JM::EvtNavigator* nav = m_buf->curEvt(); 
	JM::RecHeader* rech =(JM::RecHeader*) nav->getHeader("/Event/Rec"); 
	if(rech)
		LogDebug << "succeeded: "<< rech <<endl;
	else {
		LogError << "got empty pointer EvtNavigator::getHeader(\"/Event/Rec\");"
			<<endl;
	}
	LogDebug << "trying to load the recPos from the RecHeader."<< endl;
	rec_x = rech->x();
	rec_y = rech->y();
	rec_z = rech->z();
	// set sigma
	double rec_r = sqrt(rec_x*rec_x+rec_y*rec_y+rec_z*rec_z)/1000;
	sigma_x = sigma_y = sigma_z = (6+0.1*rec_r+0.02*rec_r*rec_r)*100;

	LogDebug << "succeeded: "<< rec_x<<" "<<rec_y<<" "<<rec_z <<endl;
}

#include "TStopwatch.h"
bool SteepRiseAlg::FindSteepestRiseTime() {
    TStopwatch timer;
    timer.Start();

	minimizer->Clear();
	minimizer->SetFunction(riseTimeFunctor);

	LoadInitialpos();

	minimizer->SetLimitedVariable(0,"rec_x",rec_x,sigma_x/10,rec_x-sigma_x*3,rec_x+sigma_x*3);
	minimizer->SetLimitedVariable(1,"rec_y",rec_y,sigma_y/10,rec_y-sigma_y*3,rec_y+sigma_y*3);
	minimizer->SetLimitedVariable(2,"rec_z",rec_z,sigma_z/10,rec_z-sigma_z*3,rec_z+sigma_z*3);

	minimizer->Minimize();

	const double *rec = minimizer->X();

	recPos.SetX(rec[0]);
	recPos.SetY(rec[1]);
	recPos.SetZ(rec[2]);
	const double goodness = minimizer->MinValue();

	recHeader = new JM::RecHeader();
	recHeader->setX(recPos.X());
	recHeader->setY(recPos.Y());
	recHeader->setZ(recPos.Z());
	recHeader->setPositionQuality(goodness);

    timer.Stop();
    double time = timer.RealTime();
	LogInfo<<"==========================================================="<<std::endl;
	LogInfo<<"The initial guess x is "<<rec_x<<" ± "<<sigma_x<<std::endl;
	LogInfo<<"The initial guess y is "<<rec_y<<" ± "<<sigma_y<<std::endl;
	LogInfo<<"The initial guess z is "<<rec_z<<" ± "<<sigma_z<<std::endl;
	LogInfo<<"The Reconstructed x is "<<recPos.X()<<std::endl;
	LogInfo<<"The Reconstructed y is "<<recPos.Y()<<std::endl;
	LogInfo<<"The Reconstructed z is "<<recPos.Z()<<std::endl;
	LogInfo<<"The minimized goodness is "<<goodness<<endl;
    LogInfo<<"The Reconstruction Process Cost "<<time<<std::endl;
	LogInfo<<"==========================================================="<<std::endl;
	return true;
}

bool SteepRiseAlg::FindPeakAndStart() {
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

void SteepRiseAlg::LoadParameters(const double *params) {
	recPos.SetX(params[0]);
	recPos.SetY(params[1]);
	recPos.SetZ(params[2]);
}

double SteepRiseAlg::RiseTimeGoodness() {
	LogDebug << "Current recPos: "<<recPos.X()<<" "<<recPos.Y()<<" "<<recPos.Z()<<endl; LogDebug << "Initial guess: "<<rec_x<<" "<<rec_y<<" "<<rec_z<<endl; if(recPos.Mag()>17.7e3) {
		return 4e10;
	}
	m_helperSvc->CorrectTOFAndCollectHits(recPos,*chhlistptr,clusterHits); // automatically sorted
	bool found = FindPeakAndStart();
	if(!found) return 3e10;

	//const double goodness = clusterHits.GetBinWidth()*(peak_i-start_i+1)/clusterHits.GetEntries(peak_i);
	const double goodness = -double(clusterHits.GetEntries(peak_i-1,peak_i+1));

	LogDebug<<" rise amp: "<<clusterHits.GetEntries(peak_i)/clusterHits.GetBinWidth()<<endl;
	LogDebug<<" rise mean: "<<clusterHits.GetBinCenter(peak_i)<<endl;
	LogDebug<<" rise sigma: "<<goodness<<endl;
	LogDebug<<" dark hit rate (GHz): "<<m_helperSvc->GetExpectedDarkHit()<<endl;
	return goodness;
}


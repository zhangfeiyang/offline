/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#include "ChargeCenterAlg.h"
#include "SniperKernel/AlgFactory.h"

using std::endl;

DECLARE_ALGORITHM(ChargeCenterAlg);

ChargeCenterAlg::ChargeCenterAlg(const std::string & name) : AlgBase(name),
	m_iEvt(0), 
	clusterHits(5,-500,1750) { // 1ns per bin; -500 ns to 1750 ns
	declProp("CL",CL = 0.999);
	declProp("PreWindow",m_preWindow = 0);
	declProp("PostWindow",m_postWindow = 0);
	declProp("ClusterLengthThreshold",m_clusterLengthThreshold = 10); // unit: ns
	declProp("CalibFactor",m_calibFactor = 1.040);
	declProp("ForceRec",m_forceRec = false); // for debug use.
	declProp("CalibInputPath",m_calibInputPath = "/Event/Calib"); 
	declProp("RecOutputPath",m_recOutputPath = "/Event/Rec"); 
};

ChargeCenterAlg::~ChargeCenterAlg() {
};

#include "DataRegistritionSvc/DataRegistritionSvc.h"
bool ChargeCenterAlg::initialize() {
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

	LogInfo << objName()
		<< " initialized successfully"
		<< endl;
	return true;
};


bool ChargeCenterAlg::execute() {
	++m_iEvt; 
	LogDebug << "---------------------------------------" << std::endl; 
	LogDebug << "Processing event " << m_iEvt << std::endl; 

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

	bool found = FindRecPos();
	if(!found) recPos.SetXYZ(0,0,1e10); // still write this event to keep events aligned.
	WriteToRecHeader();

	nav->addHeader(m_recOutputPath, recHeader); 

	return true;
};

bool ChargeCenterAlg::finalize() {
	LogInfo << objName()
		<< " finalized successfully"
		<< endl;
	return true;
};


bool ChargeCenterAlg::FindRecPos() {
	recPos.SetXYZ(0,0,0);
	m_helperSvc->CorrectTOFAndCollectHits(recPos,*chhlistptr,clusterHits); // automatically sorted

	bool found = FindPeakAndStart();
	if(!found&&!m_forceRec) return false;

	const double ns_to_s = 1e-9;
	double N_dark_hit = expected_dark_hit()*clusterHits.GetBinWidth()*ns_to_s;
	if(m_forceRec) N_dark_hit = 0;

	double nPEsum = 0;

	for(unsigned int i = start_i; i<=end_i; ++i) {
		const list<ClusterHit*> *clusterHitsBin = clusterHits.GetBin(i);
		if(!clusterHitsBin) continue;
		for(list<ClusterHit*>::const_iterator clusterHitsIt = clusterHitsBin->begin();
				clusterHitsIt!=clusterHitsBin->end(); ++clusterHitsIt) {
			const double weight = (*clusterHitsIt)->charge;
			recPos += m_helperSvc->GetPMTCenter((*clusterHitsIt)->pmtId)*weight;
			nPEsum += weight;
		}
	}
	if(nPEsum-N_dark_hit*(end_i-start_i+1)!=0)
		recPos*=m_calibFactor/(nPEsum-N_dark_hit*(end_i-start_i+1));
	else
		return false;
	return true;
}

bool ChargeCenterAlg::FindPeakAndStart() {
	start_i = end_i = peak_i = clusterHits.GetNbins()/2;
	unsigned int peak_N = 0;
	for(unsigned int scan = 0;scan<clusterHits.GetNbins();++scan) {
		if(clusterHits.GetEntries(scan)>peak_N) {
			peak_i = scan;
			peak_N = clusterHits.GetEntries(scan);
		}
	}
	//	LogDebug<<"pk_i: "<<peak_i<<" --> "<<clusterHits.GetBinCenter(peak_i)<<endl;
	const double ns_to_s = 1e-9;
	const double N_dark_hit = expected_dark_hit()*clusterHits.GetBinWidth()*ns_to_s;
	if(peak_N<=PoissonUpperLimit(N_dark_hit)) {
		LogWarn<<"no signal in this event."<<endl;
		if(!m_forceRec)
			return false;
	}
	start_i = end_i = peak_i;
	for(unsigned int scan = peak_i;scan>0;--scan) {
		if(clusterHits.GetEntries(scan-1)<=PoissonUpperLimit(N_dark_hit)) {
			start_i = scan;
			break;
		}
	}
	//	LogDebug<<"st_i: "<<start_i<<endl;
	for(unsigned int scan = peak_i;scan+1<clusterHits.GetNbins();++scan) {
		if(clusterHits.GetEntries(scan+1)<=PoissonUpperLimit(N_dark_hit)) {
			end_i = scan;
			break;
		}
	}

	if(clusterHits.GetBinCenter(end_i)-clusterHits.GetBinCenter(start_i)<m_clusterLengthThreshold) {
		LogDebug<<"too short window.."<<endl;
		if(!m_forceRec)
			return false;
	}

	if(start_i>m_preWindow/clusterHits.GetBinWidth())
		start_i -= m_preWindow/clusterHits.GetBinWidth(); // now inside dark hit region
	else
		start_i = 0;
	end_i += m_postWindow/clusterHits.GetBinWidth(); // now inside dark hit region

	LogDebug <<" found the rise: "<<
		clusterHits.GetBinCenter(start_i)<<" to "<<
		clusterHits.GetBinCenter(end_i)<<" (ns) "<<
		"darkhit "<<N_dark_hit<<
		" upperlimit "<<PoissonUpperLimit(N_dark_hit)<<
		" entries from ("<<clusterHits.GetEntries(start_i-1)<<") "
		<<clusterHits.GetEntries(start_i)<<
		" to "<<clusterHits.GetEntries(end_i)<<
		" ("<<clusterHits.GetEntries(end_i+1)<<")"<<
		" [peak "<<clusterHits.GetEntries(peak_i)<<
		"("<<clusterHits.GetBinCenter(peak_i)<<
		")]"<<
		endl;

	if(!clusterHits.InSafeWindow(start_i,end_i)) {
		LogInfo<<" This cluster is outside the safe window and abandoned"<<endl;
		return false;
	} 

	return true;
}

unsigned int ChargeCenterAlg::PoissonLowerLimit(double mu) const {
	return m_helperSvc->PoissonLowerLimit(mu,CL);
};

unsigned int ChargeCenterAlg::PoissonUpperLimit(double mu) const {
	return m_helperSvc->PoissonUpperLimit(mu,CL);
};

bool ChargeCenterAlg::WriteToRecHeader() {
	recHeader = new JM::RecHeader(); //unit: mm,  MeV, ...
  JM::CDRecEvent *CD_event = new JM::CDRecEvent;
	CD_event->setX(recPos.X());
	CD_event->setY(recPos.Y());
	CD_event->setZ(recPos.Z());
  recHeader->setCDEvent(CD_event);
	LogInfo<<"==========================================================="<<std::endl;
	LogInfo<<"The Reconstructed x is "<<recPos.X()<<std::endl;
	LogInfo<<"The Reconstructed y is "<<recPos.Y()<<std::endl;
	LogInfo<<"The Reconstructed z is "<<recPos.Z()<<std::endl;
	LogInfo<<"==========================================================="<<std::endl;
	return true;
}

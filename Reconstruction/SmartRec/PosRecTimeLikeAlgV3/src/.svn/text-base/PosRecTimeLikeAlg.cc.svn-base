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
#include "TStopwatch.h"
#include "TFile.h"
#include "TH1D.h"
#include <boost/filesystem.hpp>
#include "Event/ClusterHeader.h"
#include "Event/ClusterEvent.h"

using std::endl;
namespace fs = boost::filesystem;

DECLARE_ALGORITHM(PosRecTimeLikeAlg);

PosRecTimeLikeAlg::PosRecTimeLikeAlg(const std::string & name) : AlgBase(name),
	m_iEvt(0), 
	clusterHits(1,-500,1750)  {
    declProp("File_path", File_path = "$RECTIMELIKEALGROOT/share/elec");
	declProp("Tolerance", tolerance = 0.1);
	declProp("UseFirstHitOnly", use_firstHitOnly = false);
	declProp("CalibInputPath",m_calibInputPath = "/Event/Calib"); 
	declProp("RecInputPath",m_recInputPath = "/Event/Rec"); 
	declProp("ClusterInputPath",m_clusterInputPath = "/Event/Cluster"); 
	declProp("RecOutputPath",m_recOutputPath = "/Event/Rec"); 
};

PosRecTimeLikeAlg::~PosRecTimeLikeAlg() {
};

#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "SmartRecHelperSvc/SmartRecHelperSvc.h"
#include "Math/Factory.h"
bool PosRecTimeLikeAlg::initialize() {
	LogInfo << " This is PosRecTimeLikeAlg version 3 "<<endl;
	bool loaded = LoadPdf();
    if(!loaded) return false;

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
	const double ns_to_s = 1e-9;
	m_N_dark_hit = m_helperSvc->GetExpectedDarkHit()*clusterHits.GetBinWidth()*ns_to_s;
	LogInfo << objName()
		<< " SmartRecHelperSvc loaded: "<<m_helperSvc
		<< " ; Dark hit: "<<m_N_dark_hit<<" (/ns)"
		<< endl;

  IncludeDNToPdf();

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

	TStopwatch timer;
	timer.Start();
	bool hasSignal = LoadInitialpos();
	if(hasSignal)
		FitRecPos(); // Fill recPos and goodness
	else {
		recPos.SetXYZ(0,0,1e10);
		goodness = -1e10;
	}
  JM::CDRecEvent *CD_event = recHeader->cdEvent();
  CD_event->setX(recPos.X());
  CD_event->setY(recPos.Y());
  CD_event->setZ(recPos.Z());
  CD_event->setPositionQuality(goodness);
  timer.Stop();
  double time = timer.RealTime();
  LogInfo<<"==========================================================="<<std::endl;
	LogInfo<<"The initial guess x is "<<rec_x<<" ± "<<sigma_x<<std::endl;
	LogInfo<<"The initial guess y is "<<rec_y<<" ± "<<sigma_y<<std::endl;
	LogInfo<<"The initial guess z is "<<rec_z<<" ± "<<sigma_z<<std::endl;
	LogInfo<<"The initial guess t0 is "<<peak_t<<" ± "<<sigma_t<<std::endl;
	LogInfo<<"The Reconstructed x is "<<recPos.X()<<std::endl;
	LogInfo<<"The Reconstructed y is "<<recPos.Y()<<std::endl;
	LogInfo<<"The Reconstructed z is "<<recPos.Z()<<std::endl;
	LogInfo<<"The Reconstructed t0 is "<<t0<<endl;
	LogInfo<<"The minimized goodness is "<<goodness<<endl;
    LogInfo<<"The Reconstruction Process Cost "<<time<<std::endl;
	LogInfo<<"==========================================================="<<std::endl;

	if(m_recOutputPath!=m_recInputPath) {
		nav->addHeader(m_recOutputPath, recHeader); 
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
	originRecHeader=(JM::RecHeader*) nav->getHeader(m_recInputPath);
	if(originRecHeader) {
		LogDebug << "succeeded: "<< originRecHeader <<endl;
		LogDebug << "trying to load the recPos from the RecHeader."<< endl;
    JM::CDRecEvent *originCD_event = originRecHeader->cdEvent();
    if(originCD_event)
      LogDebug << "succeeded: "<< originCD_event<<endl;
    else
      return false;
		LogDebug << "trying to load the recPos from the RecHeader."<< endl;
		rec_x = originCD_event->x();
		rec_y = originCD_event->y();
		rec_z = originCD_event->z();
	} else {
		LogWarn << "got empty pointer EvtNavigator::getHeader(\""<<m_recInputPath<<"\");"
			<<" it's recommended to run ChargeCenter first. you will save 90% of time."
			<<endl;
		rec_x = rec_y = rec_z = 0;
		if(m_recInputPath==m_recOutputPath&&!originRecHeader)
			throw SniperException("Ask for modification of in-existed header: "+m_recInputPath);
	}
	if(m_recInputPath==m_recOutputPath)
		recHeader = originRecHeader;
	else {
		recHeader = new JM::RecHeader();
    recHeader->setCDEvent(new JM::CDRecEvent());
  }
	double rec_r = sqrt(rec_x*rec_x+rec_y*rec_y+rec_z*rec_z)/1000;
	sigma_x = sigma_y = sigma_z = (6+0.1*rec_r+0.02*rec_r*rec_r)*100;

	TVector3 initPos(rec_x,rec_y,rec_z);
	m_helperSvc->CorrectTOFAndCollectHits(initPos,*chhlistptr,clusterHits); // automatically sorted
	bool found = FindPeak();
	if(!found) return false;
	peak_t = clusterHits.GetBinCenter(peak_i);
	sigma_t = 36*1.732*3*1.1+clusterHits.GetBinWidth();

	LogDebug << "initial guess: "<< rec_x<<" "<<rec_y<<" "<<rec_z <<" "<<peak_t<<
		" : "<<sigma_x<<" "<<sigma_y<<" "<<sigma_z <<" "<<sigma_t<<
		endl;
	return true;
}

bool PosRecTimeLikeAlg::FitRecPos() {
	PrepareInput();
	recPos.SetXYZ(rec_x,rec_y,rec_z);
	t0 = peak_t;
	best_goodness = 1e20;
	last_x_move = last_y_move = last_z_move = last_t_move = -100;
	step_length = sigma_x;  // ugly way.
	while(step_length>tolerance) {
		if(!Try8Direction(step_length)
				&&!Try8Direction(step_length/3)
				&&!Try8Direction(step_length/9)
				&&!Try8Direction(step_length/27)
				&&!Try8Direction(step_length/81)
				&&!Try8Direction(step_length/243)
				&&!Try8Direction(step_length*3)
				&&!Try8Direction(step_length*9)
				&&!Try8Direction(step_length*27)
				&&!Try8Direction(step_length*81)) {
			LogInfo <<" fail to find the rec pos."<<endl;
			return false;
		} 
		sychronize_with_cache();  // improved.
	}
	return true;
}

bool PosRecTimeLikeAlg::FindPeak() {
	unsigned int peak_N = 0;
	for(unsigned int scan = 1;scan<clusterHits.GetNbins()-1;++scan) {
		if(clusterHits.GetEntries(scan-1,scan+1)>peak_N) {
			peak_i = scan;
			peak_N = clusterHits.GetEntries(scan-1,scan+1);
		}
	}
	if(peak_N<=m_helperSvc->PoissonUpperLimit(m_N_dark_hit*3)) {
		LogWarn<<"no signal in this event."<<endl;
		return false;
	}
	LogDebug <<" found the peak: "<<
		clusterHits.GetBinCenter(peak_i)<<" (ns) "<<
		"darkhit "<<m_N_dark_hit<<
		" at "<<clusterHits.GetEntries(peak_i)<<
		">"<<m_helperSvc->PoissonUpperLimit(m_N_dark_hit)<<
		endl;
	return true;
}

bool PosRecTimeLikeAlg::LoadPdf() {
   fs::path s(File_path);
#define ROLL(ARG) \
   ARG(1); \
   ARG(2); \
   ARG(3); \
   ARG(4); \
   ARG(5); 

#define GETT(N) Time_## N ##hit = TFile::Open(TString((s/"pdf_n" #N ".root").string()));

   ROLL(GETT);
  
   if(!Time_1hit) {
       LogError  << "Failed to get Likelihood Function File!" << std::endl;
       return false;
   }

   TH1D *tmp = new TH1D; // bug of root. see https://root.cern.ch/phpBB3/viewtopic.php?f=3&t=12358
#define GETH(N) pdf_## N ##hit = (TH1D*)Time_## N ##hit->Get("tim");

   ROLL(GETH);

   delete tmp;


#define SCALE(N) pdf_## N ##hit->Scale(1./pdf_## N ##hit->Integral("width")); 

   ROLL(SCALE);

   LogDebug<<Time_5hit<<" "<<Time_5hit->Get("tim")<<endl;
   LogDebug<<pdf_5hit<<" "<<"pdf_5hit->GetRMS() "<<pdf_5hit->GetMean()<<endl;
   return true;
}

bool PosRecTimeLikeAlg::IncludeDNToPdf() {
	const double ns_to_s = 1e-9;
  double N_dark_hit_per_PMT = m_helperSvc->GetDarkRate()*m_helperSvc->GetWaveformRecEff()*ns_to_s*clusterHits.GetBinWidth();
#define UPDATE(N) \
     pdf_## N ##hit->SetBinContent(i,pdf_## N ##hit->GetBinContent(i)*N+\
         N_dark_hit_per_PMT*pdf_## N ##hit->GetBinWidth(i));

  int binM = pdf_3hit->GetMaximumBin();
  double pdf_before = pdf_3hit->GetBinContent(binM);
  for(int i = 1;i<=pdf_1hit->GetNbinsX();++i) {
    ROLL(UPDATE);
  }
  ROLL(SCALE);
  double pdf_after= pdf_3hit->GetBinContent(binM);
  LogDebug<<"Modification: h3("<<pdf_3hit->GetBinCenter(binM)<<")<"<<pdf_before
    <<"> -> <"<<(pdf_before*3)<<"/"<<N_dark_hit_per_PMT*pdf_3hit->GetBinWidth(binM)<<">"
    <<"> -> <"<<pdf_after<<">"<<endl;
  return true;
}

bool PosRecTimeLikeAlg::Goodness() {
  if(!new_goodness()&&cach_filled) {
    int my_index = required_index();
    LogTest <<  "cached        : "
      <<cached_x[my_index]<<" "<<cached_y[my_index]<<" "<<cached_z[my_index]<<" "
      <<cached_t[my_index]<<" "<<cached_goodness[my_index]<<endl;
    goodness = cached_goodness[required_index()];
    LogTest << "Current recPos: "<<recPos.X()<<" "<<recPos.Y()<<" "<<recPos.Z()<<" "<<t0<<" "<<goodness<<endl; 
    return true;
  }
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
#define FAST_PDF
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
    if(pdf>0) {
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

bool PosRecTimeLikeAlg::Try8Direction(const double tmp_step_length) {
  if(tmp_step_length!=cached_length) {
    cach_filled = false; // disable cache
  }
  const double t0_step_scale = 0.01;
  TVector3 initRecPos(recPos);
  double init_t0(t0);
  improved = false;
  for(x_move = -1; x_move<=1; ++x_move)
    for(y_move = -1; y_move<=1; ++y_move)
      for(z_move = -1; z_move<=1; ++z_move)
        for(t_move = -1; t_move<=1; ++t_move) {
          //LogDebug << "Current index: "<<index()<<endl;
          recPos=initRecPos+TVector3(x_move,y_move,z_move)*tmp_step_length;
          t0 = init_t0+t_move*tmp_step_length*t0_step_scale;
          Goodness();
          // cach 81 value
          new_cached_x[index()] = recPos.X();
          new_cached_y[index()] = recPos.Y();
          new_cached_z[index()] = recPos.Z();
          new_cached_t[index()] = t0;
          new_cached_goodness[index()] = goodness;
          if(goodness<best_goodness) {
            best_goodness = goodness;
            best_recPos = recPos;
						best_t0 = t0;
						best_step_length = tmp_step_length;
						next_x_move = x_move;
						next_y_move = y_move;
						next_z_move = z_move;
						next_t_move = t_move;
						improved = true;
					}
				}
	recPos = initRecPos;
	t0 = init_t0;
	// cach related
	for(int i = 0;i<81;++i) {
		cached_x[i] = new_cached_x[i];
		cached_y[i] = new_cached_y[i];
		cached_z[i] = new_cached_z[i];
		cached_t[i] = new_cached_t[i];
		cached_goodness[i] = new_cached_goodness[i];
	}
	cach_filled = true;
	cached_length = tmp_step_length;
	return improved;
}

bool PosRecTimeLikeAlg::sychronize_with_cache() {
	last_x_move = next_x_move;
	last_y_move = next_y_move;
	last_z_move = next_z_move;
	last_t_move = next_t_move;
	LogDebug<<"moved from "
		<<recPos.X()<<" "<<recPos.Y()<<" "<<recPos.Z()<<" "<<t0<<" "<<step_length
		<<" to "
		<<best_recPos.X()<<" "<<best_recPos.Y()<<" "<<best_recPos.Z()<<" "<<best_t0<<" "<<best_step_length
		<<" move: "
		<<last_x_move<<" "<<last_y_move<<" "<<last_z_move<<" "<<last_t_move
		<<endl;
	recPos = best_recPos;
	t0 = best_t0;
	step_length = best_step_length;
	return true;
}

bool PosRecTimeLikeAlg::new_goodness() {
	return !((last_x_move+x_move>=-1)&&(last_x_move+x_move<=1)
			&&(last_y_move+y_move>=-1)&&(last_y_move+y_move<=1)
			&&(last_z_move+z_move>=-1)&&(last_z_move+z_move<=1)
			&&(last_t_move+t_move>=-1)&&(last_t_move+t_move<=1));
}

int PosRecTimeLikeAlg::index() {
	return (((x_move+1)*3+(y_move+1))*3+(z_move+1))*3+t_move+1;
}

int PosRecTimeLikeAlg::required_index() {
	return (((last_x_move+x_move+1)*3+(last_y_move+y_move+1))*3+(last_z_move+z_move+1))*3+last_t_move+t_move+1;
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

#include "SpmtFastDet2ElecAlg.h"
#include "SniperKernel/AlgFactory.h"
#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "Context/TimeStamp.h"
#include "TRandom.h" 
#include "RootWriter/RootWriter.h"
#include <math.h>

DECLARE_ALGORITHM(SpmtFastDet2ElecAlg);

SpmtFastDet2ElecAlg::SpmtFastDet2ElecAlg(const std::string& name):AlgBase(name), m_buf(0), m_vecNPE(maxSPMT,0), m_vecTime(maxSPMT,0),  m_event_tree(0), m_EvtID(0) {

}

SpmtFastDet2ElecAlg::~SpmtFastDet2ElecAlg(){

}

bool SpmtFastDet2ElecAlg::initialize(){

  LogDebug<<"SpmtFastDet2ElecAlg::initialize"<<std::endl;

  m_EvtID=0;

  if(!SetNavigatorBuffer()) return false;
  if(!SetUserOutputTree()) return false;

  return true;
}

bool SpmtFastDet2ElecAlg::execute(){

  LogDebug<<"SpmtFastDet2ElecAlg::execute"<<std::endl;

  if(!LoadSimEvt()) return false;
  if(!FillElecEvent()) return false;
  if(!FillUserOutput()) return false;

  return true;
}

bool SpmtFastDet2ElecAlg::finalize(){

  LogDebug<<"SpmtFastDet2ElecAlg::finalize"<<std::endl;

  return true;
}

bool SpmtFastDet2ElecAlg::SetNavigatorBuffer(){

  SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
  if ( navBuf.invalid() ) {
    LogError << "cannot get the NavBuffer @ /Event" << std::endl;
    return false;
  }
  m_buf = navBuf.data();

  return true;
}

bool SpmtFastDet2ElecAlg::SetUserOutputTree(){

  SniperPtr<RootWriter> svc("RootWriter");
  if (svc.invalid()) {
    LogError << "Can't Locate RootWriter. If you want to use it, please "
             << "enalbe it in your job option file."
             << std::endl;
    return false;
  }
  m_event_tree = svc->bookTree("SIMEVT", "Spmt fast elec tree");
  m_event_tree->Branch("evtID", &m_EvtID, "evtID/I");
  m_event_tree->Branch("NPEs",&m_vecNPE);
  m_event_tree->Branch("Times",&m_vecTime); 
  m_event_tree->Branch("Types",&m_vecType);          
  m_event_tree->Branch("Gains",&m_vecGain);          
  m_event_tree->Branch("Boards",&m_vecBoard_num);
  m_event_tree->Branch("ChNums",&m_vecCh_num);        
  m_event_tree->Branch("CoarseTimes",&m_vecCoarse_time);   
  m_event_tree->Branch("EvtCounters",&m_vecEvent_counter); 
  m_event_tree->Branch("FineTimes",&m_vecFine_time);     
  m_event_tree->Branch("Charges",&m_vecCharge);        

  return true;
}

bool SpmtFastDet2ElecAlg::FillUserOutput(){

  m_event_tree->Fill();
  ++m_EvtID;

  return true;
}

bool SpmtFastDet2ElecAlg::LoadSimEvt(){

  // load event info in memory
  m_evtNav = m_buf->curEvt();
  if (not m_evtNav) {
    return false;
  }
  m_simHeader = dynamic_cast<JM::SimHeader*>(m_evtNav->getHeader("/Event/Sim"));
  LogDebug << "simhdr: " << m_simHeader << std::endl;
  if (not m_simHeader) {
    return false;
  }
  m_simEvt = dynamic_cast<JM::SimEvent*>(m_simHeader->event());
  LogDebug << "simevt: " << m_simEvt << std::endl;
  if (not m_simEvt) {
    return false;
  }
  TTimeStamp current_evt_TimeStamp = m_evtNav->TimeStamp();
  LogInfo << "load evt TimeStamp: " << current_evt_TimeStamp << std::endl;

  // reinit vectors
  for(std::vector<int>::iterator it = m_vecNPE.begin(); it != m_vecNPE.end(); ++it)
    (*it)=0;
  for(std::vector<double>::iterator it = m_vecTime.begin(); it != m_vecTime.end(); ++it)
    (*it)=0;

  // fill vectors
  int pmtId=0;
  int pmtNum=0;
  int pmtNPE=0;
  double pmtTime=0;
  const std::vector<JM::SimPMTHit*>& cdPmtHits = m_simEvt->getCDHitsVec();
  for(std::vector<JM::SimPMTHit*>::const_iterator it = cdPmtHits.begin(); it != cdPmtHits.end(); ++it ){

    pmtId=(*it)->getPMTID();
    pmtNum=pmtId-startSPMT;
    pmtNPE=(*it)->getNPE();
    pmtTime=(*it)->getHitTime();

    if(pmtNum>=0){// only SPMTs
      if(pmtNum>=maxSPMT){
        LogError << " Spmt numbering error " <<  std::endl;
        return false;// check pmt numbering!
      }
      if(!m_vecNPE[pmtNum])m_vecTime[pmtNum]=pmtTime;// first p.e. set initial time
      m_vecNPE[pmtNum]+=pmtNPE;
      if(pmtTime<m_vecTime[pmtNum])m_vecTime[pmtNum]=pmtTime;// leading time only!
    }
  }

  return true;
}

bool SpmtFastDet2ElecAlg::FillElecEvent(){
  // first init vectors
  m_vecType.clear();
  m_vecGain.clear();
  m_vecBoard_num.clear();
  m_vecCh_num.clear();
  m_vecCoarse_time.clear();
  m_vecEvent_counter.clear();
  m_vecFine_time.clear();
  m_vecCharge.clear();

  // now init sniper stuff
  JM::EvtNavigator* nav = new JM::EvtNavigator();
  TTimeStamp current_evt_TimeStamp = m_evtNav->TimeStamp();
  TRandom m_r;
  nav->setTimeStamp(current_evt_TimeStamp);
  SniperPtr<IDataMemMgr> mMgr(getScope(), "BufferMemMgr");
  mMgr->adopt(nav, "/Event");
  JM::SpmtElecEvent* spmtEvent = new JM::SpmtElecEvent(); // memory leak?
  std::vector<JM::SpmtElecAbcBlock> abcBlocks;

  // now fill blocks
  for(unsigned int i=0; i<m_vecNPE.size(); ++i){
    if(m_vecNPE[i]>0){
      JM::SpmtElecAbcBlock aBlock;
      // type
      aBlock.setType(false);// false: physics
      m_vecType.push_back(false);
      double charge = m_r.Gaus(pe2AdcMean*m_vecNPE[i],pe2AdcStdd*sqrt(m_vecNPE[i]));
      // gain
      if(charge>pe2AdcGainTh){
        aBlock.setGain(true);// high gain
        m_vecGain.push_back(true);
        charge/=pe2AdcGainRa;
      }
      else {
        aBlock.setGain(false);// low gain
        m_vecGain.push_back(false);
      }
      // channel number
      aBlock.setCh_num(i%16);//4bits
      m_vecCh_num.push_back(i%16);
      aBlock.setBoard_num(i/16);
      m_vecBoard_num.push_back(i/16);
      // coarse time
      double  l_Time = m_vecTime[i]+m_r.Gaus(0.,tts);
      unsigned long coarseTime = l_Time/coarseTimeStep;
      coarseTime %= maxCoarseTime; // max or mod?
      aBlock.setCoarse_time(coarseTime);
      m_vecCoarse_time.push_back(coarseTime);  
      // event counter
      aBlock.setEvent_counter(m_vecNPE[i]);// 12bits
      m_vecEvent_counter.push_back(m_vecNPE[i]);
      // fine time
      unsigned int fTime = fmod(l_Time,coarseTimeStep)/(coarseTimeStep/1024);
      aBlock.setFine_time(fTime);//10bits, 2^10=1024 -> 25ns/1024=0.024414ns
      m_vecFine_time.push_back(fTime);
      // charge
      if(charge>1024) charge = 1024;
      aBlock.setCharge(charge);//10bits
      m_vecCharge.push_back(charge);
      abcBlocks.push_back(aBlock);
    }
  }
  spmtEvent->setSpmtBlocks(abcBlocks);
  JM::ElecHeader* header = new JM::ElecHeader();
  header->setSpmtEvent(spmtEvent);
  nav->addHeader("/Event/Elec", header);
  nav->addHeader("/Event/Sim",m_simHeader);// keep sim info in output!
 
  return true;
}

/*
TotTracker Calib


Author: A.Meregaglia, C.Jollet (IPHC)
*/

#include "Event/SimHeader.h"
#include "Event/SimEvent.h"
#include "Event/CalibHeader.h"
#include "Event/CalibTTChannel.h"
#include "EvtNavigator/NavBuffer.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "Geometry/RecGeomSvc.h"
#include "Identifier/Identifier.h"
#include "Identifier/CdID.h"
#include "TH1D.h"
#include "TMath.h"
#include "TMinuit.h"
//#include "DetSimAlg/IDetElement.h"

#include "TTCalibAlg.h"
#include "SniperKernel/AlgFactory.h"
#include "RootWriter/RootWriter.h"
#include <bitset>
#include "Geometry/TTGeomSvc.h"


/////////////////////////////////////////////


DECLARE_ALGORITHM(TTCalibAlg);

TTCalibAlg::TTCalibAlg(const std::string& name)
	:AlgBase(name)
{
  // Set Default Values of Some Parameters


}

TTCalibAlg::~TTCalibAlg()
{

}

bool
TTCalibAlg::initialize()
{

  //read Channel positions
  
  tt_pos_svc = 0;
  SniperPtr<TTGeomSvc> svctt(getScope(), "TTGeomSvc");
  if (svctt.invalid()) {
    LogError << "Can't get TTGeomSvc. We can't initialize TT position." << std::endl;
    assert(0);
  } else {
    LogInfo << "Retrieve TTGeomSvc successfully." << std::endl;
    tt_pos_svc = svctt.data();
  }
    

// Get Data Navigator
  SniperDataPtr<JM::NavBuffer> navBuf(getScope(), "/Event");
  if( navBuf.invalid() )
  {
    LogError << "cannot get the NavBuffer @ /Event" << std::endl;
    return false;
  }
  m_buf = navBuf.data();

  LogInfo << objName() << " initialized successfully." << std::endl;

  //to be read from DB for real data conversion
  meangain=40;
  return true;
}

bool 
TTCalibAlg::execute()
{
  LogDebug << "---------------------------------------" << std::endl;
  LogDebug << "Processing event " << m_evt_id << std::endl;

/*       
   if (m_evt_id<83013)
    {
      m_evt_id++;
      return true;
    }
  */
  // Get Input Data
  // initialize

  // LogDebug << "AA Processing event " <<m_buf->curEvt()<< std::endl;  
  JM::EvtNavigator* nav = m_buf->curEvt();
  JM::SimHeader* sh = dynamic_cast<JM::SimHeader*>(nav->getHeader("/Event/Sim"));
  if (not sh) 
    return false;
  JM::SimEvent* se  = dynamic_cast<JM::SimEvent*>(sh->event());
  if (not se) 
    return false;
  // create a TTCalibEvent
  JM::CalibHeader* cal_hdr = 0;

  // for Calib Header, we need to check it is existing or not.
  // especially integrated with other calib algorithms.
  bool isCalibHeaderNew = false;
  cal_hdr = dynamic_cast<JM::CalibHeader*>(nav->getHeader("/Event/Calib"));
  if (!cal_hdr) {
      cal_hdr = new JM::CalibHeader();
      isCalibHeaderNew = true;
  }
  JM::TTCalibEvent* cal_event = new JM::TTCalibEvent();
  
  const std::vector<JM::SimTTHit*>& tmp_hits_tt = se->getTTHitsVec();


  //loop on hits from data model 
  for (std::vector<JM::SimTTHit*>::const_iterator ithit = tmp_hits_tt.begin();
       ithit != tmp_hits_tt.end(); ++ithit) 
    {
      JM::SimTTHit* tthit = *ithit;
      
      int channelID=tthit->getChannelID();
      JM::CalibTTChannel* calibchannel=cal_event->addCalibTTChannel(channelID);

      //    std::cout<<" ANS "<<m_evt_id<<std::endl;
      //calibchannel->setNPE(tthit->getPE());
      calibchannel->setNPE(tthit->getADC()/meangain);
      calibchannel->setNADC(tthit->getADC());

      calibchannel->setX(tt_pos_svc->getChannelPos(channelID,0)); 
      calibchannel->setY(tt_pos_svc->getChannelPos(channelID,1));
      calibchannel->setZ(tt_pos_svc->getChannelPos(channelID,2));

      //calibchannel->setX(tthit->getX());
      //calibchannel->setY(tthit->getY());
      //calibchannel->setZ(tthit->getZ());
    }

  cal_hdr->setTTEvent(cal_event);
  if (isCalibHeaderNew) nav->addHeader("/Event/Calib", cal_hdr);
  
  m_evt_id ++;
  return true;
}



bool TTCalibAlg::finalize()
{
  LogInfo << objName() << " finalized successfully." << std::endl;
  return true;
}

// Private Functions
std::string TTCalibAlg::StringconvertDecimalToBinary(int n, int nbit)
{
  //if nbit is not 29 this should not work!
  if(nbit!=29)
    {
      LogError<<" Error in the expected bit size "<<std::endl;
      return false;
    }
  std::string strout = std::bitset<29>(n).to_string();
  
  return strout;
}



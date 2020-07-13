#include "TestSpmtElecAlg.h"
#include "SniperKernel/AlgFactory.h"
#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "EvtNavigator/NavBuffer.h"
#include "Event/ElecHeader.h"
#include "Event/ElecEvent.h"

DECLARE_ALGORITHM(TestSpmtElecAlg);

TestSpmtElecAlg::TestSpmtElecAlg(const std::string& name)
    : AlgBase(name),
      m_loop(0)
{
    declProp("EvtTimeGap", m_gap = 200000);  //nano second
    //RunMode: 0, nothing to do; 1, reading; 2, generating;
    declProp("RunMode",    m_mode = 0);  
}

bool TestSpmtElecAlg::initialize()
{
    LogDebug << "initializing" << std::endl;

    SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
    if ( navBuf.invalid() ) {
        LogError << "cannot get the NavBuffer @ /Event" << std::endl;
        return false;
    }
    m_buf = navBuf.data();


    // ... Only For Generating
    if ( m_mode == 2 ) {
    }

    return true;
}

bool TestSpmtElecAlg::execute()
{
    LogDebug << "executing" << std::endl;

    if ( m_mode == 1 ) {  //reading
      JM::EvtNavigator* nav = m_buf->curEvt();
      // Event After Split
      JM::ElecHeader* elecheader = static_cast<JM::ElecHeader*>(nav->getHeader("/Event/Elec"));
      if (elecheader) {
	JM::SpmtElecEvent* elecevent  = dynamic_cast<JM::SpmtElecEvent*>(elecheader->spmtEvent());
        LogInfo << "ElecEvent Read in: " << elecevent << std::endl;
        LogInfo << "Abc blocks in SpmtElecEvent: " << elecevent->spmtBlocks().size() << std::endl;
        if(elecevent->spmtBlocks().size())
        LogInfo << "Amplitude first block: " << elecevent->spmtBlocks().at(0).charge() << std::endl;

      }
      else{
        LogInfo << "ElecEvent not found" << std::endl;
      }
      LogDebug << "reading: " << m_loop++
               << "  buffer_size: " << m_buf->size()
               << "  cur: " << m_buf->curEvt()->TimeStamp()
               << std::endl;
    }
    else if ( m_mode == 2 ) {
        //make a dummy EvtNavigator
        JM::EvtNavigator* nav = new JM::EvtNavigator();
        static TTimeStamp time(2014, 7, 20, 10, 10, 2, 111);
        time.Add(TTimeStamp(0, abs(m_r.Gaus(m_gap, m_gap/5))));
        nav->setTimeStamp(time);

        //TODO: register the EvtNavigator to Memory Store
        SniperPtr<IDataMemMgr> mMgr(getScope(), "BufferMemMgr");
        mMgr->adopt(nav, "/Event");

        //set headers and events ...
        JM::SpmtElecEvent* spmtEvent = new JM::SpmtElecEvent();
        std::vector<JM::SpmtElecAbcBlock> abcBlocks; 
        JM::SpmtElecAbcBlock aBlock;
        aBlock.setType(true);
        aBlock.setGain(true);
        aBlock.setCoarse_time(4);
        aBlock.setEvent_counter(1);
        aBlock.setFine_time(2);
        aBlock.setCharge(8*m_loop);
        abcBlocks.push_back(aBlock);
        spmtEvent->setSpmtBlocks(abcBlocks);
     
        JM::ElecHeader* header = new JM::ElecHeader();
        header->setSpmtEvent(spmtEvent);
        nav->addHeader("/Event/Elec", header);

        LogDebug << "executing: " << m_loop++
                 << "  buffer_size: " << m_buf->size()
                 << std::endl;
    }
    //else, mode 0 nothing to do
    return true;
}

bool TestSpmtElecAlg::finalize()
{
    LogDebug << "finalizing" << std::endl;
    return true;
}

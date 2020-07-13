#ifndef SPMT_FAST_DET_2_ELEC_ALG
#define SPMT_FAST_DET_2_ELEC_ALG

#include "SniperKernel/AlgBase.h"
#include "EvtNavigator/NavBuffer.h"
#include "Event/SimHeader.h"
#include "Event/SimEvent.h"
#include "Event/ElecHeader.h"
#include "Event/ElecEvent.h"


#include <string>
#include <TTree.h>

class SpmtFastDet2ElecAlg: public AlgBase
{
  public:
    SpmtFastDet2ElecAlg(const std::string& name);
    ~SpmtFastDet2ElecAlg();

    bool initialize();
    bool execute();
    bool finalize();

    // helper functions
    bool SetNavigatorBuffer();
    bool SetUserOutputTree();

    bool LoadSimEvt();
    bool FillElecEvent();
    bool FillUserOutput();
  private:

    static const int maxSPMT=40000;// we could save little memory here
    static const int startSPMT=300000;

    static const double pe2AdcMean = 30.4;
    static const double pe2AdcStdd = 7.4;
    static const double tts = 2.17;// ns -  fixed and the same for all PMTs for now
    static const double pe2AdcGainTh = 820;
    static const double pe2AdcGainRa = 20;
    static const double coarseTimeStep = 25; // ns
    static const unsigned long maxCoarseTime = 67108864;//2^26

    JM::NavBuffer* m_buf;

    //sim event related
    JM::EvtNavigator* m_evtNav;
    JM::SimHeader*    m_simHeader;
    JM::SimEvent*     m_simEvt;

    // vector of infos from PMT Hits
    std::vector<int>           m_vecNPE;
    std::vector<double>        m_vecTime;
    //vector of infos from abc blocks 
    std::vector<UInt_t>        m_vecType; // root trees dislike vector<UChar_t> !         
    std::vector<UInt_t>        m_vecGain; // vector<bool> as well!
    std::vector<UInt_t>        m_vecBoard_num;// vector<UChar_t> as well!!          
    std::vector<UInt_t>        m_vecCh_num;        
    std::vector<UInt_t>        m_vecCoarse_time;  // 32 bit int! 
    std::vector<UInt_t>        m_vecEvent_counter; 
    std::vector<UInt_t>        m_vecFine_time;     
    std::vector<UInt_t>        m_vecCharge;        

    TTree* m_event_tree;

    int m_EvtID;

};

#endif

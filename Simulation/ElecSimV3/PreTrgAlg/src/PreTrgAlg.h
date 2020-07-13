#ifndef PreTrgAlg_h
#define PreTrgAlg_h
#include "SniperKernel/AlgBase.h"
#include "EvtNavigator/NavBuffer.h"
#include "Context/TimeStamp.h"
#include "ElecBufferMgrSvc/IElecBufferMgrSvc.h"
#include "GlobalTimeSvc/IGlobalTimeSvc.h"
#include <map>
#include <vector>
#include <string>


class PreTrgAlg: public AlgBase
{
    public:
        PreTrgAlg(const std::string& name);
        ~PreTrgAlg();

        bool initialize();
        bool execute();
        bool finalize();
        bool find_Trg_from_PulseBuffer();
        bool get_Services();



    private:

        IElecBufferMgrSvc* BufferSvc;
        IGlobalTimeSvc* TimeSvc;


        double m_PulseBufferLength; //unit ns
        double m_PreTrigger_PulseNum;
        double m_Trigger_FiredPmtNum;

        double m_Trigger_window;
        double m_Trigger_slip_window;
        double m_Interval_of_two_TriggerTime;

        std::deque<TimeStamp> m_TriggerBuffer;

        std::map<int, std::map<int,int> > T_pmtNum;//key: ns  sub_key:pmtID  sub_value: no use  we use (it->second).size() to represent the hit pmt num in the second.
        std::map<int,int> T_pmtNum_without_overlap;
};




















#endif

#ifndef GlobalTimeSvc_h
#define GlobalTimeSvc_h

#include "SniperKernel/SvcBase.h"
#include "GlobalTimeSvc/IGlobalTimeSvc.h"
#include "Context/TimeStamp.h"
#include <TTimeStamp.h>
#include <string>

class GlobalTimeSvc: public IGlobalTimeSvc, public SvcBase
{
    public:
        GlobalTimeSvc(const std::string& name);
        ~GlobalTimeSvc();

        bool initialize();
        bool finalize();

        TTimeStamp set_current_evt_time(TTimeStamp delta); //add time delta to get new evt time

        TTimeStamp get_current_evt_time();

        TimeStamp get_start_time();

        TimeStamp get_TimeStamp_for_DarkPulse();

        void set_TimeStamp_for_DarkPulse(TimeStamp m_tempTimeStamp);
        const TimeStamp& global_start_time() const;
        const TimeStamp& global_stop_time() const;
        // method is_in_range will check start <= input <= stop
        bool is_in_range(const TimeStamp&) const;

    private:
        std::string m_start_Time;
        std::string m_stop_Time;
        // timestamp type for start/stop
        TTimeStamp m_start_timestamp;
        TTimeStamp m_stop_timestamp;

        TTimeStamp current_evt_time;

        TimeStamp  TimeStamp_for_DarkPulse;

        std::map<std::string,double> m_rateMap;///events rate map
        double m_totalRate;///the sum of events rate
        double m_mainTau;///1.0/totalRate



    private:

        TTimeStamp str2time(std::string str_time);




};


#endif

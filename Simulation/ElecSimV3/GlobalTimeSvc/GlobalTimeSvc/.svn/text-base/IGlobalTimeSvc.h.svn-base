#ifndef IGlobalTimeSvc_h
#define IGlobalTimeSvc_h
#include "Context/TimeStamp.h"
#include <TTimeStamp.h>



class IGlobalTimeSvc{
    public:
        virtual ~IGlobalTimeSvc() = 0;
        virtual TTimeStamp set_current_evt_time(TTimeStamp delta) = 0;
        virtual TTimeStamp get_current_evt_time() = 0;
        
        virtual TimeStamp get_start_time() = 0;
        virtual TimeStamp get_TimeStamp_for_DarkPulse() = 0; 
        virtual void set_TimeStamp_for_DarkPulse(TimeStamp m_tempTimeStamp) = 0; 

        // Following methods are used to check hit time
        //    -- Tao Lin, 2017/06/16
        virtual const TimeStamp& global_start_time() const = 0;
        virtual const TimeStamp& global_stop_time() const = 0;
        // method is_in_range will check start <= input <= stop
        virtual bool is_in_range(const TimeStamp&) const = 0;
};








#endif

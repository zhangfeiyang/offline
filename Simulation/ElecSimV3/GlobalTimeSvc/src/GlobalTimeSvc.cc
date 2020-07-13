#include "GlobalTimeSvc.h"
#include "SniperKernel/SvcFactory.h"
#include "SniperKernel/SniperLog.h"

using namespace std;

DECLARE_SERVICE(GlobalTimeSvc);


GlobalTimeSvc::GlobalTimeSvc(const std::string& name)
    : SvcBase(name)
{
    // the hits could be filtered by start/stop
    declProp("start", m_start_Time="1970-01-01 00:00:00");
    declProp("stop", m_stop_Time="2038-01-19 00:00:00");
}


GlobalTimeSvc::~GlobalTimeSvc(){

}


bool GlobalTimeSvc::initialize(){

    m_start_timestamp = str2time(m_start_Time);
    m_stop_timestamp = str2time(m_stop_Time);
    if (m_stop_timestamp<m_start_timestamp) {
        LogError << "Can't initialize because start timestamp is later than stop timestamp." << std::endl;
        LogError << "start time: " << m_start_Time << std::endl;
        LogError << "stop time: " << m_stop_Time << std::endl;
        return false;
    }

    LogInfo<<"I'm at Beijing , so I input local time 1970-1-1 08:00:00. It equal standard time 1970-1-1 00:00:00"<<endl;
    LogInfo<<"start Time (local time): " << m_start_Time<<endl;
    current_evt_time = str2time(m_start_Time);
    LogInfo<<"current_evt_time: "  << current_evt_time<<endl;

    TimeStamp tempTimeStamp(0);
    TimeStamp_for_DarkPulse = tempTimeStamp;


    return true;

}





bool GlobalTimeSvc::finalize(){


    return true;
}


TTimeStamp GlobalTimeSvc::set_current_evt_time(TTimeStamp delta){

    current_evt_time.Add(delta);  
    return current_evt_time;

}



TTimeStamp GlobalTimeSvc::get_current_evt_time(){
    return current_evt_time;
}



TTimeStamp GlobalTimeSvc::str2time(string str_time)
{
    struct tm tm_time;
    strptime(str_time.c_str(),"%Y-%m-%d %H:%M:%S", &tm_time);

    setenv("TZ", "", 1);
    tzset();

    time_t tTime=mktime(&tm_time);
    LogInfo<<"tTime (number of seconds since standard time 1970-1-1 00:00:00): " << tTime<<endl;


    TTimeStamp answer(tTime,0);
    return answer;
}



TimeStamp GlobalTimeSvc::get_start_time(){


    TTimeStamp StartTime = str2time(m_start_Time);

    TimeStamp m_StartTime(StartTime.GetSec(), StartTime.GetNanoSec() );

    return m_StartTime;

}



TimeStamp GlobalTimeSvc::get_TimeStamp_for_DarkPulse(){
    return TimeStamp_for_DarkPulse;
}


void GlobalTimeSvc::set_TimeStamp_for_DarkPulse(TimeStamp m_tempTimeStamp){
    TimeStamp_for_DarkPulse = m_tempTimeStamp;
}



const TimeStamp& GlobalTimeSvc::global_start_time() const{

    const static TimeStamp s_StartTime(m_start_timestamp.GetSec(),
                                       m_start_timestamp.GetNanoSec() );

    return s_StartTime;

}

const TimeStamp& GlobalTimeSvc::global_stop_time() const{

    const static TimeStamp s_StopTime(m_stop_timestamp.GetSec(),
                                      m_stop_timestamp.GetNanoSec() );

    return s_StopTime;

}

bool GlobalTimeSvc::is_in_range(const TimeStamp& val) const {
    return global_start_time() <= val && val <= global_stop_time();
}

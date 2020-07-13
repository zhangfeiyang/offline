#ifndef Pulse_h
#define Pulse_h
#include "Context/TimeStamp.h"
#include "ElecDataStruct/EventKeeper.h"


class Pulse {

    public:
        Pulse(int o_pmtID,
                double o_amplitude,
                double o_TTS,
                TimeStamp o_pulseHitTime,
                TimeStamp o_EvtTimeStamp)
            :
                m_pmtID(o_pmtID),
                m_amplitude(o_amplitude),
                m_TTS(o_TTS),
                m_pulseHitTime(o_pulseHitTime),
                m_EvtTimeStamp(o_EvtTimeStamp)
    {}

        Pulse(const Pulse& others)
            :
                m_pmtID(others.m_pmtID),
                m_amplitude(others.m_amplitude),
                m_TTS(others.m_TTS),
                m_pulseHitTime(others.m_pulseHitTime),
                m_EvtTimeStamp(others.m_EvtTimeStamp),
                m_entry(others.m_entry)
    {}

        double amplitude();
        double TTS();
        TimeStamp pulseHitTime();
        TimeStamp pulseHitTime() const;

        TimeStamp EvtTimeStamp();
        int pmtID();

        void set_entry(const EventKeeper::Entry& entry);
        const EventKeeper::Entry& entry();
    private:
        int m_pmtID;
        double m_amplitude;
        double m_TTS;
        TimeStamp m_pulseHitTime;
        TimeStamp m_EvtTimeStamp;
        EventKeeper::Entry m_entry; // ref to Event
};




#endif

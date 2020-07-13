#include "ElecDataStruct/Pulse.h"
#include "Context/TimeStamp.h"


double Pulse::amplitude(){
    return m_amplitude;
}

double Pulse::TTS(){
    return m_TTS;
}


TimeStamp Pulse::pulseHitTime(){
    return m_pulseHitTime;
}


TimeStamp Pulse::pulseHitTime() const{
    return m_pulseHitTime;
}


TimeStamp Pulse::EvtTimeStamp(){
    return m_EvtTimeStamp;
}


int Pulse::pmtID(){
    return m_pmtID;
}

void Pulse::set_entry(const EventKeeper::Entry& entry) {
    m_entry = entry;
}

const EventKeeper::Entry& Pulse::entry() {
    return m_entry;
}





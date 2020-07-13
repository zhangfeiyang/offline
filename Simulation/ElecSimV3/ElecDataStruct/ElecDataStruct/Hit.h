#ifndef Hit_h
#define Hit_h
#include "Context/TimeStamp.h"
#include "ElecDataStruct/EventKeeper.h"


class Hit{

    public:
        Hit(int i_pmtID,
                TimeStamp i_hitTime,
                TimeStamp i_EvtTimeStamp,
                double i_weight):
            m_pmtID(i_pmtID),
            m_hitTime(i_hitTime),
            m_EvtTimeStamp(i_EvtTimeStamp),
            m_weight(i_weight)
    {}
    



    public:
        int pmtID();
        TimeStamp hitTime(); //get global hitTime
        TimeStamp hitTime() const; //get global hitTime

        TimeStamp EvtTimeStamp();
        double weight();
        double relative_hitTime_ns(); // get relative hitTime 

        void set_entry(const EventKeeper::Entry& entry);
        const EventKeeper::Entry& entry();




    private:

        int m_pmtID;
        TimeStamp m_hitTime; //global hitTime
        TimeStamp m_EvtTimeStamp;
        double m_weight;

        EventKeeper::Entry m_entry; // ref to Event
};





#endif

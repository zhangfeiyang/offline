#include "ReadOutAlg.h"
#include "SniperKernel/AlgFactory.h"
#include "SniperKernel/SniperLog.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "SniperKernel/Incident.h"
#include "InputReviser/InputReviser.h"
#include "Identifier/CdID.h"
#include "Event/SimHeader.h"
#include "Event/SimEvent.h"
#include "Event/SimPMTHit.h"
#include <time.h>
#include <TMath.h>
#include <TRandom.h>
#include <TStopwatch.h>
#include <TTimeStamp.h>
#include <TString.h>
#include "Context/TimeStamp.h"
#include "SniperKernel/Task.h"
#include "GlobalTimeSvc/IGlobalTimeSvc.h"
#include "ElecDataStruct/EventKeeper.h"


using namespace std;

DECLARE_ALGORITHM(ReadOutAlg);


ReadOutAlg::ReadOutAlg(const string& name):AlgBase(name){


}

ReadOutAlg::~ReadOutAlg(){

}


bool ReadOutAlg::initialize(){

    m_evtID=0;
    get_Services();

    // SniperPtr<DataRegistritionSvc> drsSvc(getScope(), "DataRegistritionSvc");
    // if ( drsSvc.invalid() ) {
    //         LogError << "Failed to get DataRegistritionSvc!" << std::endl;
    //             throw SniperException("Make sure you have load the DataRegistritionSvc.");
    // }
    // // FIXME: Why we need register Data???
    // drsSvc->registerData("JM::ElecEvent", "/Event/Elec");

    return true;
}


bool ReadOutAlg::execute(){

    LogInfo<<"begin event: " <<m_evtID<<endl; 
    get_TriggerTime();
    create_new_crate();

    produce_waveform();
    ReadOutOneEvent();

    delete_crate();
    

    //CheckOutWaveform();
//
    pop_TriggerTime();//every evt, use one TriggerTime and pop it 



    m_evtID++;
    return true;
}


bool ReadOutAlg::finalize(){


    return true;
}



bool ReadOutAlg::get_Services(){

    SniperPtr<IGlobalTimeSvc> TimeSvcPtr(Task::top(),"GlobalTimeSvc"); 
    TimeSvc = TimeSvcPtr.data();


    SniperPtr<IElecBufferMgrSvc> BufferSvcPtr(Task::top(),"ElecBufferMgrSvc");
    BufferSvc = BufferSvcPtr.data();



    return true;
}


bool ReadOutAlg::put_hit_into_buffer(){

    TTimeStamp Evt_TimeStamp = TimeSvc->get_current_evt_time();
    TimeStamp m_Evt_TimeStamp(Evt_TimeStamp.GetSec(),Evt_TimeStamp.GetNanoSec());//convert TTimeStamp to TimeStamp


    TimeStamp firstHitTime(0); //create variable to save firstHitTime


    //find firstHitTime , if no hit in buffer, the firstHitTime=start_time
    if(BufferSvc->get_HitBuffer().size() == 0){
        firstHitTime = TimeSvc->get_start_time(); //this function return TimeStamp type
        LogInfo<<"the buffer is empty, so the firstHitTime is start time: "<<firstHitTime<<endl;

    }else{
        firstHitTime = BufferSvc->get_firstHitTime();
        LogInfo<<"firstHitTime in buffer: " <<firstHitTime<<endl;
    }


    LogInfo<<"current Evt_TimeStamp: " <<m_Evt_TimeStamp<<endl;

    //to control the HitBuffer length 
    TimeStamp delta_TimeStamp = m_Evt_TimeStamp - firstHitTime ;
    LogInfo<<"delta_TimeStamp: " << delta_TimeStamp<<endl;
    LogInfo<<"delta_TimeStamp in nanosecond: " << delta_TimeStamp.GetSeconds() * 1e9<<endl;



    while(delta_TimeStamp.GetSeconds() * 1e9 < 2000){

        LogInfo<<"Incident::fire UnpackingTask"<<endl;
        Incident::fire("UnpackingTask");


        Evt_TimeStamp = TimeSvc->get_current_evt_time();
        TimeStamp m_Evt_TimeStamp(Evt_TimeStamp.GetSec(),Evt_TimeStamp.GetNanoSec());
        LogInfo<<"current Evt_TimeStamp: " <<m_Evt_TimeStamp<<endl;


        firstHitTime = BufferSvc->get_firstHitTime();
        LogInfo<<"firstHitTime in buffer: " <<firstHitTime<<endl;

        delta_TimeStamp = m_Evt_TimeStamp - firstHitTime ;
        LogInfo<<"delta_TimeStamp: " << delta_TimeStamp<<endl;
        LogInfo<<"delta_TimeStamp in nanosecond: " << delta_TimeStamp.GetSeconds() * 1e9<<endl;

    }

    return true;
}



bool ReadOutAlg::get_TriggerTime(){

    m_TriggerBuffer = BufferSvc->get_TriggerBuffer();

    LogInfo<<"Trigger Buffer size: " << m_TriggerBuffer.size()<<endl;

    if(m_TriggerBuffer.size() == 0){
        LogInfo<<"Trigger Buffer size is 0, do PreTrgTask" <<endl;

        LogInfo<<"Incident::fire PreTrgTask"<<endl;
        Incident::fire("PreTrgTask");

    }


    TriggerTime = BufferSvc->get_TriggerTimeStamp();  

    m_TriggerBuffer = BufferSvc->get_TriggerBuffer();
    LogInfo<<"trigger buffer size: " << m_TriggerBuffer.size()<<endl;
    LogInfo<<"TriggerTime(ns): "  << TriggerTime.GetSeconds()*1e9<<endl;


    return true;
}

void ReadOutAlg::produce_waveform(){

    m_TriggerBuffer = BufferSvc->get_TriggerBuffer();
    LogInfo<<"trigger buffer size: " << m_TriggerBuffer.size()<<endl;

    if(m_TriggerBuffer.size() != 0){

        LogInfo<<"we have TriggerTime, Incident::fire WaveformSimAlg" <<endl;
        Incident::fire("WaveformSimTask");
    }else{
        LogInfo<<"Error! No TriggerTime in TriggerBuffer! "<<endl;
    }

}






void ReadOutAlg::CheckOutWaveform(){

    // bool Waveform_is_enough = BufferSvc->WaveformBufferEnough(TriggerTime, ReadOutLength);


    bool Waveform_is_enough = false;

    if(Waveform_is_enough == false){


        LogInfo<<"Waveform isn't enough, Incident::fire WaveformSimTask"<<endl;
        Incident::fire("WaveformSimTask");

    }


}



void ReadOutAlg::pop_TriggerTime(){
   
    BufferSvc->pop_TriggerTimeStamp();
}


void ReadOutAlg::ReadOutOneEvent(){
    
    JM::ElecFeeCrate* m_crate = BufferSvc->get_crate();

    JM::EvtNavigator* nav = new JM::EvtNavigator();
    // FIXME: use the real time stamp
    nav->setTimeStamp(TTimeStamp(TriggerTime.GetSec(),TriggerTime.GetNanoSec()));

    SniperPtr<IDataMemMgr> mMgr(getScope(), "BufferMemMgr");
    mMgr->adopt(nav, "/Event");

    JM::ElecHeader* elec_hdr = new JM::ElecHeader;
    JM::ElecEvent * elec_evt = new JM::ElecEvent;

    elec_evt->setElecFeeCrate(*m_crate);
    //FIXME: because the Data Model don't use pointer in
    // current version, it will copy the whole data.
    // After copy the data, we should remove the original one.
    // set the relation
    elec_hdr -> setEvent(elec_evt);
    nav->addHeader("/Event/Elec", elec_hdr);

    // Try to associate SimEvents with this event navigator
    // A problem is that SimHeader may be invalid.
    EventKeeper& keeper = EventKeeper::Instance();    

    const EventKeeper::Record& record = keeper.current_record();
    LogInfo << "EventKeeper::Record::simevents::size(): " << record.simevents.size() << std::endl;
    int cnt = 0;
    for (std::map<EventKeeper::Entry, int>::const_iterator it = record.simevents.begin();
         it != record.simevents.end(); ++it) {
        // nav->addHeader("/Event/Sim", it->first.header);
        // nav->copyHeader(it->first.evtnav.get(), "/Event/Sim", Form("/Event/Sim[%d]", cnt));
        nav->copyHeader(it->first.evtnav.get(), "/Event/Sim", "/Event/Sim");

        ++cnt;
    }
    keeper.commit();
}


void ReadOutAlg::create_new_crate(){
    LogInfo<<"create new crate!" <<endl;
    BufferSvc->create_new_crate();

}

void ReadOutAlg::delete_crate(){
    if(m_TriggerBuffer.size() == 0){}else{
    BufferSvc->delete_crate();}
}









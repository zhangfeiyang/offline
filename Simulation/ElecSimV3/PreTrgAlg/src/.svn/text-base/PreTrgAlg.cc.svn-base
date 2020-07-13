#include "PreTrgAlg.h"
#include "SniperKernel/AlgFactory.h"
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
#include "Context/TimeStamp.h"
#include "SniperKernel/Task.h"
#include "GlobalTimeSvc/IGlobalTimeSvc.h"
#include "ElecBufferMgrSvc/IElecBufferMgrSvc.h"
#include "ElecDataStruct/Hit.h"
#include "ElecDataStruct/Pulse.h"
#include <deque>


using namespace std;

DECLARE_ALGORITHM(PreTrgAlg);


PreTrgAlg::PreTrgAlg(const string& name):AlgBase(name){
    declProp("PulseBufferLength",m_PulseBufferLength=2000);//unit ns
    declProp("PreTrigger_PulseNum",m_PreTrigger_PulseNum=200);// pulse number
    declProp("Trigger_FiredPmtNum",m_Trigger_FiredPmtNum=800);// pulse number for 0.7MeV threshold,1MeV~1200 fired pmt num
    declProp("Trigger_window",m_Trigger_window=300);// ns
    declProp("Trigger_slip_window",m_Trigger_slip_window=25);// ns
    declProp("Interval_of_two_TriggerTime",m_Interval_of_two_TriggerTime=1000);// ns

}


PreTrgAlg::~PreTrgAlg(){

}


bool PreTrgAlg::initialize(){

    get_Services();



    return true;
}


bool PreTrgAlg::execute(){

    LogInfo<<"execute PreTrgAlg !"<<endl;

    find_Trg_from_PulseBuffer(); // for sample test,I get trigger from PulseBuffer.If the hits in buffer not enough, I do the UnpackingAlg.







    return true;
}



bool PreTrgAlg::finalize(){


    return true;
}



bool PreTrgAlg::find_Trg_from_PulseBuffer(){

    m_TriggerBuffer = BufferSvc->get_TriggerBuffer();

    while(m_TriggerBuffer.size() == 0){

        T_pmtNum.clear();

        //when I find Trg, first I make sure there are enough Pulse in the Buffer .

        int m_PulseBufferSize = BufferSvc->get_PulseBufferSize();

        //LogInfo<<"m_PulseBufferSize: " <<m_PulseBufferSize<<endl;
        TimeStamp delta_PulseTimeStamp(0);   //I set the initial delta_PulseTimeStamp = 0, if the m_PulseBufferSize < 2, the delta_PulseTimeStamp = 0.

        if(m_PulseBufferSize >= 2){
            TimeStamp firstPulseTime = BufferSvc->get_firstPulseTime();

            TimeStamp lastPulseTime = BufferSvc->get_lastPulseTime();

            delta_PulseTimeStamp = lastPulseTime - firstPulseTime;
        }

        LogInfo<<"delta_PulseTimeStamp(ns): " << delta_PulseTimeStamp.GetSeconds()*1e9<<endl;

        LogInfo<<"PulseBufferLength: " << m_PulseBufferLength <<" ns"<<endl;
        while(delta_PulseTimeStamp.GetSeconds() * 1e9 < m_PulseBufferLength){
            LogInfo<<"PulseBuffer don't have enough Pulse , Incident::fire PmtSimTask"<<endl;

            Incident::fire("PMTSimTask");

            m_PulseBufferSize = BufferSvc->get_PulseBufferSize();

            LogInfo<<"PulseBuffer size: "<<m_PulseBufferSize<<endl;

            if(m_PulseBufferSize >= 2){
                TimeStamp firstPulseTime = BufferSvc->get_firstPulseTime();

                //LogInfo<<"firstPulseTime(ns): " <<firstPulseTime.GetSeconds()*1e9<<endl;
                LogInfo<<"firstPulseTime(ns): " <<firstPulseTime<<endl;

                TimeStamp lastPulseTime = BufferSvc->get_lastPulseTime();

                LogInfo<<"lastPulseTime(ns): "<<lastPulseTime.GetSeconds()*1e9<<endl;

                delta_PulseTimeStamp = lastPulseTime - firstPulseTime;
                LogInfo<<"delta_PulseTimeStamp(ns): " << delta_PulseTimeStamp.GetSeconds()*1e9<<endl;
            }
        }

        //get Trigger TimeStamp

        //TimeStamp TriggerTime = BufferSvc->get_firstPulseTime(); //for sample test, use firstPulseTime as TriggerTime

        LogInfo<<"begin trigger Alg, before PreTrigger"<<endl;

        TimeStamp PulseTime_for_trigger = BufferSvc->get_firstPulseTime();
        PulseTime_for_trigger.Add(m_PulseBufferLength/2.0 * 1e-9);  //this time used to give which pulse will be used to get trigger

        std::vector<Pulse> PulseVector_for_trigger = BufferSvc->get_PulseVector_without_pop(PulseTime_for_trigger);

        if(PulseVector_for_trigger.size() < m_PreTrigger_PulseNum){ //not enough pulse in pulseVector_for_trigger
            LogInfo<<"not enough pulse, pop 1/4 pules time length, and put more pulse in" <<endl;
            TimeStamp PulseTime_for_pop = BufferSvc->get_firstPulseTime();
            PulseTime_for_pop.Add(m_PulseBufferLength/4.0 * 1e-9);  //this time used to give which pulse will be poped 

            //pop pulse which TimeStamp < PulseTime_for_pop
            TimeStamp firstPulse_Time = BufferSvc->get_firstPulseTime();
            //LogInfo<<"firstPulse_Time(ns): " <<firstPulse_Time.GetSeconds()*1e9<<endl;

            while(firstPulse_Time < PulseTime_for_pop){
                BufferSvc->pop_PulseBufferFront();
                firstPulse_Time = BufferSvc->get_firstPulseTime();
                //LogInfo<<"in while, firstPulse_Time(ns): " <<firstPulse_Time.GetSeconds()*1e9<<endl;
            }

        }else{    // Trigger Alg PulseVector have enough pulse to find triggerTime

            LogInfo<<"we have enough pulse , do trigger Alg" <<endl;
            TimeStamp first_PulseTime_in_temVector = PulseVector_for_trigger[0].pulseHitTime();

            std::vector<Pulse>::iterator it;
            for(it=PulseVector_for_trigger.begin();
                    it!=PulseVector_for_trigger.end();
                    it++){

                int time_index = int( (it->pulseHitTime() - first_PulseTime_in_temVector).GetSeconds()*1e9  );

                T_pmtNum[time_index][it->pmtID()]=1;  // the 1 is not use, we just use the size
            }

            int end_index = (PulseTime_for_trigger - first_PulseTime_in_temVector).GetSeconds()*1e9;


            //slip window to find TriggerTime

            TimeStamp temp_Time(0);

            for(int i=0; i<end_index - m_Trigger_window; i= i + m_Trigger_slip_window){

                double pmt_num_in_triggerWindow = 0;
                T_pmtNum_without_overlap.clear();
                for(int j=0; j<m_Trigger_window; j++){
                
                    std::map<int,int>::iterator it;
                    for(it=T_pmtNum[j+i].begin(); it!=T_pmtNum[j+i].end(); it++ )
                     {
                    T_pmtNum_without_overlap.insert(pair<int,int>(it->first,1));
                    }  
                  //  pmt_num_in_triggerWindow += T_pmtNum[i+j].size(); //the size is the fired pmt num
                   }

                    pmt_num_in_triggerWindow = T_pmtNum_without_overlap.size();

                  //  LogInfo<<"pmt_num_in_triggerWindow: "<<pmt_num_in_triggerWindow<<endl;

                if(pmt_num_in_triggerWindow > m_Trigger_FiredPmtNum){
                    TimeStamp TriggerTime = first_PulseTime_in_temVector;
                    TriggerTime.Add(i*1e-9); 
                    if(temp_Time.GetSeconds() == 0){
                        BufferSvc->save_to_TriggerBuffer(TriggerTime);
                        temp_Time = TriggerTime;

                    }else if( (TriggerTime - temp_Time).GetSeconds()*1e9 > m_Interval_of_two_TriggerTime ){
                        BufferSvc->save_to_TriggerBuffer(TriggerTime);
                        temp_Time = TriggerTime;
                    }
                  }
               }

            m_TriggerBuffer = BufferSvc->get_TriggerBuffer();
            if(m_TriggerBuffer.size() == 0){
                LogInfo<<"we have enough pulse in vecotor, but don't find trigger, we need pop pulse time length" <<endl;

                TimeStamp PulseTime_for_pop = BufferSvc->get_firstPulseTime();
                PulseTime_for_pop.Add(m_PulseBufferLength/4.0 * 1e-9);  //this time used to give which pulse will be poped 

                //pop pulse which TimeStamp < PulseTime_for_pop
                TimeStamp firstPulse_Time = BufferSvc->get_firstPulseTime();
                //LogInfo<<"firstPulse_Time(ns): " <<firstPulse_Time.GetSeconds()*1e9<<endl;

                while(firstPulse_Time < PulseTime_for_pop){
                    BufferSvc->pop_PulseBufferFront();
                    firstPulse_Time = BufferSvc->get_firstPulseTime();
            //        LogInfo<<"in while, firstPulse_Time(ns): " <<firstPulse_Time.GetSeconds()*1e9<<endl;
                }
            }

        }

        m_TriggerBuffer = BufferSvc->get_TriggerBuffer(); //update the TriggerBuffer,then we can see if trigger time in buffer
//    if(m_TriggerBuffer.size() == 0){return true; }

    }
    return true;
}





bool PreTrgAlg::get_Services(){

    SniperPtr<IGlobalTimeSvc> TimeSvcPtr(Task::top(),"GlobalTimeSvc"); 
    TimeSvc = TimeSvcPtr.data();


    SniperPtr<IElecBufferMgrSvc> BufferSvcPtr(Task::top(),"ElecBufferMgrSvc");
    BufferSvc = BufferSvcPtr.data();



    return true;
}























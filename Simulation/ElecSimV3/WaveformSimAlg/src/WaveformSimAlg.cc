#include "WaveformSimAlg.h"
#include "SniperKernel/AlgFactory.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "SniperKernel/Incident.h"
#include "InputReviser/InputReviser.h"
#include "Identifier/CdID.h"
#include "Event/SimHeader.h"
#include "Event/SimEvent.h"
#include "Event/SimPMTHit.h"
#include "Event/ElecHeader.h"
#include <time.h>
#include <TMath.h>
#include <TROOT.h>
#include <TRandom.h>
#include <TStopwatch.h>
#include <TTimeStamp.h>
#include "Context/TimeStamp.h"
#include "SniperKernel/Task.h"
#include "GlobalTimeSvc/IGlobalTimeSvc.h"
#include "ElecBufferMgrSvc/IElecBufferMgrSvc.h"
#include "ElecDataStruct/Hit.h"
#include "ElecDataStruct/EventKeeper.h"
#include "RootWriter/RootWriter.h"

#include "SniperKernel/SniperPtr.h"  
#include "SniperKernel/ToolFactory.h"
#include "SniperKernel/SniperLog.h"  


using namespace std;

DECLARE_ALGORITHM(WaveformSimAlg);


WaveformSimAlg::WaveformSimAlg(const string& name):AlgBase(name){

    declProp("preWaveSimWindow",m_preWaveSimWindow=500); //unit ns , this timeWindow decide which Pulse will be put into pulse_vector
    declProp("postWaveSimWindow",m_postWaveSimWindow=1250);

////////////////

    declProp("preTimeTolerance", m_preTimeTolerance=100); //unit ns

    declProp("postTimeTolerance", m_postTimeTolerance=900);

    declProp("PulseSampleWidth", m_PulseSampleWidth=150);  //unit ns, the time window for one Ideal pulse waveform width
    declProp("enableOvershoot", m_enableOvershoot=false);
    declProp("enableSatuation", m_enableSatuation=false);
    declProp("enableNoise", m_enableNoise=false);
    declProp("enableFADC", m_enableFADC=false);
    declProp("simFrequency", m_simFrequency=1e9);
    declProp("noiseAmp", m_noiseAmp=0.5e-3);
    declProp("speAmp", m_speAmp=5.6e-3);
    declProp("PmtTotal", m_PmtTotal=17746);
    declProp("waveform_width", m_width=13e-9);
    declProp("waveform_mu", m_mu=0.43);

    declProp("FadcRange", m_FadcRange=1);//unit: the number of pe.
    declProp("FadcBit", m_FadcBit=8);
    declProp("FadcOffset", m_FadcOffset=5.6e-3);


    declProp("enableAssignSimTime", m_enableAssignSimTime=false);
    declProp("simTime", m_simTime=1250);




    m_linearityThreshold = 20;

    m_pulseCountSlotWidth = 10; //unit ns
    m_gainFactor = 1.0; //Mean PMT gain (in units of 10^7) 
    m_pulseCountWindow = 1; // Number of counted slots before and after a pulse




}

WaveformSimAlg::~WaveformSimAlg(){

}





bool WaveformSimAlg::initialize(){

    m_eventID = 0;
    get_Services();
    loadResponse();

    return true;

}



bool WaveformSimAlg::execute(){

    LogInfo<<"execute WaveformSimAlg! "<<endl;
    clear_vector();//clear temp_pulse_vector

    load_Pulse();

    produce_Waveform();

    m_evt_tree -> Fill();

    m_eventID ++;







    return true;
}


bool WaveformSimAlg::finalize(){


    return true;
}


void WaveformSimAlg::clear_vector(){
    LogInfo<<"clear temp pulse_vector"<<endl;
    pulse_vector.clear(); 


    // clear vectors
    m_PulseTime_Offset.clear();
    m_nPE_perPMT.clear();
    m_PMTID.clear();

    m_Amplitude.clear();
    m_PMTID_perPulse.clear();

    m_nevents = 0;
    m_tags.clear();
    m_filenames.clear();
    m_entries.clear();
    m_nhits.clear();
}



void WaveformSimAlg::get_Services(){

    SniperPtr<IGlobalTimeSvc> TimeSvcPtr(Task::top(),"GlobalTimeSvc");
    TimeSvc = TimeSvcPtr.data();

    SniperPtr<IElecBufferMgrSvc> BufferSvcPtr(Task::top(),"ElecBufferMgrSvc");
    BufferSvc = BufferSvcPtr.data();





    SniperPtr<RootWriter> svc("RootWriter");
    if (svc.invalid()) {
        LogError << "Can't Locate RootWriter. If you want to use it, please "
            << "enalbe it in your job option file."
            << std::endl;
        return;
    }

    gROOT->ProcessLine("#include <vector>");

    m_evt_tree = svc->bookTree("SIMEVT", "TTS and Amplitude information");

    m_evt_tree->Branch("evtID", &m_eventID, "evtID/I");
    m_evt_tree->Branch("nPMT", &m_nPMT, "nPMT/I");
    m_evt_tree->Branch("nPulse", &m_nPulse, "nPulse/I");
    m_evt_tree->Branch("nPE_perPMT", &m_nPE_perPMT);
    m_evt_tree->Branch("PMTID", &m_PMTID);
    m_evt_tree->Branch("adc_firstPE", m_adc_firstPE, "adc_firstPE[1250]/I");
    m_evt_tree->Branch("PMTID_perPulse", &m_PMTID_perPulse);
    m_evt_tree->Branch("Amplitude", &m_Amplitude);
  //  m_evt_tree->Branch("PulseTime_Offset", &m_PulseTime_Offset);


    m_index_tree = svc->bookTree("SIMEVT/eventindex",
                               "event index between SimEvent and ElecEvent");
    m_index_tree->Branch("eventid", &m_eventID);
    m_index_tree->Branch("nevents", &m_nevents);
    m_index_tree->Branch("tags", &m_tags);
    m_index_tree->Branch("filenames", &m_filenames);
    m_index_tree->Branch("entries", &m_entries);
    m_index_tree->Branch("nhits", &m_nhits);

}


void WaveformSimAlg::load_Pulse(){

    //make sure lastPulseTime > WaveSimLastTime
    TimeStamp TriggerTime = BufferSvc->get_TriggerTimeStamp();

    m_simTimeEarliest = TriggerTime;
    m_simTimeEarliest.Subtract(m_preTimeTolerance*1e-9);


    TimeStamp lastPulseTime = BufferSvc->get_lastPulseTime();

    TimeStamp WaveSimLastTime(0);
    WaveSimLastTime = TriggerTime;
    //    WaveSimLastTime.Add(m_preWaveSimWindow*1e-9);
    WaveSimLastTime.Add(m_postWaveSimWindow*1e-9); //the lastPulseTime must greater than the WaveSimLastTime.


    LogInfo<<"WaveSimLastTime: " <<WaveSimLastTime.GetSeconds()*1e9<<endl;
    LogInfo<<"lastPulseTime: " << lastPulseTime.GetSeconds()*1e9<<endl;



    while(WaveSimLastTime > lastPulseTime){
        LogInfo<<"the WaveSimLastTime > lastPulseTime, Incident::fire PMTSimTask" <<endl;

        Incident::fire("PMTSimTask");
        LogInfo<<"Error, if endless loop!!" <<endl;
        lastPulseTime = BufferSvc->get_lastPulseTime();
        LogInfo<<"lastPulseTime: " << lastPulseTime.GetSeconds()*1e9<<endl;

    }

    // pop Pulse before WaveSimFirstTime=TriggerTime-m_preWaveSimWindow

    TimeStamp WaveSimFirstTime(0);
    WaveSimFirstTime = TriggerTime;
    WaveSimFirstTime.Subtract(m_preWaveSimWindow*1e-9);
    //WaveSimFirstTime.Add(100*1e-9);

    LogInfo<<"WaveSimFirstTime: " <<WaveSimFirstTime.GetSeconds()*1e9<<endl;

    TimeStamp firstPulseTime = BufferSvc->get_firstPulseTime();

    LogInfo<<"firstPulseTime(ns): " <<firstPulseTime.GetSeconds()*1e9<<endl;

    while(firstPulseTime < WaveSimFirstTime){
        BufferSvc->pop_PulseBufferFront();       
        firstPulseTime = BufferSvc->get_firstPulseTime();
        //LogInfo<<"in while, firstPulseTime(ns): " <<firstPulseTime.GetSeconds()*1e9<<endl;

    }


    //get pulse_vector for WaveFormSim

    pulse_vector = BufferSvc->get_PulseVector(WaveSimLastTime);
    LogInfo<<"pulse vector size for waveform sim: " << pulse_vector.size()<<endl;


    int TTS_index = 0;
    m_nPulse = pulse_vector.size();
    vector<Pulse>::iterator it=pulse_vector.begin(); 
    m_firstPE_PMTID =  it->pmtID(); 

    // Now, the pulses will be used for waveform simulation,
    // and must be in the ElecEvent. So we add the Entry info into EventKeeper.
    // -- Tao Lin <lintao@ihep.ac.cn>, 2017/10/13
    EventKeeper& keeper = EventKeeper::Instance();    

    for (vector<Pulse>::iterator it=pulse_vector.begin(); 
            it != pulse_vector.end(); ++it) {
        keeper.add(it->entry());
      //  m_TTS[TTS_index] = it->TTS();
        m_Amplitude.push_back(it->amplitude());
        m_PMTID_perPulse.push_back(it->pmtID());

    //    int tOffset = int(  (it->pulseHitTime() - m_simTimeEarliest).GetSeconds() * m_simFrequency  );
   //     m_PulseTime_Offset[TTS_index] = tOffset;

        TTS_index++;

    }

    // save index into tree
    const EventKeeper::Record& record = keeper.current_record();
    m_nevents = record.simevents.size();
    for (std::map<EventKeeper::Entry, int>::const_iterator it = record.simevents.begin();
         it != record.simevents.end(); ++it) {
        m_tags.push_back(it->first.tag);
        m_filenames.push_back(it->first.filename);
        m_entries.push_back(it->first.entry);
        m_nhits.push_back(it->second);
    }
    m_index_tree->Fill();
    // keeper.commit();



}



void WaveformSimAlg::produce_Waveform(){

    LogInfo<<"produce_Waveform!! " <<endl;

    TimeStamp TriggerTime = BufferSvc->get_TriggerTimeStamp();

    m_simTimeEarliest = TriggerTime;
    m_simTimeEarliest.Subtract(m_preTimeTolerance*1e-9);

    //m_simTimeLatest = pulse_vector.back().pulseHitTime();
    //m_simTimeLatest.Add(m_postTimeTolerance*1e-9);

    //if(!m_enableAssignSimTime){
    //    m_simTime = (m_simTimeLatest - m_simTimeEarliest).GetSeconds()*1e9;  //unit ns
    //}



    //LogInfo<<"first pulse time: " << pulse_vector.front().pulseHitTime().GetSeconds()*1e9<<endl;
    LogInfo<<"m_simTimeEarliest: " << m_simTimeEarliest.GetSeconds()*1e9<<endl;

    //LogInfo<<"last pulse time: " << pulse_vector.back().pulseHitTime().GetSeconds()*1e9<<endl;
    //LogInfo<<"m_simTimeLatest: " << m_simTimeLatest.GetSeconds()*1e9<<endl;

    if(m_enableAssignSimTime){
        LogInfo<<"Assign Sim Time: " << m_simTime<<endl;
    }else{

        LogInfo<<"simTime: " << m_simTime<<endl;

    }

    //get crate


    JM::ElecFeeCrate* crate = BufferSvc->get_crate();

    if(crate->channelData().size() == 0){

        for(int pmtIdx = 0; pmtIdx < m_PmtTotal; pmtIdx++){

            crate->channelData()[pmtIdx];
        } 

    }else{
        LogInfo << "does not initialize crate" << std::endl;
    }

    // set EvtTimeStamp and triggerTime
    crate->setEvtTimeStamp(m_simTimeEarliest);   //TriggerTime - preTimeTolerance
    crate->setTriggerTime(TriggerTime);



    // Organize Pulses by Channel(pmtID)
    map<int, vector<Pulse> > pulseMap;
    mapPulsesByChannel(pulse_vector, pulseMap);

    const map<int,JM::ElecFeeChannel>& channelData = crate->channelData();

    m_nPMT = 0;

    for(int channelId=0; channelId<m_PmtTotal; channelId++){

        JM::ElecFeeChannel& channel = crate->channelData()[channelId];

        if(pulseMap[channelId].size() > 0){
            m_PMTID.push_back(channelId);
            m_nPE_perPMT.push_back(pulseMap[channelId].size());
            generateOneChannel(channelId, pulseMap[channelId], channel); 
         if(channelId == m_firstPE_PMTID)for(int i=0; i<m_simTime; i++){
              m_adc_firstPE[i] = channel.adc()[i];
              }
            m_nPMT ++;

        }



    }


    //BufferSvc->set_standard_TimeStamp(m_simTimeLatest); //roll the waveform buffer standard index

}



void WaveformSimAlg::loadResponse(){
    double dT_seconds = (1. / m_simFrequency);
    double PulseSampleWidth = m_PulseSampleWidth*1e-9; //unit s

    int nPulseSamples = int(PulseSampleWidth/dT_seconds);
    int nOvershootSamples = int(16000/(dT_seconds*1e9)); //1 second == 1e9 ns
    m_pmtPulse.resize(nPulseSamples);
    m_overshoot.resize(nOvershootSamples);


    for (int i=0; i<nPulseSamples; i++) {
        m_pmtPulse[i] = pmtPulse(i*dT_seconds,1);
    }


    for (int i=0; i<nOvershootSamples; i++) {

        m_overshoot[i] = 0;
        // Store overshoot for raw signal
        if(m_enableOvershoot){
            m_overshoot[i] += overshoot(i*dT_seconds);
        }
    }


    //////dump information


    //            for(int i=0; i<nPulseSamples; i++){
    //                LogInfo<<"Ideal Pulse Waveform Sample: " << m_pmtPulse[i]<<"  "<< i<<endl;
    //            }

    if( !m_enableOvershoot ){
        LogInfo<<"Overshoot disabled"<<endl; 
    }else{
        LogInfo<<"Overshoot enabled"<<endl;
    }


    if( !m_enableSatuation ){ 
        LogInfo << "Saturation disabled" << endl; 
    }else{ 
        LogInfo << "Saturation enabled" << endl;
    }


}




double WaveformSimAlg::pmtPulse(double deltaT, int nPulse) {
    // Return ideal single pe pulse with amplitude 1 V
    double width; // pulse width parameter
    double mu; // parameter determining the degree of asymmetry
    //if ( nPulse > 1 ){
    //    width = getPulseWidth( nPulse); 
    //    mu    = getPulseForm( nPulse);
    //}
    //else {
    //    width = 7.5e-9;
    //    mu    = 0.45;
    //}

    //width = 14e-9;   //fangxiao change it to 20inch MCP-PMT's parameter
    //mu = 0.45;

    width = m_width;
    mu = m_mu;

    double shift = 6e-9 -width/1.5;
    if (deltaT-shift<0) return 0.;


    return - exp( -pow( log( (deltaT-shift)/width),2) 
            / ( 2*pow(mu,2) ) ) ;  // unit V
}



double WaveformSimAlg::overshoot(double deltaT) {
    if (deltaT < 0) return 0.;
    double amp = 0.01; // Relative overshoot amplitude for spe pulses
    // Fermi onset
    double t0   = 80e-9; 
    double t1   = 20e-9;
    double fermi = 1. / (exp( (t0 - deltaT) / t1) + 1.);
    // Exponential overshoot component
    double tau = 880.e-9; // Overshoot decay time in s
    double expoOS = exp(-(deltaT-87e-9)/tau);
    // Slower overshoot component
    double mean = 0.6e-6;
    double sigma = 0.1e-6;
    double t = deltaT -mean;
    double gausOS = 0.12 * exp(pow(t,2)/(-2*pow(sigma,2)));
    // Undershoot 
    mean = 0.7e-6;
    sigma = 0.14e-6;
    t = deltaT -mean;
    double undershoot = -0.03 * exp(pow(t,2)/(-2*pow(sigma,2)));

    return  amp * fermi * (expoOS + gausOS + undershoot)
        ; //unit V
}


void WaveformSimAlg::mapPulsesByChannel(vector<Pulse>& pulse_vector, 
        map<int, std::vector<Pulse> >& pulseMap){

    for (vector<Pulse>::iterator it=pulse_vector.begin(); 
            it != pulse_vector.end(); ++it) {
       
        (pulseMap[it->pmtID()]).push_back(*it); 
    }
}



void WaveformSimAlg::generateOneChannel(int channelId, vector<Pulse>& channelPulses, JM::ElecFeeChannel& channel){

    // The number of samples in time given the simulation frequency
    TimeStamp TriggerTime = BufferSvc->get_TriggerTimeStamp();

    TimeStamp WaveSimFirstTime(0);
    WaveSimFirstTime = TriggerTime;
    WaveSimFirstTime.Subtract(m_preWaveSimWindow*1e-9);

    int simSamples = int(m_simTime * 1e-9 * m_simFrequency);


    if(simSamples != m_simTime){
        LogInfo<<"error, simSamples != m_simTime, simSamples: " << simSamples<<endl;
    }


    // Prepare Raw Signal
    if(m_rawSignal.size() != simSamples) m_rawSignal.resize( simSamples );

    double* rawStart = &m_rawSignal[0];

    for( unsigned int sigIdx = 0; sigIdx!=simSamples; sigIdx++){
        *(rawStart + sigIdx) = 0;
    } 


    // Add noise to raw signal if requested
    if( m_enableNoise ){
        for(unsigned int index=0; index < simSamples; index++){
            *(rawStart + index) += noise();
        }
    }



    int channelPulsesN = channelPulses.size();

    if( channelPulsesN > 0 ){
        // Prepare time slots for pulse counting
        int numPulseTimeSlots = int(m_simTime
                /m_pulseCountSlotWidth) + 1;

        std::vector<int> pulseTimeSlots(numPulseTimeSlots);


        // Fill pulse count time slots
        // Count the number of pulses for each time slot to model nonlinearity
        for (int i = 0; i < numPulseTimeSlots; i++ ){ 
            pulseTimeSlots[i] = 0;
        }

        std::vector<Pulse>::iterator pulseIter, pulseDone = channelPulses.end();

        for(pulseIter=channelPulses.begin(); pulseIter != pulseDone; ++pulseIter){
            int timeSlot = int(  (pulseIter->pulseHitTime() - WaveSimFirstTime).GetSeconds()*1e9 
                    / m_pulseCountSlotWidth );


            int pulseNo = int(pulseIter->amplitude()+0.5);
            if(timeSlot>=numPulseTimeSlots) continue;
            pulseTimeSlots[timeSlot]+=pulseNo;
        }

        double* pmtPulseStart = &m_pmtPulse[0];
        double* overshootStart = &m_overshoot[0];

        int nPulseSamples = m_pmtPulse.size();
        int nOvershootSamples = m_overshoot.size();


        // Loop over pulses, add each to raw signal
        for(pulseIter=channelPulses.begin(); pulseIter != pulseDone; ++pulseIter){

            int tOffset = int(  (pulseIter->pulseHitTime() - m_simTimeEarliest).GetSeconds() * m_simFrequency  );

            float amplitude = pulseIter->amplitude() * m_speAmp * m_gainFactor;
            unsigned int nPulse=0;
            unsigned int nCoincPulse=0;
            float satAmp = amplitude;
            float satCharge = amplitude;

            // Count the total number of pulses within a nearby time window
            // This number is used to determine the nonlinearity
            if(channelPulsesN>5){

                int timeSlot = int(  (pulseIter->pulseHitTime() - WaveSimFirstTime).GetSeconds()*1e9
                        / m_pulseCountSlotWidth);

                nCoincPulse = pulseTimeSlots[timeSlot];

                for (int iSlot = timeSlot - m_pulseCountWindow; 
                        iSlot <= timeSlot + m_pulseCountWindow; iSlot++){
                    if(iSlot>=0 && iSlot<numPulseTimeSlots) 
                        nPulse += pulseTimeSlots[iSlot];
                }
                // Get saturated amplitudes
                satAmp *= ampSatFactor(nPulse);
                satCharge *= chargeSatFactor(nPulse);
            }else{
                nCoincPulse =1;
                nPulse = 1;
            }

            unsigned int nSamples = int(8.4 * nPulseSamples);


            // Now add pulses to the raw and shaped signal
            for(unsigned int index = 0; index < nSamples; index++){
                unsigned int sampleIdx = tOffset + index;
                double idxTime = index * (1. / m_simFrequency);
                if(sampleIdx>0 && sampleIdx<simSamples){
                    if(index<nPulseSamples) {
                        if(nPulse>m_linearityThreshold){
                            *(rawStart + sampleIdx) -= satAmp * pmtPulse(idxTime, nPulse);
                        }  else

                            *(rawStart + sampleIdx) -= satCharge * (*(pmtPulseStart + index));

                    }
                    // Add overshoot
                    if(m_enableOvershoot){
                        *(rawStart + sampleIdx) -= satCharge * (*(overshootStart+index));

                    }
                }
            }

        }// end loop pulse

    }

    vector<double>::iterator sig_it ;

    // for waveform buffer method

    //    TimeStamp index_stamp = m_simTimeEarliest;
    //
    //    for(sig_it = m_rawSignal.begin();
    //            sig_it != m_rawSignal.end(); 
    //            sig_it++){
    //
    //        BufferSvc->save_waveform(channelId, index_stamp, *sig_it); 
    //
    //
    //        index_stamp.Add(1*1e-9); 
    //    }


    //  add raw_waveform to channel
    int m_tdc_temp = 0;
    for(sig_it = m_rawSignal.begin();
            sig_it != m_rawSignal.end(); 
            sig_it++){
        //if(*sig_it!=0){   // fangxiao change it so I save all point 
        //cout<<"adc: " << *sig_it<<endl;

        if(m_enableFADC){

            channel.adc().push_back( FADC_sample(m_FadcRange*m_speAmp, *sig_it, m_FadcBit) ); 

        }else{
            channel.adc().push_back(*sig_it); 
        }

        //channel.tdc().push_back(m_tdc_temp); 
        //}

        m_tdc_temp++;
    }


}



double WaveformSimAlg::noise(){
    // Simple noise model
    // Approximate Gaussian-distributed noise
    return gRandom->Gaus(0,1.28) * m_noiseAmp; // no offset

}


double WaveformSimAlg::ampSatFactor(int nPulse){
    double q = double(nPulse);
    double qSat = 533.98;
    double a = 2.884;
    return saturationModel(q, qSat, a);

}


double WaveformSimAlg::chargeSatFactor(int nPulse){
    double q = double(nPulse);
    double qSat = 939.77;
    double a = 2.113;
    return saturationModel(q, qSat, a);
}


double WaveformSimAlg::saturationModel(double q, double qSat, double a){
    if(q<1) return 1;
    double num = pow(1 + 8*pow(q/qSat,a),0.5) - 1;
    double denom = 4* pow(q/qSat,a);
    return pow(num/denom,0.5);
}


int WaveformSimAlg::FADC_sample(double adc_range, double amp_val, double FadcBit){
    // double adc_range = 1; //unit v
    //double LSB = adc_range/TMath::Power(2,FadcBit);

    //int amp_adc = int( (amp_val+m_FadcOffset)/LSB );    //with noise some point<0
    //int amp_adc = int( (amp_val)/LSB );  


    double LSB = 0;

    double High_gain = 0.06;   //0.06pe/bit , for 8 bit: range=0.06 * 2^8
    double medium_gain = 0.4;
    double low_gain = 8;

    int    amp_adc = 0;
    unsigned int amp_Fadc = 0;
    double High_range = High_gain * TMath::Power(2, FadcBit) * m_speAmp;
    double medium_range = medium_gain * TMath::Power(2, FadcBit) * m_speAmp;
    double low_range = low_gain * TMath::Power(2, FadcBit) * m_speAmp;
    //LogInfo<<"high range pe: " << High_gain * TMath::Power(2,FadcBit)<<endl;

    if((amp_val+m_FadcOffset)<0){
     amp_Fadc = 0; 
    }else if( 0 <= (amp_val+m_FadcOffset) && (amp_val+m_FadcOffset) < High_range){
        LSB = High_range/TMath::Power(2,FadcBit);
     amp_adc = int( (amp_val+m_FadcOffset)/LSB );
     amp_Fadc = amp_adc+(high_range_marker<<8);
    }else if( High_range <= (amp_val+m_FadcOffset) && (amp_val+m_FadcOffset) < medium_range ){
        LSB = medium_range/TMath::Power(2,FadcBit);
     amp_adc = int( (amp_val+m_FadcOffset)/LSB );
     amp_Fadc = amp_adc+(medium_range_marker<<8);
    }else if(( amp_val+m_FadcOffset) >= medium_range ){
        LSB = low_range/TMath::Power(2,FadcBit);
     amp_adc = int( (amp_val+m_FadcOffset)/LSB );
     amp_Fadc = amp_adc+(low_range_marker<<8);
    }

     //amp_adc = int( (amp_val+m_FadcOffset)/LSB );    //with noise some point<0

    return amp_Fadc;

}






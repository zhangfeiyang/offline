#include "SniperKernel/ToolFactory.h"
#include "SniperKernel/SniperLog.h"
#include "SniperKernel/SniperPtr.h"
#include "EsPulseTool.h"
#include <iostream>


DECLARE_TOOL(EsPulseTool);

EsPulseTool::EsPulseTool(const std::string& name) : ToolBase(name)
{

    declProp("PmtTotal",m_PmtTotal=17746);
    declProp("enableAfterPulse", m_enableAfterPulse=true);
    declProp("enableDarkPulse", m_enableDarkPulse=true);
    declProp("enableEfficiency", m_enableEfficiency=false);
    declProp("enableAssignGain", m_enableAssignGain=false);
    declProp("enableAssignSigmaGain", m_enableAssignSigmaGain=false);
    declProp("inputGain", m_Gain=1);
    declProp("inputSigmaGain", m_SigmaGain=0.3);



    declProp("preTimeTolerance", m_preTimeTolerance=50);
    declProp("postTimeTolerance", m_postTimeTolerance=100);
    declProp("expWeight", m_expWeight=0.01);
    declProp("speExpDecay", m_speExpDecay=1.1);
    declProp("darkRate", m_darkRate=50e3);

    vertexTime = 0;
    m_timeInterval = 20; // unit ns 

    m_enableNonlinearAfterpulse = false;//Enable nonlinear suppression of afterpulsing
    m_veryLongTime = 3000; // Definition of very long time for hit time suppression
    m_afterPulseAmpMode ="SinglePE"; // Mode for afterpulse amplitude distribution
    m_darkPulseAmpMode ="SinglePE"; // Mode for dark pulse amplitude distribution 
    m_linearAfterpulseThreshold = 400;//Upper limit of linear afterpulsing in number of PE

    m_afterPulsePdf.clear();
    m_afterPulseEdges.clear();
    m_afterPulseTime.clear();

    for(int ii=0; ii < NUM_BINS_DIST; ii++) {
        m_afterPulsePdf.push_back(afterPusleTimingDist[ii]);
        m_afterPulseEdges.push_back(ii*100.+500.);
    }

    getAfterPulseAmpPdf(m_afterPulseAmpPdf); 
    getAfterPulseAmpEdges(m_afterPulseAmpEdges);

}

EsPulseTool::~EsPulseTool(){

}


void EsPulseTool::generatePulses(vector<Pulse>& pulse_vector, vector<Hit>& hit_vector, vector<PmtData>& pd_vector){


    cout<<"unit_hit_vector.size: "<<hit_vector.size()<<endl;

    // Define simulation time window
    double headerTime = m_simTimeEarliest;

    vector<Hit>::iterator hvIter; 
    vector<Hit>::iterator hvDone = hit_vector.end();

    map<int,vector<Pulse> >* p_pulsesByPmt = new map<int,vector<Pulse> >;
    map<int,vector<Pulse> >& pulsesByPmt = *p_pulsesByPmt;
    pulsesByPmt.clear();
    map<int,vector<Pulse> >::iterator pulsePmtIter,pulsePmtEnd;


    for (hvIter=hit_vector.begin(); hvIter != hvDone; ++hvIter) {

        double m_hitTime = hvIter->hitTime() ;  
        double m_weight = hvIter->weight();//The weight of the hit
        int m_pmtID = hvIter->pmtID(); 
        ///////////////////////////////////////////////////////////////////////////////
        //The main input parameter
        //They dependens on pmt
        const double m_efficiency = pd_vector[m_pmtID].efficiency();//pmtData the PMT efficiency to determine whether ignore SimHit

        double m_gain=0;
        double m_sigmaGain=0;

        if(m_enableAssignGain){
            m_gain = m_Gain;
        }else{
            m_gain = pd_vector[m_pmtID].gain();//pmtData Gain
        }

        if(m_enableAssignSigmaGain){
            m_sigmaGain = m_SigmaGain;
        }else{
            m_sigmaGain = pd_vector[m_pmtID].sigmaGain();//pmtData sigmaGain
        }


        const double m_afterPulseProb = pd_vector[m_pmtID].afterPulseProb();
        const double m_timeSpread = pd_vector[m_pmtID].timeSpread();
        const double m_timeOffset = pd_vector[m_pmtID].timeOffset();
        //////////////////////////////////////////////////////////////////////////////////


        if( double(m_hitTime - (headerTime  + preTimeTolerance)) >m_veryLongTime){
            continue;    //ignore very long time hit
        }

        if(m_enableEfficiency){ 
            if(gRandom->Rndm() > m_efficiency){
                continue;    //ignore SimHit due to efficiency
            }
        }

        //These two represent pmtData
        double transitTime = gRandom->Gaus(0,1) * m_timeSpread + m_timeOffset;
        double headerOffset = vertexTime - headerTime;//that is -m_simTimeEarliest
        double pulseHitTime = double(headerOffset + m_hitTime) + transitTime ; // m_hitTime is global time , pulseHitTime unit is ns

        //   cout<<"pulseHitTIme: "<< pulseHitTime <<endl;
        if(pulseHitTime<0) pulseHitTime=0;
        if(pulseHitTime>m_simDeltaT) pulseHitTime=m_simDeltaT;

        double amplitude = PulseAmp(m_weight,m_gain,m_sigmaGain);

        Pulse pulse(m_pmtID, amplitude, pulseHitTime);
        pulse_vector.push_back(pulse);

        //PMT pulse counting

        if(m_enableAfterPulse){
            if( m_enableNonlinearAfterpulse ){
                // Add pulse to the list for this PMT
                pulsesByPmt[m_pmtID].push_back(pulse);
            }else{
                // Immediatly add linear afterpulsing
                if (gRandom->Rndm() < m_afterPulseProb) 
                    pulse_vector.push_back(makeAfterPulse(pulse, pd_vector[m_pmtID]));
            }
        }
    }
    //////////////////////////////////////////end loop


    // Add afterpulses in nonlinear mode
    if(m_enableAfterPulse){
        if( m_enableNonlinearAfterpulse){
            pulsePmtEnd = pulsesByPmt.end(); 
            for(pulsePmtIter = pulsesByPmt.begin();pulsePmtIter != pulsePmtEnd;++pulsePmtIter){
                int pmt_ID = pulsePmtIter->first;
                vector<Pulse>& pulseList = pulsePmtIter->second;

                // Get PMT properties
                PmtData id_pd = pd_vector[pmt_ID]; 

                // Prepare a handle for memory buffer
                int* pulseCount = 0;

                // Process hits to make afterpulses
                vector<Pulse>::iterator pulseIter, 
                    pulseEnd = pulseList.end();

                if(pulseList.size() > m_linearAfterpulseThreshold ){
                    // Add Nonlinear afterpulsing
                    // Step 1: assemble pulse counts in a specified time window

                    int numTimeSlots = int( (m_simTimeLatest - headerTime)
                            *int( 1/(m_timeInterval) + 1) );

                    // allocate memory only if needed
                    if(!pulseCount) pulseCount = new int[numTimeSlots];
                    // Clear memory buffer
                    for(int i=0; i<numTimeSlots; i++) pulseCount[i] = 0;
                    // Loop once to create pulse counts
                    for(pulseIter=pulseList.begin(); pulseIter != pulseEnd; pulseIter++){
                        int hitTimeSlot = int((*pulseIter).pulseHitTime()/m_timeInterval);
                        int pulseNo = int((*pulseIter).amplitude()+0.5);
                        pulseCount[hitTimeSlot] += pulseNo;
                    }
                    // Loop again to create afterpulses
                    for(pulseIter=pulseList.begin(); pulseIter != pulseEnd; pulseIter++){
                        int hitTimeSlot = int((*pulseIter).pulseHitTime()/m_timeInterval);
                        double nonlinearProb = id_pd.afterPulseProb()/0.0164
                            *NumAfterPulse(pulseCount[hitTimeSlot]) / pulseCount[hitTimeSlot];
                        if (gRandom->Rndm()< nonlinearProb){ 
                            pulse_vector.push_back(makeAfterPulse(*pulseIter, id_pd));
                        }
                    }
                }else{
                    // Add Linear afterpulsing
                    for(pulseIter=pulseList.begin(); pulseIter != pulseEnd; pulseIter++){
                        if (gRandom->Rndm() < id_pd.afterPulseProb()){ 
                            pulse_vector.push_back(makeAfterPulse(*pulseIter, id_pd));
                        }
                    }
                }
                // Free memory buffer if it was used
                if(pulseCount) delete [] pulseCount;
            }
        }
    }




    // Process dark pulses
    if(m_enableDarkPulse){
        // Get list of all detector sensors

        for ( int pmtID=0; pmtID < m_PmtTotal; ++pmtID) {

            // Generate Poisson-distributed number around mean number of dark hits in simulation time window
            int Ndark = PoissonRand( (pd_vector[pmtID].darkRate()+(m_darkRate - 15e3) ) 
                    *double(m_simTimeLatest-m_simTimeEarliest)
                    *1.0e-9 ); //the mean value of old darkRate is 15e3,so we substract 15e3 for assign it from Property


            for (int dummy = 0; dummy < Ndark; ++dummy) {
                pulse_vector.push_back(makeDarkPulse(pmtID, pd_vector[pmtID]));
            }
        }
    }
    if(pulse_vector.size() > 0){
        cout << "pulse_vector size: " << pulse_vector.size() << endl;
    }

    if (p_pulsesByPmt)
    { delete p_pulsesByPmt;
    }
}





void EsPulseTool::SetSimTime(double earliest_item, double latest_item){

    // earliest_item unit is ns,  preTimeTolerance unit is ns
    m_simTimeEarliest = earliest_item - m_preTimeTolerance;
    m_simTimeLatest = latest_item + m_postTimeTolerance;
    m_simDeltaT = double(m_simTimeLatest - m_simTimeEarliest) ; // electronic simulation beginning and end times 
    cout<<"m_simDeltaT: " << m_simDeltaT<<endl;

}


void EsPulseTool::getAfterPulseAmpPdf(vector<double>& pdf){
    pdf.push_back(0);pdf.push_back(0.0219574);pdf.push_back(0.0931247);pdf.push_back(0.179757);
    pdf.push_back(0.264803);pdf.push_back(0.342568);pdf.push_back(0.411712);pdf.push_back(0.472498);
    pdf.push_back(0.525729);pdf.push_back(0.572335);pdf.push_back(0.613205);pdf.push_back(0.649137);
    pdf.push_back(0.702162);pdf.push_back(0.745131);pdf.push_back(0.780295);pdf.push_back(0.809341);
    pdf.push_back(0.842677);pdf.push_back(0.868769);pdf.push_back(0.889482);pdf.push_back(0.906131);
    pdf.push_back(0.930777);pdf.push_back(0.947671);pdf.push_back(0.95962);pdf.push_back(0.968294);
    pdf.push_back(0.974731);pdf.push_back(0.983341);pdf.push_back(0.988564);pdf.push_back(0.99189);
    pdf.push_back(0.994094);pdf.push_back(0.995601);pdf.push_back(0.996661);pdf.push_back(0.997423);
    pdf.push_back(0.997983);pdf.push_back(0.998401);pdf.push_back(0.998717);pdf.push_back(0.999151);
    pdf.push_back(0.999418);pdf.push_back(0.999591);pdf.push_back(0.999705);pdf.push_back(0.999783);
    pdf.push_back(0.999838);pdf.push_back(0.999876);pdf.push_back(0.999905);pdf.push_back(0.999926);
    pdf.push_back(0.999941);pdf.push_back(0.999953);pdf.push_back(0.999962);pdf.push_back(0.999969);
    pdf.push_back(0.999975);pdf.push_back(0.999979);pdf.push_back(0.999983);pdf.push_back(1.0);
}


void EsPulseTool::getAfterPulseAmpEdges(vector<double>& edges){
    edges.push_back(0.5);edges.push_back(0.7);edges.push_back(0.9);edges.push_back(1.1);
    edges.push_back(1.3);edges.push_back(1.5);edges.push_back(1.7);edges.push_back(1.9);
    edges.push_back(2.1);edges.push_back(2.3);edges.push_back(2.5);edges.push_back(2.7);
    edges.push_back(3.05);edges.push_back(3.4);edges.push_back(3.75);edges.push_back(4.1);
    edges.push_back(4.6);edges.push_back(5.1);edges.push_back(5.6);edges.push_back(6.1);
    edges.push_back(7.1);edges.push_back(8.1);edges.push_back(9.1);edges.push_back(10.1);
    edges.push_back(11.1);edges.push_back(13.1);edges.push_back(15.1);edges.push_back(17.1);
    edges.push_back(19.1);edges.push_back(21.1);edges.push_back(23.1);edges.push_back(25.1);
    edges.push_back(27.1);edges.push_back(29.1);edges.push_back(31.1);edges.push_back(35.1);
    edges.push_back(39.1);edges.push_back(43.1);edges.push_back(47.1);edges.push_back(51.1);
    edges.push_back(55.1);edges.push_back(59.1);edges.push_back(63.1);edges.push_back(67.1);
    edges.push_back(71.1);edges.push_back(75.1);edges.push_back(79.1);edges.push_back(83.1);
    edges.push_back(87.1);edges.push_back(91.1);edges.push_back(95.1);edges.push_back(100);
}


double EsPulseTool::PulseAmp(double weight,double gain, double sigmaGain){

    double amp;
    //    double m_expWeight = 0.01; //Weight of the exponential contribution to the spe response function
    //    double m_speExpDecay = 1.1;//Decay time of the exponential contribution to the spe response function
    double m_speCutoff = 0.15; //Charge cut against which the PMT efficiency is computed

    //include relative gain
    double randW = gRandom->Rndm();
    if (randW > m_expWeight || weight >1.1){
        amp = gRandom->Gaus(0,1) * sigmaGain * TMath::Sqrt(weight) + gain * weight;
    }
    else {
        amp = (gRandom->Exp(m_speExpDecay) + m_speCutoff) * gain * weight;
    }
    if(amp<0) amp = 0;

    return amp;
}



Pulse EsPulseTool::makeAfterPulse(Pulse pulse,PmtData pd){

    // Time offset from main pulse based on time PDF of after-pulses
    // double current_rand = m_randAfterPulseTime();

    double pulseHitTime;
    double amplitude;

    double current_rand = gRandom -> Rndm();
    double afterPulseTime = ConvertPdfRand01(current_rand,m_afterPulsePdf,m_afterPulseEdges) + pulse.pulseHitTime(); 
    //cout<<"ConvertPdfRand01:  " << ConvertPdfRand01(current_rand,m_afterPulsePdf,m_afterPulseEdges)<<endl;
    // cout<<"afterPulseTime:  "<< afterPulseTime <<endl;

    if(afterPulseTime > m_simDeltaT) afterPulseTime = m_simDeltaT;
    pulseHitTime = afterPulseTime ;

    if(m_afterPulseAmpMode == "SinglePE") { 

        if(m_enableAssignGain && m_enableAssignSigmaGain){
            amplitude = PulseAmp(pulse.amplitude(), m_Gain, m_SigmaGain);
        }else{
            amplitude = PulseAmp(pulse.amplitude(),pd.gain(),pd.sigmaGain());
        }
    }


    if(m_afterPulseAmpMode == "PDF"){
        current_rand = gRandom -> Rndm();
        amplitude = ConvertPdfRand01(current_rand,m_afterPulseAmpPdf,m_afterPulseAmpEdges);
        amplitude = PulseAmp(amplitude, pd.gain(), pd.sigmaGain());
    }

    Pulse afterpulse(pulse.pmtID(), amplitude, pulseHitTime);

    return afterpulse;
}


Pulse EsPulseTool::makeDarkPulse( int pmtID,  PmtData& pd) {
    double amplitude = 0.0;
    double pulseHitTime = 0.0 ;

    double darkPulseTime = gRandom->Rndm() * m_simDeltaT;
    pulseHitTime = darkPulseTime;

    if(m_darkPulseAmpMode == "SinglePE"){

        if(m_enableAssignGain && m_enableAssignSigmaGain){
            amplitude = PulseAmp(1.0, m_Gain, m_SigmaGain);
        }
        else {
            amplitude = PulseAmp(1.0, pd.gain(), pd.sigmaGain());
        }

    }

    if(m_darkPulseAmpMode == "PDF"){
        double current_rand = gRandom->Rndm();
        amplitude = ConvertPdfRand01(current_rand,m_afterPulseAmpPdf, m_afterPulseAmpEdges);
        amplitude = PulseAmp(amplitude, pd.gain(), pd.sigmaGain());
    }
    Pulse darkpulse(pmtID, amplitude, pulseHitTime);

    return darkpulse;
}



double EsPulseTool::NumAfterPulse( const int numPmtHit) {
    // Get number of after-pulses per PMT pulse based on the number of PMT hits

    double cnt;

    if (numPmtHit <= 400)
        cnt = 0.016 * numPmtHit;
    else if (numPmtHit <= 2500)
        cnt = -1.307853 + 0.02666278 * numPmtHit - 0.2001321e-4 * pow((double)numPmtHit, 2)
            +0.7330343e-8 * pow((double)numPmtHit, 3) - 0.102098e-11 * pow((double)numPmtHit, 4);
    else
        cnt = 15.;

    return cnt;
}


int EsPulseTool::PoissonRand(double mean) {
    // Using source code from ROOT's TRandom::Poisson
    // Note: ROOT uses different algorithms depending on the mean, but mean is small 
    //       for our purposes, so use algorithm for mean<25

    int n;
    if (mean <= 0) return 0;

    double expmean = exp(-mean);
    double pir = 1;
    n = -1;
    while(1) {
        n++;
        pir *= gRandom->Rndm();
        if (pir <= expmean) break;
    }
    return n;
}



double EsPulseTool::ConvertPdfRand01 (double rand,vector<double> pdf, vector<double> edges){
    // Defined PDF returns random number in [0,1] distributed according to user-defined histogram.
    // It assumes even bin sizes, so accomodate uneven bin sizes for generality.
    int current_bin;
    int Nbins = pdf.size();

    for(int bin=0; bin<Nbins; bin++) {
        if(rand >= pdf[bin] && rand < pdf[bin+1]) {
            current_bin = bin;
            break;
        }
        else
            current_bin = Nbins-1;
    }


    return edges[current_bin] + (rand-pdf[current_bin])*(edges[current_bin+1]-edges[current_bin])
        /(pdf[current_bin+1]-pdf[current_bin]);

}














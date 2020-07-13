#ifndef WaveformSimAlg_h
#define WaveformSimAlg_h
#include "SniperKernel/AlgBase.h"
#include "EvtNavigator/NavBuffer.h"
#include "Context/TimeStamp.h"
#include "ElecBufferMgrSvc/IElecBufferMgrSvc.h"
#include "GlobalTimeSvc/IGlobalTimeSvc.h"
#include "Event/ElecHeader.h"
#include <map>
#include <vector>
#include <string>
#include "TTree.h"
#include "SniperKernel/ToolBase.h"

namespace JM 
{
    class SimHeader;
    class SimEvent;
}


class WaveformSimAlg: public AlgBase
{
    public:
        WaveformSimAlg(const std::string& name);
        ~WaveformSimAlg();

        bool initialize();
        bool execute();
        bool finalize();


    private:
        void get_Services();
        void clear_vector();
        void load_Pulse();
        void produce_Waveform();


        void mapPulsesByChannel(std::vector<Pulse>& pulse_vector, 
            std::map<int, std::vector<Pulse> >& pulseMap);

        void generateOneChannel(int channelId,
                std::vector<Pulse>& channelPulses,
                JM::ElecFeeChannel& channel 
                );


    private:
        void loadResponse();
        double pmtPulse(double deltaT, int nPulse); 
        double overshoot(double deltaT);




    private:

        JM::SimHeader* m_simheader;
        JM::SimEvent* m_simevent;

        IElecBufferMgrSvc* BufferSvc;
        IGlobalTimeSvc* TimeSvc; 

        std::vector<Pulse> pulse_vector;



        double m_preWaveSimWindow;
        double m_postWaveSimWindow;

        double m_preTimeTolerance;
        double m_postTimeTolerance;

        TimeStamp m_simTimeEarliest; //the waveform begin time
        TimeStamp m_simTimeLatest;
        double m_simTime;
        double m_FadcOffset;



        bool m_enableOvershoot;
        bool m_enableSatuation;
        bool m_enableNoise;
        bool m_enableAssignSimTime;

        double m_gainFactor;
        double m_simFrequency;
        double m_noiseAmp;
        double m_speAmp;
        double m_width;
        double m_mu;
        double m_linearityThreshold;
        double m_PulseSampleWidth;
        bool m_enableFADC;
        double m_FadcBit;
        double m_FadcRange;

        int m_PmtTotal;


        double m_pulseCountSlotWidth;
        // Number of counted slots before and after the pulse.
        int m_pulseCountWindow;
        // Voltage amplitude of noise.





        // Ideal PMT pulse shape.
        std::vector<double> m_pmtPulse;
        // Ideal overshoot shape
        std::vector<double> m_overshoot;


        std::vector<double> m_rawSignal;



    private:

        double noise();

        double ampSatFactor(int nPulse);

        double chargeSatFactor(int nPulse);

        double saturationModel(double q, double qSat, double a);


        int FADC_sample(double adc_range, double amp_val, double FadcBit);


    private:
        TTree* m_evt_tree;
        int m_eventID;
        int m_nPMT;
        int m_nPulse;

        // * Update from fixed array to vector.
        //   The fixed array is too large which causes 
        //   a very large virtural memory.
        //   -- Tao Lin, May 4th 2017
        std::vector<int> m_PulseTime_Offset;
        std::vector<int> m_nPE_perPMT;
        std::vector<int> m_PMTID;
        int m_adc_firstPE[1250];
        int m_firstPE_PMTID;
        std::vector<double> m_Amplitude;
        std::vector<int> m_PMTID_perPulse;
        static const unsigned int high_range_marker = 0;
        static const unsigned int medium_range_marker = 1;
        static const unsigned int low_range_marker = 2;

        // Save the index between SimEvent and ElecEvent
        TTree* m_index_tree;
        int m_nevents;
        std::vector<std::string> m_tags;
        std::vector<std::string> m_filenames;
        std::vector<int> m_entries;
        std::vector<int> m_nhits;
};





#endif

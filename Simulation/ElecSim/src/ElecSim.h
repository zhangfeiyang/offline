#ifndef ElecSim_h
#define ElecSim_h

#include "SniperKernel/AlgBase.h"
#include <iostream>
#include <vector>
#include <map>
#include <iterator>
#include <TFile.h>
#include <TTree.h>
#include <TMath.h>
#include <TRandom.h>
#include <string>
#include <sstream>
#include <cassert>
#include <TCanvas.h>
#include <TGraph.h>
#include <TAxis.h>
#include "ElecSimClass.h"
#include "Gen_Pulse.h"
#include "Gen_Signal.h"

#include <map>
#include <list>

namespace JM {
    class ElecFeeCrate;
    class SimHeader;
    class SimEvent;
}

class ElecSimAlg: public AlgBase
{
    public:
        ElecSimAlg(const std::string& name);

        ~ElecSimAlg();

        bool initialize();
        bool execute();
        bool finalize();
    private:
        // DetSim Related
        bool load_detsim_data();
        // Output 
        bool save_elecsim_data();

    private:
        JM::SimHeader* m_simheader;
        JM::SimEvent* m_simevent;


    private:
        Gen_Signal m_gen_signal;
        Gen_Pulse m_gen_pulse;
        Root_IO m_IO;
        Hit_Collection m_hit_vector_Sig;
        Pulse_Collection m_pulse_vector;
      //  ElecFeeCrate m_crate;  //create a crate to save signals
        PmtData_Collection m_pd_vector ;
        FeeSimData_Collection m_fsd_vector;
    private:
        int m_count;
        int PmtTotal;
        std::string m_pmtdata_file;
        int pe_num_per_pmt;

        std::map<std::string, std::string> m_BKtype2filename;

    private:
        // split related
        bool execute_();
        struct m_split_related {
            int count;
            bool is_first;
            std::list<JM::ElecFeeCrate*> buffer;
        } m_split_related;

    private:
        // Gen_Signal.cc input

        string string_enableOvershoot;
        string string_enableRinging;
        string string_enableSatuation;
        string string_enableNoise;
        string string_enablePretrigger;
        string string_simFrequency;
        string string_noiseAmp;
        string string_speAmp;
        string string_PmtTotal;
        string string_preTimeTolerance;
        string string_postTimeTolerance;

        ////////////////////////////////

        string string_split_evt_time;


        ////////////////////////////////
        bool m_enableOvershoot;
        bool m_enableRinging;
        bool m_enableSatuation;
        bool m_enableNoise;
        bool m_enablePretrigger;
        double m_simFrequency;
        double m_noiseAmp;
        double m_speAmp;
        double m_PmtTotal;
        double m_preTimeTolerance;
        double m_postTimeTolerance;

        bool m_enableFADC;
        double m_FadcBit;
        ////////////////////////////////
        //Gen_Pulse.cc  input


        double m_split_evt_time;


        bool m_enableAfterPulse;
        bool m_enableDarkPulse;
        bool m_use_current_task_buffer;
        double m_expWeight;
        double m_speExpDecay;
        double m_darkRate;


};

#endif

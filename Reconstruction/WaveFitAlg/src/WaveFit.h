#ifndef WaveFit_h
#define WaveFit_h

#include "MyTree.h"
#include <stdio.h>
#include <TFile.h>
#include <TTree.h>
#include <TString.h>
#include <boost/python.hpp>
#include "SniperKernel/AlgBase.h"

#include "AnalysisTool.h"
#include "IWaveFitTool.h"

class ElecFeeCrate;

namespace JM{
    class ElecFeeCrate;
    
    class SimHeader;
    class SimEvent;
    class CalibHeader;
    class CalibEvent;
    class CalibPMTChannel;
}

class WaveFitAlg: public AlgBase
{
    public:
        WaveFitAlg(const std::string& name);
        ~WaveFitAlg();

        bool initialize();
        bool execute();
        bool finalize();

    private:
        JM::ElecFeeCrate* load_elecsim_crate();
        void draw_wave(int chni, int eventspantime, float* waveform);
        bool save_calib_event();
        IWaveFitTool* load_wave_fit_tool();
    private:
        JM::ElecFeeCrate* m_crate;
    private:
	std::string m_output_file;
	 //TString m_output_file;
    private:
	int m_count;
        int m_PmtTotal;
    private:
        JM::SimHeader* m_simheader;
        JM::SimEvent* m_simevent;
        JM::CalibHeader* m_calibhitcol;

    private:
        // PMTID -> PMT Header
        std::map<int, JM::CalibPMTChannel*> m_cache_first_hits;
    private:
        FadcTree* outTree;
    private:
        bool m_flag_draw_wave;
        std::string m_fit_tool_name;

        IWaveFitTool* fit_tool;
};
#endif

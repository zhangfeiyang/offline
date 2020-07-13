#ifndef EsFrontEndAlg_h
#define EsFrontEndAlg_h

#include "SniperKernel/AlgBase.h"
#include "EsClass.h"
#include <iostream>
#include <vector>
#include <map>
#include <list>
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


namespace JM {
    class ElecFeeCrate;
    class SimHeader;
    class SimEvent;
}

class IEsPulseTool;
class IEsFeeTool;


class EsFrontEndAlg: public AlgBase
{
    public:
        EsFrontEndAlg(const std::string& name);
        ~EsFrontEndAlg();

        bool initialize();
        bool execute();
        bool finalize();

    private:
        // DetSim Related  
        bool load_detsim_data(); 
        // Output 
        bool save_elecsim_data(JM::ElecFeeCrate* m_crate);




    private:
        JM::SimHeader* m_simheader;
        JM::SimEvent* m_simevent;

        Root_IO m_IO;
        Hit_Collection m_hit_vector;
        Pulse_Collection m_pulse_vector;
        PmtData_Collection m_pd_vector ;
        FeeSimData_Collection m_fsd_vector;




        //tool
        IEsPulseTool* m_pmtTool;
        IEsFeeTool* m_FeeTool;



        //Property
        std::string m_pmtTool_name;
        std::string m_FeeTool_name;
        std::string m_pmtdata_file;

        bool m_use_current_task_buffer;

        int m_PmtTotal;



};


#endif

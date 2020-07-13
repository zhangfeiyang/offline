#ifndef TestBuffDataAlg_h
#define TestBuffDataAlg_h

#include <boost/python.hpp>
#include "SniperKernel/AlgBase.h"
#include <TFile.h>
#include <TTree.h>
#include <TH1D.h>

class ElecFeeCrate;
class DataBufSvcV2;

namespace JM{
    class ElecFeeCrate;
}

class TestBuffDataAlg: public AlgBase
{
    public:
        TestBuffDataAlg(const std::string& name);
        ~TestBuffDataAlg();

        bool initialize();
        bool execute();
        bool finalize();

    private:
        JM::ElecFeeCrate* m_crate;
        
        TTree* m_evt_tree;

        int m_EvtID;
        int m_Fired_PMT_Num;
        int m_PMTID[20000];
        double m_tdc[20000][1250];
        double m_adc[20000][1250];
        TH1D* h_1;
};

#endif

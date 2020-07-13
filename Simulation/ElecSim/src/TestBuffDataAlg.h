#ifndef TestBuffDataAlg_h
#define TestBuffDataAlg_h

#include <boost/python.hpp>
#include "SniperKernel/AlgBase.h"
#include <TFile.h>
#include <TTree.h>

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
        JM::ElecFeeCrate* load_elecsim_crate();
        TFile* f;
        TTree* t;

        double pmtID_tdc[17746][3000];  //pmtID,i
        double pmtID_adc[17746][3000];
        int total_Hit_PMT;
        int Hit_PMT_ID[17746];


        int count;
        int EvtID;

};

#endif

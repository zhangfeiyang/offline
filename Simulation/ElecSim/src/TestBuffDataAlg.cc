#include "TestBuffDataAlg.h"
#include "SniperKernel/AlgFactory.h"
#include "ElecSimClass.h"
#include "Event/ElecHeader.h"

#include "EvtNavigator/NavBuffer.h"

#include <TCanvas.h>
#include <TGraph.h>
#include <TAxis.h>
#include <TH1F.h>



DECLARE_ALGORITHM(TestBuffDataAlg);

    TestBuffDataAlg::TestBuffDataAlg(const std::string& name)
    : AlgBase(name)
    , m_crate(NULL)
{
}

TestBuffDataAlg::~TestBuffDataAlg()
{
}

    bool
TestBuffDataAlg::initialize()
{
    EvtID = 0;

    f = new TFile("waveform.root","recreate");
    t = new TTree("tree","tree");
    t->Branch("EvtID", EvtID, "EvtID/I");
    t->Branch("total_Hit_PMT", &total_Hit_PMT, "total_Hit_PMT/I");
    t->Branch("Hit_PMT_ID", Hit_PMT_ID, "Hit_PMT_ID[total_Hit_PMT]/I");

    t->Branch("pmtID_adc", pmtID_adc, "pmtID_adc[total_Hit_PMT][2000]/D");
    t->Branch("pmtID_tdc", pmtID_tdc, "pmtID_tdc[total_Hit_PMT][2000]/D");


    return true;
}

    bool
TestBuffDataAlg::execute()
{
    // Get Sim Header from Buffer
    m_crate = load_elecsim_crate();  


    /////////////////////////////////
    total_Hit_PMT = 0;

    for(int i=0; i<17746; i++){
        Hit_PMT_ID[i] = 0;
        for(int j=0; j<3000; j++){
            pmtID_adc[i][j]=0;
            pmtID_tdc[i][j]=0;
        }
    }
    


    for(int pmtID=0; pmtID<17746; pmtID++){
        int tdc_size = 0;
        tdc_size = (*m_crate).channelData()[pmtID].tdc().size();

        if(tdc_size >5 ){
            Hit_PMT_ID[total_Hit_PMT] = pmtID;
            for(int i=0; i<tdc_size; i++){
                pmtID_adc[total_Hit_PMT][i]=(*m_crate).channelData()[pmtID].adc()[i];
                pmtID_tdc[total_Hit_PMT][i]=(*m_crate).channelData()[pmtID].tdc()[i];
            }
            total_Hit_PMT++;
        }
    }

    /////////////////////////////////

    t->Fill();
    EvtID++;
    return true;
}

    bool
TestBuffDataAlg::finalize()
{
    f->Write();
    f->Close();
    return true;
}



JM::ElecFeeCrate* TestBuffDataAlg::load_elecsim_crate()
{
    SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
    if (navBuf.invalid()) {
        return 0;
    }
    LogDebug << "navBuf: " << navBuf.data() << std::endl;
    JM::EvtNavigator* evt_nav = navBuf->curEvt();
    LogDebug << "evt_nav: " << evt_nav << std::endl;
    if (not evt_nav) {
        return 0;
    }
    JM::ElecHeader* elec_hdr = dynamic_cast<JM::ElecHeader*>(
            evt_nav->getHeader("/Event/Elec"));
    if (not elec_hdr) {
        return 0;
    }
    JM::ElecEvent* elec_evt = dynamic_cast<JM::ElecEvent*>(elec_hdr->event());
    const JM::ElecFeeCrate& efc = elec_evt->elecFeeCrate();
    return const_cast<JM::ElecFeeCrate*>(&efc);
    return 0;
}














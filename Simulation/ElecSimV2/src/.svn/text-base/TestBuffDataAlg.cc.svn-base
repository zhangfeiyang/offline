#include "TestBuffDataAlg.h"
#include "SniperKernel/AlgFactory.h"
#include "EsClass.h"
#include "Event/ElecHeader.h"

#include "EvtNavigator/NavBuffer.h"



#include <TCanvas.h>
#include <TGraph.h>
#include <TAxis.h>



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
    count = 0;
    return true;
}

    bool
TestBuffDataAlg::execute()
{
    // Get Sim Header from Buffer
    m_crate = load_elecsim_crate();  

    if(m_crate == NULL){

        cout<<"not get m_crate: "<<endl;
        return 0;
    }


    /////////////////////////////////
    int test_pmtID = 0;
    int tdc_size = 0;

    for (int i = 0; i < 10000; ++i) {
        tdc_size = (*m_crate).channelData()[i].tdc().size();
        if (tdc_size) {
            test_pmtID = i;
            break;
        }
    }
    cout << "found pmt: " << test_pmtID << endl;
    cout<<"tdc_size: " <<tdc_size<<endl;

    //test_pmtID = 1;

    double tdc[tdc_size];
    double adc[tdc_size];
    // vector<int>::iterator tdc_it;
    //    for(tdc_it = crate.m_channelData[0].m_tdc.begin();
    //            tdc_it != crate.m_channelData[0].m_tdc.end();
    //            tdc_it++){
    //        cout<<"tdc: " <<*tdc_it<<endl; 
    //    }


    for(int i=0; i<tdc_size; i++){
        tdc[i] = double((*m_crate).channelData()[test_pmtID].tdc()[i]);
        //  cout<<"tdc: "<< tdc[i]<<endl;
        adc[i] = (*m_crate).channelData()[test_pmtID].adc()[i];
        //  cout<<"adc: "<< adc[i]<<endl;
    }

    TCanvas* c1 = new TCanvas();
    TGraph* gr1 = new TGraph(tdc_size, tdc, adc);
    gr1 -> Draw("AC");

    c1 -> Print(Form("adc_tdc_%d.png", count),"png");
    count++;
    cout<<"count: " << count<<endl;

    delete gr1;
    delete c1;

    return true;
}

    bool
TestBuffDataAlg::finalize()
{
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














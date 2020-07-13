#include "TemplateFitAlg.h"

#include "SniperKernel/AlgFactory.h"
#include "SniperKernel/SniperLog.h"
#include "RootWriter/RootWriter.h"

#include "EvtNavigator/NavBuffer.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "Event/ElecHeader.h"
#include "Identifier/CdID.h"

#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "Event/CalibHeader.h"

#include "TError.h"

DECLARE_ALGORITHM(TemplateFitAlg);

    TemplateFitAlg::TemplateFitAlg(const std::string& name)
    : AlgBase(name)
      , m_tf(0), m_file(0), myt(0)
{
    declProp("InputRootFile", m_rootfile);
    declProp("Chi2tolerance", chi2torlerance=2.5);
    declProp("PmtTotal", m_PmtTotal=17746);

}

TemplateFitAlg::~TemplateFitAlg()
{

}

    bool 
TemplateFitAlg::initialize()
{

    //
    gErrorIgnoreLevel=kError;
    // = register data =
    SniperPtr<DataRegistritionSvc> drSvc("DataRegistritionSvc");
    if ( drSvc.invalid() ) {
        LogError << "Failed to get DataRegistritionSvc instance!"
            << std::endl;
        return false;
    }
    drSvc->registerData("JM::CalibEvent", "/Event/CalibEvent");

    // = create template fit =
    m_tf = new TemplateFit();
    // = load root file if not use the data model =
    if (m_rootfile.size()) {
        m_file = TFile::Open(m_rootfile.c_str());
        if (m_file == 0) {
            return false;
        }
    }
    // = output related=
    SniperPtr<RootWriter> svc("RootWriter");
    if (svc.invalid()) {
        LogError << "Can't Locate RootWriter. If you want to use it, please "
            << "enalbe it in your job option file."
            << std::endl;
        return false;
    }
    myt=svc->bookTree("TEMPLFIT/myt","myt");
    myt->Branch("npulse",&npulse);
    myt->Branch("chId",&chId);
    myt->Branch("firsthittime",&firsthittime,"firsthittime/D");
    myt->Branch("chi2",&chi2,"chi2/F");
    myt->Branch("pe",pe,"pe[npulse]/F");
    myt->Branch("time",time,"time[npulse]/F");
    return true;
}

    bool 
TemplateFitAlg::execute()
{
    // = clear the cache =
    m_cache_first_hits.clear();


    // load the data from buffer if possible 
    JM::ElecFeeCrate* m_crate = load_elecsim_crate();
    // loop the channels in one event
    for (int chni = 0; chni < m_PmtTotal; chni++){
        int tdc_size = (*m_crate).channelData()[chni].tdc().size();
        if(tdc_size==0)continue;

        // build histogram
        JM::ElecFeeChannel& channel = (*m_crate).channelData()[chni];

        ChannelParams params;
        params.channelID = chni;
        build_hist(channel, params);
        fitOneChannel(params);
        //break;
    }
    return save_calib_event();
}

    bool 
TemplateFitAlg::finalize()
{
    return true;
}

    bool
TemplateFitAlg::fitOneChannel(const TemplateFitAlg::ChannelParams& params)
{
    // = initialize =
    Pair roi;
    vector<float> npeQ;
    vector<float> init;
    vector<float> init_index;

    TFitResultPtr  region_tptrinit;
    TFitResultPtr  region_tptrless;
    TFitResultPtr  region_tptrmore;
    TFitResultPtr  region_tptr;
    TFitResultPtr  tptr;

    // = load data =
    // = fill histogram =
    chId = params.channelID;
    TemplateFit* tf = m_tf;
    TFile* wavelib = m_file;
    tf->SetChannel(CdID::id(chId, 0));
    TH1F* thf=0;
    // thf= (TH1F*)wavelib->Get(Form("spe_%d",chId));
    thf = params.hist;
    if (thf == 0) {
        LogError << "Can't find the histogram" << std::endl;
    }

    roi.clear();

    // add this part to test 
    // create channel
    JM::CalibPMTChannel* pmt_hdr = new JM::CalibPMTChannel;
    pmt_hdr->setPmtId(CdID::id(chId, 0)); 
    m_cache_first_hits[chId] = pmt_hdr;
    // add to test



    //
    // = do the real fit =
    // == search region ==
    roi=tf->SearchRoi(thf);
    // == fit the region ==
    if(roi.size()==0){/*  cout<<chId<<" no roi "<<endl;*/myt->Fill();return true;}
    // to check whether region fit
    bool fitstatus=true;
    bool pulseexsit=false;

    Pair::iterator myIt = roi.begin();
    for(;myIt != roi.end();myIt++)
    {
        npeQ.clear();
        npeQ=tf->NpeQ(myIt->first,myIt->second);
        // safe

        init_index.clear();
        init_index=tf->RoughQT(myIt->first,myIt->second,npeQ);
        // safe

        init.clear();
        for(int i=0;i<init_index.size();i++){init.push_back(thf->GetBinCenter(int(init_index[i])));}

        tf->SetParameters(init,thf->GetBinCenter(int(myIt->first)),thf->GetBinCenter(int(myIt->second)));//abs time

        // safe.

        region_tptrinit=tf->Fit(thf);
        if(region_tptrinit->Chi2()/region_tptrinit->Ndf()<chi2torlerance)
        { 
            region_tptr = region_tptrinit;
        }
        else
        {
            //cout<<chId<<" try more now chi2 "<<region_tptrinit->Chi2()/region_tptrinit->Ndf()<<endl;
            npeQ[0]+=1;

            init_index.clear();
            init_index=tf->RoughQT(myIt->first,myIt->second,npeQ);
            init.clear();
            for(int i=0;i<init_index.size();i++){init.push_back(thf->GetBinCenter(int(init_index[i])));}
            tf->SetParameters(init,thf->GetBinCenter(int(myIt->first)),thf->GetBinCenter(int(myIt->second)));
            region_tptrmore=tf->Fit(thf);

            if(region_tptrmore->Chi2()/region_tptrmore->Ndf()<chi2torlerance)
            {
                region_tptr = region_tptrmore;
            }
            else
            {
                //cout<<chId<<" try less now chi2 "<<region_tptrmore->Chi2()/region_tptrmore->Ndf()<<endl;
                npeQ[0]-=2;

                init_index.clear();
                init_index=tf->RoughQT(myIt->first,myIt->second,npeQ);
                init.clear();
                for(int i=0;i<init_index.size();i++){init.push_back(thf->GetBinCenter(int(init_index[i])));}
                tf->SetParameters(init,thf->GetBinCenter(int(myIt->first)),thf->GetBinCenter(int(myIt->second)));
                region_tptrless=tf->Fit(thf);

                if(region_tptrless->Chi2()/region_tptrless->Ndf()<chi2torlerance)
                {
                    region_tptr = region_tptrless;
                }
                else
                {
                    //cout<<" chi2 larger than expected "<<endl;
                    fitstatus = false;
                }
            }
        }
        if(!fitstatus)
        {
            double chi2_0=region_tptrinit->Chi2()/region_tptrinit->Ndf();
            double chi2_1=region_tptrmore->Chi2()/region_tptrmore->Ndf();
            double chi2_2=region_tptrless->Chi2()/region_tptrless->Ndf();
            if(chi2_0<chi2_1)
            {
                if(chi2_0<chi2_2)
                {
                    region_tptr = region_tptrinit;
                }
                else
                {
                    region_tptr = region_tptrless;
                }

            }
            else
            {
                if(chi2_1<chi2_2)
                {
                    region_tptr = region_tptrmore;
                }
                else{
                    region_tptr = region_tptrless;
                }

            }
        }
        if(tf->InsertRegionResult(region_tptr)) pulseexsit=true;// to check whether a pulse exsit
    }

    // safe.

    if(!pulseexsit){myt->Fill(); return true;}
    tptr = tf->totalFit(thf);
    firsthittime = tptr->Parameter(0);
    //firsthittime = tf->Get1st();// some bugs in Get1st
    int npar = tptr->NPar();

    chi2=tptr->Chi2()/tptr->Ndf();
    sumnpe=0;
    double sumnpe_pulse=0.0;
    npulse = npar/2;
    if(npulse>20){myt->Fill(); return true;}

    std::vector<double> fitcharge;
    std::vector<double> fittime;
    fitcharge.clear();
    fittime.clear();

    for(int i=0;i<npar;i+=2)
    {
        time[i/2]=tptr->Parameter(i);
        fittime.push_back(time[i/2]);
        pe[i/2]=tptr->Parameter(i+1);
        fitcharge.push_back(pe[i/2]);
        sumnpe_pulse+=tptr->Parameter(i+1);
    }
    sumnpe=(int)(sumnpe_pulse+0.5);
    // == fill data ==
    myt->Fill();

    //    // create channel
    //    JM::CalibPMTChannel* pmt_hdr = new JM::CalibPMTChannel;
    //   // pmt_hdr->setPmtId(chId); 
    //    pmt_hdr->setPmtId(CdID::id(chId, 0)); 
    pmt_hdr->setFirstHitTime(firsthittime);
    pmt_hdr->setNPE(sumnpe);
    pmt_hdr->setCharge(fitcharge);
    pmt_hdr->setTime(fittime);
    //pmt_hdr->setNPE(npulse);

    m_cache_first_hits[chId] = pmt_hdr;

    return true;
}


    JM::ElecFeeCrate*
TemplateFitAlg::load_elecsim_crate()
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
            evt_nav->getHeader("/Event/ElecEvent"));
    if (not elec_hdr) {
        return 0;
    }
    JM::ElecEvent* elec_evt = dynamic_cast<JM::ElecEvent*>(elec_hdr->event());
    const JM::ElecFeeCrate& efc = elec_evt->elecFeeCrate();
    return const_cast<JM::ElecFeeCrate*>(&efc);
    return 0;
}

    void 
TemplateFitAlg::build_hist(const JM::ElecFeeChannel& channel, ChannelParams& params) 
{
    const std::vector<double>& adc = channel.adc();
    const std::vector<int>& tdc = channel.tdc();
    double weight = 1.;
    double offset = weight/2.;

    params.hist = new TH1F("waveform", "waveform", tdc.size(), weight*tdc[0]-offset, weight*tdc[tdc.size()-1]+offset);
    params.hist->SetDirectory(0);

    for (int i = 0; i < tdc.size(); ++i) {
        params.hist->Fill(weight*tdc[i], adc[i]);
        params.hist->SetBinError(i+1, 0.2e-3); // 0.2mV
    }
    // TCanvas c;
    // params.hist->Draw();
    // c.SaveSource("test.C");
}

bool
TemplateFitAlg::save_calib_event() {
    SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
    if (navBuf.invalid()) {
        return false;
    }
    LogDebug << "navBuf: " << navBuf.data() << std::endl;
    JM::EvtNavigator* evt_nav = navBuf->curEvt();
    if (not evt_nav) {
        evt_nav = new JM::EvtNavigator;
        TTimeStamp ts;
        evt_nav->setTimeStamp(ts);
        SniperPtr<IDataMemMgr> mMgr(getScope(), "BufferMemMgr");
        if (mMgr.invalid()) {
            LogError << "Can't find BufferMemMgr" << std::endl;
            return false;
        }
        mMgr->adopt(evt_nav, "/Event");
    }

    // Build the Calib.
    JM::CalibHeader* ch = new JM::CalibHeader; 
    JM::CalibEvent* ce = new JM::CalibEvent; 

    std::list<JM::CalibPMTChannel*>vcph; 
    std::map<int, JM::CalibPMTChannel*>::iterator it;
    for (it = m_cache_first_hits.begin();
            it != m_cache_first_hits.end();
            ++it) {
        vcph.push_back(it->second);
    }

    ce->setCalibPMTCol(vcph); 
    ch->setEvent(ce); 
    evt_nav->addHeader("/Event/CalibEvent", ch); 
    return true;
}

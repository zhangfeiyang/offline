#include "EsFrontEndAlg.h"
#include "SniperKernel/AlgFactory.h"
#include "SniperKernel/SniperLog.h"
#include "SniperKernel/ToolBase.h"
#include "SniperKernel/Incident.h"
#include "Event/SimHeader.h"
#include "Event/ElecHeader.h"
#include "EvtNavigator/NavBuffer.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "Identifier/CdID.h"
#include <iostream>
#include <cassert>
#include "ElecSimV2/IEsPulseTool.h"
#include "ElecSimV2/IEsFeeTool.h"

DECLARE_ALGORITHM(EsFrontEndAlg);


    EsFrontEndAlg::EsFrontEndAlg(const std::string& name)
: AlgBase(name),m_simevent(0),m_simheader(0)
{
    declProp("pmtTool_name", m_pmtTool_name="EsPulseTool");

    declProp("FeeTool_name", m_FeeTool_name="EsFeeTool");


    declProp("UseCurrentBuffer", m_use_current_task_buffer=false);

    declProp("PmtDataFile", m_pmtdata_file="PmtData.root");

    declProp("PmtTotal", m_PmtTotal=17746);

}

EsFrontEndAlg::~EsFrontEndAlg()
{
}


bool EsFrontEndAlg::initialize()
{

    m_pmtTool = tool<IEsPulseTool>(m_pmtTool_name);

    if(m_pmtTool==NULL){
        std::cout<<"not get Pulsetool!!!"<<std::endl;
        return false;
    }


    std::cout<<"m_PmtTotal: " <<m_PmtTotal<<std::endl;

    m_FeeTool = tool<IEsFeeTool>(m_FeeTool_name);

    if(m_FeeTool==NULL){
        std::cout<<"not get Feetool!!!"<<std::endl;
        return false;
    }

    m_FeeTool -> initial();
    

    m_pd_vector.create_vector(m_pmtdata_file.c_str(),m_PmtTotal);// create  a PmtData vector
    m_fsd_vector.create_vector(m_PmtTotal);// create a FeeSimData vector


    // SniperPtr<DataRegistritionSvc> drsSvc(getScope(), "DataRegistritionSvc");
    // if ( drsSvc.invalid() ) {
    //     LogError << "Failed to get DataRegistritionSvc!" << std::endl;
    //     throw SniperException("Make sure you have load the DataRegistritionSvc.");
    // }
    // // FIXME: Why we need register Data???
    // drsSvc->registerData("JM::ElecEvent", "/Event/Elec");

    return true;
}

bool EsFrontEndAlg::execute() {

    m_hit_vector.reset();

    //load input data
    bool st_load_det = load_detsim_data();
    if (not st_load_det) {
        std::cout<<"not get input data!!"<<std::endl;
        return false;  
    }     

    // = copy data to the vector =
    int Sig_nPhotons = 0;
    vector<int> Sig_pmtID;
    vector<int>::iterator pmtID_it;
    vector<double> Sig_hitTime;

    assert(m_simevent);
    JM::SimPMTHit* hit = 0;
    TIter next_hit(m_simevent->getCDHits());
    while( (hit = (JM::SimPMTHit*)next_hit()) ) {
        int hit_pmtId = hit->getPMTID();
        //cout<<"hit_pmtID: " << hit_pmtId<<endl;
        double hit_hitTime = hit->getHitTime();
        Sig_pmtID.push_back(hit_pmtId);
        Sig_hitTime.push_back(hit_hitTime);
        // FIXME
        // if we get a merged hit, what's the nPhotons???
        ++Sig_nPhotons;

    }


    //normal  create hit_vector
    m_hit_vector.create_vector(
            Sig_nPhotons,
            Sig_pmtID,
            Sig_hitTime
            );


    JM::ElecFeeCrate *m_crate = new JM::ElecFeeCrate;  //create a crate to save signals


    vector<Hit>::iterator hit_vector_first, hit_vector_end ;

    hit_vector_first = m_hit_vector.get_vector().begin();

    hit_vector_end = m_hit_vector.get_vector().end();

    double earliest_item = hit_vector_first->hitTime();  // the earliest hitTime  unit ns
    double latest_item = (hit_vector_end-1)->hitTime();  // the latest hitTime
    std::cout<<"earliest time: " <<earliest_item<<std::endl;
    std::cout<<"latest time: " <<latest_item<<std::endl;


    m_pulse_vector.reset();       

    m_pmtTool -> SetSimTime(earliest_item,latest_item);

    m_pmtTool -> generatePulses(
            m_pulse_vector.get_vector(),
            m_hit_vector.get_vector(),
            m_pd_vector.get_vector()
            );


    m_FeeTool -> SetSimTime(earliest_item,latest_item);


    m_FeeTool -> generateSignals(m_pulse_vector.get_vector(),
            *m_crate,
            m_fsd_vector.get_vector()
            );

    save_elecsim_data(m_crate);
    delete m_crate;

    return true;
}






bool EsFrontEndAlg::finalize()
{

    return true;
}


bool EsFrontEndAlg::load_detsim_data()
{
    // trigger detector simulation task
    // * do simulation,
    // or 
    // * load data.
    JM::NavBuffer* navBuf = 0;
    if (m_use_current_task_buffer) {
        SniperDataPtr<JM::NavBuffer>  navBufPtr(getScope(), "/Event");
        if (navBufPtr.invalid()) {
            return false;
        }
        navBuf = navBufPtr.data();
        LogDebug << "navBuf: " << navBuf << std::endl;

    } else {
        LogDebug << "Trigger the detsimtask." << std::endl;
        Incident::fire("detsimtask");
        SniperDataPtr<JM::NavBuffer>  navBufPtr("detsimtask:/Event");
        if (navBufPtr.invalid()) {
            return false;
        }
        navBuf = navBufPtr.data();
        LogDebug << "navBuf: " << navBuf << std::endl;
    }
    if (navBuf->size() == 0) {
        LogError << "There is nothing in Cur Buffer." << std::endl;
        return false;
    }
    JM::EvtNavigator* evt_nav = navBuf->curEvt();
    LogDebug << "evt_nav: " << evt_nav << std::endl;
    if (not evt_nav) {
        return false;
    }
    m_simheader = dynamic_cast<JM::SimHeader*>(evt_nav->getHeader("/Event/Sim"));
    LogDebug << "simhdr: " << m_simheader << std::endl;
    if (not m_simheader) {
        return false;
    }
    m_simevent = dynamic_cast<JM::SimEvent*>(m_simheader->event());
    LogDebug << "simevt: " << m_simevent << std::endl;
    if (not m_simevent) {
        return false;
    }
    return true;
}


bool
EsFrontEndAlg::save_elecsim_data(JM::ElecFeeCrate* m_crate)
{
    JM::EvtNavigator* nav = new JM::EvtNavigator();
    static TTimeStamp time(2014, 7, 29, 10, 10, 2, 111);
    time.Add(TTimeStamp(0, 10000));
    nav->setTimeStamp(time);

    SniperPtr<IDataMemMgr> mMgr(getScope(), "BufferMemMgr");
    mMgr->adopt(nav, "/Event");

    JM::ElecHeader* elec_hdr = new JM::ElecHeader;
    JM::ElecEvent * elec_evt = new JM::ElecEvent;

    elec_evt->setElecFeeCrate(*m_crate);
    // FIXME: because the Data Model don't use pointer in
    // current version, it will copy the whole data.
    // After copy the data, we should remove the original one.
    // set the relation
    elec_hdr -> setEvent(elec_evt);
    nav->addHeader("/Event/Elec", elec_hdr);
    return true;
}

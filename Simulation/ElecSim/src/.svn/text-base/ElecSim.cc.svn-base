#include "ElecSim.h"
#include "SniperKernel/AlgFactory.h"
#include "SniperKernel/Incident.h"
#include "Event/SimHeader.h"
#include "Event/ElecHeader.h"
#include "EvtNavigator/NavBuffer.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "Identifier/CdID.h"
#include <iostream>
#include <cassert>

DECLARE_ALGORITHM(ElecSimAlg);

    ElecSimAlg::ElecSimAlg(const std::string& name)
: AlgBase(name)
    , m_simevent(0), m_simheader(0)
{
    declProp("BK2File", m_BKtype2filename);

    m_split_related.count = 0;
    m_split_related.is_first = true;
    m_pmtdata_file = "PmtData.root";

    declProp("PmtDataFile", m_pmtdata_file);
    declProp("NpePerPmt", pe_num_per_pmt);


    declProp("enableAfterPulse", m_enableAfterPulse);

    declProp("enableDarkPulse", m_enableDarkPulse);

    ////////////////////////////////////////////////
    declProp("enableOvershoot", m_enableOvershoot);
    declProp("enableRinging", m_enableRinging);
    declProp("enableSatuation", m_enableSatuation);
    declProp("enableNoise", m_enableNoise);
    declProp("enablePretrigger", m_enablePretrigger);
    declProp("simFrequency", m_simFrequency);
    declProp("noiseAmp", m_noiseAmp);
    declProp("speAmp", m_speAmp);
    declProp("PmtTotal", m_PmtTotal);
    declProp("preTimeTolerance", m_preTimeTolerance);
    declProp("postTimeTolerance", m_postTimeTolerance);
    declProp("expWeight", m_expWeight);
    declProp("speExpDecay", m_speExpDecay);
    declProp("darkRate", m_darkRate);
    declProp("enableFADC", m_enableFADC);
    declProp("FadcBit", m_FadcBit);

    //////////////////////////////////////////////////

    declProp("split_evt_time", m_split_evt_time);
    declProp("UseCurrentBuffer", m_use_current_task_buffer=false);

}

ElecSimAlg::~ElecSimAlg()
{
}

bool ElecSimAlg::initialize()
{
    // check the file exists
    TFile* tmpf = TFile::Open(m_pmtdata_file.c_str());
    if (not tmpf) {
        LogError << "File: " << m_pmtdata_file << " does not exists"
                 << std::endl;
        return false;
    }



    m_gen_pulse.initial(m_PmtTotal,
            m_preTimeTolerance,
            m_postTimeTolerance,
            m_enableAfterPulse,
            m_enableDarkPulse,
            m_expWeight,
            m_speExpDecay,
            m_darkRate);



    m_gen_signal.initial(
            m_enableOvershoot,
            m_enableRinging,
            m_enableSatuation,
            m_enableNoise,
            m_enablePretrigger,
            m_simFrequency,
            m_noiseAmp,
            m_speAmp,
            m_PmtTotal,
            m_preTimeTolerance,
            m_postTimeTolerance,
            m_enableFADC,
            m_FadcBit
            );

    m_count = 0;
    //    m_IO.initial_Sig("MC-IBD_eplus-1000-10000.root",  //input root
    //            "AdcSignals.root");                       //output root 
    m_IO.initial_Sig();
    //    m_IO.initial_BK1("MC-K40-1000000.root", 0.14099e6);  // intput BK root file and BK evt rate, unit Hz
    //    m_IO.initial_BK2("MC-Thorium-50000.root", 0.12341e6);
    //    m_IO.initial_BK3("MC-Uranium-50000.root", 0.57714e6);

    PmtTotal = m_gen_pulse.get_PmtTotal();


    m_pd_vector.create_vector(m_pmtdata_file.c_str(),PmtTotal);// create  a PmtData vector
    m_fsd_vector.create_vector(PmtTotal);// create a FeeSimData vector


    int Sig_nEntries = m_IO.get_Sig_nEntries();


    // SniperPtr<DataRegistritionSvc> drsSvc(getScope(), "DataRegistritionSvc");
    // if ( drsSvc.invalid() ) {
    //     LogError << "Failed to get DataRegistritionSvc!" << std::endl;
    //     throw SniperException("Make sure you have load the DataRegistritionSvc.");
    // }
    // // FIXME: Why we need register Data???
    // drsSvc->registerData("JM::ElecEvent", "/Event/Elec");
    return true;
}

bool ElecSimAlg::execute() {
    //create ElecFeeCrate
    // if there is no data any more, this should loop without anything.
    if (not m_split_related.count) {
        m_split_related.is_first = true;
    }
    // if we need a full simulation
    if (m_split_related.is_first) {
        m_split_related.is_first = false;
        // Full simulation
        bool st = execute_();
        //execute_();
        LogDebug << "After Execute_ , m_split_related.count: "
            << m_split_related.count 
            << std::endl;
        if (not st) {
            LogError << "Execute_ Failed!" << std::endl;
            return Incident::fire("StopRun");
        }
    }

    // yield data
    // put data into buffer
    --m_split_related.count;


    // TODO
    // push data into buffer
    // m_elecfeecratebuf->push_back( m_split_related.buffer.front() );
    save_elecsim_data();

    assert( m_split_related.count == m_split_related.buffer.size() );
    LogDebug << "ElecSim Execute Finished." << std::endl;
    return true;
}

bool ElecSimAlg::execute_()
{


    int Entry_index_Sig; 
    Entry_index_Sig = m_count;
    LogDebug<<"Event_ID: "<<m_count<<endl;
    //m_IO.get_Sig_tree()->GetEntry(Entry_index_Sig);

    m_IO.set_sig_evt_idx(Entry_index_Sig);
    m_IO.set_output_EventID(Entry_index_Sig);

    m_hit_vector_Sig.reset();


    // = get detsim event data from buffer =
    bool st_load_det = load_detsim_data();
    if (not st_load_det) {
        return false;
    }

    int Sig_nPhotons = 0;
    vector<int> Sig_pmtID;
    vector<int>::iterator pmtID_it;
    vector<double> Sig_hitTime;

    // = copy data to the vector =
    assert(m_simevent);
    JM::SimPMTHit* hit = 0;
    const std::vector<JM::SimPMTHit*>& stc = m_simevent->getCDHitsVec();
    for (std::vector<JM::SimPMTHit*>::const_iterator it_hit = stc.begin();
            it_hit != stc.end(); ++it_hit) {
        hit=*it_hit;
        int hit_pmtId = hit->getPMTID();
        //cout<<"hit_pmtID: " << hit_pmtId<<endl;
        double hit_hitTime = hit->getHitTime();
        // TODO
        //            std::cout << "PMTID (in main):" 
        //                      << static_cast<int>(CdID::module(Identifier(hit_pmtId)))
        //                      << std::endl;
        //Sig_pmtID.push_back(static_cast<int>(CdID::module(Identifier(hit_pmtId))));
        Sig_pmtID.push_back(hit_pmtId);
        Sig_hitTime.push_back(hit_hitTime);
        // FIXME
        // if we get a merged hit, what's the nPhotons???
        ++Sig_nPhotons;

    }

   // for(pmtID_it = Sig_pmtID.begin();
   //         pmtID_it!=Sig_pmtID.end();
   //         pmtID_it++){
   //     if(*pmtID_it==0){
   //         cout<<"pmtID==0"<<endl;
   //     }
   // 
   // }    

    LogDebug << "Final nPhotons: " << Sig_nPhotons << std::endl;

    // for the flatten Alg , if nPhoton=0 we put a empty crate to the buffer
    if(Sig_nPhotons == 0 ){

        JM::ElecFeeCrate *m_crate = new JM::ElecFeeCrate;  //create a crate to save signals

        m_split_related.buffer.push_back(m_crate);
        ++m_split_related.count;

        m_count++;
        return true;
    }


    //normal  create hit_vector


    m_hit_vector_Sig.create_vector(Sig_nPhotons,
            Sig_pmtID,
            Sig_hitTime,
            m_IO.get_Sig_evt_GlobalTime(),
            m_split_evt_time);


    ///////////////////////////////////////////////
    //create hit vector with certain pe per pmt

    //    m_hit_vector_Sig.create_vector_with_certain_pe_per_pmt(PmtTotal, pe_num_per_pmt, m_IO.get_Sig_evt_GlobalTime());

    ///////////////////////////////////////////////


    // loop the Sig sub_hit_vector map: map<int id, vector<Hit> > . 
    // loop a total Sig hit vector ,if two hit has a distance > 10000ns we divide the total Sig hit vector to two sub_vector.
    // the map'key is the sub_vector id, the value is the sub_vector

    for(int i=0; i < m_hit_vector_Sig.get_hit_map().size(); i++){      

        JM::ElecFeeCrate *m_crate = new JM::ElecFeeCrate;  //create a crate to save signals
        //JM::ElecHeader* m_ehd = new JM::ElecHeader;
        //m_ehd->setElecFeeCrate(*m_crate);

        LogDebug<<"subEvtID_Sig: "<< i <<endl;
        LogDebug<<"sub_hit_vector_Sig size: "<<m_hit_vector_Sig.get_sub_vector(i).size()<<endl;        

        m_IO.set_subEvtID(i);// set the subEventID_Sig,e.g mapnum

        m_IO.clear_unit_hit_vector(); //clear the unit hit vector
        m_IO.add_sig_to_unit_hit_vector(m_hit_vector_Sig.get_sub_vector(i));

        //        m_IO.mixed_Sig_BK(m_hit_vector_Sig.get_sub_vector(i));

        //one Sig evt sub_hit_vector should add  many BK , we use the mixed_sub_hit_vector as the minimum unit

        m_pulse_vector.reset();       
        //   m_crate.reset(); //every min unit(sub_mixed_hit_vector) for waveform should clear crate
        m_IO.reset();
        m_IO.set_testTdc(); // just for draw waveform

        if(m_IO.get_unit_hit_vector().size() > 0){

            vector<Hit>::iterator it, unit_hit_vector_first, unit_hit_vector_end ;

            unit_hit_vector_first = m_IO.get_unit_hit_vector().begin();
            unit_hit_vector_end = m_IO.get_unit_hit_vector().end() ;

            long double earliest_item = (*unit_hit_vector_first).hitTime();  // the earliest hitTime  unit ns
            long double latest_item = (*(unit_hit_vector_end-1)).hitTime();  // the latest hitTime
            LogDebug<<"earliest hit time of unit_hit_vector:  " << earliest_item<<endl;
            LogDebug<<"latest hit time of unit_hit_vector:  " << latest_item<<endl;

            m_gen_pulse.SetSimTime(earliest_item,latest_item);
            m_gen_signal.SetSimTime(earliest_item,latest_item);


            m_gen_pulse.generatePulses(m_pulse_vector.get_vector(),
                    m_IO.get_unit_hit_vector(),
                    m_pd_vector.get_vector()
                    );

            LogDebug<<"////////////  END Generate pulse"<<endl;
            ////////////////////////////////////////////////////////////////////////////////////
            m_gen_signal.loadResponse();

            LogDebug << "m_gen_signal.generateSignals Begin." << std::endl;

            m_gen_signal.generateSignals(m_pulse_vector.get_vector(),*m_crate,m_fsd_vector.get_vector(),m_IO);

            LogDebug << "m_gen_signal.generateSignals Finished." << std::endl;

        }



        m_split_related.buffer.push_back(m_crate);
        ++m_split_related.count;
        //m_elecfeecratebuf ->push_back(m_crate);
        //LogDebug<<"After pushback to buf , size : "<< m_elecfeecratebuf->totalSize()<<std::endl;
        //m_elecfeecratebuf ->push_back(m_ehd);




    } 

    m_count++;
    return true;
}

bool ElecSimAlg::finalize()
{
    //  m_IO.get_input_file() -> Close();
    //  m_IO.get_output_file() -> Write();
    //  m_IO.get_output_file() -> Close();
    return true;
}

bool ElecSimAlg::load_detsim_data()
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
ElecSimAlg::save_elecsim_data()
{
    JM::EvtNavigator* nav = new JM::EvtNavigator();
    static TTimeStamp time(2014, 7, 29, 10, 10, 2, 111);
    time.Add(TTimeStamp(0, 10000));
    nav->setTimeStamp(time);

    SniperPtr<IDataMemMgr> mMgr(getScope(), "BufferMemMgr");
    mMgr->adopt(nav, "/Event");

    JM::ElecHeader* elec_hdr = new JM::ElecHeader;
    JM::ElecEvent * elec_evt = new JM::ElecEvent;

    if (m_split_related.buffer.size() == 0) {
        LogError << "Nothing in the Buffer" << std::endl;
        return false;
    }
    JM::ElecFeeCrate* efc = m_split_related.buffer.front();
    m_split_related.buffer.pop_front();

    elec_evt->setElecFeeCrate((*efc));
    // FIXME: because the Data Model don't use pointer in
    // current version, it will copy the whole data.
    // After copy the data, we should remove the original one.
    delete efc;
    // set the relation
    elec_hdr -> setEvent(elec_evt);
    nav->addHeader("/Event/Elec", elec_hdr);
    return true;
}

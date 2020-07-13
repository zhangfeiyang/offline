#include "DummySplitByTimeAlg.h"
#include "SniperKernel/AlgFactory.h"
#include "SniperKernel/SniperDataPtr.h"
#include "SniperKernel/SniperLog.h"
#include "SniperKernel/Incident.h"
#include "EvtNavigator/NavBuffer.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "DataRegistritionSvc/DataRegistritionSvc.h"

#include "Event/SimHeader.h"

#include <algorithm>
#include <iterator>

DECLARE_ALGORITHM(DummySplitByTimeAlg);

DummySplitByTimeAlg::DummySplitByTimeAlg(const std::string& name)
    : AlgBase(name)
    , m_simnav(0), m_simheader(0), m_simevent(0)
{
    declProp("DetSimTaskName", detsimtask_name);
    declProp("SplitTimeGap", m_split_time_gap=10000); // 10us
    m_split_related.count = 0;
    m_split_related.is_first = true;
}

DummySplitByTimeAlg::~DummySplitByTimeAlg()
{

}

bool
DummySplitByTimeAlg::initialize()
{
    // SniperPtr<DataRegistritionSvc> drsSvc(getScope(), "DataRegistritionSvc");
    // if ( drsSvc.invalid() ) {
    //     LogError << "Failed to get DataRegistritionSvc!" << std::endl;
    //     throw SniperException("Make sure you have load the DataRegistritionSvc.");
    // }
    // // FIXME: Why we need register Data???
    // drsSvc->registerData("JM::SimEvent", "/Event/Sim");
    return true;
}

bool
DummySplitByTimeAlg::execute()
{
    while (m_split_related.count == 0) {
        // Full simulation
        bool st = execute_one();
        //execute_();
        LogDebug << "After Execute_ , m_split_related.count: "
            << m_split_related.count 
            << std::endl;
        if (not st) {
            LogError << "Execute_ Failed!" << std::endl;
            return Incident::fire("StopRun");
        } 
        if (m_hits_col.size() != 0) {
            break;
        }
    }
    if (m_hits_col.size() == 0) {
        // create a dummy event
        // FIXME: shall we get the navigator first?
        LogWarn << "There is no hit in current event. " << std::endl;
        LogWarn << "Create a dummy one." << std::endl;
        return true;
        JM::EvtNavigator* nav = new JM::EvtNavigator();
        TTimeStamp ts = m_current_timestamp;
        nav->setTimeStamp(ts);

        SniperPtr<IDataMemMgr> mMgr(getScope(), "BufferMemMgr");
        mMgr->adopt(nav, "/Event");

        // create header
        JM::SimHeader* sim_header = new JM::SimHeader;
        // create event
        JM::SimEvent* sim_event = new JM::SimEvent();

        // set the relation
        sim_header->setEvent(sim_event);
        nav->addHeader("/Event/Sim", sim_header);
        return true;
    }
    // yield data
    // put data into buffer
    --m_split_related.count;
    save_into_buffer();

    return true;
}

bool
DummySplitByTimeAlg::finalize()
{
    return true;
}

bool
DummySplitByTimeAlg::execute_one()
{
    // = get detsim event data from buffer =
    bool st_load_det = load_detsim_data();
    if (not st_load_det) {
        return false;
    }
    // = split the event =
    if (m_hits_col.size()==0) {
        return true;
    }
    // == find the gap ==
    find_gap();
    // == save the event into different SimEvents
    split_evts();
    return true;
}

bool 
DummySplitByTimeAlg::load_detsim_data()
{
    // trigger detector simulation task
    // * do simulation,
    // or 
    // * load data.
    JM::NavBuffer* navBuf = 0;
    if (detsimtask_name.empty()) {
        SniperDataPtr<JM::NavBuffer>  navBufPtr(getScope(), "/Event");
        if (navBufPtr.invalid()) {
            return false;
        }
        navBuf = navBufPtr.data();
        LogDebug << "navBuf: " << navBuf << std::endl;

    } else {
        LogDebug << "Trigger the detsimtask." << std::endl;
        Incident::fire(detsimtask_name);
        SniperDataPtr<JM::NavBuffer>  navBufPtr(detsimtask_name+":/Event");
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
    m_simnav = evt_nav;
    m_current_timestamp = evt_nav->TimeStamp();
    LogDebug << "current timestamp: '" 
             << m_current_timestamp << "'." << std::endl;
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

    m_hits_col = m_simevent->getCDHitsVec();
    m_hits_wp_col = m_simevent->getWPHitsVec();
    // put the hits in WP into CD
    std::copy(m_hits_wp_col.begin(), m_hits_wp_col.end(),
                          std::back_inserter(m_hits_col));

    m_hits_tt_col = m_simevent->getTTHitsVec();
    return true;
}

bool SortByhitTime(JM::SimPMTHit* hit1,JM::SimPMTHit* hit2){
    return hit1->getHitTime() < hit2->getHitTime();
}
bool
DummySplitByTimeAlg::find_gap() 
{
    // == sort the collection ==
    std::sort(m_hits_col.begin(),m_hits_col.end(), SortByhitTime);
    // == split the event if the gap is great than m_split_time_gap ==
    m_split_hits.clear();
    m_split_hits.push_back(0);
    for (int i = 1; i < m_hits_col.size(); ++i) {
        if ( (m_hits_col[i]->getHitTime() - m_hits_col[i-1]->getHitTime()) 
                > m_split_time_gap) {
            // save the start index
            m_split_hits.push_back(i);
        }
    }
    m_split_hits.push_back(m_hits_col.size());

    m_split_related.count = m_split_hits.size() - 1;

    return true;
}

bool
DummySplitByTimeAlg::split_evts()
{
    m_split_related.buffer.clear();

    for (int i = 0 ; i < m_split_hits.size() - 1; ++i) {
        JM::SimEvent* se = new JM::SimEvent();
        for (int j = m_split_hits[i]; j < m_split_hits[i+1]; ++j) {
            JM::SimPMTHit* old_sph = m_hits_col[j];
            JM::SimPMTHit* new_sph = se->addCDHit();
            new_sph->setPMTID( old_sph->getPMTID() );
            new_sph->setNPE( old_sph->getNPE() );
            new_sph->setHitTime( old_sph->getHitTime() );
        }

        // TODO
        // We only push TT hits into the first event,
	// i.e., we don't split TT hits.
	// 
        if (i==0) {
            for (int j=0; j < m_hits_tt_col.size(); ++j) {
		JM::SimTTHit* old_sph = m_hits_tt_col[j];
		JM::SimTTHit* new_sph = se->addTTHit();
		new_sph->setChannelID(old_sph->getChannelID());
                new_sph->setPE(old_sph->getPE());
		new_sph->setTime(old_sph->getTime());
		new_sph->setADC(old_sph->getADC());
		new_sph->setX(old_sph->getX());
		new_sph->setY(old_sph->getY());
		new_sph->setZ(old_sph->getZ());
            }
	}

        m_split_related.buffer.push_back(se);
    }
    return true;
}

bool
DummySplitByTimeAlg::save_into_buffer()
{
    // FIXME: shall we get the navigator first?
    JM::EvtNavigator* nav = new JM::EvtNavigator();
    TTimeStamp ts = m_current_timestamp;
    LogInfo << "current timestamp: '" 
             << m_current_timestamp << "'." << std::endl;
    nav->setTimeStamp(ts);

    SniperPtr<IDataMemMgr> mMgr(getScope(), "BufferMemMgr");
    mMgr->adopt(nav, "/Event");
    // create header
    JM::SimHeader* sim_header = new JM::SimHeader;
    // create event
    JM::SimEvent* sim_event = m_split_related.buffer.front();
    m_split_related.buffer.pop_front();

    // set the relation
    sim_header->setEvent(sim_event);
    // LT:
    //   To distinguish SimEvent before and after event split,
    //   we use two different path.
    //
    //   Before: /Event/SimOrig
    //   After : /Event/Sim
    //
    // 2016.10.27
    nav->addHeader("/Event/Sim", sim_header);
    nav->copyHeader(m_simnav, "/Event/Sim", "/Event/SimOrig");
    return true;
}

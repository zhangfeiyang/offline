#include <algorithm>    // std::sort
#include "UnpackHitsAlg.h"
#include "SniperKernel/AlgFactory.h"
#include "SniperKernel/Incident.h"
#include "SniperKernel/SniperLog.h"
#include "Event/SimHeader.h"

#include "EvtNavigator/NavBuffer.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "DataRegistritionSvc/DataRegistritionSvc.h"

DECLARE_ALGORITHM(UnpackHitsAlg);

UnpackHitsAlg::UnpackHitsAlg(const std::string& name)
    : AlgBase(name)
{
    declProp("DetSimTasks", m_detsim_tasks);
    declProp("TimeWindow", m_time_window=300);
}

UnpackHitsAlg::~UnpackHitsAlg()
{

}

bool UnpackHitsAlg::initialize()
{
    return true;
}

bool UnpackHitsAlg::execute()
{
    bool st = true;
    if (is_need_more_data()/*  need more data */) {
        st = load_detsim_events();
        if (not st) {
            return Incident::fire("StopRun");
        }
        st = unpack_events();
        if (not st) {
            return false;
        }
    }
    JM::SimEvent* se = group_hits();
    // TODO send group of hits
    save_into_buffer(se);
    return true;
}

bool UnpackHitsAlg::finalize()
{

    return true;
}

bool UnpackHitsAlg::load_detsim_events()
{
    LogDebug << "load_detsim_events" << std::endl;
    for (std::vector<std::string>::iterator it =
            m_detsim_tasks.begin(); it != m_detsim_tasks.end(); ++it)
    {
        JM::SimEvent* se = load_detsim_event(*it);
        m_simevt_cache.push_back(se);
    }
    LogDebug << "m_simevt_cache.size(): " << m_simevt_cache.size() << std::endl;

    return true;
}

JM::SimEvent*
UnpackHitsAlg::load_detsim_event(const std::string& taskname)
{
    JM::SimEvent* se = 0;
    Incident::fire(taskname);
    std::string bufname = taskname + ":/Event";
    SniperDataPtr<JM::NavBuffer>  navBuf(bufname);
    if (navBuf.invalid()) {
        return false;
    }
    LogDebug << "navBuf: " << navBuf.data() << std::endl;
    if (navBuf->size() == 0) {
        LogError << "There is nothing in Cur Buffer." << std::endl;
        return se;
    }
    JM::EvtNavigator* evt_nav = navBuf->curEvt();
    LogDebug << "evt_nav: " << evt_nav << std::endl;
    if (not evt_nav) {
        return se;
    }
    JM::SimHeader* simheader = dynamic_cast<JM::SimHeader*>(evt_nav->getHeader("/Event/Sim"));
    LogDebug << "simhdr: " << simheader << std::endl;
    if (not simheader) {
        return se;
    }
    se = dynamic_cast<JM::SimEvent*>(simheader->event());
    LogDebug << "simevt: " << se << std::endl;
    return se;
}

static bool cmp_Hit (UnpackHitsAlg::Hit* i,UnpackHitsAlg::Hit* j) { return (i->hittime<j->hittime); }
bool UnpackHitsAlg::unpack_events()
{
    for (std::vector<JM::SimEvent*>::iterator it 
            = m_simevt_cache.begin(); it != m_simevt_cache.end(); ++it)
    {
        // load the hits in the SimEvent
        JM::SimPMTHit* hit = 0;
        const std::vector<JM::SimPMTHit*>& stc = (*it)->getCDHitsVec();
        for (std::vector<JM::SimPMTHit*>::const_iterator it_hit = stc.begin();
                it_hit != stc.end(); ++it_hit) {
            hit=*it_hit;
            int hit_pmtId = hit->getPMTID();
            int hit_npe = hit->getNPE();
            double evttime = 0;
            double hit_hitTime = hit->getHitTime();

            m_hits_cache.push_back(new Hit(hit_pmtId, hit_npe, evttime, hit_hitTime));

        }
    }
    // clear the cache
    m_simevt_cache.clear();
    std::sort(m_hits_cache.begin(), m_hits_cache.end(), cmp_Hit);
    return true;
}

JM::SimEvent* UnpackHitsAlg::group_hits()
{
    std::vector<Hit*>::iterator it_begin = m_hits_cache.begin();
    std::vector<Hit*>::iterator it_end = get_group_fix_timewindow();

    // create the data model
    // create event
    JM::SimEvent* sim_event = new JM::SimEvent(0);
    while (it_begin != it_end) {
        JM::SimPMTHit* jm_hit = sim_event->addCDHit();
        jm_hit->setPMTID( (*it_begin)->pmtid );
        jm_hit->setNPE( (*it_begin)->npe );
        jm_hit->setHitTime( (*it_begin)->hittime );

        delete (*it_begin);
        ++it_begin;
    }
    m_hits_cache.erase(m_hits_cache.begin(), it_end);

    return sim_event;
}

std::vector<UnpackHitsAlg::Hit*>::iterator
UnpackHitsAlg::get_group_fix_timewindow() {
    std::vector<Hit*>::iterator it = m_hits_cache.end();
    if (m_hits_cache.size() == 0) {
        return it;
    }
    double first_time = m_hits_cache[0]->hittime;
    for (it = m_hits_cache.begin(); it != m_hits_cache.end(); ++it) {
        if ((*it)->hittime>(first_time+m_time_window)) {
            break;
        }
    }
    return it;
}

bool
UnpackHitsAlg::is_need_more_data()
{
    if (m_hits_cache.size() == 0) {
        return true;
    }

    if ((m_hits_cache.back()->hittime) - (m_hits_cache[0]->hittime) < m_time_window) {
        return true;
    }

    return false;
}

bool 
UnpackHitsAlg::save_into_buffer(JM::SimEvent* sim_event) 
{
    // FIXME: shall we get the navigator first?
    JM::EvtNavigator* nav = new JM::EvtNavigator();
    TTimeStamp ts;
    nav->setTimeStamp(ts);

    SniperPtr<IDataMemMgr> mMgr(getScope(), "BufferMemMgr");
    mMgr->adopt(nav, "/Event");
    // create header
    JM::SimHeader* sim_header = new JM::SimHeader;

    // set the relation
    sim_header->setEvent(sim_event);
    nav->addHeader("/Event/Sim", sim_header);
}

#include "MergeSimEventAlg.h"
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

DECLARE_ALGORITHM(MergeSimEventAlg);

MergeSimEventAlg::MergeSimEventAlg(const std::string& name)
    : AlgBase(name)
{
    declProp("InputTasks", m_tasks_name);
}

MergeSimEventAlg::~MergeSimEventAlg() {

}

bool
MergeSimEventAlg::initialize()
{
    if (m_tasks_name.size() == 0) {
        LogError << "No Input Task!" << std::endl;
        return false;
    }
    return true;
}

bool
MergeSimEventAlg::execute()
{
    // create header
    m_simheader = new JM::SimHeader();
    m_simevent = new JM::SimEvent();
    // == create a new object ==
    // == loop the tasks ==
    for (std::vector<std::string>::iterator it = m_tasks_name.begin();
            it != m_tasks_name.end(); ++it) {
        // === trigger the incident ===
        Incident::fire(*it);
        // === load the buffer ===
        SniperDataPtr<JM::NavBuffer>  navBufPtr(*it+":/Event");
        if (navBufPtr.invalid()) {
            LogError << "can't find the buffer in task[" << *it << "]" << std::endl;
            return Incident::fire("StopRun");
        }
        if (navBufPtr->size() == 0) {
            LogError << "There is nothing in Buffer[" << *it << "]." << std::endl;
            return Incident::fire("StopRun");
        }
        JM::EvtNavigator* evt_nav = navBufPtr->curEvt();
        if (not evt_nav) {
            LogError << "EvtNav is none in Buffer[" << *it << "]." << std::endl;
            return Incident::fire("StopRun");
        }
        JM::SimHeader* tmp_simheader = dynamic_cast<JM::SimHeader*>(evt_nav->getHeader("/Event/Sim"));
        if (not tmp_simheader) {
            LogError << "No SimHeader is none in Buffer[" << *it << "]." << std::endl;
            return Incident::fire("StopRun");
        }
        // === get the SimEvent ===
        JM::SimEvent* tmp_simevent = dynamic_cast<JM::SimEvent*>(tmp_simheader->event());
        if (not tmp_simevent) {
            LogError << "No SimEvent is none in Buffer[" << *it << "]." << std::endl;
            return Incident::fire("StopRun");
        }
        const std::vector<JM::SimPMTHit*>& tmp_hits_col = tmp_simevent->getCDHitsVec();
        const std::vector<JM::SimPMTHit*>& tmp_hits_wp_col = tmp_simevent->getWPHitsVec();

        if (logLevel()<1) {
            LogDebug << "Size of CD[" << *it << "] Hits Collection: " << tmp_hits_col.size() << std::endl;
            LogDebug << "Size of WP[" << *it << "] Hits Collection: " << tmp_hits_wp_col.size() << std::endl;
        }

        // === merge the SimEvent ===
        // FIXME: The pointer is copied, not the object.
        // ==== copy hits ====
        for (std::vector<JM::SimPMTHit*>::const_iterator ithit = tmp_hits_col.begin();
                ithit != tmp_hits_col.end(); ++ithit) {
            JM::SimPMTHit* old_sph = *ithit;
            JM::SimPMTHit* new_sph = m_simevent->addCDHit();
            new_sph->setPMTID( old_sph->getPMTID() );
            new_sph->setNPE( old_sph->getNPE() );
            new_sph->setHitTime( old_sph->getHitTime() );

        }

        for (std::vector<JM::SimPMTHit*>::const_iterator ithit = tmp_hits_wp_col.begin();
                ithit != tmp_hits_wp_col.end(); ++ithit) {
            JM::SimPMTHit* old_sph = *ithit;
            JM::SimPMTHit* new_sph = m_simevent->addWPHit();
            new_sph->setPMTID( old_sph->getPMTID() );
            new_sph->setNPE( old_sph->getNPE() );
            new_sph->setHitTime( old_sph->getHitTime() );

        }
    }
    // == push the object into buffer ==
    // FIXME: shall we get the navigator first?
    JM::EvtNavigator* nav = new JM::EvtNavigator();
    TTimeStamp ts;
    nav->setTimeStamp(ts);

    SniperPtr<IDataMemMgr> mMgr(getScope(), "BufferMemMgr");
    mMgr->adopt(nav, "/Event");

    m_simheader->setEvent(m_simevent);
    nav->addHeader("/Event/Sim", m_simheader);
    // == display the info ==
    if (logLevel()<1) {
        const std::vector<JM::SimPMTHit*>& tmp_hits_col = m_simevent->getCDHitsVec();
        const std::vector<JM::SimPMTHit*>& tmp_hits_wp_col = m_simevent->getWPHitsVec();
        LogDebug << "Size of CD Hits Collection: " << tmp_hits_col.size() << std::endl;
        LogDebug << "Size of WP Hits Collection: " << tmp_hits_wp_col.size() << std::endl;
    }

    return true;
}

bool
MergeSimEventAlg::finalize()
{
    return true;
}

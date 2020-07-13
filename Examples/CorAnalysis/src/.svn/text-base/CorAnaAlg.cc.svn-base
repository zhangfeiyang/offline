#include "CorAnaAlg.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "EvtNavigator/NavBuffer.h"
#include "SniperKernel/AlgFactory.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "Event/RecHeader.h"
#include "Event/CalibHeader.h"
#include "Event/ElecHeader.h"
#include "Event/SimHeader.h"

DECLARE_ALGORITHM(CorAnaAlg);

CorAnaAlg::CorAnaAlg(const std::string& name)
    : AlgBase(name),
      m_iEvt(0),
      m_buf(0)
{
}

bool CorAnaAlg::initialize()
{
    LogDebug << "initializing" << std::endl;

    SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
    if ( navBuf.invalid() ) {
        LogError << "cannot get the NavBuffer @ /Event" << std::endl;
        return false;
    }
    m_buf = navBuf.data();

    return true;
}

bool CorAnaAlg::execute()
{
    LogDebug << "executing: " << m_iEvt++
             << std::endl;

    JM::SimEvent* simevent = 0;
    JM::SimEvent* simevent_orig = 0;
    JM::CDRecEvent* recevent = 0;
    JM::CalibEvent* calibevent = 0;
    JM::ElecEvent* elecevent = 0;

    // Get the events of different stages

    JM::EvtNavigator* nav = m_buf->curEvt();
    std::vector<std::string>& paths = nav->getPath();
    std::vector<JM::SmartRef*>& refs = nav->getRef();
    LogInfo << "Start to Explore SmartRef: " << std::endl;
    LogInfo << "Size of paths: " << paths.size() << std::endl;
    LogInfo << "Size of refs: " << refs.size() << std::endl;

    for (size_t i = 0; i < paths.size(); ++i) {
        LogInfo << "... -> ref: " << std::endl;
        const std::string& path = paths[i];
        JM::SmartRef* ref = refs[i];
        JM::EventObject* evtobj = ref->GetObject();

        LogInfo << " path: " << path
                << " ref->entry(): " << ref->entry()
                << " evtobj: " << evtobj;

        if (path=="/Event/Sim") {
            JM::SimHeader* hdr = dynamic_cast<JM::SimHeader*>(evtobj);
            std::cout << " SimHeader: " << hdr;
        }
        std::cout << std::endl;
    }






    // Event After Split
    JM::SimHeader* simheader = static_cast<JM::SimHeader*>(nav->getHeader("/Event/Sim"));
    if (simheader) {
        simevent  = (JM::SimEvent*)simheader->event();
        LogInfo << "SimEvent Read in: " << simevent << std::endl;
        LogInfo << "SimEvent Track: " << simevent->getTracksVec().size() << std::endl;
        LogInfo << "SimEvent Hits: " << simevent->getCDHitsVec().size() << std::endl;
    }
    // Event Before Split
    JM::SimHeader* simheader_orig = static_cast<JM::SimHeader*>(nav->getHeader("/Event/SimOrig"));
    if (simheader_orig) {
        simevent_orig  = (JM::SimEvent*)simheader_orig->event();
        LogInfo << "SimEvent (Orig) Read in: " << simevent_orig << std::endl;
        LogInfo << "SimEvent (Orig) Track: " << simevent_orig->getTracksVec().size() << std::endl;
        LogInfo << "SimEvent (Orig) Hits: " << simevent_orig->getCDHitsVec().size() << std::endl;
    }

    // A common case is: user get one recevent, then get corresponding calib/elec/sim events.
    JM::RecHeader* recheader = static_cast<JM::RecHeader*>(nav->getHeader("/Event/Rec"));
    if (recheader) {
        recevent = recheader->cdEvent();
        LogInfo << "RecEvent Read in: " << recevent << std::endl;
    }

    JM::CalibHeader* calibheader = static_cast<JM::CalibHeader*>(nav->getHeader("/Event/Calib"));
    if (calibheader) {
        calibevent = calibheader->event();
        LogInfo << "CalibEvent Read in: " << calibevent << std::endl;
    }

    JM::ElecHeader* elecheader = dynamic_cast<JM::ElecHeader*>(nav->getHeader("/Event/Elec"));
    if (elecheader) {
        elecevent = elecheader->event();
        LogInfo << "ElecEvent Read in: " << elecevent << std::endl;
    }
    // Do the correlation analysis with the events
    // ...

    if (simevent && recevent) {
        const std::vector<JM::SimTrack*>& tracks = simevent->getTracksVec();
        LogInfo << "Compare vertex: " << std::endl;
        LogInfo << " sim tracks: " << std::endl; 
        for (std::vector<JM::SimTrack*>::const_iterator it = tracks.begin();
             it != tracks.end(); ++it) {
            LogInfo << " -> ("
                    << (*it)->getQEdepX() << ","
                    << (*it)->getQEdepY() << ","
                    << (*it)->getQEdepZ() << ")"
                    << std::endl;
        }
        LogInfo << " rec vertex: ("
                << recevent->x() << ","
                << recevent->y() << ","
                << recevent->z() << ")"
                << std::endl;
    }

    return true;

}

bool CorAnaAlg::finalize()
{
    LogDebug << "finalizing" << std::endl;
    return true;
}


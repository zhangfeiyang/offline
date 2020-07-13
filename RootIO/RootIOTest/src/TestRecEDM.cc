#include "TestRecEDM.h"

#include "SniperKernel/AlgFactory.h"
#include "SniperKernel/SniperPtr.h"
#include "SniperKernel/SniperLog.h"
#include "RootIOSvc/RootOutputSvc.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "EvtNavigator/NavBuffer.h"
#include "Event/RecHeader.h"
#include "TRandom.h"

DECLARE_ALGORITHM(TestRecEDM);

TestRecEDM::TestRecEDM(const std::string& name)
    : AlgBase(name)
    , rw_mode(1)
{
    declProp("RWMode", rw_mode);
}

TestRecEDM::~TestRecEDM()
{

}

bool
TestRecEDM::initialize()
{
    return true;
}

bool
TestRecEDM::execute()
{
    bool st = true;

    if (rw_mode == 1) {
        st = test_write();
    } else if (rw_mode == 0) {
        st = test_read();
    } else {
    
    }

    return st;
}

bool
TestRecEDM::finalize()
{
    return true;
}

bool
TestRecEDM::test_write()
{
    SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
    if (navBuf.invalid()) {
        LogError << "Can't find the NavBuffer." << std::endl;
        return false;
    }

    JM::EvtNavigator* nav = new JM::EvtNavigator();

    SniperPtr<IDataMemMgr> mMgr(getScope(), "BufferMemMgr");
    mMgr->adopt(nav, "/Event");

    JM::RecHeader* hdr = new JM::RecHeader();

    int sel = static_cast<int>(gRandom->Rndm()*4);
    // random 
    // * JM::RecEvent
    // * JM::CDTrackRecEvent
    // * JM::WPRecEvent
    // * JM::TTRecEvent
    // 
    if (sel == 0) {
        JM::CDRecEvent* evt = new JM::CDRecEvent();
        hdr->setCDEvent(evt);
    } else if (sel == 1) {
        JM::CDTrackRecEvent* evt = new JM::CDTrackRecEvent();

        int ntrk = static_cast<int>(1 + 4*gRandom->Rndm());
        for (int i = 0; i < ntrk; ++i) {
            CLHEP::HepLorentzVector start;
            CLHEP::HepLorentzVector end;
            JM::RecTrack* trk = new JM::RecTrack(start, end);

            evt->addTrack(trk);
        }

        hdr->setCDTrackEvent(evt);
    } else if (sel == 2) {
        JM::WPRecEvent* evt = new JM::WPRecEvent();
        hdr->setWPEvent(evt);
    } else if (sel == 3) {
        JM::TTRecEvent* evt = new JM::TTRecEvent();
        hdr->setTTEvent(evt);
    } else {
        LogInfo << "Unknown sel idx: " << sel << std::endl;
    }

    nav->addHeader(hdr);

    return true;
}

bool
TestRecEDM::test_read()
{
    SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
    if (navBuf.invalid()) {
        LogError << "Can't find the NavBuffer." << std::endl;
        return false;
    }

    JM::EvtNavigator* nav = navBuf->curEvt();
    JM::RecHeader* hdr = dynamic_cast<JM::RecHeader*>(nav->getHeader("/Event/Rec"));

    if (!hdr) {
        LogError << "Can't get RecHeader from current event." << std::endl;
        return false;
    }

    if (hdr->hasCDEvent()) {
        LogDebug << "CD vertex event." << std::endl;
    } else if (hdr->hasCDTrackEvent()) {
        LogDebug << "CD track event." << std::endl;
        JM::CDTrackRecEvent* evt = hdr->cdTrackEvent();
        const std::vector<JM::RecTrack*>& trks = evt->cdTracks();
        LogDebug << "  contains " << trks.size() << " tracks." << std::endl;
    } else if (hdr->hasWPEvent()) {
        LogDebug << "WP track event." << std::endl;
    } else if (hdr->hasTTEvent()) {
        LogDebug << "TT track event." << std::endl;
    }
    return true;
}

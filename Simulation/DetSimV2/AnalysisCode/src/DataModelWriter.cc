#include "DataModelWriter.hh"

#include "SniperKernel/SniperPtr.h"
#include "SniperKernel/SniperDataPtr.h"
#include "SniperKernel/ToolFactory.h"
#include "SniperKernel/SniperLog.h"
#include "SniperKernel/SniperException.h"

#include "DataRegistritionSvc/DataRegistritionSvc.h"

#include "BufferMemMgr/IDataMemMgr.h"
#include "EvtNavigator/NavBuffer.h"
#include "Event/SimHeader.h"
#include "Event/SimEvent.h"

#include "G4Event.hh"
#include "G4Track.hh"
#include "G4SDManager.hh"
#include "G4PrimaryVertex.hh"
#include "G4PrimaryParticle.hh"

#include "dywHit_PMT.hh"
#include "G4HCofThisEvent.hh"
#include "G4VHitsCollection.hh"

DECLARE_TOOL(DataModelWriter);

DataModelWriter::DataModelWriter(const std::string& name)
    : ToolBase(name)
{

}

DataModelWriter::~DataModelWriter()
{

}

void
DataModelWriter::BeginOfRunAction(const G4Run* /*aRun*/) {
    // In file DataModel/EDMUtil/src/JunoEDMDefinitions.cc, the path is already registered.
    // Only if we need a new path, then we register it manually.
    //
    // SniperPtr<DataRegistritionSvc> drsSvc(getScope(), "DataRegistritionSvc");
    // if ( drsSvc.invalid() ) {
    //     LogError << "Failed to get DataRegistritionSvc!" << std::endl;
    //     throw SniperException("Make sure you have load the DataRegistritionSvc.");
    // }
    // FIXME: Why we need register Data???
    // drsSvc->registerData("JM::SimEvent", "/Event/Sim");
}

void
DataModelWriter::EndOfRunAction(const G4Run* /*aRun*/) {
    LogInfo << "size of PMT Hit (geant4): " << sizeof(dywHit_PMT) << std::endl;
    LogInfo << "size of PMT Hit for muon (geant4): " << sizeof(dywHit_PMT_muon) << std::endl;
    LogInfo << "size of PMT Hit (data model): " << sizeof(JM::SimPMTHit) << std::endl;
}

void
DataModelWriter::BeginOfEventAction(const G4Event* /*evt*/) {

}

void
DataModelWriter::EndOfEventAction(const G4Event* evt) {
    // FIXME: shall we get the navigator first?
    // Get the navigator with GenEvent from Buffer
    SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
    if (navBuf.invalid()) {
        LogError << "Can't find the NavBuffer." << std::endl;
        return;
    }
    JM::EvtNavigator* evt_nav = navBuf->curEvt();
    if (not evt_nav) {
        LogError << "Can't find the event navigator." << std::endl;
        return;
    }

    // create a new Event Navigator
    JM::EvtNavigator* nav = new JM::EvtNavigator();
    TTimeStamp ts = evt_nav->TimeStamp();
    nav->setTimeStamp(ts);
    LogDebug << "current Timestamp: '"
            << ts
            << "'." << std::endl;

    SniperPtr<IDataMemMgr> mMgr(getScope(), "BufferMemMgr");
    mMgr->adopt(nav, "/Event");
    // create header
    JM::SimHeader* sim_header = new JM::SimHeader;
    // create event
    JM::SimEvent* sim_event = new JM::SimEvent(evt->GetEventID());
    // == fill hits
    fill_hits(sim_event, evt);
    // == fill tracks
    fill_tracks(sim_event, evt);

    // set the relation
    sim_header->setEvent(sim_event);
    nav->addHeader("/Event/Sim", sim_header);

}

void 
DataModelWriter::fill_hits(JM::SimEvent* dst, const G4Event* evt)
{

    LogDebug << "Begin Fill Hits" << std::endl;
    G4SDManager * SDman = G4SDManager::GetSDMpointer();
    G4int CollID = SDman->GetCollectionID("hitCollection");
    dywHit_PMT_Collection* col = 0;
    G4HCofThisEvent * HCE = evt->GetHCofThisEvent();
    if (!HCE) {
        LogError << "No hits collection found." << std::endl;
        return;
    }
    if (CollID >= 0) {
        col = (dywHit_PMT_Collection*)(HCE->GetHC(CollID));
    }
    if (col) {
        fill_hits_tmpl(col, dst);
    }
    // muon hit type
    CollID = SDman->GetCollectionID("hitCollectionMuon");
    dywHit_PMT_muon_Collection* col_muon = 0;
    if (CollID >= 0) {
        col_muon = (dywHit_PMT_muon_Collection*)(HCE->GetHC(CollID));
    }
    if (col_muon) {
        fill_hits_tmpl(col_muon, dst);
    }
    
    // fill evt data
    // int totPE = 0;
    LogDebug << "End Fill Hits" << std::endl;

}

void 
DataModelWriter::fill_tracks(JM::SimEvent* dst, const G4Event* evt)
{
    LogDebug << "Begin Fill Tracks" << std::endl;

    G4int nVertex = evt -> GetNumberOfPrimaryVertex();
    for (G4int index=0; index < nVertex; ++index) {
        G4PrimaryVertex* vtx = evt->GetPrimaryVertex( index );

        // Vertex info
        double x = vtx->GetX0();
        double y = vtx->GetY0();
        double z = vtx->GetZ0();
        double t = vtx->GetT0();

        // Loop Over Particle
        G4PrimaryParticle* pp = vtx -> GetPrimary();

        while (pp) {

            int trkid = pp -> GetTrackID();
            int pdgid = pp -> GetPDGcode();
            double px = pp -> GetPx();
            double py = pp -> GetPy();
            double pz = pp -> GetPz();
            double mass = pp -> GetMass();

            // new track
            JM::SimTrack* jm_trk = dst->addTrack();
            jm_trk->setPDGID(pdgid);
            jm_trk->setTrackID(trkid);
            jm_trk->setInitPx(px);
            jm_trk->setInitPy(py);
            jm_trk->setInitPz(pz);
            jm_trk->setInitMass(mass);
            jm_trk->setInitX(x);
            jm_trk->setInitY(y);
            jm_trk->setInitZ(z);
            jm_trk->setInitT(t);

            pp = pp->GetNext();
        }
    }
    LogDebug << "End Fill Tracks" << std::endl;
}

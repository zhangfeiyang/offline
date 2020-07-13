
#include "NormalAnaMgr.hh"
//  for event
#include <sstream>
#include <cassert>
#include "dywHit_PMT.hh"
#include "G4HCofThisEvent.hh"
#include "G4VHitsCollection.hh"
#include "G4SDManager.hh"
#include "G4Event.hh"
#include "G4Run.hh"
#include "G4EventManager.hh"
#include "G4TrackingManager.hh"
#include "G4OpticalPhoton.hh"

#include "SniperKernel/SniperPtr.h"
#include "SniperKernel/SniperDataPtr.h"
#include "SniperKernel/ToolFactory.h"
#include "SniperKernel/SniperLog.h"
#include "RootWriter/RootWriter.h"

#include "NormalTrackInfo.hh"
#include "EvtNavigator/NavBuffer.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "Event/SimHeader.h"

DECLARE_TOOL(NormalAnaMgr);

NormalAnaMgr::NormalAnaMgr(const std::string& name) 
    : ToolBase(name)
{
    declProp("EnableNtuple", m_flag_ntuple=true);
    m_evt_tree = 0;
    m_step_no = 0;
}

NormalAnaMgr::~NormalAnaMgr()
{

}

void
NormalAnaMgr::BeginOfRunAction(const G4Run* /*aRun*/) {
    if (not m_flag_ntuple) {
        return;
    }
    // check the RootWriter is Valid.

    SniperPtr<RootWriter> svc("RootWriter");
    if (svc.invalid()) {
        LogError << "Can't Locate RootWriter. If you want to use it, please "
                 << "enalbe it in your job option file."
                 << std::endl;
        return;
    }
    m_evt_tree = svc->bookTree("SIMEVT/evt", "evt");
    m_evt_tree->Branch("evtID", &m_eventID, "evtID/I");
    m_evt_tree->Branch("nPhotons", &m_nPhotons, "nPhotons/I");
    m_evt_tree->Branch("totalPE", &m_totalPE, "totalPE/I");
    m_evt_tree->Branch("nPE", m_nPE, "nPE[nPhotons]/I");
    m_evt_tree->Branch("energy", m_energy, "energy[nPhotons]/F");
    m_evt_tree->Branch("hitTime", m_hitTime, "hitTime[nPhotons]/D");
    m_evt_tree->Branch("pmtID", m_pmtID, "pmtID[nPhotons]/I");
    m_evt_tree->Branch("PETrackID", m_peTrackID, "PETrackID[nPhotons]/I");
    m_evt_tree->Branch("edep", &m_edep, "edep/F");
    m_evt_tree->Branch("edepX", &m_edep_x, "edepX/F");
    m_evt_tree->Branch("edepY", &m_edep_y, "edepY/F");
    m_evt_tree->Branch("edepZ", &m_edep_z, "edepZ/F");
    m_evt_tree->Branch("isCerenkov", m_isCerenkov, "isCerenkov[nPhotons]/I");
    m_evt_tree->Branch("isReemission", m_isReemission, "isReemission[nPhotons]/I");
    m_evt_tree->Branch("isOriginalOP", m_isOriginalOP, "isOriginalOP[nPhotons]/I");
    m_evt_tree->Branch("OriginalOPTime", m_OriginalOPTime, "OriginalOPTime[nPhotons]/D");

    // PMT
    m_evt_tree->Branch("nPMTs", &m_npmts_byPMT, "nPMTs/I");
    m_evt_tree->Branch("nPE_byPMT", m_nPE_byPMT, "nPE_byPMT[nPMTs]/I");
    m_evt_tree->Branch("PMTID_byPMT", m_PMTID_byPMT, "PMTID_byPMT[nPMTs]/I");
    // - 2015.10.10 Tao Lin <lintao@ihep.ac.cn>
    //   Hit's position
    m_evt_tree->Branch("LocalPosX", m_localpos_x, "LocalPosX[nPhotons]/F");
    m_evt_tree->Branch("LocalPosY", m_localpos_y, "LocalPosY[nPhotons]/F");
    m_evt_tree->Branch("LocalPosZ", m_localpos_z, "LocalPosZ[nPhotons]/F");
    // - 2016.04.17 Tao Lin <lintao@ihep.ac.cn>
    //   Hit's direction
    m_evt_tree->Branch("LocalDirX", m_localdir_x, "LocalDirX[nPhotons]/F");
    m_evt_tree->Branch("LocalDirY", m_localdir_y, "LocalDirY[nPhotons]/F");
    m_evt_tree->Branch("LocalDirZ", m_localdir_z, "LocalDirZ[nPhotons]/F");

    // - 2017.03.01 Tao Lin <lintao@ihep.ac.cn>
    //   Hit's Global Position
    m_evt_tree->Branch("GlobalPosX", m_globalpos_x, "GlobalPosX[nPhotons]/F");
    m_evt_tree->Branch("GlobalPosY", m_globalpos_y, "GlobalPosY[nPhotons]/F");
    m_evt_tree->Branch("GlobalPosZ", m_globalpos_z, "GlobalPosZ[nPhotons]/F");

    m_evt_tree->Branch("BoundaryPosX", m_boundarypos_x, "BoundaryPosX[nPhotons]/F");
    m_evt_tree->Branch("BoundaryPosY", m_boundarypos_y, "BoundaryPosY[nPhotons]/F");
    m_evt_tree->Branch("BoundaryPosZ", m_boundarypos_z, "BoundaryPosZ[nPhotons]/F");

    m_step_no = new TH1I("stepno", "step number of optical photons", 1000, 0, 1000);
    svc->attach("SIMEVT", m_step_no);
}

void
NormalAnaMgr::EndOfRunAction(const G4Run* /*aRun*/) {

}

void
NormalAnaMgr::BeginOfEventAction(const G4Event* evt) {
    // initialize the evt tree
    m_eventID = evt->GetEventID();
    m_nPhotons = 0;
    m_totalPE = 0;
    for(int i = 0; i < 2000000; i++) {
      m_nPE[i] = 0;
      m_energy[i] = 0;
      m_hitTime[i] = 0;
      m_pmtID[i] = 0;
      m_peTrackID[i] = 0;
      m_isCerenkov[i] = 0;
      m_isReemission[i] = 0;
      m_isOriginalOP[i] = 0;
      m_OriginalOPTime[i] = 0;

      m_localpos_x[i] = 0.;
      m_localpos_y[i] = 0.;
      m_localpos_z[i] = 0.;

      m_localdir_x[i] = 0.;
      m_localdir_y[i] = 0.;
      m_localdir_z[i] = 0.;

      m_boundarypos_x[i] = 0.;
      m_boundarypos_y[i] = 0.;
      m_boundarypos_z[i] = 0.;
    }
    m_edep = 0.;
    m_edep_x = 0.;
    m_edep_y = 0.;
    m_edep_z = 0.;
    m_cache_bypmt.clear();
}

void
NormalAnaMgr::EndOfEventAction(const G4Event* evt) {
    G4SDManager * SDman = G4SDManager::GetSDMpointer();
    G4int CollID = SDman->GetCollectionID("hitCollection");

    dywHit_PMT_Collection* col = 0; 
    G4HCofThisEvent * HCE = evt->GetHCofThisEvent();
    if (!HCE or CollID<0) {
        LogError << "No hits collection found." << std::endl;
    } else {
        col = (dywHit_PMT_Collection*)(HCE->GetHC(CollID));
    }
    
    // fill evt data
    int totPE = 0;
    if (col) {
        int n_hit = col->entries();
        m_nPhotons = n_hit;
        // FIXME: Make sure not overflow
        if (n_hit > 2000000) { m_nPhotons = 2000000; }

        for (int i = 0; i < n_hit; ++i) {
            totPE += (*col)[i]->GetCount(); 
            // if overflow, don't save anything into the array.
            // but still count the totalPE.
            if (i >= 2000000) { continue; }
            m_energy[i] = (*col)[i]->GetKineticEnergy();
            m_nPE[i] = (*col)[i]->GetCount();
            m_hitTime[i] = (*col)[i]->GetTime();
            m_pmtID[i] = (*col)[i]->GetPMTID();

            m_cache_bypmt[m_pmtID[i]] += m_nPE[i];

            if ((*col)[i]->IsFromCerenkov()) {
                LogDebug << "+++++ from cerenkov" << std::endl;
                m_isCerenkov[i] = 1;
            }
            if ((*col)[i]->IsReemission()) {
                LogDebug << "+++++ reemission" << std::endl;
                m_isReemission[i] = 1;
            }

            m_isOriginalOP[i] = (*col)[i]->IsOriginalOP();
            m_OriginalOPTime[i] = (*col)[i]->GetOriginalOPStartT();
            m_peTrackID[i] = (*col)[i]->GetProducerID();

            G4ThreeVector local_pos = (*col)[i]->GetPosition();
            m_localpos_x[i] = local_pos.x();
            m_localpos_y[i] = local_pos.y();
            m_localpos_z[i] = local_pos.z();

            G4ThreeVector local_dir = (*col)[i]->GetMomentum();
            m_localdir_x[i] = local_dir.x();
            m_localdir_y[i] = local_dir.y();
            m_localdir_z[i] = local_dir.z();

            G4ThreeVector global_pos = (*col)[i]->GetGlobalPosition();
            m_globalpos_x[i] = global_pos.x();
            m_globalpos_y[i] = global_pos.y();
            m_globalpos_z[i] = global_pos.z();

            G4ThreeVector boundary_pos = (*col)[i]->GetBoundaryPosition();
            m_boundarypos_x[i] = boundary_pos.x();
            m_boundarypos_y[i] = boundary_pos.y();
            m_boundarypos_z[i] = boundary_pos.z();
        }

    }

    m_npmts_byPMT = 0;
    for (std::map<int,int>::iterator it = m_cache_bypmt.begin();
            it != m_cache_bypmt.end(); ++it) {
        m_PMTID_byPMT[m_npmts_byPMT] = it->first;
        m_nPE_byPMT[m_npmts_byPMT] = it->second;
        ++m_npmts_byPMT;
    }

    m_totalPE = totPE;

    if (m_edep>0) {
        m_edep_x /= m_edep;
        m_edep_y /= m_edep;
        m_edep_z /= m_edep;
    }

    if (m_flag_ntuple and m_evt_tree) {
        m_evt_tree -> Fill();
    }
    save_into_data_model();
}


void
NormalAnaMgr::PreUserTrackingAction(const G4Track* aTrack) {

    if(aTrack->GetParentID()==0 && aTrack->GetUserInformation()==0)
    {
        NormalTrackInfo* anInfo = new NormalTrackInfo(aTrack);
        G4Track* theTrack = (G4Track*)aTrack;
        theTrack->SetUserInformation(anInfo);
    }
    NormalTrackInfo* info = (NormalTrackInfo*)(aTrack->GetUserInformation());
    if (aTrack->GetDefinition()->GetParticleName() == "opticalphoton" 
            and aTrack->GetCreatorProcess()) {
        LogDebug << "###+++ "<< aTrack ->GetCreatorProcess()->GetProcessName() <<std::endl; 
    }

    // original OP
    // set the info 
    if (aTrack->GetDefinition()->GetParticleName() == "opticalphoton" 
            and info->isOriginalOP()
            and info->getOriginalOPStartTime() == 0.0) {
        // make sure this track info is not changed before.
        assert(info->getOriginalOPStartTime() == 0.0);
        LogDebug << "------ original OP" << std::endl;
        info->setOriginalOPStartTime(aTrack->GetGlobalTime());
    }
}

void
NormalAnaMgr::PostUserTrackingAction(const G4Track* aTrack) {
    if (aTrack->GetParentID() == 0) {
        // this is the primary particle
        const G4ThreeVector& pos = aTrack->GetPosition();
        LogDebug << "!!!Primary Track " << aTrack->GetTrackID() << ": ";
        LogDebug << "+ " << pos.x() << " " << pos.y() << " " << pos.z() << std::endl;
        LogDebug << "+ " << aTrack->GetKineticEnergy() << std::endl;
    }
    G4TrackingManager* tm = G4EventManager::GetEventManager() 
                                            -> GetTrackingManager();
    G4TrackVector* secondaries = tm->GimmeSecondaries();
    if(secondaries)
    {
        NormalTrackInfo* info = (NormalTrackInfo*)(aTrack->GetUserInformation());
        size_t nSeco = secondaries->size();
        if(nSeco>0)
        {
            for(size_t i=0;i<nSeco;i++)
            { 
                // make sure the secondaries' track info is empty
                // if already attached track info, skip it.
                if ((*secondaries)[i]->GetUserInformation()) {
                    LogDebug << "The secondary already has user track info. skip creating new one" << std::endl;
                    continue;
                }
                NormalTrackInfo* infoNew = new NormalTrackInfo(info);
                // cerekov tag
                if ((*secondaries)[i]->GetCreatorProcess() 
                    and (*secondaries)[i]->GetCreatorProcess()->GetProcessName() == "Cerenkov") {
                    infoNew->setFromCerenkov();
                    LogDebug << "### infoNew->setFromCerenkov()" << std::endl;
                }
                // reemission tag
                // + parent track is an OP
                // + secondary is also an OP
                // + the creator process is Scintillation
                if (aTrack->GetDefinition()->GetParticleName() == "opticalphoton" 
                    and (*secondaries)[i]->GetDefinition()->GetParticleName() == "opticalphoton"
                    and (*secondaries)[i]->GetCreatorProcess()->GetProcessName() == "Scintillation") {
                    infoNew->setReemission();
                }
                // original optical photon tag
                if (aTrack->GetDefinition()->GetParticleName() != "opticalphoton" 
                    and (*secondaries)[i]->GetDefinition()->GetParticleName() == "opticalphoton"
                    ) {
                    LogDebug << "------ original OP" << std::endl;
                    infoNew->setOriginalOP();
                }

                (*secondaries)[i]->SetUserInformation(infoNew);
            }
        }
    }
}

void
NormalAnaMgr::UserSteppingAction(const G4Step* step) {
    G4Track* track = step->GetTrack();
    G4double edep = step->GetTotalEnergyDeposit();
    if (edep > 0 and track->GetDefinition()->GetParticleName()!= "opticalphoton"
                 and track->GetMaterial()->GetName() == "LS") {
        m_edep += edep;
        G4ThreeVector pos = step -> GetPreStepPoint() -> GetPosition();
        m_edep_x += edep * pos.x();
        m_edep_y += edep * pos.y();
        m_edep_z += edep * pos.z();

    }
    // if the step number of optical photon bigger than X, mark it as killed
    if (track->GetDefinition() == G4OpticalPhoton::Definition()) {
        G4int stepno = track->GetCurrentStepNumber();

        if (track->GetTrackStatus() == fStopAndKill) {
            // if the opticalphoton is killed, save the step no
            m_step_no->Fill(stepno);
        }

        if (stepno >= 1000) {
            G4String phyname;
            if (track->GetVolume()) { phyname = track->GetVolume()->GetName(); }
            const G4ThreeVector& tmppos = track->GetPosition();
            LogWarn << "opticalphoton [" << track->GetTrackID() << "]"
                    << "@[" << phyname << "]"
                    << " (" << tmppos.x() << ", "
                    << tmppos.y() << ", "
                    << tmppos.z() << ", "
                    << track->GetGlobalTime() << ") "
                    << " step number >= " << 1000
                    << std::endl;
            track->SetTrackStatus(fStopAndKill);
        }

        // update the last hit acrylic surface

        G4StepPoint* prepoint = step->GetPreStepPoint();
        G4StepPoint* postpoint = step->GetPostStepPoint();
        // if(postpoint->GetStepStatus()==fGeomBoundary) {
        //     LogInfo << " * "
        //             << prepoint->GetPhysicalVolume()->GetName() << "/"
        //             << postpoint->GetPhysicalVolume()->GetName() << " "
        //             << std::endl;
        // }
        if(postpoint->GetStepStatus()==fGeomBoundary 
        && prepoint->GetPhysicalVolume() 
        && prepoint->GetPhysicalVolume()->GetName() == "pAcylic"
        && postpoint->GetPhysicalVolume() 
        && postpoint->GetPhysicalVolume()->GetName() == "pInnerWater"
            ) {
            G4ThreeVector prepos = prepoint->GetPosition();
            G4ThreeVector postpos = postpoint->GetPosition();
            // LogInfo << " * "
            //         << prepoint->GetPhysicalVolume()->GetName() << "/"
            //         << postpoint->GetPhysicalVolume()->GetName() << " "
            //         << "(" << prepos.x() << ", " << prepos.y() << ", " << prepos.z() << "), "
            //         << "(" << postpos.x() << ", " << postpos.y() << ", " << postpos.z() << "), "
            //         << std::endl;
            // TODO use postpoint as the boundary between acrylic and water
            NormalTrackInfo* info = (NormalTrackInfo*)(track->GetUserInformation());
            if (info) {
                info->setBoundaryPos(postpos);
            }

        }
    }
}

bool NormalAnaMgr::save_into_data_model() {
    SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
    if (navBuf.invalid()) {
        return false;
    }
    LogDebug << "navBuf: " << navBuf.data() << std::endl;
    JM::EvtNavigator* evt_nav = navBuf->curEvt();
    LogDebug << "evt_nav: " << evt_nav << std::endl;
    if (not evt_nav) {
        return false;
    }
    JM::SimHeader* m_simheader = dynamic_cast<JM::SimHeader*>(evt_nav->getHeader("/Event/Sim"));
    LogDebug << "simhdr: " << m_simheader << std::endl;
    if (not m_simheader) {
        return false;
    }
    JM::SimEvent* m_simevent = dynamic_cast<JM::SimEvent*>(m_simheader->event());
    LogDebug << "simevt: " << m_simevent << std::endl;
    if (not m_simevent) {
        return false;
    }

    // DO NOTHING
    return true;
}

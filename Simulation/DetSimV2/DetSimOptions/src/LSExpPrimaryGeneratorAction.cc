//
// ********************************************************************
// * License and Disclaimer                                           *
// *                                                                  *
// * The  Geant4 software  is  copyright of the Copyright Holders  of *
// * the Geant4 Collaboration.  It is provided  under  the terms  and *
// * conditions of the Geant4 Software License,  included in the file *
// * LICENSE and available at  http://cern.ch/geant4/license .  These *
// * include a list of copyright holders.                             *
// *                                                                  *
// * Neither the authors of this software system, nor their employing *
// * institutes,nor the agencies providing financial support for this *
// * work  make  any representation or  warranty, express or implied, *
// * regarding  this  software system or assume any liability for its *
// * use.  Please see the license in the file  LICENSE  and URL above *
// * for the full disclaimer and the limitation of liability.         *
// *                                                                  *
// * This  code  implementation is the result of  the  scientific and *
// * technical work of the GEANT4 collaboration.                      *
// * By using,  copying,  modifying or  distributing the software (or *
// * any work based  on the software)  you  agree  to acknowledge its *
// * use  in  resulting  scientific  publications,  and indicate your *
// * acceptance of all terms of the Geant4 Software license.          *
// ********************************************************************
//

// **********************************************************************

#include <boost/python.hpp>
#include "G4Event.hh"
#include "G4ParticleGun.hh"
#include "LSExpParticleGun.hh"
#include "Randomize.hh"
#include "G4ParticleTable.hh"
#include "G4IonTable.hh"
#include "G4ParticleDefinition.hh"
#include "LSExpPrimaryGeneratorAction.hh"
#include "G4StateManager.hh"
#include "G4OpticalPhoton.hh"

// FIXME: This is a temporary solution to get data.
#include "SniperKernel/SniperDataPtr.h"
#include "SniperKernel/SniperLog.h"
#include "EvtNavigator/NavBuffer.h"
#include "Event/GenHeader.h"
#include "Event/GenEvent.h"

#include <fstream>
//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo....

LSExpPrimaryGeneratorAction::LSExpPrimaryGeneratorAction()
{
  particleGun = new LSExpParticleGun (1);

  particleName = "e+";
  xpos = 0;
  ypos = 0;
  zpos = 0;

  m_scope = 0;


}

LSExpPrimaryGeneratorAction::~LSExpPrimaryGeneratorAction()
{
}

void LSExpPrimaryGeneratorAction::GeneratePrimaries(G4Event* anEvent)
{
    HepMC::GenEvent* gep = 0;
    gep = load_gen_event();
    if (not gep) {
        // TODO raise an Error
        assert(gep);
        return;
    }
    if (SniperLog::logLevel() <= 2) {
        gep->print();
    }

    // set the event id
    anEvent->SetEventID( gep->event_number() );

    // Refer to G4DataHelpers in Dayabay
    // Loop over vertex first
    //     Loop over particles in vertex
      
    // Loop over vertices in the event
    HepMC::GenEvent::vertex_const_iterator
        iVtx = (*gep).vertices_begin(),
        doneVtx = (*gep).vertices_end();
    for (/*nop*/; doneVtx != iVtx; ++iVtx) {
        const HepMC::FourVector& v = (*iVtx)->position();
        G4PrimaryVertex* g4vtx = new G4PrimaryVertex(v.x(), v.y(), v.z(), v.t());

        // Loop over particles in the vertex
        HepMC::GenVertex::particles_out_const_iterator 
            iPart = (*iVtx)->particles_out_const_begin(),
            donePart = (*iVtx)->particles_out_const_end();
        for (/*nop*/; donePart != iPart; ++iPart) {

            // Only keep particles that are important for tracking
            if ((*iPart)->status() != 1) continue;

            G4int pdgcode= (*iPart)-> pdg_id();
            // check the pdgid
            G4ParticleTable* particletbl = G4ParticleTable::GetParticleTable();
            G4ParticleDefinition* particle_def = particletbl->FindParticle(pdgcode);

            // try to look up in ion tables
            //
            // In principle, we need to let nucleus do simulation.
            // However, GenDecay already helps us separate decay chain, 
            // we don't need Geant4 to simulate decay again.
            //
            // Only if the kinetic energy of this nucleus is important,
            // we need to enable following part.
            //
            // -- Tao Lin <lintao@ihep.ac.cn>, 29th Dec 2016
            //
            // if (!particle_def and pdgcode!=20022) {
            //     G4IonTable *theIonTable = particletbl->GetIonTable();
            //     particle_def = theIonTable->GetIon(pdgcode);
            // }

            if (particle_def == 0 and pdgcode != 20022) {
                G4cout << "=== Unknown pdgcode: [" << pdgcode 
                       << "] skip tracking"<< G4endl;
                // skip this particle
                continue;
            } else if (pdgcode == 20022) {
                particle_def = G4OpticalPhoton::Definition();
            }
            //
            const HepMC::FourVector& p = (*iPart)->momentum();
            // TODO: What's the unit!
            G4PrimaryParticle* g4prim=new G4PrimaryParticle(particle_def, p.px(), p.py(), p.pz());

            HepMC::ThreeVector pol = (*iPart)->polarization().normal3d();
            g4prim->SetPolarization(pol.x(),pol.y(),pol.z());

            g4vtx->SetPrimary(g4prim);
        }

        if (SniperLog::logLevel() <= 2) {
            g4vtx->Print();
        }

        anEvent->AddPrimaryVertex(g4vtx);

    }
}

HepMC::GenEvent*
LSExpPrimaryGeneratorAction::load_gen_event() {
    // FIXME: Don't know the scope
    SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
    if (navBuf.invalid()) {
        return 0;
    }
    JM::EvtNavigator* evt_nav = navBuf->curEvt();
    if (not evt_nav) {
        return 0;
    }
    JM::GenHeader* gen_header = dynamic_cast<JM::GenHeader*>(evt_nav->getHeader("/Event/Gen"));
    if (not gen_header) {
        return 0;
    }
    JM::GenEvent* gen_event = dynamic_cast<JM::GenEvent*>(gen_header->event());
    if (not gen_event) {
        return 0;
    }
    return gen_event->getEvent();
}

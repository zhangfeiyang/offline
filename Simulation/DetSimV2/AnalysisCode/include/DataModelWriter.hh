#ifndef DataModelWriter_hh
#define DataModelWriter_hh

#include "SniperKernel/ToolBase.h"
#include "DetSimAlg/IAnalysisElement.h"

#include "dywHit_PMT.hh"
#include "dywHit_PMT_muon.hh"
#include "Event/SimHeader.h"
#include "Event/SimEvent.h"

class G4Event;
namespace JM {
    class SimEvent;
}

class DataModelWriter: public IAnalysisElement,
                       public ToolBase{

public:
    DataModelWriter(const std::string& name);
    ~DataModelWriter();

    // Run Action
    virtual void BeginOfRunAction(const G4Run*);
    virtual void EndOfRunAction(const G4Run*);
    // Event Action
    virtual void BeginOfEventAction(const G4Event*);
    virtual void EndOfEventAction(const G4Event*);
private:

    // fill hits
    void fill_hits(JM::SimEvent* dst, const G4Event* evt);
    template<typename T>
    void fill_hits_tmpl(G4THitsCollection<T>* col, JM::SimEvent* dst) {
        if (col) {
            int n_hit = col->entries();
            // m_nPhotons = n_hit;

            for (int i = 0; i < n_hit; ++i) {
                // create new hit
                // The PMT Hit can be from WP (Water Pool) or CD (Central
                // Detector). 
                // Please use the copy no to distinguish the PMT.
                int copyno = (*col)[i]->GetPMTID();
                JM::SimPMTHit* jm_hit = 0;
                // FIXME: hard code the copy no
                if ((copyno < 30000) or (copyno >= 300000)) {
                    // TODO because in current Data Model, the 3inch and the 20inch
                    // PMTs are in the same collection.
                    jm_hit = dst->addCDHit();
                } else if (copyno >= 30000) {
                    jm_hit = dst->addWPHit();
                }
                jm_hit->setPMTID( (*col)[i]->GetPMTID() );
                jm_hit->setNPE( (*col)[i]->GetCount() );
                jm_hit->setHitTime( (*col)[i]->GetTime() );
                jm_hit->setTrackID( (*col)[i]->GetProducerID() );
            }

        }
    }
    // fill tracks
    void fill_tracks(JM::SimEvent* dst, const G4Event* evt);
};

#endif

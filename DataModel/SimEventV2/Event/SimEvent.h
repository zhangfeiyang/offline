#ifndef SimEvent_h
#define SimEvent_h

#include "Event/EventObject.h"
#include "Event/SimPMTHit.h"
#include "Event/SimTTHit.h"
#include "Event/SimTrack.h"
#include <vector>


namespace JM
{
    class SimPMTHit;
    class SimTrack;
    class SimTTHit;

    class SimEvent: public EventObject
    {
        private:
            std::vector<SimTrack*> m_tracks;  
            std::vector<SimPMTHit*> m_cd_hits; 
            std::vector<SimPMTHit*> m_wp_hits; 
            std::vector<SimTTHit*> m_tt_hits; 

            Int_t m_nhits;
            Int_t m_nhits_wp;
            Int_t m_ntrks;
            Int_t m_nbars;

            Int_t m_counter; // only for debug

            Int_t m_eventid;

            // don't support the copy constructor
            SimEvent(const SimEvent& event);

        public:
            SimEvent();
            SimEvent(Int_t evtid);
            ~SimEvent();

            // == Initial Track Info ==
            JM::SimTrack *addTrack();
            const std::vector<JM::SimTrack*>& getTracksVec() const {return m_tracks;}
            JM::SimTrack *findTrackByTrkID(int trkid);

            // == CD (Central Detector) Related ==
            JM::SimPMTHit *addCDHit();
            const std::vector<JM::SimPMTHit*>& getCDHitsVec() const {return m_cd_hits;}

            // == WP (Water Pool) Related ==
            JM::SimPMTHit *addWPHit();
            const std::vector<JM::SimPMTHit*>& getWPHitsVec() const {return m_wp_hits;}

            // == TT (Top Tracker) Related ==
            JM::SimTTHit *addTTHit();
            const std::vector<JM::SimTTHit*>& getTTHitsVec() const {return m_tt_hits;}

            // == Event ID ==
            Int_t getEventID() { return m_eventid; }
            void setEventID(Int_t val) { m_eventid = val; }
            ClassDef(SimEvent, 10)

    };
}

#endif

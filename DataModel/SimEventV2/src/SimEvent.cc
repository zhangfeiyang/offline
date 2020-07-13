#include "Event/SimEvent.h"
#include "Event/SimPMTHit.h"
#include "Event/SimTTHit.h"
#include <cassert>

ClassImp(JM::SimEvent);

namespace JM
{
    static int counter = 0;

    SimEvent::SimEvent() {
        m_counter = ++counter;
        m_tracks.clear();
        m_cd_hits.clear();
        m_wp_hits.clear();
        m_tt_hits.clear();

        m_nhits = 0;
        m_nhits_wp = 0;
        m_ntrks = 0;
        m_eventid = 0;
        m_nbars = 0;
    }

    SimEvent::SimEvent(Int_t evtid) {
        m_counter = ++counter;
        m_tracks.clear();
        m_cd_hits.clear();
        m_wp_hits.clear();
        m_tt_hits.clear();

        m_nhits = 0;
        m_nhits_wp = 0;
        m_ntrks = 0;
        m_eventid = evtid;
        m_nbars = 0;

    }

    SimEvent::~SimEvent() {
        for (std::vector<SimTrack*>::iterator it = m_tracks.begin();
                it != m_tracks.end(); ++it) {
            delete (*it);
        }
        m_tracks.clear();
        for (std::vector<SimPMTHit*>::iterator it = m_cd_hits.begin();
                it != m_cd_hits.end(); ++it) {
            delete (*it);
        }
        m_cd_hits.clear();
        for (std::vector<SimPMTHit*>::iterator it = m_wp_hits.begin();
                it != m_wp_hits.end(); ++it) {
            delete (*it);
        }
        m_wp_hits.clear();
        for (std::vector<SimTTHit*>::iterator it = m_tt_hits.begin();
                it != m_tt_hits.end(); ++it) {
            delete (*it);
        }
        m_tt_hits.clear();
        
    }

    SimTrack* SimEvent::addTrack() {
        SimTrack* track = new SimTrack;
        m_tracks.push_back(track);
        ++m_ntrks;
        return track;
    }

    SimTrack* SimEvent::findTrackByTrkID(int trkid) {
        JM::SimTrack* trk = 0;
        for (size_t i = 0; i < m_tracks.size(); ++i) {
            trk = m_tracks[i];
            if (trk->getTrackID() == trkid) {
                break;
            }
        }
        return trk;
    }

    SimPMTHit* SimEvent::addCDHit() {
        SimPMTHit* hit = new SimPMTHit;
        m_cd_hits.push_back(hit);
        ++m_nhits;
        return hit;
    }

    SimPMTHit* SimEvent::addWPHit() {
        SimPMTHit* hit = new SimPMTHit;
        m_wp_hits.push_back(hit);
        ++m_nhits_wp;
        return hit;
    }

    SimTTHit* SimEvent::addTTHit() {
        SimTTHit* hit = new SimTTHit;
        m_tt_hits.push_back(hit);
        ++m_nbars;
        return hit;
    }

}

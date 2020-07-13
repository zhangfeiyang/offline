#ifndef SimPMTHit_h
#define SimPMTHit_h

#include "TObject.h"
#include <vector>
#include <iostream>

namespace JM
{
    class SimPMTHit: public TObject {
        private:
            int pmtid;
            int npe;
            double hittime;
            double timewindow;
            int trackid; // ref to Track ID. but if hits are merged, unknown.
        public:
            SimPMTHit() {
                pmtid = -1;
                npe = -1;
                hittime = -1;
                timewindow = 0;
                trackid = -1;
            }

            virtual ~SimPMTHit() {}

        public:
            int getPMTID() {return pmtid;}
            int getNPE() {return npe;}
            double getHitTime() {return hittime;}
            double getTimeWindow() {return timewindow;}
            int getTrackID() { return trackid; }

            void setPMTID(int val) {pmtid=val;}
            void setNPE(int val) {npe=val;}
            void setHitTime(double val) {hittime = val;}
            void setTimeWindow(double val) {timewindow = val;}
            void setTrackID(int val) {trackid = val;}

            ClassDef(SimPMTHit, 6)
    };
}

#endif

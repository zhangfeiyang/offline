#ifndef SimTTHit_h
#define SimTTHit_h

#include "TObject.h"
#include <vector>
#include <iostream>

namespace JM {
    class SimTTHit: public TObject {

        private:
            int channelid;
            // pe
            float pe;
            // time
            float time;
             // ADC
            float ADC;
            // position
            float x;
            float y;
            float z;
        public:

            SimTTHit();
            virtual ~SimTTHit();

            // getter
            int getChannelID() { return channelid; }

            float getPE() { return pe; }

            float getTime() { return time; }


            float getADC() { return ADC; }

            float getX() { return x; }
            float getY() { return y; }
            float getZ() { return z; }
            // setter
            void setChannelID(int v) { channelid = v; }

            void setPE(float v) { pe = v; }
            
            void setTime(float v) { time = v; }
            
            void setADC(float v) { ADC = v; }
            
            void setX(float v) { x = v; }
            void setY(float v) { y = v; }
            void setZ(float v) { z = v; }

            ClassDef(SimTTHit, 3)
    };
}

#endif

#ifndef GenEvent_h
#define GenEvent_h

#include "Event/EventObject.h"
#include "HepMC/GenEvent.h"

namespace JM
{
    class GenEvent: public EventObject
    {
        private:
            HepMC::GenEvent* evt;

        public:

            GenEvent();
            ~GenEvent();

            void setEvent(HepMC::GenEvent* val) {
                evt = val;
            }
            HepMC::GenEvent* getEvent() {
                return evt;
            }

            ClassDef(GenEvent,2)

    };
}

#endif

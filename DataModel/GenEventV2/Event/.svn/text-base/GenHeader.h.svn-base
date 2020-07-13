#ifndef GenHeader_h
#define GenHeader_h

#include "Event/HeaderObject.h"
#include "Event/GenEvent.h"
#include "EDMUtil/SmartRef.h"

namespace JM
{
    class GenEvent;

    class GenHeader: public HeaderObject
    {
        private:
            JM::SmartRef m_event; // ||
        public:

            GenHeader();
            ~GenHeader();

            EventObject* event() {
                return m_event.GetObject();
            }
            void setEvent(GenEvent* value) {
                m_event = value;
            }
            void setEventEntry(const std::string& eventName, Long64_t& value);
            EventObject* event(const std::string& eventName);
            bool hasEvent();

            ClassDef(GenHeader,3)
    };
}

#endif

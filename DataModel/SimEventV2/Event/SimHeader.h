#ifndef SimHeader_h
#define SimHeader_h

#include "Event/HeaderObject.h"
#include "EDMUtil/SmartRef.h"
#include "Event/SimEvent.h"
#include <string>

namespace JM
{
    class SimHeader: public HeaderObject
    {
        private:
            JM::SmartRef m_event; // ||
            /* 
             * Describe what's type of the current event.
             * + IBD
             * + U
             * + Th
             * + ...
             * or 
             * + Mixing
             */
            std::string m_evt_type; 

        public:
            SimHeader();
            ~SimHeader();

            EventObject* event() {
                return m_event.GetObject();
            }
            void setEvent(SimEvent* value) {
                m_event = value;
            }
            void setEventEntry(const std::string& eventName, Long64_t& value);
            EventObject* event(const std::string& eventName);
            bool hasEvent();

        public:

            const std::string& getEventType() {
                return m_evt_type;
            }

            void setEventType(const std::string& evt_type) {
                m_evt_type = evt_type;
            }

        public:
            ClassDef(SimHeader,4)

    };
}

#endif

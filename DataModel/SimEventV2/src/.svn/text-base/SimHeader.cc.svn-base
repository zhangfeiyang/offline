
#include "Event/SimHeader.h"

ClassImp(JM::SimHeader);

namespace JM
{
    SimHeader::SimHeader() {

    }

    SimHeader::~SimHeader() {

    }

    void SimHeader::setEventEntry(const std::string& eventName, Long64_t& value) {
        if (eventName == "JM::SimEvent") {
            m_event.setEntry(value);
        }
    }

    EventObject* SimHeader::event(const std::string& eventName) {
        if (eventName == "JM::SimEvent") {
            return m_event.GetObject();
        }
        return 0;
    }

    bool SimHeader::hasEvent() {
        return m_event.HasObject();
    }

}

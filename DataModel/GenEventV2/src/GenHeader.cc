#include "Event/GenHeader.h"

ClassImp(JM::GenHeader);

namespace JM
{
    GenHeader::GenHeader() {

    }

    GenHeader::~GenHeader() {

    }

    void GenHeader::setEventEntry(const std::string& eventName, Long64_t& value) {
        if (eventName == "JM::GenEvent") {
            m_event.setEntry(value);
        }
    }

    EventObject* GenHeader::event(const std::string& eventName) {
        if (eventName == "JM::GenEvent") {
            return m_event.GetObject();
        }
        return 0;
    }

    bool GenHeader::hasEvent() {
        return m_event.HasObject();
    }
}

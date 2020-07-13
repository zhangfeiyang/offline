#include "ElecDataStruct/EventKeeper.h"
#include <iostream>
EventKeeper&
EventKeeper::Instance() {
    static EventKeeper s_keeper;
    return s_keeper;
}

EventKeeper::Entry::Entry() 
    : tag()
    , filename()
    , entry(-1)
    , header(0)
{

}

EventKeeper::Record::Record()
    : elecevent_id(-1)
{

}

void
EventKeeper::Record::reset() {
    simevents.clear();
    elecevent_id = -1;
}

EventKeeper::EventKeeper() {

}

void
EventKeeper::clear() {
    m_record.reset();

}

void
EventKeeper::set_current_entry(const EventKeeper::Entry& entry) {
    m_entry = entry;
}

const EventKeeper::Entry&
EventKeeper::current_entry() {
    return m_entry;
}

const EventKeeper::Record&
EventKeeper::current_record() {
    return m_record;
}


bool operator < (const EventKeeper::Entry &l, const EventKeeper::Entry &r) { 
    return (l.tag<r.tag)&&(l.filename<r.filename)&&(l.entry<r.entry);
}

bool
EventKeeper::add(const Entry& entry) {
    // only entry>=0 is valid
    if (entry.entry < 0) {
        return false;
    }
    // count the entry in current event.
    ++m_record.simevents[entry];
    return true;
}

bool
EventKeeper::commit() {

    // give summary:
    std::cout << "EventKeeper::commit summary: "
              << "total " << m_record.simevents.size() << " events mixing." << std::endl;
    for (std::map<Entry, int>::iterator it = m_record.simevents.begin();
         it != m_record.simevents.end(); ++it) {
        std::cout << "--> [" << it->first.tag << "] "
                  << " " << it->first.filename << ":" << it->first.entry
                  << " count: " << it->second
                  << std::endl;
    }

    clear();
    return true;
}

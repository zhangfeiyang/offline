#include "InputReviser/InputReviser.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "RootIOSvc/IInputSvc.h"
#include "RootIOSvc/IInputStream.h"
#include "SniperKernel/SniperPtr.h"
#include "SniperKernel/SniperLog.h"

InputReviser::InputReviser(const std::string& msg, bool infinite)
    : Incident(msg),
      m_infinite(infinite),
      m_revise(false),
      m_entries(-1),
      m_is(0)
{
}

InputReviser::~InputReviser()
{
}

bool InputReviser::init()
{
    SniperPtr<IInputSvc> iSvc(m_msg+":InputSvc");
    if ( iSvc.valid() ) {
        m_is = iSvc->getInputStream("EvtNavigator");
        m_entries = m_is->getEntries();
        return true;
    }
    return false;
}

bool InputReviser::fire()
{
    bool status = true;
    if ( m_is != 0 ) {
        LogDebug << " revise: " << m_revise
                << " infinite: " << m_infinite 
                << std::endl;
        if ( m_revise && m_infinite ) {
            SniperPtr<IDataMemMgr> mMgr(m_msg+":BufferMemMgr");
            mMgr->reset("/Event", 0);
            m_revise = false;
        }
        // get the event first
        status = Incident::fire();

        int iEntry = m_is->getEntry();
        LogDebug << " iEntry: " << iEntry
                << " m_entries: " << m_entries << std::endl;
        if ( iEntry+1 >= m_entries ) {
            m_revise = true;
        }
        LogDebug << " revise: " << m_revise << std::endl;
    }
    else {
        if ( init() ) {
            return fire();
        }
    }

    return status;
}

bool InputReviser::reset(int entry)
{
    SniperPtr<IDataMemMgr> mMgr(m_msg+":BufferMemMgr");
    return mMgr->reset("/Event", entry);
}

int InputReviser::getEntries()
{
    if ( m_entries < 0 ) {
        init();
    }
    return m_entries;
}

int InputReviser::getEntry()
{
    return m_is->getEntry();
}

std::string InputReviser::getFileName()
{
    std::string fn;
    fn = m_is->streamname();
    return fn;
}


//   **************************************************************************
//   *                                                                        *
//   *                      ! ! ! A T T E N T I O N ! ! !                     *
//   *                                                                        *
//   *  This file was created automatically by XmlObjDesc, please do not      *
//   *  delete it or edit it by hand.                                         *
//   *                                                                        *
//   *  If you want to change this file, first change the corresponding       *
//   *  xml-file and rerun the tools from XmlObjDesc (or run make if you      *
//   *  are using it from inside a Sniper-package).                           *
//   *                                                                        *
//   **************************************************************************

#ifndef SNIPER_ELECEVENT_ELECHEADER_H
#define SNIPER_ELECEVENT_ELECHEADER_H

// Include files
#include "Event/HeaderObject.h"
#include "Event/ElecEvent.h"
#include "Event/SpmtElecEvent.h"
#include "EDMUtil/SmartRef.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class ElecHeader ElecHeader.h
   *
   *  
   *
   * @author fangxiao
   * created Thu Dec 28 13:43:44 2017
   * 
   */

  class ElecHeader: public HeaderObject
  {
  private:

    JM::SmartRef m_event;     // ||SmartRef to the Elec Event
    JM::SmartRef m_spmtEvent; // ||SmartRef to the SPMT Elec Event
  

  protected:


  public:

    /// Default Constructor
    ElecHeader() {}
  
    /// Default Destructor
    virtual ~ElecHeader() {}
  
    /// Retrieve referenced 
    /// SmartRef to the Elec Event
    JM::ElecEvent* event();
  
    /// Update referenced 
    /// SmartRef to the Elec Event
    void setEvent(JM::ElecEvent* value);
  
    /// Retrieve referenced 
    /// SmartRef to the SPMT Elec Event
    JM::SpmtElecEvent* spmtEvent();
  
    /// Update referenced 
    /// SmartRef to the SPMT Elec Event
    void setSpmtEvent(JM::SpmtElecEvent* value);
  
    /// Set entry number of events
    void setEventEntry(const std::string& eventName, Long64_t& value);
  
    /// Get event
    JM::EventObject* event(const std::string& eventName);
  
    //Check if event exists
    bool hasEvent();
  
    //Check if spmtEvent exists
    bool hasSpmtEvent();
  
    ClassDef(ElecHeader,1);
  

  }; // class ElecHeader

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline JM::ElecEvent* JM::ElecHeader::event() 
{
  return (JM::ElecEvent*)m_event.GetObject();
}

inline void JM::ElecHeader::setEvent(JM::ElecEvent* value) 
{
  m_event = value;
}

inline JM::SpmtElecEvent* JM::ElecHeader::spmtEvent() 
{
  return (JM::SpmtElecEvent*)m_spmtEvent.GetObject();
}

inline void JM::ElecHeader::setSpmtEvent(JM::SpmtElecEvent* value) 
{
  m_spmtEvent = value;
}

inline void JM::ElecHeader::setEventEntry(const std::string& eventName, Long64_t& value)
{
  if (eventName == "JM::ElecEvent") { 
    m_event.setEntry(value);
  }
  if (eventName == "JM::SpmtElecEvent") { 
    m_spmtEvent.setEntry(value);
  }
}

inline JM::EventObject* JM::ElecHeader::event(const std::string& eventName)
{
  if (eventName == "JM::ElecEvent") { 
    return m_event.GetObject();
  }
  if (eventName == "JM::SpmtElecEvent") { 
    return m_spmtEvent.GetObject();
  }
  return 0; 
}

inline bool JM::ElecHeader::hasEvent()
{
  return m_event.HasObject();
}


inline bool JM::ElecHeader::hasSpmtEvent()
{
  return m_spmtEvent.HasObject();
}



#endif ///SNIPER_ELECEVENT_ELECHEADER_H

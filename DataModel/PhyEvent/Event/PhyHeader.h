
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

#ifndef SNIPER_PHYEVENT_PHYHEADER_H
#define SNIPER_PHYEVENT_PHYHEADER_H

// Include files
#include "Event/HeaderObject.h"
#include "Event/PhyEvent.h"
#include "EDMUtil/SmartRef.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class PhyHeader PhyHeader.h
   *
   * Physics Header Class 
   *
   * @author LI Teng
   * created Thu Dec 28 13:42:05 2017
   * 
   */

  class PhyHeader: public HeaderObject
  {
  private:

    JM::SmartRef m_event; // ||SmartRef to the phyEvent
  

  protected:


  public:

    /// Default Constructor
    PhyHeader() {}
  
    /// Default Destructor
    virtual ~PhyHeader() {}
  
    /// Retrieve referenced 
    /// SmartRef to the phyEvent
    JM::PhyEvent* event();
  
    /// Update referenced 
    /// SmartRef to the phyEvent
    void setEvent(JM::PhyEvent* value);
  
    /// Set entry number of events
    void setEventEntry(const std::string& eventName, Long64_t& value);
  
    /// Get event
    JM::EventObject* event(const std::string& eventName);
  
    //Check if event exists
    bool hasEvent();
  
    ClassDef(PhyHeader,1);
  

  }; // class PhyHeader

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline JM::PhyEvent* JM::PhyHeader::event() 
{
  return (JM::PhyEvent*)m_event.GetObject();
}

inline void JM::PhyHeader::setEvent(JM::PhyEvent* value) 
{
  m_event = value;
}

inline void JM::PhyHeader::setEventEntry(const std::string& eventName, Long64_t& value)
{
  if (eventName == "JM::PhyEvent") { 
    m_event.setEntry(value);
  }
}

inline JM::EventObject* JM::PhyHeader::event(const std::string& eventName)
{
  if (eventName == "JM::PhyEvent") { 
    return m_event.GetObject();
  }
  return 0; 
}

inline bool JM::PhyHeader::hasEvent()
{
  return m_event.HasObject();
}



#endif ///SNIPER_PHYEVENT_PHYHEADER_H

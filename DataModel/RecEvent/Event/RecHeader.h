
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

#ifndef SNIPER_RECEVENT_RECHEADER_H
#define SNIPER_RECEVENT_RECHEADER_H

// Include files
#include "Event/HeaderObject.h"
#include "Event/CDRecEvent.h"
#include "Event/CDTrackRecEvent.h"
#include "Event/WPRecEvent.h"
#include "Event/TTRecEvent.h"
#include "EDMUtil/SmartRef.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class RecHeader RecHeader.h
   *
   * Reconstruction Header Class 
   *
   * @author ZHANG Kun
   * created Thu Dec 28 13:42:24 2017
   * 
   */

  class RecHeader: public HeaderObject
  {
  private:

    JM::SmartRef m_CDEvent;      // ||Smart pointer to the RecEvent (CD)
    JM::SmartRef m_CDTrackEvent; // ||Smart pointer to the RecTrackEvent (CD)
    JM::SmartRef m_WPEvent;      // ||Smart pointer to the RecEvent (WP)
    JM::SmartRef m_TTEvent;      // ||Smart pointer to the RecEvent (TT)
  

  protected:


  public:

    /// Default Constructor
    RecHeader() {}
  
    /// Default Destructor
    virtual ~RecHeader() {}
  
    /// Retrieve referenced 
    /// Smart pointer to the RecEvent (CD)
    JM::CDRecEvent* cdEvent();
  
    /// Update referenced 
    /// Smart pointer to the RecEvent (CD)
    void setCDEvent(JM::CDRecEvent* value);
  
    /// Retrieve referenced 
    /// Smart pointer to the RecTrackEvent (CD)
    JM::CDTrackRecEvent* cdTrackEvent();
  
    /// Update referenced 
    /// Smart pointer to the RecTrackEvent (CD)
    void setCDTrackEvent(JM::CDTrackRecEvent* value);
  
    /// Retrieve referenced 
    /// Smart pointer to the RecEvent (WP)
    JM::WPRecEvent* wpEvent();
  
    /// Update referenced 
    /// Smart pointer to the RecEvent (WP)
    void setWPEvent(JM::WPRecEvent* value);
  
    /// Retrieve referenced 
    /// Smart pointer to the RecEvent (TT)
    JM::TTRecEvent* ttEvent();
  
    /// Update referenced 
    /// Smart pointer to the RecEvent (TT)
    void setTTEvent(JM::TTRecEvent* value);
  
    /// Set entry number of events
    void setEventEntry(const std::string& eventName, Long64_t& value);
  
    /// Get event
    JM::EventObject* event(const std::string& eventName);
  
    //Check if CDEvent exists
    bool hasCDEvent();
  
    //Check if CDTrackEvent exists
    bool hasCDTrackEvent();
  
    //Check if WPEvent exists
    bool hasWPEvent();
  
    //Check if TTEvent exists
    bool hasTTEvent();
  
    ClassDef(RecHeader,1);
  

  }; // class RecHeader

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline JM::CDRecEvent* JM::RecHeader::cdEvent() 
{
  return (JM::CDRecEvent*)m_CDEvent.GetObject();
}

inline void JM::RecHeader::setCDEvent(JM::CDRecEvent* value) 
{
  m_CDEvent = value;
}

inline JM::CDTrackRecEvent* JM::RecHeader::cdTrackEvent() 
{
  return (JM::CDTrackRecEvent*)m_CDTrackEvent.GetObject();
}

inline void JM::RecHeader::setCDTrackEvent(JM::CDTrackRecEvent* value) 
{
  m_CDTrackEvent = value;
}

inline JM::WPRecEvent* JM::RecHeader::wpEvent() 
{
  return (JM::WPRecEvent*)m_WPEvent.GetObject();
}

inline void JM::RecHeader::setWPEvent(JM::WPRecEvent* value) 
{
  m_WPEvent = value;
}

inline JM::TTRecEvent* JM::RecHeader::ttEvent() 
{
  return (JM::TTRecEvent*)m_TTEvent.GetObject();
}

inline void JM::RecHeader::setTTEvent(JM::TTRecEvent* value) 
{
  m_TTEvent = value;
}

inline void JM::RecHeader::setEventEntry(const std::string& eventName, Long64_t& value)
{
  if (eventName == "JM::CDRecEvent") { 
    m_CDEvent.setEntry(value);
  }
  if (eventName == "JM::CDTrackRecEvent") { 
    m_CDTrackEvent.setEntry(value);
  }
  if (eventName == "JM::WPRecEvent") { 
    m_WPEvent.setEntry(value);
  }
  if (eventName == "JM::TTRecEvent") { 
    m_TTEvent.setEntry(value);
  }
}

inline JM::EventObject* JM::RecHeader::event(const std::string& eventName)
{
  if (eventName == "JM::CDRecEvent") { 
    return m_CDEvent.GetObject();
  }
  if (eventName == "JM::CDTrackRecEvent") { 
    return m_CDTrackEvent.GetObject();
  }
  if (eventName == "JM::WPRecEvent") { 
    return m_WPEvent.GetObject();
  }
  if (eventName == "JM::TTRecEvent") { 
    return m_TTEvent.GetObject();
  }
  return 0; 
}

inline bool JM::RecHeader::hasCDEvent()
{
  return m_CDEvent.HasObject();
}


inline bool JM::RecHeader::hasCDTrackEvent()
{
  return m_CDTrackEvent.HasObject();
}


inline bool JM::RecHeader::hasWPEvent()
{
  return m_WPEvent.HasObject();
}


inline bool JM::RecHeader::hasTTEvent()
{
  return m_TTEvent.HasObject();
}



#endif ///SNIPER_RECEVENT_RECHEADER_H

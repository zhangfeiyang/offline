
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

#ifndef SNIPER_CALIBEVENT_CALIBHEADER_H
#define SNIPER_CALIBEVENT_CALIBHEADER_H

// Include files
#include "Event/HeaderObject.h"
#include "Event/CalibEvent.h"
#include "Event/TTCalibEvent.h"
#include "EDMUtil/SmartRef.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class CalibHeader CalibHeader.h
   *
   * Calibration header 
   *
   * @author ZHANG Kun
   * created Thu Dec 28 13:42:11 2017
   * 
   */

  class CalibHeader: public HeaderObject
  {
  private:

    JM::SmartRef m_event;   // ||Smart pointer to the CalibEvent
    JM::SmartRef m_TTEvent; // ||Smart pointer to the TTCalibEvent
  

  protected:


  public:

    /// Default Constructor
    CalibHeader() {}
  
    /// Default Destructor
    virtual ~CalibHeader() {}
  
    /// Get a pmt channel via pmtid
    const JM::CalibPMTChannel* getCalibPmtChannel(unsigned int pmtid);
  
    /// Add a Calibrate pmt channel to this event
    CalibPMTChannel* addCalibPmtChannel(unsigned int pmtid);
  
    /// Retrieve referenced 
    /// Smart pointer to the CalibEvent
    JM::CalibEvent* event();
  
    /// Update referenced 
    /// Smart pointer to the CalibEvent
    void setEvent(JM::CalibEvent* value);
  
    /// Retrieve referenced 
    /// Smart pointer to the TTCalibEvent
    JM::TTCalibEvent* ttEvent();
  
    /// Update referenced 
    /// Smart pointer to the TTCalibEvent
    void setTTEvent(JM::TTCalibEvent* value);
  
    /// Set entry number of events
    void setEventEntry(const std::string& eventName, Long64_t& value);
  
    /// Get event
    JM::EventObject* event(const std::string& eventName);
  
    //Check if event exists
    bool hasEvent();
  
    //Check if TTEvent exists
    bool hasTTEvent();
  
    ClassDef(CalibHeader,1);
  

  }; // class CalibHeader

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline JM::CalibEvent* JM::CalibHeader::event() 
{
  return (JM::CalibEvent*)m_event.GetObject();
}

inline void JM::CalibHeader::setEvent(JM::CalibEvent* value) 
{
  m_event = value;
}

inline JM::TTCalibEvent* JM::CalibHeader::ttEvent() 
{
  return (JM::TTCalibEvent*)m_TTEvent.GetObject();
}

inline void JM::CalibHeader::setTTEvent(JM::TTCalibEvent* value) 
{
  m_TTEvent = value;
}

inline void JM::CalibHeader::setEventEntry(const std::string& eventName, Long64_t& value)
{
  if (eventName == "JM::CalibEvent") { 
    m_event.setEntry(value);
  }
  if (eventName == "JM::TTCalibEvent") { 
    m_TTEvent.setEntry(value);
  }
}

inline JM::EventObject* JM::CalibHeader::event(const std::string& eventName)
{
  if (eventName == "JM::CalibEvent") { 
    return m_event.GetObject();
  }
  if (eventName == "JM::TTCalibEvent") { 
    return m_TTEvent.GetObject();
  }
  return 0; 
}

inline bool JM::CalibHeader::hasEvent()
{
  return m_event.HasObject();
}


inline bool JM::CalibHeader::hasTTEvent()
{
  return m_TTEvent.HasObject();
}


inline const JM::CalibPMTChannel* JM::CalibHeader::getCalibPmtChannel(unsigned int pmtid) 
{

                    return event()->getCalibPmtChannel(pmtid);
                
}

inline JM::CalibPMTChannel* JM::CalibHeader::addCalibPmtChannel(unsigned int pmtid) 
{

                    return event()->addCalibPmtChannel(pmtid);
                
}


#endif ///SNIPER_CALIBEVENT_CALIBHEADER_H

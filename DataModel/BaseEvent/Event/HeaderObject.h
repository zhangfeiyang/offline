
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

#ifndef SNIPER_BASEEVENT_HEADEROBJECT_H
#define SNIPER_BASEEVENT_HEADEROBJECT_H

// Include files
#include "EventObject.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class HeaderObject HeaderObject.h
   *
   * Base class for event header 
   *
   * @author LI Teng
   * created Thu Dec 28 13:40:38 2017
   * 
   */

  class HeaderObject: public EventObject
  {
  private:

    int m_EventID; // id of event
    int m_RunID;   // id of run
  

  protected:


  public:

    /// Default Constructor
    HeaderObject() : m_EventID(0),
                     m_RunID(0) {}
  
    /// Default Destructor
    virtual ~HeaderObject() {}
  
    /// Set the entry number of the event object
    virtual void setEventEntry(const std::string& eventName,
                               Long64_t& value) = 0;
  
    /// Get the event object of header
    virtual EventObject* event(const std::string& value) = 0;
  
    /// Retrieve const  
    /// id of event
    int EventID() const;
  
    /// Update  
    /// id of event
    void setEventID(int value);
  
    /// Retrieve const  
    /// id of run
    int RunID() const;
  
    /// Update  
    /// id of run
    void setRunID(int value);
  
    ClassDef(HeaderObject,1);
  

  }; // class HeaderObject

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline int JM::HeaderObject::EventID() const 
{
  return m_EventID;
}

inline void JM::HeaderObject::setEventID(int value) 
{
  m_EventID = value;
}

inline int JM::HeaderObject::RunID() const 
{
  return m_RunID;
}

inline void JM::HeaderObject::setRunID(int value) 
{
  m_RunID = value;
}


#endif ///SNIPER_BASEEVENT_HEADEROBJECT_H

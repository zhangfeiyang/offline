/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/

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

#ifndef SNIPER_CLUSTEREVENT_CLUSTERHEADER_H
#define SNIPER_CLUSTEREVENT_CLUSTERHEADER_H

// Include files
#include "Event/HeaderObject.h"
#include "Event/ClusterEvent.h"
#include "EDMUtil/SmartRef.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class ClusterHeader ClusterHeader.h
   *
   * Cluster Header Class 
   *
   * @author DING Xuefeng
   * created Wed Oct 11 22:35:33 2017
   * 
   */

  class ClusterHeader: public HeaderObject
  {
  private:

    JM::SmartRef m_event; // ||Smart pointer to the ClusterEvent
  

  protected:


  public:

    /// Default Constructor
    ClusterHeader() {}
  
    /// Default Destructor
    virtual ~ClusterHeader() {}
  
    /// Retrieve referenced 
    /// Smart pointer to the ClusterEvent
    JM::ClusterEvent* event();
  
    /// Update referenced 
    /// Smart pointer to the ClusterEvent
    void setEvent(JM::ClusterEvent* value);
  
    /// Set entry number of events
    void setEventEntry(const std::string& eventName, Long64_t& value);
  
    /// Get event
    JM::EventObject* event(const std::string& eventName);
  
    //Check if event exists
    bool hasEvent();
  
    ClassDef(ClusterHeader,1);
  

  }; // class ClusterHeader

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline JM::ClusterEvent* JM::ClusterHeader::event() 
{
  return (JM::ClusterEvent*)m_event.GetObject();
}

inline void JM::ClusterHeader::setEvent(JM::ClusterEvent* value) 
{
  m_event = value;
}

inline void JM::ClusterHeader::setEventEntry(const std::string& eventName, Long64_t& value)
{
  if (eventName == "JM::ClusterEvent") { 
    m_event.setEntry(value);
  }
}

inline JM::EventObject* JM::ClusterHeader::event(const std::string& eventName)
{
  if (eventName == "JM::ClusterEvent") { 
    return m_event.GetObject();
  }
  return 0; 
}

inline bool JM::ClusterHeader::hasEvent()
{
  return m_event.HasObject();
}



#endif ///SNIPER_CLUSTEREVENT_CLUSTERHEADER_H

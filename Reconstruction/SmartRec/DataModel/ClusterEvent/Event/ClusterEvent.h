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

#ifndef SNIPER_CLUSTEREVENT_CLUSTEREVENT_H
#define SNIPER_CLUSTEREVENT_CLUSTEREVENT_H

// Include files
#include "Event/EventObject.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class ClusterEvent ClusterEvent.h
   *
   * Cluster event 
   *
   * @author DING Xuefeng
   * created Wed Oct 11 22:35:33 2017
   * 
   */

  class ClusterEvent: public EventObject
  {
  private:

    unsigned int m_length; // cluster length, used to subtract the dark noise. Unit: ns
  

  protected:


  public:

    /// Default Constructor
    ClusterEvent() : m_length(0) {}
  
    /// Default Destructor
    virtual ~ClusterEvent() {}
  
    /// Retrieve const  
    /// cluster length, used to subtract the dark noise. Unit: ns
    unsigned int length() const;
  
    /// Update  
    /// cluster length, used to subtract the dark noise. Unit: ns
    void setLength(unsigned int value);
  
    ClassDef(ClusterEvent,1);
  

  }; // class ClusterEvent

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline unsigned int JM::ClusterEvent::length() const 
{
  return m_length;
}

inline void JM::ClusterEvent::setLength(unsigned int value) 
{
  m_length = value;
}


#endif ///SNIPER_CLUSTEREVENT_CLUSTEREVENT_H

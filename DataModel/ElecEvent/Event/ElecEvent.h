
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

#ifndef SNIPER_ELECEVENT_ELECEVENT_H
#define SNIPER_ELECEVENT_ELECEVENT_H

// Include files
#include "Event/EventObject.h"
#include "Event/ElecFeeCrate.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class ElecEvent ElecEvent.h
   *
   *  
   *
   * @author fangxiao
   * created Thu Dec 28 13:43:44 2017
   * 
   */

  class ElecEvent: public EventObject
  {
  private:

    JM::ElecFeeCrate m_elecFeeCrate; // 
  

  protected:


  public:

    /// Default Constructor
    ElecEvent() : m_elecFeeCrate() {}
  
    /// Default Destructor
    virtual ~ElecEvent() {}
  
    /// Retrieve const  
    /// 
    const JM::ElecFeeCrate& elecFeeCrate() const;
  
    /// Update  
    /// 
    void setElecFeeCrate(const JM::ElecFeeCrate& value);
  
    ClassDef(ElecEvent,1);
  

  }; // class ElecEvent

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline const JM::ElecFeeCrate& JM::ElecEvent::elecFeeCrate() const 
{
  return m_elecFeeCrate;
}

inline void JM::ElecEvent::setElecFeeCrate(const JM::ElecFeeCrate& value) 
{
  m_elecFeeCrate = value;
}


#endif ///SNIPER_ELECEVENT_ELECEVENT_H


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

#ifndef SNIPER_ELECEVENT_SPMTELECEVENT_H
#define SNIPER_ELECEVENT_SPMTELECEVENT_H

// Include files
#include "Event/EventObject.h"
#include "Event/SpmtElecAbcBlock.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class SpmtElecEvent SpmtElecEvent.h
   *
   *  
   *
   * @author Pietro Chimenti
   * created Thu Dec 28 13:43:44 2017
   * 
   */

  class SpmtElecEvent: public EventObject
  {
  private:

    std::vector<JM::SpmtElecAbcBlock> m_spmtBlocks; // 
  

  protected:


  public:

    /// Default Constructor
    SpmtElecEvent() : m_spmtBlocks() {}
  
    /// Default Destructor
    virtual ~SpmtElecEvent() {}
  
    /// Retrieve const  
    /// 
    const std::vector<JM::SpmtElecAbcBlock>& spmtBlocks() const;
  
    /// Update  
    /// 
    void setSpmtBlocks(const std::vector<JM::SpmtElecAbcBlock>& value);
  
    ClassDef(SpmtElecEvent,1);
  

  }; // class SpmtElecEvent

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline const std::vector<JM::SpmtElecAbcBlock>& JM::SpmtElecEvent::spmtBlocks() const 
{
  return m_spmtBlocks;
}

inline void JM::SpmtElecEvent::setSpmtBlocks(const std::vector<JM::SpmtElecAbcBlock>& value) 
{
  m_spmtBlocks = value;
}


#endif ///SNIPER_ELECEVENT_SPMTELECEVENT_H

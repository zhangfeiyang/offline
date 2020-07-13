
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

#ifndef SNIPER_PHYEVENT_PHYEVENT_H
#define SNIPER_PHYEVENT_PHYEVENT_H

// Include files
#include "Event/EventObject.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class PhyEvent PhyEvent.h
   *
   * Physics Event Class 
   *
   * @author LI Teng
   * created Thu Dec 28 13:42:05 2017
   * 
   */

  class PhyEvent: public EventObject
  {
  private:

    Float_t m_energy;  // 
    Float_t m_rawEvis; // 
    Float_t m_enrec;   // 
    Float_t m_eprec;   // 
  

  protected:


  public:

    /// Default Constructor
    PhyEvent() : m_energy(0.0),
                 m_rawEvis(0.0),
                 m_enrec(0.0),
                 m_eprec(0.0) {}
  
    /// Default Destructor
    virtual ~PhyEvent() {}
  
    /// Retrieve const  
    /// 
    const Float_t& energy() const;
  
    /// Update  
    /// 
    void setEnergy(const Float_t& value);
  
    /// Retrieve const  
    /// 
    const Float_t& rawEvis() const;
  
    /// Update  
    /// 
    void setRawEvis(const Float_t& value);
  
    /// Retrieve const  
    /// 
    const Float_t& enrec() const;
  
    /// Update  
    /// 
    void setEnrec(const Float_t& value);
  
    /// Retrieve const  
    /// 
    const Float_t& eprec() const;
  
    /// Update  
    /// 
    void setEprec(const Float_t& value);
  
    ClassDef(PhyEvent,1);
  

  }; // class PhyEvent

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline const Float_t& JM::PhyEvent::energy() const 
{
  return m_energy;
}

inline void JM::PhyEvent::setEnergy(const Float_t& value) 
{
  m_energy = value;
}

inline const Float_t& JM::PhyEvent::rawEvis() const 
{
  return m_rawEvis;
}

inline void JM::PhyEvent::setRawEvis(const Float_t& value) 
{
  m_rawEvis = value;
}

inline const Float_t& JM::PhyEvent::enrec() const 
{
  return m_enrec;
}

inline void JM::PhyEvent::setEnrec(const Float_t& value) 
{
  m_enrec = value;
}

inline const Float_t& JM::PhyEvent::eprec() const 
{
  return m_eprec;
}

inline void JM::PhyEvent::setEprec(const Float_t& value) 
{
  m_eprec = value;
}


#endif ///SNIPER_PHYEVENT_PHYEVENT_H

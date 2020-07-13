
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

#ifndef SNIPER_ELECEVENT_SPMTELECABCBLOCK_H
#define SNIPER_ELECEVENT_SPMTELECABCBLOCK_H

// Include files
#include "TObject.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class SpmtElecAbcBlock SpmtElecAbcBlock.h
   *
   * SpmtElecSim information of Abc Card data block 
   *
   * @author Pietro Chimenti
   * created Thu Dec 28 13:43:44 2017
   * 
   */

  class SpmtElecAbcBlock: public TObject
  {
  private:

    UChar_t  m_type;          // type as from CatiROC
    Bool_t   m_gain;          // High or Low catiroc gain
    UShort_t m_board_num;     // board number
    UShort_t m_ch_num;        // per board channel number
    UInt_t   m_coarse_time;   // 4-byte coarse time info
    UShort_t m_event_counter; // Per channel Catiroc Event counter
    UShort_t m_fine_time;     // 2-byte fine time info
    UInt_t   m_charge;        // 2-byte charge info
  

  protected:


  public:

    /// Default Constructor
    SpmtElecAbcBlock() : m_type(),
                         m_gain(),
                         m_board_num(),
                         m_ch_num(),
                         m_coarse_time(),
                         m_event_counter(),
                         m_fine_time(),
                         m_charge() {}
  
    /// Default Destructor
    virtual ~SpmtElecAbcBlock() {}
  
    /// Retrieve const  
    /// type as from CatiROC
    const UChar_t& type() const;
  
    /// Update  
    /// type as from CatiROC
    void setType(const UChar_t& value);
  
    /// Retrieve const  
    /// High or Low catiroc gain
    const Bool_t& gain() const;
  
    /// Update  
    /// High or Low catiroc gain
    void setGain(const Bool_t& value);
  
    /// Retrieve const  
    /// board number
    const UShort_t& board_num() const;
  
    /// Update  
    /// board number
    void setBoard_num(const UShort_t& value);
  
    /// Retrieve const  
    /// per board channel number
    const UShort_t& ch_num() const;
  
    /// Update  
    /// per board channel number
    void setCh_num(const UShort_t& value);
  
    /// Retrieve const  
    /// 4-byte coarse time info
    const UInt_t& coarse_time() const;
  
    /// Update  
    /// 4-byte coarse time info
    void setCoarse_time(const UInt_t& value);
  
    /// Retrieve const  
    /// Per channel Catiroc Event counter
    const UShort_t& event_counter() const;
  
    /// Update  
    /// Per channel Catiroc Event counter
    void setEvent_counter(const UShort_t& value);
  
    /// Retrieve const  
    /// 2-byte fine time info
    const UShort_t& fine_time() const;
  
    /// Update  
    /// 2-byte fine time info
    void setFine_time(const UShort_t& value);
  
    /// Retrieve const  
    /// 2-byte charge info
    const UInt_t& charge() const;
  
    /// Update  
    /// 2-byte charge info
    void setCharge(const UInt_t& value);
  
    ClassDef(SpmtElecAbcBlock,1);
  

  }; // class SpmtElecAbcBlock

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline const UChar_t& JM::SpmtElecAbcBlock::type() const 
{
  return m_type;
}

inline void JM::SpmtElecAbcBlock::setType(const UChar_t& value) 
{
  m_type = value;
}

inline const Bool_t& JM::SpmtElecAbcBlock::gain() const 
{
  return m_gain;
}

inline void JM::SpmtElecAbcBlock::setGain(const Bool_t& value) 
{
  m_gain = value;
}

inline const UShort_t& JM::SpmtElecAbcBlock::board_num() const 
{
  return m_board_num;
}

inline void JM::SpmtElecAbcBlock::setBoard_num(const UShort_t& value) 
{
  m_board_num = value;
}

inline const UShort_t& JM::SpmtElecAbcBlock::ch_num() const 
{
  return m_ch_num;
}

inline void JM::SpmtElecAbcBlock::setCh_num(const UShort_t& value) 
{
  m_ch_num = value;
}

inline const UInt_t& JM::SpmtElecAbcBlock::coarse_time() const 
{
  return m_coarse_time;
}

inline void JM::SpmtElecAbcBlock::setCoarse_time(const UInt_t& value) 
{
  m_coarse_time = value;
}

inline const UShort_t& JM::SpmtElecAbcBlock::event_counter() const 
{
  return m_event_counter;
}

inline void JM::SpmtElecAbcBlock::setEvent_counter(const UShort_t& value) 
{
  m_event_counter = value;
}

inline const UShort_t& JM::SpmtElecAbcBlock::fine_time() const 
{
  return m_fine_time;
}

inline void JM::SpmtElecAbcBlock::setFine_time(const UShort_t& value) 
{
  m_fine_time = value;
}

inline const UInt_t& JM::SpmtElecAbcBlock::charge() const 
{
  return m_charge;
}

inline void JM::SpmtElecAbcBlock::setCharge(const UInt_t& value) 
{
  m_charge = value;
}


#endif ///SNIPER_ELECEVENT_SPMTELECABCBLOCK_H

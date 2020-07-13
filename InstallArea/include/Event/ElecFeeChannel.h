
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

#ifndef SNIPER_ELECEVENT_ELECFEECHANNEL_H
#define SNIPER_ELECEVENT_ELECFEECHANNEL_H

// Include files
#include "TObject.h"
#include <vector>

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class ElecFeeChannel ElecFeeChannel.h
   *
   * ElecSim informaiton of per PMT channel 
   *
   * @author fangxiao
   * created Thu Dec 28 13:43:44 2017
   * 
   */

  class ElecFeeChannel
  {
  private:

    std::vector<unsigned int> m_adc; // Amplitude of Waveform
    std::vector<unsigned int> m_tdc; // Time info of Waveform
  

  protected:


  public:

    /// Default Constructor
    ElecFeeChannel() : m_adc(),
                       m_tdc() {}
  
    /// Default Destructor
    virtual ~ElecFeeChannel() {}
  
    /// 
    std::vector<unsigned int>&  adc();
  
    /// 
    std::vector<unsigned int>&  tdc();
  
    /// 
    const std::vector<unsigned int>&  tdc() const;
  
    /// Retrieve const  
    /// Amplitude of Waveform
    const std::vector<unsigned int>& adc() const;
  
    /// Update  
    /// Amplitude of Waveform
    void setAdc(const std::vector<unsigned int>& value);
  
    /// Update  
    /// Time info of Waveform
    void setTdc(const std::vector<unsigned int>& value);
  
    ClassDef(ElecFeeChannel,1);
  

  }; // class ElecFeeChannel

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline const std::vector<unsigned int>& JM::ElecFeeChannel::adc() const 
{
  return m_adc;
}

inline void JM::ElecFeeChannel::setAdc(const std::vector<unsigned int>& value) 
{
  m_adc = value;
}

inline void JM::ElecFeeChannel::setTdc(const std::vector<unsigned int>& value) 
{
  m_tdc = value;
}

inline std::vector<unsigned int>&  JM::ElecFeeChannel::adc() 
{

                    return m_adc;
                
}


#endif ///SNIPER_ELECEVENT_ELECFEECHANNEL_H

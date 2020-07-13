
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

#ifndef SNIPER_CALIBEVENT_CALIBTTCHANNEL_H
#define SNIPER_CALIBEVENT_CALIBTTCHANNEL_H

// Include files
#include "TObject.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class CalibTTChannel CalibTTChannel.h
   *
   * Calibration TT header 
   *
   * @author A.Meregaglia
   * created Thu Dec 28 13:42:11 2017
   * 
   */

  class CalibTTChannel: public TObject
  {
  private:

    double       m_nPE;   // Number of PE
    double       m_nADC;  // Number of ADC
    unsigned int m_pmtId; // Id of the pmt
    double       m_x;     // x of pmt
    double       m_y;     // y of pmt
    double       m_z;     // z of pmt
  

  protected:


  public:

  /// constructor with channelid
  CalibTTChannel(unsigned int channelid);
  
    /// Default Constructor
    CalibTTChannel() : m_nPE(0.0),
                       m_nADC(0.0),
                       m_pmtId(0),
                       m_x(0),
                       m_y(0),
                       m_z(0) {}
  
    /// Default Destructor
    virtual ~CalibTTChannel() {}
  
    /// Retrieve const  
    /// Number of PE
    double nPE() const;
  
    /// Update  
    /// Number of PE
    void setNPE(double value);
  
    /// Retrieve const  
    /// Number of ADC
    double nADC() const;
  
    /// Update  
    /// Number of ADC
    void setNADC(double value);
  
    /// Retrieve const  
    /// Id of the pmt
    unsigned int pmtId() const;
  
    /// Update  
    /// Id of the pmt
    void setPmtId(unsigned int value);
  
    /// Retrieve const  
    /// x of pmt
    double x() const;
  
    /// Update  
    /// x of pmt
    void setX(double value);
  
    /// Retrieve const  
    /// y of pmt
    double y() const;
  
    /// Update  
    /// y of pmt
    void setY(double value);
  
    /// Retrieve const  
    /// z of pmt
    double z() const;
  
    /// Update  
    /// z of pmt
    void setZ(double value);
  
    ClassDef(CalibTTChannel,1);
  

  }; // class CalibTTChannel

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline JM::CalibTTChannel::CalibTTChannel(unsigned int channelid) 
{

                m_pmtId = channelid;
              
}

inline double JM::CalibTTChannel::nPE() const 
{
  return m_nPE;
}

inline void JM::CalibTTChannel::setNPE(double value) 
{
  m_nPE = value;
}

inline double JM::CalibTTChannel::nADC() const 
{
  return m_nADC;
}

inline void JM::CalibTTChannel::setNADC(double value) 
{
  m_nADC = value;
}

inline unsigned int JM::CalibTTChannel::pmtId() const 
{
  return m_pmtId;
}

inline void JM::CalibTTChannel::setPmtId(unsigned int value) 
{
  m_pmtId = value;
}

inline double JM::CalibTTChannel::x() const 
{
  return m_x;
}

inline void JM::CalibTTChannel::setX(double value) 
{
  m_x = value;
}

inline double JM::CalibTTChannel::y() const 
{
  return m_y;
}

inline void JM::CalibTTChannel::setY(double value) 
{
  m_y = value;
}

inline double JM::CalibTTChannel::z() const 
{
  return m_z;
}

inline void JM::CalibTTChannel::setZ(double value) 
{
  m_z = value;
}


#endif ///SNIPER_CALIBEVENT_CALIBTTCHANNEL_H

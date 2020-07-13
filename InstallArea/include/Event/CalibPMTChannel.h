
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

#ifndef SNIPER_CALIBEVENT_CALIBPMTCHANNEL_H
#define SNIPER_CALIBEVENT_CALIBPMTCHANNEL_H

// Include files
#include "TObject.h"
#include <vector>

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class CalibPMTChannel CalibPMTChannel.h
   *
   * Calibration PMT header 
   *
   * @author Kun ZHANG
   * created Thu Dec 28 13:42:11 2017
   * 
   */

  class CalibPMTChannel: public TObject
  {
  private:

    double              m_nPE;          // Number of PE
    unsigned int        m_pmtId;        // Id of the pmt
    double              m_firstHitTime; // Time of the first hit
    std::vector<double> m_charge;       // Vector of charges (PE)
    std::vector<double> m_time;         // Vector of times (ns)
    double              m_riseTime;     // Time of rise 10% -> 90%
  

  protected:


  public:

  /// constructor with pmtid
  CalibPMTChannel(unsigned int pmtid);
  
    /// Default Constructor
    CalibPMTChannel() : m_nPE(0.0),
                        m_pmtId(0),
                        m_firstHitTime(0.0),
                        m_charge(),
                        m_time(),
                        m_riseTime(0.0) {}
  
    /// Default Destructor
    virtual ~CalibPMTChannel() {}
  
    /// Return size of time vector(should be the same as charge vector)
    unsigned int size() const;
  
    /// Return charge with a given index
    double charge(unsigned int index) const;
  
    /// Return time with a given index
    double time(unsigned int index) const;
  
    /// Return the max charge index for this channel
    int maxChargeIndex() const;
  
    /// Return max charge for this channel
    double maxCharge() const;
  
    /// Return sum of charge for this channel
    double sumCharge() const;
  
    /// Return the index of earliest time in a given range; returns -1 if no hits found
    int earliestTimeIndex(double earlytime=-1000000,
                          double latetime=1000000) const;
  
    /// Return earliest time in a given range; returns 0 if no hits are found
    double earliestTime(double earlytime=-1000000,
                        double latetime=1000000) const;
  
    /// Return the earliest ADC value in a given range; returns 0 if no hits are found
    double earliestCharge(double earlytime=-1000000,
                          double latetime=1000000) const;
  
    /// Return the charge in a certain time range
    double properCharge(double earlytime,
                        double latetime) const;
  
    /// Retrieve const  
    /// Number of PE
    double nPE() const;
  
    /// Update  
    /// Number of PE
    void setNPE(double value);
  
    /// Retrieve const  
    /// Id of the pmt
    unsigned int pmtId() const;
  
    /// Update  
    /// Id of the pmt
    void setPmtId(unsigned int value);
  
    /// Retrieve const  
    /// Time of the first hit
    double firstHitTime() const;
  
    /// Update  
    /// Time of the first hit
    void setFirstHitTime(double value);
  
    /// Retrieve const  
    /// Vector of charges (PE)
    const std::vector<double>& charge() const;
  
    /// Update  
    /// Vector of charges (PE)
    void setCharge(const std::vector<double>& value);
  
    /// Retrieve const  
    /// Vector of times (ns)
    const std::vector<double>& time() const;
  
    /// Update  
    /// Vector of times (ns)
    void setTime(const std::vector<double>& value);
  
    /// Retrieve const  
    /// Time of rise 10% -> 90%
    double riseTime() const;
  
    /// Update  
    /// Time of rise 10% -> 90%
    void setRiseTime(double value);
  
    ClassDef(CalibPMTChannel,1);
  

  }; // class CalibPMTChannel

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline JM::CalibPMTChannel::CalibPMTChannel(unsigned int pmtid) 
{

                    m_pmtId = pmtid;
                
}

inline double JM::CalibPMTChannel::nPE() const 
{
  return m_nPE;
}

inline void JM::CalibPMTChannel::setNPE(double value) 
{
  m_nPE = value;
}

inline unsigned int JM::CalibPMTChannel::pmtId() const 
{
  return m_pmtId;
}

inline void JM::CalibPMTChannel::setPmtId(unsigned int value) 
{
  m_pmtId = value;
}

inline double JM::CalibPMTChannel::firstHitTime() const 
{
  return m_firstHitTime;
}

inline void JM::CalibPMTChannel::setFirstHitTime(double value) 
{
  m_firstHitTime = value;
}

inline const std::vector<double>& JM::CalibPMTChannel::charge() const 
{
  return m_charge;
}

inline void JM::CalibPMTChannel::setCharge(const std::vector<double>& value) 
{
  m_charge = value;
}

inline const std::vector<double>& JM::CalibPMTChannel::time() const 
{
  return m_time;
}

inline void JM::CalibPMTChannel::setTime(const std::vector<double>& value) 
{
  m_time = value;
}

inline double JM::CalibPMTChannel::riseTime() const 
{
  return m_riseTime;
}

inline void JM::CalibPMTChannel::setRiseTime(double value) 
{
  m_riseTime = value;
}

inline unsigned int JM::CalibPMTChannel::size() const 
{

                    return m_time.size();
                
}

inline double JM::CalibPMTChannel::charge(unsigned int index) const 
{

                    return index >= m_charge.size() ? 0 : m_charge[index];
                
}

inline double JM::CalibPMTChannel::time(unsigned int index) const 
{

                    return index >= m_time.size() ? 0 : m_time[index];
                
}

inline int JM::CalibPMTChannel::maxChargeIndex() const 
{

                    if( m_charge.empty() ) return 0;
                    double maxCharge = 0;
                    int maxChargeIndex = 0;
                    for(unsigned i=0; i<m_charge.size(); i++) {
                    if( m_charge[i] > maxCharge ) {
                    maxCharge = m_charge[i];
                    maxChargeIndex = i;
                    }
                    }
                    return maxChargeIndex;
                
}

inline double JM::CalibPMTChannel::maxCharge() const 
{

                    if( m_charge.empty() ) return 0;
                    return m_charge[maxChargeIndex()];
                
}

inline double JM::CalibPMTChannel::sumCharge() const 
{

                    if( m_charge.empty() ) return 0;
                    double sumCharge = 0;
                    for(unsigned i=0; i<m_charge.size(); i++) {
                    sumCharge += m_charge[i];
                    }
                    return sumCharge;
                
}

inline int JM::CalibPMTChannel::earliestTimeIndex(double earlytime,
                                                  double latetime) const 
{
    

                    if( m_time.empty() ) return -1;
                    double earliestTime = 1e9;
                    int earliestTimeIndex = -1;
                    for(unsigned int i=0; i<m_time.size(); i++) {
                    if( m_time[i]<earliestTime &&  m_time[i]<latetime && m_time[i]>earlytime ) {
                    earliestTime = m_time[i];
                    earliestTimeIndex = i;
                    }
                    }

                    return earliestTimeIndex;

                
}

inline double JM::CalibPMTChannel::earliestTime(double earlytime,
                                                double latetime) const 
{


                    if( m_time.empty() ) return 0;
                    int index=earliestTimeIndex(earlytime,latetime);
                    if(index < 0) return 0;
                    else return m_time[index];

                
}

inline double JM::CalibPMTChannel::earliestCharge(double earlytime,
                                                  double latetime) const 
{


                    if( m_charge.empty() ) return 0;
                    int index=earliestTimeIndex(earlytime,latetime);
                    if(index < 0) return 0;
                    return m_charge[index];

                
}

inline double JM::CalibPMTChannel::properCharge(double earlytime,
                                                double latetime) const 
{

                    double pcharge=0;
                    for(unsigned int i=0;i < m_time.size();i++){
                    if(m_time[i] > earlytime && m_time[i] < latetime)
                    pcharge+=m_charge[i];
                    }
                    return pcharge;
                
}


#endif ///SNIPER_CALIBEVENT_CALIBPMTCHANNEL_H


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

#ifndef SNIPER_ELECEVENT_ELECFEECRATE_H
#define SNIPER_ELECEVENT_ELECFEECRATE_H

// Include files
#include "TObject.h"
#include "Event/ElecFeeChannel.h"
#include "Context/TimeStamp.h"
#include <vector>
#include <map>

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class ElecFeeCrate ElecFeeCrate.h
   *
   *  
   *
   * @author Fang Xiao
   * created Thu Dec 28 13:43:44 2017
   * 
   */

  class ElecFeeCrate: public TObject
  {
  private:

    std::map<int,JM::ElecFeeChannel> m_channelData;  // It's a map between PmtId and ElecFeeChannel
    double                           m_TimeStamp_v1; // the time stamp of this event
    TimeStamp                        m_EvtTimeStamp; // the time stamp of this event
    TimeStamp                        m_TriggerTime;  // simple trigger time for ElecSimV3
    std::vector<int>                 m_triggerTime;  // simple trigger time 
  

  protected:


  public:

    /// Default Constructor
    ElecFeeCrate() : m_channelData(),
                     m_TimeStamp_v1(0.0),
                     m_EvtTimeStamp(),
                     m_TriggerTime(),
                     m_triggerTime() {}
  
    /// Default Destructor
    virtual ~ElecFeeCrate() {}
  
    /// 
    std::map<int,JM::ElecFeeChannel>&  channelData();
  
    /// 
    std::vector<int>&  triggerTime();
  
    /// Retrieve const  
    /// It's a map between PmtId and ElecFeeChannel
    const std::map<int,JM::ElecFeeChannel>& channelData() const;
  
    /// Update  
    /// It's a map between PmtId and ElecFeeChannel
    void setChannelData(const std::map<int,JM::ElecFeeChannel>& value);
  
    /// Retrieve const  
    /// the time stamp of this event
    double TimeStamp_v1() const;
  
    /// Update  
    /// the time stamp of this event
    void setTimeStamp_v1(double value);
  
    /// Retrieve const  
    /// the time stamp of this event
    const TimeStamp& EvtTimeStamp() const;
  
    /// Update  
    /// the time stamp of this event
    void setEvtTimeStamp(const TimeStamp& value);
  
    /// Retrieve const  
    /// simple trigger time for ElecSimV3
    const TimeStamp& TriggerTime() const;
  
    /// Update  
    /// simple trigger time for ElecSimV3
    void setTriggerTime(const TimeStamp& value);
  
    /// Retrieve const  
    /// simple trigger time 
    const std::vector<int>& triggerTime() const;
  
    /// Update  
    /// simple trigger time 
    void setTriggerTime(const std::vector<int>& value);
  
    ClassDef(ElecFeeCrate,1);
  

  }; // class ElecFeeCrate

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline const std::map<int,JM::ElecFeeChannel>& JM::ElecFeeCrate::channelData() const 
{
  return m_channelData;
}

inline void JM::ElecFeeCrate::setChannelData(const std::map<int,JM::ElecFeeChannel>& value) 
{
  m_channelData = value;
}

inline double JM::ElecFeeCrate::TimeStamp_v1() const 
{
  return m_TimeStamp_v1;
}

inline void JM::ElecFeeCrate::setTimeStamp_v1(double value) 
{
  m_TimeStamp_v1 = value;
}

inline const TimeStamp& JM::ElecFeeCrate::EvtTimeStamp() const 
{
  return m_EvtTimeStamp;
}

inline void JM::ElecFeeCrate::setEvtTimeStamp(const TimeStamp& value) 
{
  m_EvtTimeStamp = value;
}

inline const TimeStamp& JM::ElecFeeCrate::TriggerTime() const 
{
  return m_TriggerTime;
}

inline void JM::ElecFeeCrate::setTriggerTime(const TimeStamp& value) 
{
  m_TriggerTime = value;
}

inline const std::vector<int>& JM::ElecFeeCrate::triggerTime() const 
{
  return m_triggerTime;
}

inline void JM::ElecFeeCrate::setTriggerTime(const std::vector<int>& value) 
{
  m_triggerTime = value;
}

inline std::map<int,JM::ElecFeeChannel>&  JM::ElecFeeCrate::channelData() 
{

                    return m_channelData;
                
}

inline std::vector<int>&  JM::ElecFeeCrate::triggerTime() 
{
 
                    return m_triggerTime; 
                
}


#endif ///SNIPER_ELECEVENT_ELECFEECRATE_H

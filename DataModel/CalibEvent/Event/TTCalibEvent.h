
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

#ifndef SNIPER_TTCALIBEVENT_TTCALIBEVENT_H
#define SNIPER_TTCALIBEVENT_TTCALIBEVENT_H

// Include files
#include "Event/EventObject.h"
#include "CalibTTChannel.h"
#include <list>

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class TTCalibEvent TTCalibEvent.h
   *
   * Calibration event class 
   *
   * @author A.Meregaglia
   * created Thu Dec 28 13:42:11 2017
   * 
   */

  class TTCalibEvent: public EventObject
  {
  private:

    std::list<JM::CalibTTChannel*> m_calibTTCol; // Collection of CalibTTChannel in a evt
  

  protected:


  public:

    /// Default Constructor
    TTCalibEvent() : m_calibTTCol() {}
  
  /// destructor for SimTTHeader.
  ~TTCalibEvent();
  
    /// Get a TT channel via chid
    const JM::CalibTTChannel* getCalibTTChannel(unsigned int chid) const;
  
    /// Add a Calibrate TT channel to this event
    CalibTTChannel* addCalibTTChannel(unsigned int chid);
  
    /// Retrieve const  
    /// Collection of CalibTTChannel in a evt
    const std::list<JM::CalibTTChannel*>& calibTTCol() const;
  
    /// Update  
    /// Collection of CalibTTChannel in a evt
    void setCalibTTCol(const std::list<JM::CalibTTChannel*>& value);
  
    ClassDef(TTCalibEvent,1);
  

  }; // class TTCalibEvent

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline JM::TTCalibEvent::~TTCalibEvent() 
{

                    for (std::list<JM::CalibTTChannel*>::iterator it = m_calibTTCol.begin();
                    it != m_calibTTCol.end(); ++it) {
                        if (*it) {
                         delete (*it);
                        }
                    }
                    m_calibTTCol.clear();
                
}

inline const std::list<JM::CalibTTChannel*>& JM::TTCalibEvent::calibTTCol() const 
{
  return m_calibTTCol;
}

inline void JM::TTCalibEvent::setCalibTTCol(const std::list<JM::CalibTTChannel*>& value) 
{
  m_calibTTCol = value;
}

inline const JM::CalibTTChannel* JM::TTCalibEvent::getCalibTTChannel(unsigned int chid) const 
{

                    std::list<JM::CalibTTChannel*>::const_iterator cpIter;
                    cpIter = m_calibTTCol.begin();
                    while(cpIter!=m_calibTTCol.end())
                    {
                        if((*cpIter)->pmtId()==chid) break;
                        cpIter++;
                    }
                    if(cpIter==m_calibTTCol.end()) return 0;
                    return *cpIter;

                
}

inline JM::CalibTTChannel* JM::TTCalibEvent::addCalibTTChannel(unsigned int chid) 
{

                    JM::CalibTTChannel* cp = 0;
                    if(!this->getCalibTTChannel(chid)){
                        cp = new JM::CalibTTChannel(chid);
                        m_calibTTCol.push_back(cp);
                    }
                    return cp;
                
}


#endif ///SNIPER_TTCALIBEVENT_TTCALIBEVENT_H

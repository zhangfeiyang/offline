
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

#ifndef SNIPER_CALIBEVENT_CALIBEVENT_H
#define SNIPER_CALIBEVENT_CALIBEVENT_H

// Include files
#include "Event/EventObject.h"
#include "CalibPMTChannel.h"
#include <list>

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class CalibEvent CalibEvent.h
   *
   * Calibration event class 
   *
   * @author ZHANG Kun
   * created Thu Dec 28 13:42:11 2017
   * 
   */

  class CalibEvent: public EventObject
  {
  private:

    std::list<JM::CalibPMTChannel*> m_calibPMTCol; // Collection of CalibPMTChannel in a evt
  

  protected:


  public:

    /// Default Constructor
    CalibEvent() : m_calibPMTCol() {}
  
  /// destructor for SimPMTHeader.
  ~CalibEvent();
  
    /// Get a pmt channel via pmtid
    const JM::CalibPMTChannel* getCalibPmtChannel(unsigned int pmtid) const;
  
    /// Add a Calibrate pmt channel to this event
    CalibPMTChannel* addCalibPmtChannel(unsigned int pmtid);
  
    /// Retrieve const  
    /// Collection of CalibPMTChannel in a evt
    const std::list<JM::CalibPMTChannel*>& calibPMTCol() const;
  
    /// Update  
    /// Collection of CalibPMTChannel in a evt
    void setCalibPMTCol(const std::list<JM::CalibPMTChannel*>& value);
  
    ClassDef(CalibEvent,1);
  

  }; // class CalibEvent

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline JM::CalibEvent::~CalibEvent() 
{

                    for (std::list<JM::CalibPMTChannel*>::iterator it = m_calibPMTCol.begin();
                    it != m_calibPMTCol.end(); ++it) {
                        if (*it) {
                         delete (*it);
                        }
                    }
                    m_calibPMTCol.clear();
                
}

inline const std::list<JM::CalibPMTChannel*>& JM::CalibEvent::calibPMTCol() const 
{
  return m_calibPMTCol;
}

inline void JM::CalibEvent::setCalibPMTCol(const std::list<JM::CalibPMTChannel*>& value) 
{
  m_calibPMTCol = value;
}

inline const JM::CalibPMTChannel* JM::CalibEvent::getCalibPmtChannel(unsigned int pmtid) const 
{

                    std::list<JM::CalibPMTChannel*>::const_iterator cpIter;
                    cpIter = m_calibPMTCol.begin();
                    while(cpIter!=m_calibPMTCol.end())
                    {
                        if((*cpIter)->pmtId()==pmtid) break;
                        cpIter++;
                    }
                    if(cpIter==m_calibPMTCol.end()) return 0;
                    return *cpIter;

                
}

inline JM::CalibPMTChannel* JM::CalibEvent::addCalibPmtChannel(unsigned int pmtid) 
{

                    JM::CalibPMTChannel* cp = 0;
                    if(!this->getCalibPmtChannel(pmtid)){
                        cp = new JM::CalibPMTChannel(pmtid);
                        m_calibPMTCol.push_back(cp);
                    }
                    return cp;
                
}


#endif ///SNIPER_CALIBEVENT_CALIBEVENT_H

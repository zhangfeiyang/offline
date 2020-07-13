
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

#ifndef SNIPER_RECEVENT_CDTRACKRECEVENT_H
#define SNIPER_RECEVENT_CDTRACKRECEVENT_H

// Include files
#include "Event/EventObject.h"
#include "Event/RecTrack.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class CDTrackRecEvent CDTrackRecEvent.h
   *
   * Reconstruction Event Class 
   *
   * @author ZHANG Kun
   * created Thu Dec 28 13:42:24 2017
   * 
   */

  class CDTrackRecEvent: public EventObject
  {
  private:

    std::vector<JM::RecTrack*> m_cdTracks; // The Cd tracks in this event
  

  protected:


  public:

    /// Default Constructor
    CDTrackRecEvent() : m_cdTracks() {}
  
  /// destructor
  ~CDTrackRecEvent();
  
    /// Get a Cd track via index
    const JM::RecTrack * getTrack(int index) const;
  
    /// Add a Cd track to this event
    void addTrack(JM::RecTrack* track);
  
    /// Retrieve const  
    /// The Cd tracks in this event
    const std::vector<JM::RecTrack*>& cdTracks() const;
  
    ClassDef(CDTrackRecEvent,1);
  

  }; // class CDTrackRecEvent

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline JM::CDTrackRecEvent::~CDTrackRecEvent() 
{

                        std::vector<RecTrack*>::const_iterator it = m_cdTracks.begin();
                        std::vector<RecTrack*>::const_iterator end = m_cdTracks.end();
                        while(it!=end){
                            if(*it) delete  (*it);
                            it++;
                        }
                        m_cdTracks.clear();
                
}

inline const std::vector<JM::RecTrack*>& JM::CDTrackRecEvent::cdTracks() const 
{
  return m_cdTracks;
}

inline const JM::RecTrack * JM::CDTrackRecEvent::getTrack(int index) const 
{

                    return m_cdTracks.at(index);
                
}

inline void JM::CDTrackRecEvent::addTrack(JM::RecTrack* track) 
{

                    m_cdTracks.push_back(track);
                
}


#endif ///SNIPER_RECEVENT_CDTRACKRECEVENT_H

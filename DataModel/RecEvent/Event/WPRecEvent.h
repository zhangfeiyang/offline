
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

#ifndef SNIPER_RECEVENT_WPRECEVENT_H
#define SNIPER_RECEVENT_WPRECEVENT_H

// Include files
#include "Event/EventObject.h"
#include "Event/RecTrack.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class WPRecEvent WPRecEvent.h
   *
   * Reconstructed WP track event 
   *
   * @author 
   * created Thu Dec 28 13:42:24 2017
   * 
   */

  class WPRecEvent: public EventObject
  {
  private:

    std::vector<JM::RecTrack*> m_wpTracks; // The WP tracks in this event
  

  protected:


  public:

    /// Default Constructor
    WPRecEvent() : m_wpTracks() {}
  
  /// destructor
  ~WPRecEvent();
  
    /// Get a WP track via index
    const JM::RecTrack * getTrack(int index) const;
  
    /// Add a WP track to this event
    void addTrack(JM::RecTrack* track);
  
    /// Retrieve const  
    /// The WP tracks in this event
    const std::vector<JM::RecTrack*>& wpTracks() const;
  
    ClassDef(WPRecEvent,1);
  

  }; // class WPRecEvent

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline JM::WPRecEvent::~WPRecEvent() 
{

                        std::vector<RecTrack*>::const_iterator it = m_wpTracks.begin();
                        std::vector<RecTrack*>::const_iterator end = m_wpTracks.end();
                        while(it!=end){
                            if(*it) delete  (*it);
                            it++;
                        }
                        m_wpTracks.clear();
                
}

inline const std::vector<JM::RecTrack*>& JM::WPRecEvent::wpTracks() const 
{
  return m_wpTracks;
}

inline const JM::RecTrack * JM::WPRecEvent::getTrack(int index) const 
{

                    return m_wpTracks.at(index);
                
}

inline void JM::WPRecEvent::addTrack(JM::RecTrack* track) 
{

                    m_wpTracks.push_back(track);
                
}


#endif ///SNIPER_RECEVENT_WPRECEVENT_H

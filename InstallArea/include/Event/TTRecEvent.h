
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

#ifndef SNIPER_RECEVENT_TTRECEVENT_H
#define SNIPER_RECEVENT_TTRECEVENT_H

// Include files
#include "Event/EventObject.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class TTRecEvent TTRecEvent.h
   *
   * Reconstructed TT track event 
   *
   * @author 
   * created Thu Dec 28 13:42:24 2017
   * 
   */

  class TTRecEvent: public EventObject
  {
  private:

    int                 m_NTotPoints; // total points
    std::vector<double> m_PointX;     // vector of point x
    std::vector<double> m_PointY;     // vector of point y
    std::vector<double> m_PointZ;     // vector of point z
    int                 m_NTracks;    // total points
    std::vector<int>    m_NPoints;    // N points for each track
    std::vector<double> m_Coeff0;     // vector of Coeff0
    std::vector<double> m_Coeff1;     // vector of Coeff1
    std::vector<double> m_Coeff2;     // vector of Coeff2
    std::vector<double> m_Coeff3;     // vector of Coeff3
    std::vector<double> m_Coeff4;     // vector of Coeff4
    std::vector<double> m_Coeff5;     // vector of Coeff5
    std::vector<double> m_Chi2;       // vector of Chi2
  

  protected:


  public:

    /// Default Constructor
    TTRecEvent() : m_NTotPoints(0),
                   m_PointX(),
                   m_PointY(),
                   m_PointZ(),
                   m_NTracks(0),
                   m_NPoints(0),
                   m_Coeff0(),
                   m_Coeff1(),
                   m_Coeff2(),
                   m_Coeff3(),
                   m_Coeff4(),
                   m_Coeff5(),
                   m_Chi2() {}
  
    /// Default Destructor
    virtual ~TTRecEvent() {}
  
    /// Add a point to this event
    void addPoint(double x,
                  double y,
                  double z);
  
    /// Add a reconstructed track to this event
    void addTrack(int npoints,
                  double coeff[6],
                  double chi2);
  
    /// Retrieve const  
    /// total points
    int nTotPoints() const;
  
    /// Retrieve const  
    /// vector of point x
    const std::vector<double>& PointX() const;
  
    /// Retrieve const  
    /// vector of point y
    const std::vector<double>& PointY() const;
  
    /// Retrieve const  
    /// vector of point z
    const std::vector<double>& PointZ() const;
  
    /// Retrieve const  
    /// total points
    int nTracks() const;
  
    /// Retrieve const  
    /// N points for each track
    const std::vector<int>& nPoints() const;
  
    /// Retrieve const  
    /// vector of Coeff0
    const std::vector<double>& Coeff0() const;
  
    /// Retrieve const  
    /// vector of Coeff1
    const std::vector<double>& Coeff1() const;
  
    /// Retrieve const  
    /// vector of Coeff2
    const std::vector<double>& Coeff2() const;
  
    /// Retrieve const  
    /// vector of Coeff3
    const std::vector<double>& Coeff3() const;
  
    /// Retrieve const  
    /// vector of Coeff4
    const std::vector<double>& Coeff4() const;
  
    /// Retrieve const  
    /// vector of Coeff5
    const std::vector<double>& Coeff5() const;
  
    /// Retrieve const  
    /// vector of Chi2
    const std::vector<double>& Chi2() const;
  
    ClassDef(TTRecEvent,1);
  

  }; // class TTRecEvent

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline int JM::TTRecEvent::nTotPoints() const 
{
  return m_NTotPoints;
}

inline const std::vector<double>& JM::TTRecEvent::PointX() const 
{
  return m_PointX;
}

inline const std::vector<double>& JM::TTRecEvent::PointY() const 
{
  return m_PointY;
}

inline const std::vector<double>& JM::TTRecEvent::PointZ() const 
{
  return m_PointZ;
}

inline int JM::TTRecEvent::nTracks() const 
{
  return m_NTracks;
}

inline const std::vector<int>& JM::TTRecEvent::nPoints() const 
{
  return m_NPoints;
}

inline const std::vector<double>& JM::TTRecEvent::Coeff0() const 
{
  return m_Coeff0;
}

inline const std::vector<double>& JM::TTRecEvent::Coeff1() const 
{
  return m_Coeff1;
}

inline const std::vector<double>& JM::TTRecEvent::Coeff2() const 
{
  return m_Coeff2;
}

inline const std::vector<double>& JM::TTRecEvent::Coeff3() const 
{
  return m_Coeff3;
}

inline const std::vector<double>& JM::TTRecEvent::Coeff4() const 
{
  return m_Coeff4;
}

inline const std::vector<double>& JM::TTRecEvent::Coeff5() const 
{
  return m_Coeff5;
}

inline const std::vector<double>& JM::TTRecEvent::Chi2() const 
{
  return m_Chi2;
}

inline void JM::TTRecEvent::addPoint(double x,
                                     double y,
                                     double z) 
{

    m_PointX.push_back(x);
    m_PointY.push_back(y);
    m_PointZ.push_back(z);

    ++m_NTotPoints;
                
}

inline void JM::TTRecEvent::addTrack(int npoints,
                                     double coeff[6],
                                     double chi2) 
{

    m_NPoints.push_back(npoints);
    m_Coeff0.push_back(coeff[0]);
    m_Coeff1.push_back(coeff[1]);
    m_Coeff2.push_back(coeff[2]);
    m_Coeff3.push_back(coeff[3]);
    m_Coeff4.push_back(coeff[4]);
    m_Coeff5.push_back(coeff[5]);
    m_Chi2.push_back(chi2);

    ++m_NTracks;
                
}


#endif ///SNIPER_RECEVENT_TTRECEVENT_H

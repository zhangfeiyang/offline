
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

#ifndef SNIPER_RECEVENT_CDRECEVENT_H
#define SNIPER_RECEVENT_CDRECEVENT_H

// Include files
#include "Event/EventObject.h"

// Forward declarations

namespace JM 
{

  // Forward declarations

  /** @class CDRecEvent CDRecEvent.h
   *
   * Reconstructed CD vertex event 
   *
   * @author 
   * created Thu Dec 28 13:42:24 2017
   * 
   */

  class CDRecEvent: public EventObject
  {
  private:

    unsigned int          m_nVertexes;       // number of reconstructed vertexes
    std::vector<Double_t> m_PESum;           // Total number of PE
    std::vector<Double_t> m_energy;          // Best estimation of deposit energy. Unit:MeV
    std::vector<Double_t> m_eprec;           // Reconstructed positron energy. Unit:MeV
    std::vector<Double_t> m_x;               // x position. Unit:mm
    std::vector<Double_t> m_y;               // y position. Unit:mm
    std::vector<Double_t> m_z;               // z position. Unit:mm
    std::vector<Double_t> m_px;              // x direction
    std::vector<Double_t> m_py;              // y direction
    std::vector<Double_t> m_pz;              // z direction
    std::vector<Double_t> m_chisq;           // goodness of the fit
    std::vector<Double_t> m_energyQuality;   // quality of energy recontruction
    std::vector<Double_t> m_positionQuality; // quality of position recontruction
  

  protected:


  public:

    /// Default Constructor
    CDRecEvent() : m_nVertexes(1),
                   m_PESum(),
                   m_energy(),
                   m_eprec(),
                   m_x(),
                   m_y(),
                   m_z(),
                   m_px(),
                   m_py(),
                   m_pz(),
                   m_chisq(),
                   m_energyQuality(),
                   m_positionQuality() {}
  
    /// Default Destructor
    virtual ~CDRecEvent() {}
  
    /// Retrieve const  
    /// number of reconstructed vertexes
    unsigned int nVertexes() const;
  
    /// Update  
    /// number of reconstructed vertexes
    void setNVertexes(unsigned int value);
  
    /// Retrieve const  
    /// Total number of PE
    const std::vector<Double_t>& peSumVec() const;
  
    /// Update  
    /// Total number of PE
    void setPESum(const std::vector<Double_t>& value);
  
    /// Only set one value 
    /// Total number of PE
    void setPESum(const Double_t& value);
  
    /// Only get one value 
    /// Total number of PE
    Double_t peSum();
  
    /// Retrieve const  
    /// Best estimation of deposit energy. Unit:MeV
    const std::vector<Double_t>& energyVec() const;
  
    /// Update  
    /// Best estimation of deposit energy. Unit:MeV
    void setEnergy(const std::vector<Double_t>& value);
  
    /// Only set one value 
    /// Best estimation of deposit energy. Unit:MeV
    void setEnergy(const Double_t& value);
  
    /// Only get one value 
    /// Best estimation of deposit energy. Unit:MeV
    Double_t energy();
  
    /// Retrieve const  
    /// Reconstructed positron energy. Unit:MeV
    const std::vector<Double_t>& eprecVec() const;
  
    /// Update  
    /// Reconstructed positron energy. Unit:MeV
    void setEprec(const std::vector<Double_t>& value);
  
    /// Only set one value 
    /// Reconstructed positron energy. Unit:MeV
    void setEprec(const Double_t& value);
  
    /// Only get one value 
    /// Reconstructed positron energy. Unit:MeV
    Double_t eprec();
  
    /// Retrieve const  
    /// x position. Unit:mm
    const std::vector<Double_t>& xVec() const;
  
    /// Update  
    /// x position. Unit:mm
    void setX(const std::vector<Double_t>& value);
  
    /// Only set one value 
    /// x position. Unit:mm
    void setX(const Double_t& value);
  
    /// Only get one value 
    /// x position. Unit:mm
    Double_t x();
  
    /// Retrieve const  
    /// y position. Unit:mm
    const std::vector<Double_t>& yVec() const;
  
    /// Update  
    /// y position. Unit:mm
    void setY(const std::vector<Double_t>& value);
  
    /// Only set one value 
    /// y position. Unit:mm
    void setY(const Double_t& value);
  
    /// Only get one value 
    /// y position. Unit:mm
    Double_t y();
  
    /// Retrieve const  
    /// z position. Unit:mm
    const std::vector<Double_t>& zVec() const;
  
    /// Update  
    /// z position. Unit:mm
    void setZ(const std::vector<Double_t>& value);
  
    /// Only set one value 
    /// z position. Unit:mm
    void setZ(const Double_t& value);
  
    /// Only get one value 
    /// z position. Unit:mm
    Double_t z();
  
    /// Retrieve const  
    /// x direction
    const std::vector<Double_t>& pxVec() const;
  
    /// Update  
    /// x direction
    void setPx(const std::vector<Double_t>& value);
  
    /// Only set one value 
    /// x direction
    void setPx(const Double_t& value);
  
    /// Only get one value 
    /// x direction
    Double_t px();
  
    /// Retrieve const  
    /// y direction
    const std::vector<Double_t>& pyVec() const;
  
    /// Update  
    /// y direction
    void setPy(const std::vector<Double_t>& value);
  
    /// Only set one value 
    /// y direction
    void setPy(const Double_t& value);
  
    /// Only get one value 
    /// y direction
    Double_t py();
  
    /// Retrieve const  
    /// z direction
    const std::vector<Double_t>& pzVec() const;
  
    /// Update  
    /// z direction
    void setPz(const std::vector<Double_t>& value);
  
    /// Only set one value 
    /// z direction
    void setPz(const Double_t& value);
  
    /// Only get one value 
    /// z direction
    Double_t pz();
  
    /// Retrieve const  
    /// goodness of the fit
    const std::vector<Double_t>& chisqVec() const;
  
    /// Update  
    /// goodness of the fit
    void setChisq(const std::vector<Double_t>& value);
  
    /// Only set one value 
    /// goodness of the fit
    void setChisq(const Double_t& value);
  
    /// Only get one value 
    /// goodness of the fit
    Double_t chisq();
  
    /// Retrieve const  
    /// quality of energy recontruction
    const std::vector<Double_t>& energyQualityVec() const;
  
    /// Update  
    /// quality of energy recontruction
    void setEnergyQuality(const std::vector<Double_t>& value);
  
    /// Only set one value 
    /// quality of energy recontruction
    void setEnergyQuality(const Double_t& value);
  
    /// Only get one value 
    /// quality of energy recontruction
    Double_t energyQuality();
  
    /// Retrieve const  
    /// quality of position recontruction
    const std::vector<Double_t>& positionQualityVec() const;
  
    /// Update  
    /// quality of position recontruction
    void setPositionQuality(const std::vector<Double_t>& value);
  
    /// Only set one value 
    /// quality of position recontruction
    void setPositionQuality(const Double_t& value);
  
    /// Only get one value 
    /// quality of position recontruction
    Double_t positionQuality();
  
    ClassDef(CDRecEvent,1);
  

  }; // class CDRecEvent

} // namespace JM;

// -----------------------------------------------------------------------------
// end of class
// -----------------------------------------------------------------------------

// Including forward declarations

inline unsigned int JM::CDRecEvent::nVertexes() const 
{
  return m_nVertexes;
}

inline void JM::CDRecEvent::setNVertexes(unsigned int value) 
{
  m_nVertexes = value;
}

inline const std::vector<Double_t>& JM::CDRecEvent::peSumVec() const 
{
  return m_PESum;
}

inline void JM::CDRecEvent::setPESum(const std::vector<Double_t>& value) 
{
  m_PESum = value;
}

inline void JM::CDRecEvent::setPESum(const Double_t& value) 
{
  if (!m_PESum.size()) { m_PESum.push_back(value); }
  else if (m_PESum.size()==1) { m_PESum[0] = value; } 
}

inline Double_t JM::CDRecEvent::peSum() 
{
  return m_PESum.at(0);
}

inline const std::vector<Double_t>& JM::CDRecEvent::energyVec() const 
{
  return m_energy;
}

inline void JM::CDRecEvent::setEnergy(const std::vector<Double_t>& value) 
{
  m_energy = value;
}

inline void JM::CDRecEvent::setEnergy(const Double_t& value) 
{
  if (!m_energy.size()) { m_energy.push_back(value); }
  else if (m_energy.size()==1) { m_energy[0] = value; } 
}

inline Double_t JM::CDRecEvent::energy() 
{
  return m_energy.at(0);
}

inline const std::vector<Double_t>& JM::CDRecEvent::eprecVec() const 
{
  return m_eprec;
}

inline void JM::CDRecEvent::setEprec(const std::vector<Double_t>& value) 
{
  m_eprec = value;
}

inline void JM::CDRecEvent::setEprec(const Double_t& value) 
{
  if (!m_eprec.size()) { m_eprec.push_back(value); }
  else if (m_eprec.size()==1) { m_eprec[0] = value; } 
}

inline Double_t JM::CDRecEvent::eprec() 
{
  return m_eprec.at(0);
}

inline const std::vector<Double_t>& JM::CDRecEvent::xVec() const 
{
  return m_x;
}

inline void JM::CDRecEvent::setX(const std::vector<Double_t>& value) 
{
  m_x = value;
}

inline void JM::CDRecEvent::setX(const Double_t& value) 
{
  if (!m_x.size()) { m_x.push_back(value); }
  else if (m_x.size()==1) { m_x[0] = value; } 
}

inline Double_t JM::CDRecEvent::x() 
{
  return m_x.at(0);
}

inline const std::vector<Double_t>& JM::CDRecEvent::yVec() const 
{
  return m_y;
}

inline void JM::CDRecEvent::setY(const std::vector<Double_t>& value) 
{
  m_y = value;
}

inline void JM::CDRecEvent::setY(const Double_t& value) 
{
  if (!m_y.size()) { m_y.push_back(value); }
  else if (m_y.size()==1) { m_y[0] = value; } 
}

inline Double_t JM::CDRecEvent::y() 
{
  return m_y.at(0);
}

inline const std::vector<Double_t>& JM::CDRecEvent::zVec() const 
{
  return m_z;
}

inline void JM::CDRecEvent::setZ(const std::vector<Double_t>& value) 
{
  m_z = value;
}

inline void JM::CDRecEvent::setZ(const Double_t& value) 
{
  if (!m_z.size()) { m_z.push_back(value); }
  else if (m_z.size()==1) { m_z[0] = value; } 
}

inline Double_t JM::CDRecEvent::z() 
{
  return m_z.at(0);
}

inline const std::vector<Double_t>& JM::CDRecEvent::pxVec() const 
{
  return m_px;
}

inline void JM::CDRecEvent::setPx(const std::vector<Double_t>& value) 
{
  m_px = value;
}

inline void JM::CDRecEvent::setPx(const Double_t& value) 
{
  if (!m_px.size()) { m_px.push_back(value); }
  else if (m_px.size()==1) { m_px[0] = value; } 
}

inline Double_t JM::CDRecEvent::px() 
{
  return m_px.at(0);
}

inline const std::vector<Double_t>& JM::CDRecEvent::pyVec() const 
{
  return m_py;
}

inline void JM::CDRecEvent::setPy(const std::vector<Double_t>& value) 
{
  m_py = value;
}

inline void JM::CDRecEvent::setPy(const Double_t& value) 
{
  if (!m_py.size()) { m_py.push_back(value); }
  else if (m_py.size()==1) { m_py[0] = value; } 
}

inline Double_t JM::CDRecEvent::py() 
{
  return m_py.at(0);
}

inline const std::vector<Double_t>& JM::CDRecEvent::pzVec() const 
{
  return m_pz;
}

inline void JM::CDRecEvent::setPz(const std::vector<Double_t>& value) 
{
  m_pz = value;
}

inline void JM::CDRecEvent::setPz(const Double_t& value) 
{
  if (!m_pz.size()) { m_pz.push_back(value); }
  else if (m_pz.size()==1) { m_pz[0] = value; } 
}

inline Double_t JM::CDRecEvent::pz() 
{
  return m_pz.at(0);
}

inline const std::vector<Double_t>& JM::CDRecEvent::chisqVec() const 
{
  return m_chisq;
}

inline void JM::CDRecEvent::setChisq(const std::vector<Double_t>& value) 
{
  m_chisq = value;
}

inline void JM::CDRecEvent::setChisq(const Double_t& value) 
{
  if (!m_chisq.size()) { m_chisq.push_back(value); }
  else if (m_chisq.size()==1) { m_chisq[0] = value; } 
}

inline Double_t JM::CDRecEvent::chisq() 
{
  return m_chisq.at(0);
}

inline const std::vector<Double_t>& JM::CDRecEvent::energyQualityVec() const 
{
  return m_energyQuality;
}

inline void JM::CDRecEvent::setEnergyQuality(const std::vector<Double_t>& value) 
{
  m_energyQuality = value;
}

inline void JM::CDRecEvent::setEnergyQuality(const Double_t& value) 
{
  if (!m_energyQuality.size()) { m_energyQuality.push_back(value); }
  else if (m_energyQuality.size()==1) { m_energyQuality[0] = value; } 
}

inline Double_t JM::CDRecEvent::energyQuality() 
{
  return m_energyQuality.at(0);
}

inline const std::vector<Double_t>& JM::CDRecEvent::positionQualityVec() const 
{
  return m_positionQuality;
}

inline void JM::CDRecEvent::setPositionQuality(const std::vector<Double_t>& value) 
{
  m_positionQuality = value;
}

inline void JM::CDRecEvent::setPositionQuality(const Double_t& value) 
{
  if (!m_positionQuality.size()) { m_positionQuality.push_back(value); }
  else if (m_positionQuality.size()==1) { m_positionQuality[0] = value; } 
}

inline Double_t JM::CDRecEvent::positionQuality() 
{
  return m_positionQuality.at(0);
}


#endif ///SNIPER_RECEVENT_CDRECEVENT_H

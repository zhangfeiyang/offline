#include "NNVT_MCPPMT_PMTSolid.hh"

#include "G4Ellipsoid.hh"
#include "G4Tubs.hh"
#include "G4Torus.hh"
#include "G4Polyhedra.hh"
#include "G4SubtractionSolid.hh"
#include "G4IntersectionSolid.hh"
#include "G4UnionSolid.hh"

#include <cmath>

NNVT_MCPPMT_PMTSolid::NNVT_MCPPMT_PMTSolid()
  : m_R(254.*mm), m_H(570.*mm), m_Htop(184.*mm), 
    m_Hbtm(172.50*mm), m_Rbtm(50.*mm), m_Rtorus(43.*mm) {

  m_Heq2torus = m_H - m_Htop - m_Hbtm;
  m_theta = atan((m_Rbtm+m_Rtorus)/(m_Heq2torus));
  m_Htubetorus = m_Rtorus*cos(m_theta);
  m_Rtubetorus = m_Rbtm+m_Rtorus - m_Rtorus*sin(m_theta);
}

G4VSolid*
NNVT_MCPPMT_PMTSolid::GetSolid(G4String solidname, double thickness) {
  double R = m_R + thickness;
  double H = m_H + thickness*2;
  double Htop = m_Htop + thickness;

  double Hbtm = m_Hbtm + thickness;
  double Rbtm = m_Rbtm + thickness;

  double Rtorus = m_Rtorus - thickness;

  double Htubetorus = Rtorus*cos(m_theta);
  double Rtubetorus = m_Rbtm+m_Rtorus - m_Rtorus*sin(m_theta);


  // PART I:
  G4Ellipsoid* pmttube_solid_part1 = new G4Ellipsoid(
                                            solidname+"_1_Ellipsoid",
                                            R, // pxSemiAxis
                                            R, // pySemiAxis
                                            Htop // pzSemiAxis
                                            );
  // return pmttube_solid_part1;
  // PART II:
  G4Tubs* pmttube_solid_tube = new G4Tubs(
                                    solidname+"_2_Tube",
                                    0*mm,  /* inner */ 
                                    Rtubetorus, /* pmt_r */ 
                                    Htubetorus/2, /* part 2 h */ 
                                    0*deg, 
                                    360*deg);
  G4Torus* pmttube_solid_torus = new G4Torus(
                                        solidname+"_2_Torus",
                                        0*mm,  // R min
                                        Rtorus, // R max
                                        (m_Rbtm+m_Rtorus), // Swept Radius
                                        0.00*deg,
                                        360.00*deg);
  G4SubtractionSolid* pmttube_solid_part2 = new G4SubtractionSolid(
                                            solidname+"_part2",
                                            pmttube_solid_tube,
                                            pmttube_solid_torus,
                                            0,
                                            G4ThreeVector(0,0,-Htubetorus/2)
                                            );
  // return pmttube_solid_part2;
  // PART III:
  G4Tubs* pmttube_solid_end_tube = new G4Tubs(
                                    solidname+"_3_EndTube",
                                    0*mm,  /* inner */ 
                                    Rbtm, //21*cm/2, /* pmt_r */ 
                                    Hbtm/2, //30*cm/2, /* pmt_h */ 
                                    0*deg, 
                                    360*deg);
  //return pmttube_solid_end_tube;
  // I+II
  G4UnionSolid* pmttube_solid_1_2 = new G4UnionSolid(
                                            solidname+"_1_2",
                                            pmttube_solid_part1,
                                            pmttube_solid_part2,
                                            0,
                                            G4ThreeVector(0, 0, -m_Heq2torus+Htubetorus/2)
                                            );
  // return pmttube_solid_1_2;
  // I+II + III 
  G4UnionSolid* pmttube_solid_1_2_3 = new G4UnionSolid(
                                            solidname,
                                            pmttube_solid_1_2,
                                            pmttube_solid_end_tube,
                                            0,
                                            G4ThreeVector(0,0, 
                                                -(m_Heq2torus+Hbtm*0.50))
                                            );
  return pmttube_solid_1_2_3;

}

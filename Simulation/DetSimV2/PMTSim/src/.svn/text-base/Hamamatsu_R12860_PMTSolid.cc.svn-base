#include "Hamamatsu_R12860_PMTSolid.hh"

#include "G4Ellipsoid.hh"
#include "G4Tubs.hh"
#include "G4Torus.hh"
#include "G4Polyhedra.hh"
#include "G4Polycone.hh"
#include "G4SubtractionSolid.hh"
#include "G4IntersectionSolid.hh"
#include "G4UnionSolid.hh"

#include <cmath>

Hamamatsu_R12860_PMTSolid::Hamamatsu_R12860_PMTSolid()
{
    m1_h = 190.;
    m1_r = 254.;

    m2_h = 5.; // -5 -> 0;
    m2_r = m1_r;

    m3_h = 190.; // ?
    m3_r = 254.;

    //               R_1
    //         ._______________
    //       .    .            |
    //     . theta .           |
    //   ._________.___________|
    //     Rtorus    R_2

    m4_torus_r = 80.; // ?
    m4_torus_angle = 45.*deg; // ?

    m4_r_2 = 254./2;
    m4_r_1 = (m4_r_2+m4_torus_r) - m4_torus_r*cos(m4_torus_angle);

    m4_h = m4_torus_r*sin(m4_torus_angle) + 5.0*mm;

    m5_r = m4_r_2;
    m5_h = 65.;


    //
    //             m6_r
    //        .............|  (-275.)
    //        .            |
    //         .           |  m6_h
    //           .         |
    //              .......|  (..?..)
    //               m7_r

    m6_r = m5_r;
    m6_h = 190./2;
    m7_r = 75./2; // omit the torus for simplicity

    m8_r = 75./2;

    // (x/m6_r)^2 + (y/m6_h)^2 = 1
    // x = m8_r = 75/2
    // -> y = sqrt( (254^2-75^2)/254^2 * 190^2/4 )
    // >>> ( (254.**2-75.**2)/254.**2 * 190.**2/4 ) ** 0.5
    // 90.764151727223648
    // m8_h = 145-y = 55
    m8_h = 55.+15.;

    m9_r = 51.50/2;
    m9_h = 30.;
}

G4VSolid*
Hamamatsu_R12860_PMTSolid::GetSolid(G4String solidname, double thickness)
{
    G4VSolid* pmt_solid = NULL;

    double P_I_R = m1_r + thickness;
    double P_I_H = m1_h + thickness;

    G4VSolid* solid_I = new G4Ellipsoid(
					solidname+"_I",
					P_I_R,
					P_I_R,
					P_I_H,
					0, // pzBottomCut -> equator
					P_I_H // pzTopCut -> top
					);
    // pmt_solid = solid_I;

    G4VSolid* solid_II = new G4Tubs(
					solidname+"_II",
					0.0,
					P_I_R,
					m2_h/2,
					0.*deg,
					360.*deg
					);
    G4cout << __LINE__ << G4endl;
    // I+II
    pmt_solid = new G4UnionSolid(
				 solidname+"_1_2",
				 solid_I,
				 solid_II,
				 0,
				 G4ThreeVector(0,0,-m2_h/2)
				 );

    G4VSolid* solid_III = new G4Ellipsoid(
					  solidname+"_III",
					  P_I_R,
					  P_I_R,
					  P_I_H,
					  -P_I_H,
					  0);

    // +III
    pmt_solid = new G4UnionSolid(
				 solidname+"_1_3",
				 pmt_solid,
				 solid_III,
				 0,
				 G4ThreeVector(0,0,-m2_h)
				 );

    G4VSolid* solid_IV_tube = new G4Tubs(
					 solidname+"_IV_tube",
					 0.0,
					 m4_r_1,
					 m4_h/2,
					 0.0*deg,
					 360.0*deg
					 );
    G4VSolid* solid_IV_torus = new G4Torus(
					   solidname+"_IV_torus",
					   0.*mm,
					   m4_torus_r-thickness, // R
					   m4_torus_r+m4_r_2, // swept radius
					   0.0*deg,
					   360.0*deg);
    G4VSolid* solid_IV = new G4SubtractionSolid(
						solidname+"_IV",
						solid_IV_tube,
						solid_IV_torus,
						0,
						G4ThreeVector(0,0,-m4_h/2)
						);
    // +IV
    pmt_solid = new G4UnionSolid(
				 solidname+"_1_4",
				 pmt_solid,
				 solid_IV,
				 0,
				 G4ThreeVector(0,0,-210.*mm+m4_h/2)
				 );

    G4VSolid* solid_V = new G4Tubs(
				   solidname+"_V",
				   0.0,
				   m5_r+thickness,
				   m5_h/2,
				   0.0*deg,
				   360.0*deg
				   );
    // +V
    pmt_solid = new G4UnionSolid(
				 solidname+"_1_5",
				 pmt_solid,
				 solid_V,
				 0,
				 G4ThreeVector(0,0,-210.*mm-m5_h/2)
				 );


    double P_VI_R = m6_r + thickness;
    double P_VI_H = 95.*mm + thickness;
    G4VSolid* solid_VI = new G4Ellipsoid(
					 solidname+"_VI",
					 P_VI_R,
					 P_VI_R,
					 P_VI_H,
					 -90.*mm,
					 0);

    // +VI
    pmt_solid = new G4UnionSolid(
    				 solidname+"_1_6",
    				 pmt_solid,
    				 solid_VI,
    				 0,
    				 G4ThreeVector(0,0,-275.*mm)
    				 );

    G4VSolid* solid_VIII = new G4Tubs(
				      solidname+"_VIII",
				      0.0,
				      m8_r+thickness,
				      m8_h/2,
				      0.0*deg,
				      360.0*deg
				      );
    // +VIII
    pmt_solid = new G4UnionSolid(
				 solidname+"_1_8",
				 pmt_solid,
				 solid_VIII,
				 0,
				 G4ThreeVector(0,0,-420.*mm+m8_h/2)
				 );

    // G4VSolid* solid_IX = new G4Tubs(
    // 				    solidname+"_IX",
    // 				    0.0,
    // 				    m9_r+thickness,
    // 				    m9_h/2,
    // 				    0.0*deg,
    // 				    360.0*deg
    // 				    );
    double* r_IX_in = new double[2]; r_IX_in[0] = 0.0;            r_IX_in[1] = 0.0;
    double* r_IX = new double[2];    r_IX[0] = m9_r+thickness;    r_IX[1] = m9_r+thickness;
    double* z_IX = new double[2];    z_IX[0] = -(m9_h+thickness); z_IX[1] = 0;
    G4VSolid* solid_IX = new G4Polycone(
					solidname+"_IX",
					0.0*deg,
					360.*deg,
					2,
					z_IX,
					r_IX_in,
					r_IX
					);


    // +VIII
    pmt_solid = new G4UnionSolid(
				 solidname+"_1_9",
				 pmt_solid,
				 solid_IX,
				 0,
				 G4ThreeVector(0,0,-420.*mm)
				 );


    return pmt_solid;
}

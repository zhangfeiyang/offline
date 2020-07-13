#include "CalPositionCylinder.hh"
#include "G4ThreeVector.hh"
#include "G4RotationMatrix.hh"
#include <cassert>

namespace JUNO {
namespace Cylinder {

CalPositionCylinder::CalPositionCylinder(G4double cyl_r,
                                 G4double cyl_h,
                                 G4double pmt_r,
                                 G4double pmt_h,
                                 G4double pmt_interval) 
{
    m_cyl_r = cyl_r;
    m_cyl_h = cyl_h;
    m_pmt_r = pmt_r;
    m_pmt_h = pmt_h;
    m_pmt_interval = pmt_interval;

    initialize();
    calculate();

    m_position_iter = m_position.begin();
}

CalPositionCylinder::~CalPositionCylinder() {

}

void CalPositionCylinder::initialize() {
  /*G4int n_max =*/ GetMaxiumNinCircle(
                                    m_cyl_r,
                                    m_pmt_interval);
  assert(m_pmt_interval > 2 * m_pmt_r);

}

// Helper:
G4int CalPositionCylinder::GetMaxiumNinCircle(G4double r_circle,
    G4double interval)
{
  assert(r_circle >= 0);//keep r_circle >= 0
  G4int N = 0;
  N = int(r_circle*2*pi/interval);
  if(r_circle == 0) N = 1;
  return N;
}

G4Transform3D CalPositionCylinder::next() {
    return *(m_position_iter++);
}

void CalPositionCylinder::calculate() {
  G4int n_pmt = 0;
 // pmts on ball surface
  double ball_r = 20.252*m;
  double m_ball_circle_r = ball_r+0.5*m;
  double pmt_interval  = 1.60*m;
  double delta_theta = pmt_interval/m_ball_circle_r;
  /////////////////// //ball pmts////////////////
  G4int n_ball_ring = 0;
  G4int n_ball_pmt = 0;
 for(G4double d_theta =delta_theta; d_theta <3.14159/2+2*delta_theta; d_theta += delta_theta){
   n_ball_ring++;
   double  mb_r = m_ball_circle_r*sin(d_theta);
   double  nb_max = GetMaxiumNinCircle(mb_r, pmt_interval);
    assert(nb_max);
    //G4cout<<" veto pool pmt bottom ring: "<<n_btm_ring<<", max pmt: "<<n_max<<G4endl;
   double   mb_per_phi = 2 * pi / nb_max;
    for(G4int i = 0; i< nb_max; ++i){
      G4double phi = mb_per_phi * i;
      G4double x = mb_r * cos(phi);
      G4double y = mb_r * sin(phi);
      G4double z = m_ball_circle_r*cos(d_theta);
      //G4cout<<" veto pool pmt bottom position xyz: ("<<x<<", "<<y<<", "<<z<<")"<<G4endl; 

      G4ThreeVector pos(x, y, z);
      G4RotationMatrix rot;
      rot.rotateY(d_theta); 
      rot.rotateZ(phi);
      G4Transform3D trans(rot, pos);

      // Append trans
      m_position.push_back(trans);
      n_ball_pmt++;
      // DEBUG info
      // if(d_theta<3.14159/2) G4cout<<"half_ball_pmt ="<<n_ball_pmt<<G4endl;
      n_pmt++;
    }
  }

 //wall pmts//////////////////////
  G4double m_r_circle = m_cyl_r - (m_pmt_h - m_pmt_r + 5*mm);
  G4int n_max = GetMaxiumNinCircle(m_r_circle, m_pmt_interval);
  assert(n_max);
  G4cout<<" veto pool, r= "<<m_cyl_r<<" mm, h= "<<m_cyl_h<<" mm"<<G4endl;
  G4cout<<" veto pool pmt r = "<<m_pmt_r<<" mm, h= "<<m_pmt_h<<" mm"<<G4endl; 
  G4cout<<" veto pool pmt position interval   : "<<m_pmt_interval<<" mm"<<G4endl;
  G4cout<<" veto pool pmt wall max number in each ring: "<<n_max<<G4endl;
  G4int n_wall_pmt = 0;
  G4int n_wall_ring = 0;
  m_per_phi = 2 * pi / n_max; 
//  for(G4double m_z = m_cyl_h/2. - m_pmt_interval * 1 / 3.; m_z > -m_cyl_h / 2. + m_pmt_r; m_z -= m_pmt_interval ){
    for(G4double m_z = 0; m_z > -m_cyl_h / 2. + m_pmt_r; m_z -= m_pmt_interval ){
    for (G4int i = 0; i < n_max; ++i) {
      G4double phi = m_per_phi * i;
      G4double x = m_r_circle * cos(phi);
      G4double y = m_r_circle * sin(phi);
      G4double z = m_z;
      //G4cout<<" veto pool pmt wall position xyz: ("<<x<<", "<<y<<", "<<z<<")"<<G4endl; 
      G4ThreeVector pos(x, y, z);
      G4RotationMatrix rot;
      rot.rotateY(pi/2);
      rot.rotateZ(pi + phi);
      G4Transform3D trans(rot, pos);

      // Append trans
      m_position.push_back(trans);
      n_wall_pmt++;
      n_pmt++;
    }
    n_wall_ring++;
  }
  G4cout<<" veto pool wall rings: "<<n_wall_ring<<G4endl;
  G4cout<<" veto pool wall pmts : "<<n_wall_pmt<<G4endl;
 //bottom pmts
  G4int n_btm_ring = 0;
  G4int n_btm_pmt = 0;
  for(G4double m_r =0; m_r < m_cyl_r - m_pmt_r - 5*mm; m_r += m_pmt_interval){
    n_btm_ring++;
    n_max = GetMaxiumNinCircle(m_r, m_pmt_interval);
    assert(n_max);
    //G4cout<<" veto pool pmt bottom ring: "<<n_btm_ring<<", max pmt: "<<n_max<<G4endl;
    m_per_phi = 2 * pi / n_max;
    for(G4int i = 0; i< n_max; ++i){
      G4double phi = m_per_phi * i; 
      G4double x = m_r * cos(phi);
      G4double y = m_r * sin(phi);
      G4double z = -m_cyl_h/2. + (m_pmt_h - m_pmt_r + 5*mm);;
      //G4cout<<" veto pool pmt bottom position xyz: ("<<x<<", "<<y<<", "<<z<<")"<<G4endl; 

      G4ThreeVector pos(x, y, z);
      G4RotationMatrix rot;
      rot.rotateZ(pi + phi);
      G4Transform3D trans(rot, pos);

      // Append trans
      m_position.push_back(trans);
      n_btm_pmt++;
      n_pmt++;
    }
  }
  G4cout<<" veto pool bottom rings: "<<n_btm_ring<<G4endl;
  G4cout<<" veto pool bottom pmts : "<<n_btm_pmt<<G4endl;
  G4cout<<" veto pool pmt total : "<<n_pmt<<G4endl;
}

G4bool CalPositionCylinder::hasNext() {
    return m_position_iter != m_position.end();
}


}
}

//
// ********************************************************************
// * License and Disclaimer                                           *
// *                                                                  *
// * The  Geant4 software  is  copyright of the Copyright Holders  of *
// * the Geant4 Collaboration.  It is provided  under  the terms  and *
// * conditions of the Geant4 Software License,  included in the file *
// * LICENSE and available at  http://cern.ch/geant4/license .  These *
// * include a list of copyright holders.                             *
// *                                                                  *
// * Neither the authors of this software system, nor their employing *
// * institutes,nor the agencies providing financial support for this *
// * work  make  any representation or  warranty, express or implied, *
// * regarding  this  software system or assume any liability for its *
// * use.  Please see the license in the file  LICENSE  and URL above *
// * for the full disclaimer and the limitation of liability.         *
// *                                                                  *
// * This  code  implementation is the result of  the  scientific and *
// * technical work of the GEANT4 collaboration.                      *
// * By using,  copying,  modifying or  distributing the software (or *
// * any work based  on the software)  you  agree  to acknowledge its *
// * use  in  resulting  scientific  publications,  and indicate your *
// * acceptance of all terms of the Geant4 Software license.          *
// ********************************************************************
//
#ifndef LSExpDetectorConstruction_h
#define LSExpDetectorConstruction_h 1

#include "globals.hh"
#include "G4VUserDetectorConstruction.hh"
#include "G4OpticalSurface.hh"

class G4Box;
class G4Sphere;
class G4Tubs;
class G4LogicalVolume;
class G4VPhysicalVolume;
class G4Material;
class G4MaterialPropertyVector;
class G4VSensitiveDetector;
class LSExpDetectorMessenger;
class IDetElement;
class IDetElementPos;
class IPMTElement;
class IMCParamsSvc;
class Task;

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

class LSExpDetectorConstruction : public G4VUserDetectorConstruction
{
  public:
  
     LSExpDetectorConstruction();
    ~LSExpDetectorConstruction();

  public:
  
     G4VPhysicalVolume* Construct();

  public:
     void setScope(Task* scope) {m_scope = scope;}
     Task* getScope() {return m_scope;}

  public:
     // Interface to setup the whole detector
     // For PMT
     void setPMTQEScale(double scale) { m_pmt_qe_scale_for_elec = scale;}
     // For Central Detector
     void setCDName(const std::string& cd_name) {m_cd_name = cd_name;}
     void setCDEnabled(bool v) { m_cd_enabled = v; }
     void setPMTName(const std::string& pmt_name) {m_pmt_name = pmt_name;}
     void setLPMTExtra(const std::string& pmt_extra) {m_extra_lpmt = pmt_extra;}
     void set3inchPMTName(const std::string& pmt_name) {m_3inchpmt_name = pmt_name;}
     void setPMTMother(const std::string& pmt_mother) {m_pmt_mother=pmt_mother;}
     void setPMTPosMode(const std::string& pos_mode) {m_pmt_pos_mode=pos_mode;}
     void setVetoPMTPosMode(const std::string& pos_mode) {m_veto_pmt_pos_mode=pos_mode;}
     void setPMTPosFile(const std::string& pos_file) {m_pmt_pos_file=pos_file;}
     void set3inchPMTPosFile(const std::string& pos_file) {m_3inch_pmt_pos_file=pos_file;}
     void set3inchPMTPosOffset(double pos_offset) {m_3inchpmt_pos_offset=pos_offset;}
     // For Prototype Detector
     void setPMTPosDir(const std::string& pos_dir) {m_pmt_pos_dir=pos_dir;}

     void setStrutName(const std::string& strut_name) {m_strut_name = strut_name;}
     void setStrutMother(const std::string& strut_mother) {m_strut_mother=strut_mother;}
     void setStrutPosFile(const std::string& pos_file) {m_strut_pos_file=pos_file;}
     void setStrutPosDir(const std::string& pos_dir) {m_strut_pos_dir=pos_dir;}
 
     void setFastenerName(const std::string& fastener_name) {m_fastener_name = fastener_name;}
     void setFastenerMother(const std::string& fastener_mother) {m_fastener_mother=fastener_mother;}
     void setFastenerPosFile(const std::string& pos_file) {m_fastener_pos_file=pos_file;}
     void setFastenerPosDir(const std::string& pos_dir) {m_fastener_pos_dir=pos_dir;}
     // For Water Pool
     void setWPEnabled(bool v) { m_wp_enabled = v; }
     // For Top Tracker
     void setTTName(const std::string& tt_name) {m_tt_name = tt_name;}
     void setTTEnabled(bool v) { m_tt_enabled = v; }
     // For Calib Unit
     void setCalibUnitName(const std::string& calib_name) {m_calibunit_name = calib_name;}
     void setCalibUnitExtras(const std::vector<std::string>& v) {m_calibunit_extras = v;}
     // For Chimney 
     void setTopChimneyName(const std::string& top_chimney_name) 
     {m_chimney_top_name=  top_chimney_name;}
     void setLowerChimneyName(const std::string& lower_chimney_name)
     {m_chimney_lower_name=  lower_chimney_name;}
  private:
     void DefineMaterials();

     void DefineVariables();

  private:
     // helper: load the DetElement from DetSimAlg
     IDetElement* det_elem(const std::string& name);
     IDetElementPos* det_elem_pos(const std::string& name);

  private:

     // == Outer Water Pool ==
     void setupOuterWaterPool();
     // == Central Detector ==
     void setupCentralDetector();
     void setupReflectorInCD();
     void setupPrototypeDetector();
     void setupPrototypeDetectorOnePMT();
     // === PMT ===
     void setupPMT(G4VSensitiveDetector*);
     void setupCD_PMTs();
     void setupWP_PMTs();
     // === Stick ===
     void setupCD_Sticks(IDetElement* cd_det);

     // == Rock And Exp Hall ==
     void setupRockAndExpHall();

     // == Top Tracker==
     void setupTopTracker();

     // == Calib Unit ==
     void setupCalibUnit();

     // == Chimney==
     void setupTopChimney();
     void setupLowerChimney();

  private:
     G4VSensitiveDetector* getPMTSD();
  private:
     bool helper_mpt(G4MaterialPropertiesTable*, const std::string&, IMCParamsSvc*, const std::string&, float scale=1.0); 
     // insert properties into material properties table
  private: 

     G4Box*             solidWorld;    // pointer to the solid envelope 
     G4LogicalVolume*   logicWorld;    // pointer to the logical envelope
     G4VPhysicalVolume* physiWorld;    // pointer to the physical envelope
     


     G4Material* Galactic;          // Default material
     G4Material* Air;          // Default material
     G4Material* GdLS;           // Target material
     G4Material* LS;           // Target material
     G4Material* LAB;
     G4Material* ESR;         // Detector material
     G4Material* Tyvek;         // Detector material
     G4Material* Acrylic;         // Detector material
     G4Material* DummyAcrylic;         // Detector material
     G4Material* Teflon;         // Detector material
     G4Material* ETFE;         // Detector material
     G4Material* FEP;         // Detector material
     G4Material* PE_PA;          // Default material PE/PA--Nylon
     G4Material* PA;          // Default material---Nylon
     G4Material* Photocathode_mat;
     G4Material* Steel;
     G4Material* StainlessSteel;
     G4Material* Mylar;
     G4Material* Vacuum;
     G4Material* VacuumT;

     G4Material* Pyrex;
     G4Material* Oil;
     G4Material* Water;
     G4Material* vetoWater;
     G4Material* Rock;
     G4Material* Copper;

     G4OpticalSurface* Photocathode_opsurf;
     G4OpticalSurface* Photocathode_opsurf_3inch;
 
     G4double pmttube_r;
     G4double pmttube_h;
     G4double ball_r;
     G4double strut_r;
     G4double strut_r_acrylic;
     G4double strut_r_balloon;
     G4double fastener_r;
     G4double gap;

     // control specific detector components.
     bool m_cd_enabled;
     // NOTE: when WP is disabled, the CD could have some problem.
     //       The reflector needs both WP and CD.
     bool m_wp_enabled;
     bool m_tt_enabled;

  private:
     // = World = 
     // == Rock And Exp Hall ==
     std::string m_rock_and_exphall;
     IDetElement* de_top_rock;
     IDetElement* de_exp_hall;
     IDetElement* de_bottom_rock;

     double m_topRockOffsetZ;
     double m_btmRockOffsetZ;

     // == Central Detector ==
     IDetElement* de_cd_det;
     // == Outer Water Pool ==
     IDetElement* de_wp_det;

     // == TOP TRACKER ==
     std::string m_tt_name;
    //for TT
     G4Material* Aluminium;
     G4Material* TiO2;
     G4Material* Scintillator;
     G4Material* Adhesive;
     G4Material* TiO2Coating;

     // == Calib Unit ==
     std::string m_calibunit_name;
     std::vector<std::string> m_calibunit_extras;
     IDetElement* de_calibunit;

     // == Chimney  ==
     std::string m_chimney_top_name;
     IDetElement* de_topchimney;
     std::string m_chimney_lower_name;
     IDetElement* de_lowerchimney;
  private:
     std::string m_cd_name;
     std::string m_pmt_name;
     std::string m_mask_mother;
     std::string m_pmt_mother;
     std::string m_pmt_pos_mode;
     std::string m_pmt_pos_file;
     std::string m_3inchpmt_name;
     std::string m_3inch_pmt_pos_file;
     double m_3inchpmt_pos_offset;
     std::string m_pmt_pos_dir;

     // m_extra_lpmt is used when two categories of PMTs are constructed
     // together.
     std::string m_extra_lpmt; // 'ONE' or 'TWO'

     std::string m_veto_pmt_pos_mode;

     std::string m_strut_name;
     std::string m_strut_mother;
     std::string m_strut_pos_file;
     std::string m_strut_pos_dir;
     
     std::string m_fastener_name;
     std::string m_fastener_mother;
     std::string m_fastener_pos_file;
     std::string m_fastener_pos_dir;
     
  private:
     // control SD
     bool hits_merge_flag;
     double hits_merge_window;

     double m_pmt_qe_scale_for_elec;
  private:
     // Modify the Optical Property by some coefficient
     double coeff_abslen;
     double coeff_ceff;
     double coeff_ceff_3inch;
     double coeff_lsly;
     double coeff_rayleigh;
     void DefineOpticalPropertyCoefficient();
     void ModifyOpticalProperty();

  private:
     G4String m_sd_type;
     G4VSensitiveDetector* GetPMTSD();

     IPMTElement* pmt_det; // for 20inch PMT
     IPMTElement* pmt_det_3inch; // for 3inch PMT
  private:
     Task* m_scope;
};

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

#endif

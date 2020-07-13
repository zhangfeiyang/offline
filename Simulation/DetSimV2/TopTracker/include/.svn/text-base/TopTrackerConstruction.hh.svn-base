#ifndef TopTrackerConstruction_hh
#define TopTrackerConstruction_hh

#include "SniperKernel/ToolBase.h"
#include "DetSimAlg/IDetElement.h"

#include "globals.hh"

class G4Box;
class G4Sphere;
class G4Tubs;
class G4SubtractionSolid;
class G4LogicalVolume;
class G4VPhysicalVolume;
class G4Material;

class TopTrackerConstruction : public IDetElement,
                            public ToolBase{
public:
    G4LogicalVolume* getLV();
    bool inject(std::string motherName, IDetElement* other, IDetElementPos* pos);

    double geom_info(const std::string&) { return 0.0; }
    double geom_info(const std::string& param,  const int wallnumber);

    TopTrackerConstruction(const std::string& name);
    ~TopTrackerConstruction();

private:

    void initMaterials();
    void initVariables();

    void makeAirTTLogical();
                                
    void makeStripLogical();
    void makeStripPhysical();

               
    void makeCoatingLogical();
    void makeCoatingPhysical();
                                
    void makeModuleLogical();
    void makeModulePhysical();
                            
    void makeModuleTapeLogical();
    void makeModuleTapePhysical();
                                
    void makePlaneLogical();
    void makePlanePhysical();

    void makeWallLogical();
    void makeWallPhysical();

    
private:

    G4Box*              BoxsolidAirTT; 
    G4SubtractionSolid* solidAirTT; //Logic volume containing TT
    G4Tubs*             solidChimney;
   
    G4LogicalVolume*    logicAirTT;

   
                                
                                
                                
    G4Box*              solidBar; //Scintillator
    G4LogicalVolume*    logicBar;
    G4VPhysicalVolume*  physiBar;
                                
    G4Box*              solidCoating; //TiO2
    G4LogicalVolume*    logicCoating;
    G4VPhysicalVolume*  physiCoating[64];
    
    G4Box*              solidModuleTape; //Tape between scintillator and Al
    G4LogicalVolume*    logicModuleTape;
    G4VPhysicalVolume*  physiModuleTape;
                                
    G4Box*              solidModule; //Aluminium box
    G4LogicalVolume*    logicModule;
    G4VPhysicalVolume*  physiModule[4];
                                
    G4Box*              solidPlane; //4 modules
    G4LogicalVolume*    logicPlane;
    G4VPhysicalVolume*  physiPlane[2];
                                
    G4Box*              solidWall;// 2 planes 1 X and 1 Y
    G4LogicalVolume*    logicWall;
    G4VPhysicalVolume*  physiWall[62];
                                
                                
private:

    G4Material* Aluminium;           // TT material
    G4Material* Scintillator;
    G4Material* TiO2Coating;
    G4Material* Adhesive;
    G4Material* Air;
    
private:
    double m_box_x;
    double m_box_y;
    double m_box_z;

    double m_chimney_R;
    double m_chimney_Z;

    double m_wall_x;
    double m_wall_y;
    double m_wall_z;
                                
    double m_lengthBar;
    double m_thicknessBar;
    double m_widthBar;
    double m_spaceBar;
               
    double m_lengthCoating;
    double m_thicknessCoating;
    double m_widthCoating;
                          
    double m_lengthModuleTape;
    double m_thicknessModuleTape;
    double m_widthModuleTape;
                    
    double m_lengthModule;
    double m_thicknessModule;
    double m_widthModule;
    double m_spaceModule;

    double m_lengthPlane;
    double m_thicknessPlane;
    double m_widthPlane;
    double m_vspacePlane;
                        
    //wall positions
    double m_zlowerwall;
    double m_zshift;//to access module and space for PMTs
    double m_zspace;//distance between wall layers
    double m_zspaceChimney;//distance between walls above chimney
    double m_xspace;//distance between walls in x
    double m_xspace1;//distance between walls in x central row
    double m_yspace;//distance between walls in y
    double m_xhole;//hole for chimney in x direction
    double m_zshiftMR;//to access module and space for PMTs in middle row with respect to the other rowa
    double m_zlowerwallChimney;

    double m_wall_posx[62];
    double m_wall_posy[62];
    double m_wall_posz[62];
    int m_wall_layer[62];
    int m_wall_column[62];
  int m_wall_row[62];

    double m_mod_posxy[4];
    double m_bar_posxy[64];
    double m_plane_posz[2];
                  

    bool IsOverlap;

};

#endif

#ifndef DetSim1Construction_hh
#define DetSim1Construction_hh

#include "SniperKernel/ToolBase.h"
#include "DetSimAlg/IDetElement.h"
#include "globals.hh"

class G4Box;
class G4Sphere;
class G4Tubs;
class G4VSolid;
class G4LogicalVolume;
class G4VPhysicalVolume;
class G4Material;

class DetSim1Construction : public IDetElement,
                            public ToolBase{
public:
    G4LogicalVolume* getLV();
    bool inject(std::string motherName, IDetElement* other, IDetElementPos* pos);

    DetSim1Construction(const std::string& name);
    ~DetSim1Construction();

private:

    void initMaterials();
    void initVariables();

    // + Tyvek film 
    //   the Tyvek film will contain the Inner Water Pool.
    //   and the surface will be added when the CD is injected into Outer Water
    //   Pool.
    void makeReflectorLogical();
    void makeReflectorChimneyLogical();

    // + WP: Water Pool
    void makeWPLogical();
    void makeWPWithChimneyLogical();
    void makeWPPhysical();

    // ++ Acrylic Ball
    void makeAcrylicLogical();
    void makeAcrylicWithChimneyLogical();
    void makeAcrylicPhysical();

    // +++ LS 
    void makeLSLogical();
    void makeLSWithChimneyLogical();
    void makeLSPhysical();

    // ++ PMT
    //    The PMTs are injected into WP.
    void makePMTLogical();
    void makePMTPhysical();

    // + Sensor Enclosure
    void makeSensorLogical();
    void makeSensorPhysical();

private:
    G4VSolid*          solidReflector;
    G4LogicalVolume*   logicReflector;

    G4VSolid*          solidWaterPool;
    G4LogicalVolume*   logicWaterPool;
    G4VPhysicalVolume* physiWaterPool;

    G4VSolid*           solidAcrylic;
    G4LogicalVolume*    logicAcrylic;
    G4VPhysicalVolume*  physiAcrylic;

    G4VSolid*           solidTarget;   // pointer to the solid Target
    G4LogicalVolume*    logicTarget;   // pointer to the logical Target
    G4VPhysicalVolume*  physiTarget;   // pointer to the physical Target

    G4Tubs*             solidSensor;
    G4LogicalVolume*    logicSensor;
    G4VPhysicalVolume*  physiSensor[10];

    G4Tubs*             solidEnclosure;
    G4LogicalVolume*    logicEnclosure;
    G4VPhysicalVolume*  physiEnclosure[10];

    G4LogicalVolume*   pmttube_log;
    G4VPhysicalVolume* pmttube_phys;
private:

    G4Material* LS;           // Target material
    G4Material* Acrylic;         
    G4Material* Water;
    G4Material* Tyvek;
		G4Material* Copper;
		G4Material* Steel;
    G4Material* Teflon;
    G4Material* Sensor_Steel;
private:
    double m_radLS;
    double m_thicknessAcrylic;
    double m_radAcrylic;
    double m_radWP;
    double m_heightWP;

    double m_radInnerWater;        // the radius of ball;
    double m_radInnerWaterChimney; // the radius of tube

    double m_thicknessReflector;
    double m_radReflector;
    double m_radReflectorChimney;

    double m_ChimneyTopToCenter;
    double m_radLSChimney;
    double m_radAcrylicChimney;

    double m_blockerZ;
    double m_ChimneyoffSet;

    double m_radEnclosure; 
    double m_halfHeightEnclosure;
    double m_radSensor;
    double m_halfHeightSensor;
    //G4double zPlane[6] = {0.5*cm,0.5*cm+1*nm,12.5*cm,12.5*cm+1*nm,12.8*cm,12.8*cm};
    //G4double rInner[6] = {0,0,0,0,0,0};
    //G4double rOuter[6] = {2.5*cm,2.5*cm,1.5*cm,1.5*cm,1.5*cm,2.5*cm,2.5*cm};
    G4Transform3D posEnclosure[10];

private:
    // properties
    bool m_use_chimney;
    bool m_check_overlap;
};

#endif

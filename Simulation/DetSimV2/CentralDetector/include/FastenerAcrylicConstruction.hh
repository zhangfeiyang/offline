#ifndef FastenerAcrylicConstruction_hh
#define FastenerAcrylicConstruction_hh

#include "SniperKernel/ToolBase.h"
#include "DetSimAlg/IDetElement.h"
#include "globals.hh"

class G4Box;
class G4Sphere;
class G4Tubs;
class G4LogicalVolume;
class G4VPhysicalVolume;
class G4Material;
class G4VSolid;

class FastenerAcrylicConstruction : public IDetElement,
                            public ToolBase{
public:
    G4LogicalVolume* getLV();
    bool inject(std::string motherName, IDetElement* other, IDetElementPos* pos);

    FastenerAcrylicConstruction(const std::string& name);
    ~FastenerAcrylicConstruction();

private:
    void initMaterials();
    void initVariables();

    // ++Strut 
    void makeFastenerLogical();
private:
    
    G4VSolid*     solidFasteners_up ;
    G4VSolid*     solidFasteners_up1 ;
    G4VSolid*     solidFasteners_down ;
    G4VSolid*     solidFasteners_Bolts; 
    G4VSolid*     solidFasteners1 ;
    G4VSolid*     solidFasteners2;
    G4VSolid*     solidFasteners; 
    G4VSolid*     FastenersUnion; 
    G4LogicalVolume* logicFasteners;

private:
    G4Material* Copper;           // Target material

private:
    double fasteners_up_out_R     ;
    double fasteners_length_up    ;
    double fasteners_up1_in_R     ;
    double fasteners_up1_out_R    ;
    double fasteners_length_up1   ;
    double fasteners_down_in_R    ; 
    double fasteners_down_out_R   ;                 
    double fasteners_length_down  ;                
    double fasteners_bolts_R      ;               
    double fasteners_bolts_length ;              
    
    double gap ;              
    double fasteners_pos ;              

};

#endif

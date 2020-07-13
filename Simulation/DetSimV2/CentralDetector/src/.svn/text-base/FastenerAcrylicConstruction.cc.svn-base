
#include "FastenerAcrylicConstruction.hh"
#include "G4Material.hh"
#include "G4LogicalVolume.hh"
#include "G4PVPlacement.hh"
#include "G4Sphere.hh"
#include "G4Tubs.hh"
#include "G4UnionSolid.hh"
#include "G4VisAttributes.hh"

#include "SniperKernel/SniperPtr.h"
#include "SniperKernel/ToolFactory.h"

DECLARE_TOOL(FastenerAcrylicConstruction);

FastenerAcrylicConstruction::FastenerAcrylicConstruction(const std::string& name)
    : ToolBase(name)
{
    logicFasteners = 0;
    initVariables();

}

FastenerAcrylicConstruction::~FastenerAcrylicConstruction() {

}

G4LogicalVolume* 
FastenerAcrylicConstruction::getLV() {
    if (logicFasteners) {
        return logicFasteners;
    }
    initMaterials();

    makeFastenerLogical();

    return logicFasteners;
}

bool 
FastenerAcrylicConstruction::inject(std::string /* motherName */, IDetElement* other, IDetElementPos* pos) {
    // Get the mother volume in current DetElem.
    G4LogicalVolume* mothervol = 0;
    if (not mothervol) {
        // don't find the volume.
        return false;
    }

    // retrieve the daughter's LV
    G4LogicalVolume* daughtervol = other->getLV();

    if (not daughtervol) {
        return false;
    }

    int copyno = 0;
    while (pos->hasNext()) {
        new G4PVPlacement(
            pos->next(),
            daughtervol,
            daughtervol->GetName()+"_phys",
            mothervol,
            false,
            copyno++
                );
    }
    G4cout<< " Fastener_Acrylic_Number = "<< copyno <<G4endl;

    return true;
}

void
FastenerAcrylicConstruction::initVariables() {
   fasteners_up_out_R = 150.;  
   fasteners_length_up = 10.;  
   fasteners_up1_in_R = 41.;  
   fasteners_up1_out_R = 50.;  
   fasteners_length_up1 = 25.;  
   fasteners_down_in_R = 80.;  
   fasteners_down_out_R = 150.;  
   fasteners_length_down = 5.;  
   fasteners_bolts_R = 10.;  
   fasteners_bolts_length = 140./2.; 
}

void 
FastenerAcrylicConstruction::initMaterials() {
    Copper = G4Material::GetMaterial("Copper");
}

void
FastenerAcrylicConstruction::makeFastenerLogical() {
  solidFasteners_up = new G4Tubs(
      "solidFasteners_up",
      0,  
      fasteners_up_out_R ,  
      fasteners_length_up ,  
      0*deg, 
      360*deg);
  
  solidFasteners_up1 = new G4Tubs(
      "solidFasteners_up1",
      fasteners_up1_in_R ,  
      fasteners_up1_out_R ,  
      fasteners_length_up1 ,  
      0*deg, 
      360*deg);

  solidFasteners_down = new G4Tubs(
      "solidFasteners_down",
      fasteners_down_in_R ,  
      fasteners_down_out_R ,  
      fasteners_length_down ,  
      0*deg, 
      360*deg);

  solidFasteners_Bolts = new G4Tubs(
      "solidFasteners_Bolts",
      0,  
      fasteners_bolts_R ,  
      fasteners_bolts_length ,  
      0*deg, 
      360*deg);

  solidFasteners1 = solidFasteners_down;
  
  for (int i = 0 ;i < 8; i++){
      G4UnionSolid* FastenersUnion = new G4UnionSolid(
              "solid_FastenersUnion",
              solidFasteners1,
              solidFasteners_Bolts,
              0,
              G4ThreeVector(125.*sin(i*(pi/4.)),125.*cos(i*(pi/4.)),-(5.+130./2.))
              );
 
      solidFasteners1 = FastenersUnion;
  }

  G4UnionSolid* solidFasteners2 = new G4UnionSolid(
      "solidFasteners2",
      solidFasteners1,
      solidFasteners_up,
      0,
      G4ThreeVector(0,0,-(10.+130.))
      );
  
  G4UnionSolid* solidFasteners = new G4UnionSolid(
      "sFasteners",
      solidFasteners2,
      solidFasteners_up1,
      0,
      G4ThreeVector(0,0,-(10.+130.+25.))
      );

  logicFasteners = new G4LogicalVolume(
      solidFasteners, 
      Copper, 
      "lFasteners",
      0,
      0,
      0);
     
  G4VisAttributes* fasteners_visatt = new G4VisAttributes(G4Colour(1.0, 0, 1.0));
  fasteners_visatt -> SetForceWireframe(true);  
  fasteners_visatt -> SetForceAuxEdgeVisible(true);
  //fasteners_visatt -> SetForceSolid(true);
  //fasteners_visatt -> SetForceLineSegmentsPerCircle(4);
  logicFasteners -> SetVisAttributes(fasteners_visatt);


}


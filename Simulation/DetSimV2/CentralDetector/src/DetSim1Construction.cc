#include "DetSim1Construction.hh"
#include "G4Material.hh"
#include "G4LogicalVolume.hh"
#include "G4PVPlacement.hh"
#include "G4Sphere.hh"
#include "G4Tubs.hh"
#include "G4VisAttributes.hh"
#include "RoundBottomFlaskSolidMaker.hh"
#include "G4Element.hh"

#include "SniperKernel/SniperPtr.h"
#include "SniperKernel/ToolFactory.h"
#include "SniperKernel/SniperLog.h"

#include "DetSimAlg/DetSimAlg.h"
#include "DetSimAlg/IDetElement.h"
#include "DetSimAlg/IPMTElement.h"
#include "Geometry/PMTParamSvc.h"
#include "G4UnionSolid.hh"
#include "G4Box.hh"
#include "G4Element.hh"
#include "G4MaterialPropertiesTable.hh"
#include "G4Torus.hh"

DECLARE_TOOL(DetSim1Construction);

				DetSim1Construction::DetSim1Construction(const std::string& name)
: ToolBase(name),
				solidReflector(0), logicReflector(0),
				solidWaterPool(0), logicWaterPool(0), physiWaterPool(0),
				solidAcrylic(0), logicAcrylic(0), physiAcrylic(0)
{

				declProp("UseChimney", m_use_chimney = true);
				declProp("CheckOverlap", m_check_overlap = false);
}

DetSim1Construction::~DetSim1Construction() {

}

G4LogicalVolume* 
DetSim1Construction::getLV() {
				if (logicReflector) {
								return logicReflector;
				}
				initVariables();
				initMaterials();

				if (m_use_chimney) {
								makeReflectorChimneyLogical();
								makeWPWithChimneyLogical();
								makeAcrylicWithChimneyLogical();
								makeLSWithChimneyLogical();
				} else {
								makeReflectorLogical();
								makeWPLogical();
								makeAcrylicLogical();
								makeLSLogical();
				}
				makeWPPhysical();
				makeAcrylicPhysical();
				makeLSPhysical();
				makeSensorLogical();
				makeSensorPhysical();

				return logicReflector;
}

bool
DetSim1Construction::inject(std::string motherName, IDetElement* other, IDetElementPos* pos) {
				// Get the mother volume in current DetElem.
				G4LogicalVolume* mothervol = 0;
				if ( motherName == "lWaterPool" or motherName =="OuterWaterVeto" or motherName == "3inchInnerWater" or motherName == "20inchInnerWater") {
								mothervol = logicWaterPool;
				} else if ( motherName == "lTarget" ) {
								mothervol = logicTarget;
				}
				if (not mothervol) {
								// don't find the volume.
								return false;
				}
				LogDebug << "The mother volume is " << mothervol->GetName() << std::endl;

				// retrieve the daughter's LV
				G4LogicalVolume* daughtervol = 0;

				// if other is NULL, assume it's 20inch PMT mixing mode.
				IPMTElement* pmt_elem_r12860 = 0; // R12860 w/ or w/o mask
				IPMTElement* pmt_elem_nnvt = 0; // NNVT w/ or w/o mask
				if (!other) {
								// retrieve
								// * get detsimalg 
								// * get pmt elem
								SniperPtr<DetSimAlg> detsimalg(getScope(), "DetSimAlg");
								if (detsimalg.invalid()) {
												LogError << "Can't Load DetSimAlg" << std::endl;
												return false;
								}
								pmt_elem_r12860 = dynamic_cast<IPMTElement*>(detsimalg->findTool("HamamatsuR12860")); // need to define the official name
								pmt_elem_nnvt = dynamic_cast<IPMTElement*>(detsimalg->findTool("NNVTMCPPMT"));

								LogInfo << "Mixing PMT mode: " << std::endl;
								LogInfo << "-> Get Hamamatsu R12860: " << pmt_elem_r12860 << std::endl;
								LogInfo << "-> Get NNVT MCPPMT: " << pmt_elem_nnvt << std::endl;

				} else {

								daughtervol = other->getLV();

								if (not daughtervol) {
												return false;
								}

								LogDebug << "The daughter volume ptr is " 
												<< daughtervol << std::endl;
								LogDebug << "The daughter volume name is " 
												<< daughtervol->GetName() << std::endl;
				}


				int copyno = 0;
				if (motherName == "OuterWaterVeto") {
								copyno = 30000;
				}else if (motherName == "3inchInnerWater") {
								copyno = 300000;
				}
				bool is_20inch_pmt = false;
				if (motherName == "20inchInnerWater") {
								is_20inch_pmt = true;
				}
				// FIXME: Skip the top PMTs
				// skip 7 PMTs when chimney is enabled
				//
				// * 2016.07.21
				//   We modify the input data directly, so could keep consistency.
				//
				// if (m_use_chimney and is_20inch_pmt and copyno<7) {
				//     while (pos->hasNext()) {
				//         if (m_use_chimney and is_20inch_pmt and copyno<7) {
				//             pos->next(),
				//             copyno++;
				//             continue;
				//         } else {
				//             break;
				//         }
				//     }
				//     // reset the copyno to 0
				//     copyno = 0;
				// }

				// * Supporting different PMTs in simulation.
				//   Instead of passing another PMT's detelem pointer, we just retrieve 
				//   it from DetSimAlg directly. The default LPMT is NNVT MCP-PMT. 
				//   So here, pointer of NNVT MCP-PMT is passed with detelem, 
				//   while pointer of Hamamatsu PMT is got from DetSimAlg.
				//    
				//   -- Tao Lin, 2017.05.27
				PMTParamSvc* pmt_param_svc = 0;
				if (is_20inch_pmt) {
								SniperPtr<PMTParamSvc> svc(getScope(), "PMTParamSvc");
								if (svc.invalid()) {
												LogError << "Can't get PMTParamSvc. We can't initialize PMT." << std::endl;
												assert(0);
								} else {
												LogInfo << "Retrieve PMTParamSvc successfully." << std::endl;
												pmt_param_svc = svc.data();
								}
				}

				while (pos->hasNext()) {

								if (!daughtervol and is_20inch_pmt and pmt_param_svc) {
												// For LPMTs, Hamamatsu and NNVT 
												G4LogicalVolume* daughter_pmt = 0;
												G4String daughter_pmt_name = "pLPMT"; // prefix
												// check
												if (pmt_param_svc->isHamamatsu(copyno)) {
																// select Hamamatsu
																LogTest << "PMTID " << copyno << " is Hamamatsu PMT. " << std::endl;  
																daughter_pmt = pmt_elem_r12860->getLV();
																daughter_pmt_name += "_Hamamatsu_R12860";
												} else if (pmt_param_svc->isNNVT(copyno)) {
																daughter_pmt = pmt_elem_nnvt->getLV();
																daughter_pmt_name += "_NNVT_MCPPMT";
												}
												new G4PVPlacement(
																				pos->next(),
																				daughter_pmt,
																				daughter_pmt_name,
																				mothervol,
																				false,
																				copyno++,
																				m_check_overlap // check overlap
																				);
								} else {
												if (!daughtervol) {
																LogError << "can't construct daughter volume." << std::endl;
												}
												new G4PVPlacement(
																				pos->next(),
																				daughtervol,
																				daughtervol->GetName()+"_phys",
																				mothervol,
																				false,
																				copyno++,
																				m_check_overlap // check overlap
																				);
								}
				}
				if(motherName == "lWaterPool" or motherName=="20inchInnerWater") {
								G4cout<<"PMT_Acrylic_Number = "<<copyno<<G4endl;
				} else if (motherName == "3inchInnerWater") {
								G4cout<<"3inch PMT Number: = "<<copyno-300000<<G4endl;
				} else {
								G4cout<<"Veto_PMT_Number = "<<copyno-30000<<G4endl;
				}


				return true;
}

void
DetSim1Construction::initVariables() {
				SniperPtr<DetSimAlg> detsimalg(getScope(), "DetSimAlg");
				if (detsimalg.invalid()) {
								std::cout << "Can't Load DetSimAlg" << std::endl;
								assert(0);
				}
				ToolBase* t = detsimalg->findTool("GlobalGeomInfo");
				assert(t);
				IDetElement* globalinfo = dynamic_cast<IDetElement*>(t);

				m_radLS = 17.7*m;
				m_thicknessAcrylic = 12.*cm;
				m_radAcrylic = m_radLS + m_thicknessAcrylic;

				m_radWP = globalinfo->geom_info("WaterPool.R"); // This value will be changed in the future
				m_heightWP = globalinfo->geom_info("WaterPool.H");

				//    m_ChimneyTopToCenter = m_heightWP/2;
				//    m_radLSChimney = 0.25*m;
				m_radLSChimney = 0.4*m;
				m_radAcrylicChimney  = m_radLSChimney + m_thicknessAcrylic;
				m_ChimneyTopToCenter = m_radLS+m_thicknessAcrylic;
				//m_ChimneyBoxOuterHeight = 21*cm +5*mm*2 + 2*mm*2;
				// == inner water buffer ==
				// the water buffer should be different from the Outer water pool.
				// FIXME what's the radius of the inner water?
				//m_radInnerWater = 20.25*m;;
				m_radInnerWater = 20.05*m; // inner radius of latticed shell
				// BUG?: m_radInnerWaterChimney = m_radLSChimney + 1*cm;
				m_radInnerWaterChimney = m_radAcrylicChimney + 1*cm;

				// FIXME: wha't the thickness of reflector
				m_thicknessReflector = 2*mm;
				m_radReflector = m_radInnerWater + m_thicknessReflector;
				m_radReflectorChimney = m_radInnerWaterChimney + m_thicknessReflector;
}

void 
DetSim1Construction::initMaterials() {
				Copper = G4Material::GetMaterial("Copper");
				LS = G4Material::GetMaterial("LS");
				Steel = G4Material::GetMaterial("Steel");
				Water = G4Material::GetMaterial("Water");
				Acrylic = G4Material::GetMaterial("Acrylic");
				Tyvek = G4Material::GetMaterial("Tyvek");
				Teflon = G4Material::GetMaterial("Teflon");
				double a =55.845*g/mole;
				double ncomponents;
				double natoms;
				G4Element* elFe = new G4Element("Ferrum","Fe",26,a);
				G4double density = 3.035*g/cm3;
				Sensor_Steel = new G4Material("Sensor_Steel",density,ncomponents=1);
				Sensor_Steel->AddElement(elFe,natoms=1);
}

void 
DetSim1Construction::makeReflectorLogical() {
				solidReflector = new G4Sphere("sReflectorInCD",
												0*m,
												m_radReflector,
												0.*deg,
												360*deg,
												0.*deg,
												180.*deg);

				logicReflector = new G4LogicalVolume(solidReflector,
												Tyvek,
												"lReflectorInCD",
												0,
												0,
												0);

}

void
DetSim1Construction::makeReflectorChimneyLogical() {
				RoundBottomFlaskSolidMaker rbfs("sReflectorInCD",
												m_radReflector,             // 
												m_radReflectorChimney,      // 
												m_heightWP/2,
												TOPTOEQUATORH);
				solidReflector = rbfs.getSolid();

				logicReflector = new G4LogicalVolume(solidReflector,
												Tyvek,
												"lReflectorInCD",
												0,
												0,
												0);
				G4VisAttributes* visatt = new G4VisAttributes(G4Colour(0.5, 0., 0.5));
				visatt -> SetForceWireframe(true);  
				visatt -> SetForceAuxEdgeVisible(true);
				//visatt -> SetForceSolid(true);
				//visatt -> SetForceLineSegmentsPerCircle(4);
				logicReflector -> SetVisAttributes(visatt);

}

void
DetSim1Construction::makeWPLogical() {
				solidWaterPool = new G4Sphere("sInnerWater",
												0*m,
												m_radInnerWater,
												0.*deg,
												360*deg,
												0.*deg,
												180.*deg);

				logicWaterPool = new G4LogicalVolume(solidWaterPool,
												Water,
												"lInnerWater",
												0,
												0,
												0);
}

void
DetSim1Construction::makeWPWithChimneyLogical() {
				RoundBottomFlaskSolidMaker rbfs("sInnerWater",
												m_radInnerWater,
												m_radInnerWaterChimney,
												m_heightWP/2,
												TOPTOEQUATORH);
				solidWaterPool = rbfs.getSolid();

				logicWaterPool = new G4LogicalVolume(solidWaterPool,
												Water,
												"lInnerWater",
												0,
												0,
												0);
				G4VisAttributes* visatt = new G4VisAttributes(G4Colour(0.5, 0.8, 0.5));
				visatt -> SetForceWireframe(true);  
				visatt -> SetForceAuxEdgeVisible(true);
				//visatt -> SetForceSolid(true);
				//visatt -> SetForceLineSegmentsPerCircle(4);
				logicWaterPool -> SetVisAttributes(visatt);
}

void
DetSim1Construction::makeWPPhysical() {
				physiWaterPool = new G4PVPlacement(0,
												G4ThreeVector(0,0,0),
												logicWaterPool,
												"pInnerWater",
												logicReflector,
												false,
												0);
}

void
DetSim1Construction::makeAcrylicLogical() {
				solidAcrylic = new G4Sphere("sAcrylic",
												0*m,
												m_radAcrylic,
												0.*deg, 
												360.*deg, 
												0.*deg, 
												180.*deg);
				logicAcrylic = new G4LogicalVolume(solidAcrylic, 
												Acrylic, 
												"lAcrylic",
												0,
												0,
												0);

				G4VisAttributes* acrylic_visatt = new G4VisAttributes(G4Colour(0, 0, 1.0));
				acrylic_visatt -> SetForceWireframe(true);  
				acrylic_visatt -> SetForceAuxEdgeVisible(true);
				//acrylic_visatt -> SetForceSolid(true);
				//acrylic_visatt -> SetForceLineSegmentsPerCircle(4);
				logicAcrylic -> SetVisAttributes(acrylic_visatt);
}

void
DetSim1Construction::makeAcrylicPhysical() {
				physiAcrylic = new G4PVPlacement(0,              // no rotation
												G4ThreeVector(0,0,0), // at (x,y,z)
												logicAcrylic,    // its logical volume 
												"pAcylic",       // its name
												logicWaterPool,  // its mother  volume
												false,           // no boolean operations
												0);              // no particular field
}

void
DetSim1Construction::makeLSLogical() {

				solidTarget = new G4Sphere("sTarget", 
												0*m, 
												m_radLS, 
												0.*deg, 
												360.*deg, 
												0.*deg, 
												180.*deg);
				logicTarget = new G4LogicalVolume(solidTarget, 
												LS, 
												"lTarget",
												0,
												0,
												0);

}

void
DetSim1Construction::makeLSPhysical() {
				physiTarget = new G4PVPlacement(0,              // no rotation
												G4ThreeVector(0,0,0), // at (x,y,z)
												logicTarget,    // its logical volume 
												"pTarget",       // its name
												logicAcrylic,  // its mother  volume
												false,           // no boolean operations
												0);              // no particular field

				//----------------------- This is about USS receiver-------------------------------------------------------

				G4Tubs *solidUSSPTFE = new G4Tubs("sUSSBeCu",0,5*mm,5*cm,0,360*deg);
				G4LogicalVolume* logicUSSPTFE = new G4LogicalVolume(solidUSSPTFE,Teflon,"lUSSPTFE",0,0,0);

				G4RotationMatrix *pRot = new G4RotationMatrix();
				pRot->rotateY(90.*deg);

				new G4PVPlacement(pRot,G4ThreeVector(17649*mm,0,0),logicUSSPTFE,"pUSSPTFE",logicTarget,false,0);

				G4Tubs *solidUSSBeCu = new G4Tubs("sUSSBeCu",0,5*mm,0.05*mm,0,360*deg);
				G4LogicalVolume* logicUSSBeCu = new G4LogicalVolume(solidUSSBeCu,Copper,"lUSSBeCu",0,0,0);
				new G4PVPlacement(0,G4ThreeVector(0,0,49.95*mm),logicUSSBeCu,"pUSSBeCu",logicUSSPTFE,false,0);


				//------------------------ USS cables---------------------------------------------------------------------
				// the cable includes wire0, wire1, wire2, wire3, four layers.

				double distance = 30*cm;
				G4Torus* solidUSSWire0 = new G4Torus("wire0",
												0.*mm,
												0.14*mm,
												17698.985*mm - distance,
												5.*degree,
												5.*degree
												);
				G4LogicalVolume* logicWire0 = new G4LogicalVolume(solidUSSWire0,
												Copper,
												"lwire0",
												0,
												0,
												0);

				G4PVPlacement* physicsWire0 = new G4PVPlacement(0,
												G4ThreeVector(0,0,0),
												logicWire0,
												"pwire0",
												logicTarget,
												false,
												0);

				//--------------------------------------------------------------------------

				G4Torus* solidUSSWire1 = new G4Torus("wire1",
												0.14*mm,
												0.445*mm,
												17698.985*mm - distance,
												5.*degree,
												5.*degree
												);
				G4LogicalVolume* logicWire1 = new G4LogicalVolume(solidUSSWire1,
												Teflon,
												"lwire1",
												0,
												0,
												0 );
				G4PVPlacement* physicsWire1 = new G4PVPlacement(0,
												G4ThreeVector(0,0,0),
												logicWire1,
												"pwire1",
												logicTarget,
												false,
												0);

				//--------------------------------------------------------------------------
				//--------------------------------------------------------------------------

				G4Torus* solidUSSWire2 = new G4Torus("wire2",
												0.445*mm,
												0.685*mm,
												17698.985*mm - distance,
												5.*degree,
												5.*degree
												);
				G4LogicalVolume* logicWire2 = new G4LogicalVolume(solidUSSWire2,
												Copper,
												"lwire2",
												0,
												0,
												0 );
				G4PVPlacement* physicsWire2 = new G4PVPlacement(0,
												G4ThreeVector(0,0,0),
												logicWire2,
												"pwire2",
												logicTarget,
												false,
												0);

				//--------------------------------------------------------------------------
				//--------------------------------------------------------------------------

				G4Torus* solidUSSWire3 = new G4Torus("wire3",
												0.685*mm,
												1.015*mm,
												17698.985*mm - distance,
												5.*degree,
												5.*degree
												);
				G4LogicalVolume* logicWire3 = new G4LogicalVolume(solidUSSWire3,
												Teflon,
												"lwire3",
												0,
												0,
												0);
				G4PVPlacement* physicsWire3 = new G4PVPlacement(0,
												G4ThreeVector(0,0,0),
												logicWire3,
												"pwire3",
												logicTarget,
												false,
												0);

				//--------------------------CLS cable---------------------------------------------------------------------
				//  includes cable1 and cable2 respectively for 46 degree, and 76 degree.

				G4Element* Fe = new G4Element("Iron", "Fe", 26., 55.845*g/mole);
				G4Element* Cr = new G4Element("Cr", "Cr", 24, 51.9961*g/mole);
				G4Element* Ni = new G4Element("Ni", "Ni", 28, 58.6934*g/mole);

				G4Material* CLSCable = new G4Material("CLSCable",4.8*g/cm3,3);
				CLSCable->AddElement(Fe, 0.7);
				CLSCable->AddElement(Cr, 0.2);
				CLSCable->AddElement(Ni, 0.1);
				G4MaterialPropertiesTable* SteelMPT = new G4MaterialPropertiesTable();
				double fPP_SteelTank[4] = {1.55*eV, 6.20*eV, 10.33*eV, 15.50*eV};
				double fSteelTankABSORPTION[4] = {1.E-3*mm, 1.E-3*mm, 1.E-3*mm, 1.E-3*mm};
				SteelMPT->AddProperty("ABSLENGTH", fPP_SteelTank, fSteelTankABSORPTION, 4);
				double SSDiameter = 1*mm;

				//--------------cls cable1------------------------------
				double theta1 = 46;
				double CLS1L = 2*17.7*m*sin(theta1/2/180*3.141592654);
				double slope1 = (180 - theta1)/2;
				G4Tubs *solidCLS1SS = new G4Tubs("sCLS1SS",0,SSDiameter/2,CLS1L/2.0,0,360*deg);
				G4LogicalVolume* logicCLS1SS = new G4LogicalVolume(solidCLS1SS,CLSCable,"lCLS1SS",0,0,0);
				G4RotationMatrix *pRot1 = new G4RotationMatrix();
				pRot1->rotateY(-slope1*deg);
				double X1 = 17.7*m*cos(theta1/2/180*3.141592654)*sin(theta1/2/180*3.141592654);
				double Z1 = 17.7*m*cos(theta1/2/180*3.141592654)*cos(theta1/2/180*3.141592654);
				new G4PVPlacement(pRot1,G4ThreeVector(-X1,0,Z1),logicCLS1SS,"pCLS1Cable",logicTarget,false,0);


				//--------------cls cable2------------------------------
				double theta2 = 76;
				double CLS2L = 2*17.7*m*sin(theta2/2/180*3.141592654);
				double slope2 = (180 - theta2)/2;
				G4Tubs *solidCLS2SS = new G4Tubs("sCLS2SS",0,SSDiameter/2,CLS2L/2.0,0,360*deg);
				G4LogicalVolume* logicCLS2SS = new G4LogicalVolume(solidCLS2SS,CLSCable,"lCLS2SS",0,0,0);
				G4RotationMatrix *pRot2 = new G4RotationMatrix();
				pRot2->rotateY(slope2*deg);
				double X2 = 17.7*m*cos(theta2/2/180*3.141592654)*sin(theta2/2/180*3.141592654);
				double Z2 = 17.7*m*cos(theta2/2/180*3.141592654)*cos(theta2/2/180*3.141592654);
				new G4PVPlacement(pRot2,G4ThreeVector(X2,0,Z2),logicCLS2SS,"pCLS2Cable",logicTarget,false,0);

				//-----------------------CLS anchor1 ---------------------------------------------------------------------

				double anchorD = 90*mm;
				double anchorL = 116*mm;
				double anchorH = 100*mm;

				G4Tubs *solidAnchor1 = new G4Tubs("sAnchor1",0,anchorD/2,anchorH/2,-90,180*deg);
				G4Box *solidAnchor2 = new G4Box("sAnchor2",anchorL/2,anchorD/2,anchorH/2);
				G4UnionSolid* solidAnchor = new G4UnionSolid("sAnchor", solidAnchor1, solidAnchor2,0 ,G4ThreeVector(-anchorL/2,0,0));
				G4LogicalVolume* logicAnchor = new G4LogicalVolume(solidAnchor,Teflon,"lAnchor",0,0,0);
				new G4PVPlacement(0,G4ThreeVector(-17583,0,0),logicAnchor,"pAnchor",logicTarget,false,0);


}

void
DetSim1Construction::makeAcrylicWithChimneyLogical() {
				RoundBottomFlaskSolidMaker rbfs("sAcrylic",
												m_radAcrylic,
												m_radAcrylicChimney,
												m_ChimneyTopToCenter,
												TOPTOEQUATORH);
				solidAcrylic = rbfs.getSolid();
				logicAcrylic = new G4LogicalVolume(solidAcrylic, 
												Acrylic, 
												"lAcrylic",
												0,
												0,
												0);

				G4VisAttributes* acrylic_visatt = new G4VisAttributes(G4Colour(0, 0, 1.0));
				acrylic_visatt -> SetForceWireframe(true);  
				acrylic_visatt -> SetForceAuxEdgeVisible(true);
				//acrylic_visatt -> SetForceSolid(true);
				//acrylic_visatt -> SetForceLineSegmentsPerCircle(4);
				logicAcrylic -> SetVisAttributes(acrylic_visatt);

}

void
DetSim1Construction::makeLSWithChimneyLogical() {
				RoundBottomFlaskSolidMaker rbfs("sTarget",
												m_radLS,
												m_radLSChimney,
												m_ChimneyTopToCenter,
												TOPTOEQUATORH);
				solidTarget = rbfs.getSolid();
				logicTarget = new G4LogicalVolume(solidTarget, 
												LS, 
												"lTarget",
												0,
												0,
												0);

				G4VisAttributes* visatt = new G4VisAttributes(G4Colour(0, 1.0, 0));
				visatt -> SetForceWireframe(true);  
				visatt -> SetForceAuxEdgeVisible(true);
				//visatt -> SetForceSolid(true);
				//visatt -> SetForceLineSegmentsPerCircle(4);
				logicTarget -> SetVisAttributes(visatt);

}

void
DetSim1Construction::makeSensorLogical() {
				m_radEnclosure = 36./2.*mm;
				m_halfHeightEnclosure = 49./2.*mm;
				m_radSensor = 18./2.*mm;
				m_halfHeightSensor = 45./2.*mm;

				solidSensor    = new G4Tubs("sSensor",0,m_radSensor,m_halfHeightSensor,0,360*deg);
				logicSensor    = new G4LogicalVolume(solidSensor, Sensor_Steel, "lSensor" ,0,0,0);
				solidEnclosure = new G4Tubs("sEnclosure",0,m_radEnclosure,m_halfHeightEnclosure,0,360*deg);
				logicEnclosure = new G4LogicalVolume(solidSensor, Teflon, "lEnclosure" ,0,0,0);
}

void
DetSim1Construction::makeSensorPhysical() {
				double theta[10] = {5.60,20,42.5,59.00,75.5,90,104.5,121,137.5,160};
				for(int i=0;i<10;i++){
								char buff[20];
								G4double radius = 17.829*m+9.45*mm+m_halfHeightEnclosure;
								CLHEP::HepRotation rot;
								rot.rotateY(90*deg);
								rot.rotateZ(theta[i]*deg);
								G4ThreeVector pos = G4ThreeVector(radius*std::cos(theta[i]*deg),radius*std::sin(theta[i]*deg),0);
								G4Transform3D tr = G4Transform3D(rot,pos);
								posEnclosure[i] = tr;
								sprintf(buff,"pEnclosure%d",i);
								physiEnclosure[i] = new G4PVPlacement(
																tr,
																logicEnclosure,
																buff,
																logicWaterPool,
																false,
																0
																);
								sprintf(buff,"pSensor%d",i);
								physiSensor[i] = new G4PVPlacement(
																0,G4ThreeVector(),
																logicSensor,
																buff,
																logicEnclosure,
																false,
																0
																);
				}
}

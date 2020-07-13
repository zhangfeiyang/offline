#include "TopTrackerConstruction.hh"
#include "G4Material.hh"
#include "G4LogicalVolume.hh"
#include "G4PVPlacement.hh"
#include "G4Box.hh"
#include "G4Tubs.hh"
#include "G4SubtractionSolid.hh"
#include "G4VisAttributes.hh"
#include "G4RegionStore.hh"

#include "SniperKernel/SniperPtr.h"
#include "SniperKernel/ToolFactory.h"
#include <exception>

DECLARE_TOOL(TopTrackerConstruction);

TopTrackerConstruction::TopTrackerConstruction(const std::string& name)
    : ToolBase(name)
{
    logicAirTT = 0;
    initVariables();
   
}

TopTrackerConstruction::~TopTrackerConstruction() {
  
}

G4LogicalVolume* 
TopTrackerConstruction::getLV() {
  // if already initialized
  if (logicAirTT) {
    return logicAirTT;
  }
  initMaterials();
  
  makeAirTTLogical();
  
  makeWallLogical();
  makePlaneLogical();
  makeModuleLogical();
  makeModuleTapeLogical();
  makeCoatingLogical();
  makeStripLogical();
  
  makeWallPhysical();
  makePlanePhysical();
  makeModulePhysical();
  makeModuleTapePhysical();
  makeCoatingPhysical();
  makeStripPhysical();
  
  return logicAirTT;
}

bool
TopTrackerConstruction::inject(std::string motherName, IDetElement* other, IDetElementPos* /*pos*/) {
  // Get the mother volume in current DetElem.
  G4LogicalVolume* mothervol = 0;
  if ( motherName == "lAirTT" ) {
    mothervol = logicAirTT;
  }
  if (not mothervol) {
    // don't find the volume.
    return false;
  }
  
  // retrieve the daughter's LV
  G4LogicalVolume* daughtervol = other->getLV();
  
  if (not daughtervol) {
    return false;
  }
  
  
  return true;
}

double 
TopTrackerConstruction::geom_info(const std::string& param, const int wallnumber)
{
  if (param == "Wall.X") {
    return m_wall_posx[wallnumber];
  } else if (param == "Wall.Y") {
    return m_wall_posy[wallnumber];
  } else if (param == "Wall.Z") {
    return m_wall_posz[wallnumber];
  } else if (param == "Wall.Layer") {
    return m_wall_layer[wallnumber];
  }  else if (param == "Wall.Column") {
    return m_wall_column[wallnumber];
  }  else if (param == "Wall.Row") {
    return m_wall_row[wallnumber];
  } else if (param == "Mod.XY") {
    return m_mod_posxy[wallnumber];
  } else if (param == "Bar.XY") {
    return m_bar_posxy[wallnumber];
  } else if (param == "Plane.Z") {
    return m_plane_posz[wallnumber];
  }
  
  else {
    // don't recognize, throw exception
    throw std::invalid_argument("Unknown param: "+param);
  }
}

void
TopTrackerConstruction::initVariables() {
  
  
  m_box_x= 48./2.*m;
  m_box_y= 48./2.*m;
  m_box_z= 5/2.*m;
  
  m_chimney_R=50*cm;
  m_chimney_Z=2.0*m;
  // the designed chimney radius is 40cm, the chimney height above the water is ~3.5m.
  
  m_lengthBar= 686/2.*cm;
  m_thicknessBar= 1/2.*cm;
  m_widthBar= 2.6/2.*cm;
  m_spaceBar=0.01*cm;
  
  m_lengthCoating= 686/2.*cm;
  m_thicknessCoating= 1.03/2.*cm;
  m_widthCoating= 2.63/2.*cm;
  
  m_lengthModuleTape=686/2.*cm;
  m_thicknessModuleTape=1.21/2.*cm;
  m_widthModuleTape=169.13/2.*cm;
  
  m_lengthModule=686.12/2.*cm;
  m_thicknessModule=1.33/2.*cm;
  m_widthModule=169.25/2.*cm;
  m_spaceModule=0.01*cm;
  
  m_lengthPlane=686.12/2.*cm;
  m_thicknessPlane=1.33/2.*cm;
  m_widthPlane=677.03/2.*cm;
  m_vspacePlane=0.1*cm;
  
  m_wall_x=686.12/2.*cm;
  m_wall_y=686.12/2.*cm;
  m_wall_z= 2.76/2.*cm;
  
  m_zlowerwall=-0.855*m;
  m_zshift=5*cm;
  m_zspace=1.5*m;
  m_zspaceChimney=1.5*m;
  m_xspace=-15.*cm;
  m_xspace1=-10.*cm;
  m_yspace=-15.*cm;
  m_xhole=200*cm;
  m_zlowerwallChimney=50*cm;
  
  //IsOverlap = true;
  IsOverlap = false;
  
}

void 
TopTrackerConstruction::initMaterials() {
  Aluminium = G4Material::GetMaterial("Aluminium");
  Scintillator = G4Material::GetMaterial("Scintillator");
  Adhesive = G4Material::GetMaterial("Adhesive");
  TiO2Coating = G4Material::GetMaterial("TiO2Coating");
  Air = G4Material::GetMaterial("Air");
  
}

void
TopTrackerConstruction::makeAirTTLogical() {
  BoxsolidAirTT = new G4Box("BoxsAirTT",
			    m_box_x,
			    m_box_y,
			    m_box_z);
  
  solidChimney = new G4Tubs("Cylinder",
			    0,
			    m_chimney_R,
			    m_chimney_Z,
			    0,
			    twopi); 
  
  G4ThreeVector zTrans(0, 0,-m_box_z + m_chimney_Z);
  
  solidAirTT =  new G4SubtractionSolid("sAirTT",
				       BoxsolidAirTT,
				       solidChimney,
				       0,
				       zTrans);
  
  
  logicAirTT = new G4LogicalVolume(solidAirTT,
				   Air,
				   "lAirTT",
				   0,
				   0,
				   0);
}

void
TopTrackerConstruction::makeStripLogical() {
  
  solidBar = new G4Box("sBar",
		       m_lengthBar,
		       m_widthBar,
		       m_thicknessBar);
  
  logicBar = new G4LogicalVolume(solidBar,
				 Scintillator,
				 "lBar",
				 0,
				 0,
				 0);
  
}
void
TopTrackerConstruction::makeStripPhysical() {
  
  
  physiBar = new G4PVPlacement(0,              // no rotation
			       G4ThreeVector(0,0,0), // at (x,y,z)
			       logicBar,    // its logical volume
			       "pBar",       // its name
			       logicCoating,  // its mother  volume
			       false,           // no boolean operations
			       0,
			       IsOverlap);              // no particular field
  
}
void
TopTrackerConstruction::makeCoatingLogical() {
  
  solidCoating = new G4Box("sBar",
			   m_lengthCoating,
			   m_widthCoating,
			   m_thicknessCoating);
  
  logicCoating = new G4LogicalVolume(solidCoating,
				     TiO2Coating,
				     "lCoating",
				     0,
				     0,
				     0);
  
}
void
TopTrackerConstruction::makeCoatingPhysical() {
  
  char modname[30];
  double y0(0);
  double yy(0);
  
  y0=-(64*2*m_widthCoating + 63*m_spaceBar)/2. + m_widthCoating;
  
  for(int jj=0;jj<64;jj++) {
    
    sprintf(modname,"pCoating%i",jj);
    
    yy=y0+jj * (m_spaceBar + 2*m_widthCoating);
    
    physiCoating[jj] = new G4PVPlacement(0,              // no rotation
					 G4ThreeVector(0,yy,0), // at (x,y,z)
					 logicCoating,    // its logical volume
					 modname,       // its name
					 logicModuleTape,  // its mother  volume
					 false,           // no boolean operations
					 jj,  //copy number
					 IsOverlap);
    
    m_bar_posxy[jj]=yy;
    
    
  }
  
}

void
TopTrackerConstruction::makeModuleTapeLogical() {
  
  solidModuleTape = new G4Box("sModuleTape",
			      m_lengthModuleTape,
			      m_widthModuleTape,
			      m_thicknessModuleTape);
  
  logicModuleTape = new G4LogicalVolume(solidModuleTape,
					Adhesive,
					"lModuleTape",
					0,
					0,
					0);
  
}
void
TopTrackerConstruction::makeModuleTapePhysical() {
  
  
  physiModuleTape = new G4PVPlacement(0,              // no rotation
				      G4ThreeVector(0,0,0), // at (x,y,z)
				      logicModuleTape,    // its logical volume
				      "pModuleTape",       // its name
				      logicModule,  // its mother  volume
				      false,           // no boolean operations
				      0,
				      IsOverlap);              // no particular field
  
}

void
TopTrackerConstruction::makeModuleLogical() {
  
  solidModule = new G4Box("sModule",
			  m_lengthModule,
			  m_widthModule,
			  m_thicknessModule);
  
  logicModule = new G4LogicalVolume(solidModule,
				    Aluminium,
				    "lModule",
				    0,
				    0,
				    0);
  
}

void
TopTrackerConstruction::makeModulePhysical() {
  
  char modname[30];
  double y0(0);
  double yy(0);
  
  y0=-(4*2*m_widthModule + 3*m_spaceModule)/2. + m_widthModule;
  
  for(int jj=0;jj<4;jj++) {
    
    sprintf(modname,"pModule%i",jj);
    
    yy=y0+jj * (m_spaceModule + 2*m_widthModule);
    
    physiModule[jj] = new G4PVPlacement(0,              // no rotation
					G4ThreeVector(0,yy,0), // at (x,y,z)
					logicModule,    // its logical volume
					modname,       // its name
					logicPlane,  // its mother  volume
					false,           // no boolean operations
					jj,  //copy number
					IsOverlap);
       
    m_mod_posxy[jj]=yy;
    
  }
  
}
void
TopTrackerConstruction::makePlaneLogical() {
  
  solidPlane = new G4Box("sPlane",
                         m_lengthPlane,
                         m_widthPlane,
                         m_thicknessPlane);
  
  logicPlane = new G4LogicalVolume(solidPlane,
                                   Air,
                                   "lPlane",
                                   0,
                                   0,
                                   0);
  
}

void
TopTrackerConstruction::makePlanePhysical() {
  
  char modname[30];
  double z0(0);
  double zz(0);
  
  z0=-(2*2*m_thicknessPlane + m_vspacePlane)/2. + m_thicknessPlane;
  
  G4RotationMatrix MRot;
  MRot.rotateZ(-M_PI/2.*rad); 
  
  for(int jj=0;jj<2;jj++) {
    
    sprintf(modname,"pPlane%i",jj);
    
    zz=z0+jj * (m_vspacePlane + 2*m_thicknessPlane);
    if(jj==0) //bottom plane, "vertical walls"
      {
	physiPlane[jj] = new G4PVPlacement(
					   G4Transform3D(MRot,G4ThreeVector(0,0,zz)),
					   logicPlane,    // its logical volume
					   modname,       // its name
					   logicWall,  // its mother  volume
					   false,           // no boolean operations
					   jj,  //copy number
					   IsOverlap);
      }
    else  //upper plane, "horizontal planes"
      {
	physiPlane[jj] = new G4PVPlacement(
					   0,G4ThreeVector(0,0,zz),
					   logicPlane,    // its logical volume
					   modname,       // its name
					   logicWall,  // its mother  volume
					   false,           // no boolean operations
					   jj,  //copy number
					   IsOverlap);
      }
    
    m_plane_posz[jj]=zz;
  }
  
}

void
TopTrackerConstruction::makeWallLogical() {
  
  solidWall = new G4Box("sWall",
			m_wall_x,
			m_wall_y,
			m_wall_z);
  
  logicWall = new G4LogicalVolume(solidWall,
				  Air,
				  "lWall",
				  0,
				  0,
				  0);
  
}

void
TopTrackerConstruction::makeWallPhysical() {
  
  char modname[30];
  double z0(0);
  double zz(0);
  
  double x0(0);
  double xx(0);
  
  double y0(0);
  double yy(0);
    
  z0=m_zlowerwall;
  x0=-(3*2*m_wall_x+2*m_xspace)/2. + m_wall_x;
  y0=-(7*2*m_wall_y+6*m_yspace)/2. + m_wall_y;
  
  int volcnt(0);
  
  for(int vv=0;vv<2;vv++) {
    
    xx=x0+vv * (2*m_xspace + 4*m_wall_x);
    
    for(int uu=0;uu<7;uu++) {
      
      yy=y0+uu * (m_yspace + 2*m_wall_y);
      
      for(int jj=0;jj<3;jj++) {
	
	int ny(vv);
	if(vv==1)
	  ny=vv+1;
	
	sprintf(modname,"pWall%i",volcnt);
        
	if(uu%2==0)
	  zz=z0+jj * (m_zspace) + 2* m_zshift;
	else
	  zz=z0+jj * (m_zspace) + m_zshift;
	
        
	physiWall[volcnt] = new G4PVPlacement(0,              // no rotation
					      G4ThreeVector(xx,yy,zz), // at (x,y,z)
					      logicWall,    // its logical volume
					      modname,       // its name
					      logicAirTT,  // its mother  volume
					      false,           // no boolean operations
					      volcnt,              // no particular field
					      IsOverlap);
	
	
	m_wall_posx[volcnt]=xx;
	m_wall_posy[volcnt]=yy;
	m_wall_posz[volcnt]=zz;
	m_wall_layer[volcnt]=jj;
	if(vv==0)
	  m_wall_column[volcnt]=0;
	else if(vv==1)
	  m_wall_column[volcnt]=2;
	m_wall_row[volcnt]=uu;
	
	volcnt++;
	
      }
    }
  }
  
  
  //middle row  
  
  for(int uu=0;uu<7;uu++) {
    
    if(uu==3)
      continue;
    
    yy=y0+uu * (m_yspace + 2*m_wall_y);
    
    for(int jj=0;jj<3;jj++) {
      
      sprintf(modname,"pWall%i",volcnt);
      
      if(uu%2==0)
	zz=z0+jj * (m_zspace);
      else
	zz=z0+jj * (m_zspace) + 3*m_zshift;
      
      physiWall[volcnt] = new G4PVPlacement(0,              // no rotation
					    G4ThreeVector(0,yy,zz), // at (x,y,z)
					    logicWall,    // its logical volume
					    modname,       // its name
					    logicAirTT,  // its mother  volume
					    false,           // no boolean operations
					    volcnt,              // no particular field
					    IsOverlap);
      
      m_wall_posx[volcnt]=0;
      m_wall_posy[volcnt]=yy;
      m_wall_posz[volcnt]=zz;
      m_wall_layer[volcnt]=jj;
      m_wall_column[volcnt]=1;
      m_wall_row[volcnt]=uu;
      volcnt++;
      
    }
  }
  
  
  //chimney obsolete to be modified if needed!!!
  /*
    z0=m_zlowerwallChimney;
    
    for(int jj=0;jj<2;jj++) {
    
    //sprintf(modname,"pWall%i_%i_%i",0,0,jj+3);
    sprintf(modname,"pWall%i",volcnt);
    
    zz=z0+jj * (m_zspaceChimney);
    
    physiWall[volcnt] = new G4PVPlacement(0,              // no rotation
    G4ThreeVector(0,0,zz), // at (x,y,z)
    logicWall,    // its logical volume
    modname,       // its name
    logicAirTT,  // its mother  volume
    false,           // no boolean operations
    volcnt,              // no particular field
    IsOverlap);
    
    m_wall_posx[volcnt]=0;
    m_wall_posy[volcnt]=0;
    m_wall_posz[volcnt]=zz;
    
    volcnt++;
    
    }
  */
    
  /*	for(int oo=0;oo<volcnt;oo++)
	std::cout<<" position wall "<<oo<<" x "<<m_wall_posx[oo]<<" y "<<m_wall_posy[oo]<<" z "<<m_wall_posz[oo]<<std::endl;
  */
  
}



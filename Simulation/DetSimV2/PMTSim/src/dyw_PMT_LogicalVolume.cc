//-------------------------------------------------------------------
//                       8inch PMT Logical Volume
//--------------------------------------------------------------------
// Modified by: Weili Zhong, 2006/03/01
//--------------------------------------------------------------------
// This file is part of the GenericLAND software library.
// $Id: dyw_PMT_LogicalVolume.cc 1751 2007-10-13 01:11:37Z lou $
//
// GLG4_PMT_LogicalVolume.cc
// defines classes for constructing PMT assemblies for GenericLAND
// Original by Glenn Horton-Smith, Dec 1999
// Modification history:
//  G.H-S.  2001/03/20:  Added GLG4PMTOpticalModel for thin photocathode
// T.P. Lou 2007/10/12: Use boolean solids for the inner bodies of the PMT.
//                      This prevent the inner bodies from overlapping or
//                      overshooting.

#include "dyw_PMT_LogicalVolume.hh"
#include "dywPMTOpticalModel.hh"

#include "G4Material.hh"
#include "G4Tubs.hh"
#include "G4IntersectionSolid.hh" // for boolean solids
#include "G4SubtractionSolid.hh" // for boolean solids
#include "G4PVPlacement.hh"
#include "dywEllipsoid.hh"
#include "dywTorusStack.hh"
#include "G4VisAttributes.hh"               // for G4VisAttributes::Invisible
#include "G4OpticalSurface.hh"
#include "G4LogicalBorderSurface.hh"

G4OpticalSurface* dyw_PMT_LogicalVolume::our_Mirror_opsurf = NULL;

////////////////////////////////////////////////////////////////
// dyw_PMT_LogicalVolume
//
dyw_PMT_LogicalVolume::dyw_PMT_LogicalVolume
 ( const G4String& plabel, // label -- subvolume names are derived from this
   G4double r_bound,       // radius of bounding cylinder
   G4double hh_bound,      // half height of bounding cylinder
   G4Material* ExteriorMat // material which fills the bounding cylinder
  )
  : G4LogicalVolume( new G4Tubs
                     ( plabel+"_envelope_solid", 0.0, r_bound,
                       hh_bound, 0., 2.*M_PI ),
                    ExteriorMat,
                    plabel )
{
  if ( our_Mirror_opsurf == NULL )
    {
      // construct a static mirror surface with idealized properties
      our_Mirror_opsurf =  new G4OpticalSurface("Mirror_opsurf");
      our_Mirror_opsurf->SetFinish(polishedfrontpainted); // needed for mirror
      our_Mirror_opsurf->SetModel(glisur); 
      our_Mirror_opsurf->SetType(dielectric_metal); 
      our_Mirror_opsurf->SetPolish(0.999);              // a guess -- FIXME
      G4MaterialPropertiesTable* propMirror= NULL;
      G4Material *matMirror = G4Material::GetMaterial("PMT_Mirror");
      if (matMirror)
        propMirror= matMirror->GetMaterialPropertiesTable();
      if ( propMirror == NULL ) {
        G4cout << "Warning: setting PMT mirror reflectivity to 0.9999 because no PMT_Mirror material properties defined" << G4endl;
        propMirror= new G4MaterialPropertiesTable();
        propMirror->AddProperty("REFLECTIVITY", new G4MaterialPropertyVector());
        //propMirror->AddEntry("REFLECTIVITY", twopi*hbarc/(800.0e-9*m), 0.9999);
        //propMirror->AddEntry("REFLECTIVITY", twopi*hbarc/(200.0e-9*m), 0.9999);
        propMirror->AddEntry("REFLECTIVITY", 1.55*eV, 0.9999);
        propMirror->AddEntry("REFLECTIVITY", 15.5*eV, 0.9999);
      }
      our_Mirror_opsurf->SetMaterialPropertiesTable( propMirror );
    }
}


////////////////////////////////////////////////////////////////
// constants defining the (fixed by manufacturer) dimensions of the
// phototubes:
//

static const int R5912_n_edge= 6;
static const G4double R5912_z_edge[R5912_n_edge+1]= { 75.00, 53.06, 0.00, -53.06, -73.86, -85.00, -215.00};
static const G4double R5912_rho_edge[R5912_n_edge+1]= {0.00, 72.57, 101.00, 72.57, 44.32, 42.00, 42.00 };
static const G4double R5912_z_o[R5912_n_edge]= {     -56.00,  0.00,   0.00, 56.00, -85.00, -215.00 /* includes 20-pin connector at back */ };

////////////////////////////////////////////////////////////////
// dyw_8inch_LogicalVolume
//
dyw_8inch_LogicalVolume::dyw_8inch_LogicalVolume
    (const G4String& plabel, // label -- subvolume names are derived from this
     G4Material* ExteriorMat,// material which fills the bounding cylinder
     G4Material* GlassMat,   // glass material
     G4OpticalSurface* Photocathode_opsurf, // photocathode 
     G4Material* PMT_Vacuum, // vacuum inside tube
     G4Material* DynodeMat,  // dynode material
     G4Material* MaskMat,    // material for photocathode mask (e.g, blk acryl)
                             // OK to set MaskMat == NULL for no mask
     G4VSensitiveDetector *detector, // sensitive detector hook
     ePmtStyle PmtStyle      // PMT approx. style (TorusStack or Ellipsoid)
     )
: dyw_PMT_LogicalVolume(plabel,
                       110.*millimeter,
                       150.*millimeter,
                       ExteriorMat)
{
  if (PmtStyle == kPmtStyle_Ellipsoid) {
    ConstructPMT_UsingEllipsoid
     ( 102.*millimeter,       // equatorial radius of phototube
        75.*millimeter,       // height of face above eq.
       -75.*millimeter,       // depth of back below eq.
        32.*millimeter,       // radius of stem
       130.*millimeter,       // length of stem
       27.5*millimeter,       // radius of dynode stack
      -30.0*millimeter,       // z coordinate of top of dynode stack, equator=0
       3.  *millimeter,       // thickness of the walls
       ExteriorMat,                   // material outside tube
       GlassMat,                      // glass material
       Photocathode_opsurf,               // photocathode surface 
       PMT_Vacuum,                    // tube interior
       DynodeMat,                     // dynode stack metal
       detector                // detector hook
     );
  }
  else {
    ConstructPMT_UsingTorusStack
     ( R5912_n_edge,
       R5912_z_edge,
       R5912_rho_edge,
       R5912_z_o,
       27.5*millimeter,       // radius of dynode stack
      -30.0*millimeter,       // z coordinate of top of dynode stack, equator=0
       3.  *millimeter,       // thickness of the walls
       ExteriorMat,                   // material outside tube
       GlassMat,                      // glass material
       Photocathode_opsurf,               // photocathode surface 
       PMT_Vacuum,                    // tube interior
       DynodeMat,                     // dynode stack metal
       detector                // detector hook
     );
  }
  
  if (MaskMat != NULL) {
    // make the mask -- use thin cylindrical disk for now
    G4double r_mask_inner=  96.*millimeter;
    G4double r_mask_outer= ((G4Tubs *)(this->GetSolid()))
      ->GetOuterRadius(); // bounding cylinder size
    G4double hh_mask= 1.0*millimeter;              // half height
    
    G4LogicalVolume* mask_log
      = new G4LogicalVolume
        (new G4Tubs(plabel+"_mask_solid", // name of solid
                    r_mask_inner, r_mask_outer, // inner and outer radii
                    hh_mask,              // use flat disk, 2mm thick for now
                    0.*deg, 360.*deg      // start and end span angle
                    ),
         MaskMat,
         plabel+"_mask_log");
    
    /**    G4PVPlacement* mask_phys =  **/
    new G4PVPlacement
      (0,                    // no rotation
       G4ThreeVector(0., 0., R5912_z_edge[1] + hh_mask + z_equator), // displacement
       mask_log,             // logical volume
       plabel+"_mask_phys",  // name
       this,                 // mother volume
       false,                // no boolean ops
       0);                   // copy number
  }
}

static const int R3600_n_edge= 9;
static const G4double R3600_z_edge[R3600_n_edge+1]= { 188.00,  116.71,    0.00, -116.71, -136.05, -195.00, -282.00, -355.00, -370.00, -422.00};
static const G4double R3600_rho_edge[R3600_n_edge+1]= { 0.00,  198.55,  254.00,  198.55,  165.40,  127.00,  127.00,   53.00,   41.35,   41.35};
static const G4double R3600_z_o[R3600_n_edge]= {     -127.00,    0.00,    0.00,  127.00, -195.00, -195.00, -280.00, -370.00, -370.00};

////////////////////////////////////////////////////////////////
// 20inch_LogicalVolume
//
dyw_20inch_LogicalVolume::dyw_20inch_LogicalVolume
    (const G4String& plabel, // label -- subvolume names are derived from this
     G4Material* ExteriorMat,// material which fills the bounding cylinder
     G4Material* GlassMat,   // glass material
     G4OpticalSurface* Photocathode_opsurf, // photocathode 
     G4Material* PMT_Vacuum, // vacuum inside tube
     G4Material* DynodeMat,  // dynode material
     G4Material* MaskMat,    // material for photocathode mask (e.g, blk acryl)
                             // OK to set MaskMat == NULL for no mask
     G4VSensitiveDetector *detector, // sensitive detector hook
     ePmtStyle PmtStyle      // PMT approx. style (TorusStack or Ellipsoid)
     )
: dyw_PMT_LogicalVolume(plabel,
                       260.*millimeter,
                       340.*millimeter,   // hh_bound: half height of bounding cylinder
                       ExteriorMat)
{
  if (PmtStyle == kPmtStyle_Ellipsoid) {
    ConstructPMT_UsingEllipsoid
     ( 254.*millimeter,       // equatorial radius of phototube
       188.*millimeter,       // height of face above eq.
      -192.*millimeter,       // depth of back below eq.
       127.*millimeter,       // radius of stem
       230.*millimeter,       // length of stem
        94.*millimeter,       // radius of dynode stack
      -117.*millimeter,       // z coordinate of top of dynode stack, equator=0
       4.  *millimeter,       // thickness of the walls
       ExteriorMat,                   // material outside tube
       GlassMat,                      // glass material
       Photocathode_opsurf,               // photocathode surface 
       PMT_Vacuum,                    // tube interior
       DynodeMat,                     // dynode stack metal
       detector                // detector hook
     );
  }
  else {
    ConstructPMT_UsingTorusStack
     ( R3600_n_edge,
       R3600_z_edge,
       R3600_rho_edge,
       R3600_z_o,
        94.*millimeter,       // radius of dynode stack
      -117.*millimeter,       // z coordinate of top of dynode stack, equator=0
       4.  *millimeter,       // thickness of the walls
       ExteriorMat,                   // material outside tube
       GlassMat,                      // glass material
       Photocathode_opsurf,               // photocathode surface 
       PMT_Vacuum,                    // tube interior
       DynodeMat,                     // dynode stack metal
       detector                // detector hook
     );
  }
  
  if (MaskMat != NULL) {
    // make the mask -- use thin cylindrical disk for now
    G4double r_mask_inner= 254.*millimeter;
    G4double r_mask_outer= ((G4Tubs *)(this->GetSolid()))
      ->GetOuterRadius(); // bounding cylinder size
    G4double hh_mask= 1.5*millimeter;              // half height
    
    G4LogicalVolume* mask_log
      = new G4LogicalVolume
        (new G4Tubs(plabel+"_mask_solid", // name of solid
                    r_mask_inner, r_mask_outer, // inner and outer radii
                    hh_mask,              // use flat disk, 2mm thick for now
                    0.*deg, 360.*deg      // start and end span angle
                    ),
         MaskMat,
         plabel+"_mask_log");
    
    /** G4PVPlacement* mask_phys =  **/
    new G4PVPlacement
      (0,                    // no rotation
       G4ThreeVector(0., 0., 19.5*millimeter + z_equator), // displacement
       mask_log,             // logical volume
       plabel+"_mask_phys",  // name
       this,                 // mother volume
       false,                // no boolean ops
       0);                   // copy number
    
    // mask is black
    //    G4VisAttributes * visAtt= new G4VisAttributes(G4Color(0.0,0.0,0.0,1.0));
    G4VisAttributes * visAtt= new G4VisAttributes(G4Color(0.8,0.8,0.8,1.0));
    mask_log->SetVisAttributes( visAtt );

  }
  
}



////////////////////////////////////////////////////////////////
// ConstructPMT_UsingTorusStack
//  -- makes PMT assembly using TorusStack shapes
//     This is the preferred PMT model.
//     A model built using "Ellipsoid"'s is provided for comparison
//
void
dyw_PMT_LogicalVolume::
ConstructPMT_UsingTorusStack
   (const G4int n_edge,
    const G4double outer_z_edge[],
    const G4double outer_rho_edge[],
    const G4double outer_z_o[],
    G4double r_dynode,     // radius of dynode stack
    G4double z_dynode,     // z coordinate of top of dynode stack, equator=0.
    G4double d_wall,       // thickness of the walls
    G4Material*  /* Exterior */  ,          // material outside tube
    G4Material* Glass,             // glass material
    G4OpticalSurface* OpPCSurface,  // photocathode surface
    G4Material* PMT_Vac,           // tube interior
    G4Material* Dynode_mat,        // dynode stack metal
    G4VSensitiveDetector* detector // detector hook
   )
{
  ////////////////////////////////////////////////////////////////
  // MAKE SOLIDS
  ////
  
  // pmt-shaped volume (to be filled with glass)
  dywTorusStack*  body_solid= new dywTorusStack
    ( GetName() + "_body_solid" );
  body_solid->SetAllParameters (n_edge,
                                outer_z_edge,
                                outer_rho_edge,
                                outer_z_o );
  
  // inner volume (to be filled with vacuum)
  dywTorusStack * inner_solid= new dywTorusStack(GetName()+"_inner_solid");

  G4int helper_equator_index = -1;

  // set shapes of inner volumes
  // also scan for lowest allowed point of dynode
  G4double z_lowest_dynode= z_dynode;
  {
    // We will have to calculate the inner dimensions of the PMT.
    // To allow this, we allocate some workspace.
    // Once upon a time, a very long time ago, g++ was inefficient
    // in allocating small arrays and would fail if the array size was < 4,
    // so here we make sure we allocate one array of sufficient size.
    G4double * dscratch= new G4double[4*(n_edge+1)];
    G4double * inner_z_edge= dscratch;
    G4double * inner_rho_edge= dscratch + n_edge+1;
    G4ThreeVector norm;
    G4int iedge_equator= -1;
    // calculate inner surface edges, check dynode position, and find equator
    inner_z_edge[0]  = outer_z_edge[0]   - d_wall;
    inner_rho_edge[0]= 0.0;
    for (int i=1; i<n_edge; i++) {
      norm= body_solid->SurfaceNormal
        ( G4ThreeVector(0.0,
                        outer_rho_edge[i],
                        outer_z_edge[i]) );
      inner_z_edge[i]  = outer_z_edge[i]   - d_wall * norm.z();
      inner_rho_edge[i]= outer_rho_edge[i] - d_wall * norm.y();
      if (inner_rho_edge[i] > r_dynode && inner_z_edge[i] < z_lowest_dynode)
        z_lowest_dynode= inner_z_edge[i];
      if (outer_z_edge[i] == 0.0 || inner_z_edge[i] == 0.0)
        iedge_equator= i;
    }
    inner_z_edge[n_edge]  = outer_z_edge[n_edge]   + d_wall;
    inner_rho_edge[n_edge]= outer_rho_edge[n_edge] - d_wall;
    // one final check on dynode allowed position
    if (inner_rho_edge[n_edge] > r_dynode
        && inner_z_edge[n_edge] < z_lowest_dynode)
      z_lowest_dynode= inner_z_edge[n_edge];
    // sanity check equator index
    if (iedge_equator < 0) {
      iedge_equator= (1+n_edge)/2;
      G4cout << "dyw_PMT_LogicalVolume::ConstructPMT_UsingTorusStack: "
        "Warning, pathological PMT shape, equator edge not found!" << G4endl;
    }
    
    helper_equator_index = iedge_equator;

    // sanity check on dynode height
    if (z_dynode > inner_z_edge[iedge_equator]) {
      z_dynode= inner_z_edge[iedge_equator];
      G4cout << "dyw_PMT_LogicalVolume::ConstructPMT_UsingTorusStack: "
        "Warning, dynode higher than equator, dynode truncated!" << G4endl;
    }
    // set inner surfaces
    inner_solid->SetAllParameters(n_edge,inner_z_edge,inner_rho_edge,outer_z_o);
    // dywTorusStack keeps its own copy of edges, so we can delete our workspace
    delete [] dscratch;
  }

    G4double helper_sep_tube_r = outer_rho_edge[helper_equator_index];
    G4double helper_sep_tube_h = outer_z_edge[0] - outer_z_edge[helper_equator_index];
    G4double helper_sep_tube_hh = helper_sep_tube_h/2;

    // TODO: check the UNIT?

    G4VSolid * pInnerSep = new G4Tubs("Inner_Separator",
                                      0.,
                                      helper_sep_tube_r+1E-9*mm,
                                      helper_sep_tube_hh,
                                      0.,360.*degree);
    G4ThreeVector innerSepDispl(0.,0.,helper_sep_tube_hh-1E-9*mm);
    G4VSolid * inner1_solid = new G4IntersectionSolid( GetName()
      + "_inner1_solid", inner_solid, pInnerSep, NULL, innerSepDispl);
    G4VSolid * inner2_solid = new G4SubtractionSolid( GetName()
      + "_inner2_solid", inner_solid, pInnerSep, NULL, innerSepDispl);

  // dynode volume
  G4double hh_dynode= (z_dynode - z_lowest_dynode)/2.0;
  G4Tubs* dynode_solid= new G4Tubs
    ( GetName()+"_dynode_solid",
      0.0, r_dynode,          // solid cylinder (fixme?)
      hh_dynode,              // half height of cylinder
      0., 2.*M_PI );          // cylinder complete in phi

  
  ////////////////////////////////////////////////////////////////
  // MAKE LOGICAL VOLUMES (add materials)
  ////
  
  G4LogicalVolume* body_log= new G4LogicalVolume
    ( body_solid,
      Glass,
      GetName()+"_body_log" );
  body_log->SetSensitiveDetector(detector);
  
  G4LogicalVolume* inner1_log= new G4LogicalVolume
    ( inner1_solid,
      PMT_Vac,
      GetName()+"_inner1_log" );
  inner1_log->SetSensitiveDetector(detector);
  
  G4LogicalVolume* inner2_log= new G4LogicalVolume
    ( inner2_solid,
      PMT_Vac,
      GetName()+"_inner2_log" );

  G4LogicalVolume* dynode_log= new G4LogicalVolume
    ( dynode_solid,
      Dynode_mat,
      GetName()+"_dynode_log" );

  ////////////////////////////////////////////////////////////////
  // MAKE PHYSICAL VOLUMES (place logical volumes)
  ////
  
  // calculate z coordinate of equatorial plane in envelope
  z_equator= ((G4Tubs *)(this->GetSolid()))->GetZHalfLength()
    - outer_z_edge[0] - 0.1*mm; // face of tube 100 um from front of cylinder
  G4ThreeVector equatorTranslation(0.,0.,z_equator);
  G4ThreeVector noTranslation(0.,0.,0.);

  // place outer solids in envelope
  G4PVPlacement* body_phys= new G4PVPlacement
    ( 0,                   // no rotation
      equatorTranslation,  // puts body equator in right place
      body_log,            // the logical volume
      GetName()+"_body_phys", // a name for this physical volume
      this,                // the mother volume
      false,               // no boolean ops
      0 );                 // copy number

  // place inner solids in outer solid (vacuum)
  G4PVPlacement* inner1_phys= new G4PVPlacement
    ( 0,                   // no rotation
      noTranslation,       // puts face equator in right place
      GetName()+"_inner1_phys",         // a name for this physical volume
      inner1_log,                    // the logical volume
      body_phys,           // the mother volume
      false,               // no boolean ops
      0 );                 // copy number
  G4PVPlacement* inner2_phys= new G4PVPlacement
    ( 0,                   // no rotation
      noTranslation,       // puts face equator in right place
      GetName()+"_inner2_phys",         // a name for this physical volume
      inner2_log,                    // the logical volume
      body_phys,           // the mother volume
      false,               // no boolean ops
      0 );                 // copy number

  // place dynode in stem/back
  /**  G4PVPlacement* dynode_phys =  **/
  new G4PVPlacement
    ( 0,
      G4ThreeVector(0.0, 0.0, z_dynode - hh_dynode),
      GetName()+"_dynode_phys",
      dynode_log,
      inner2_phys,
      false,
      0 );

  ////////////////////////////////////////////////////////////////
  // Attach optical surfaces to borders
  ////
  new G4LogicalBorderSurface(GetName()+"_photocathode_logsurf1",
                             inner1_phys, body_phys,
                             OpPCSurface);
  new G4LogicalBorderSurface(GetName()+"_photocathode_logsurf2",
                             body_phys, inner1_phys,
                             OpPCSurface);
  new G4LogicalBorderSurface(GetName()+"_mirror_logsurf1",
                                inner2_phys, body_phys,
                                our_Mirror_opsurf);
  new G4LogicalBorderSurface(GetName()+"_mirror_logsurf2",
                                body_phys, inner2_phys,
                                our_Mirror_opsurf);

  ////////////////////////////////////////////////////////////////
  // FastSimulationModel
  ////
  /**  dywPMTOpticalModel * pmtOpticalModel =  **/
  G4Region* body_region = new G4Region(this->GetName()+"_body_region");
  body_region->AddRootLogicalVolume(body_log);
  new dywPMTOpticalModel( GetName()+"_optical_model", body_phys, body_region);

  
  ////////////////////////////////////////////////////////////////
  // Set colors and visibility
  ////
  G4VisAttributes * visAtt;
  this-> SetVisAttributes (G4VisAttributes::Invisible);
  // PMT glass
  // visAtt= new G4VisAttributes(G4Color(0.0,1.0,1.0,0.05));
  // body_log->SetVisAttributes( visAtt );
  body_log->SetVisAttributes( G4VisAttributes::Invisible );
  // dynode is medium gray
  visAtt= new G4VisAttributes(G4Color(0.5,0.5,0.5,1.0));
  dynode_log->SetVisAttributes( visAtt );
  // (surface of) interior vacuum is clear orangish gray on top (PC),
  // silvery blue on bottom (mirror)
  visAtt= new G4VisAttributes(G4Color(0.7,0.5,0.3,0.27));
  inner1_log->SetVisAttributes (visAtt);
  visAtt= new G4VisAttributes(G4Color(0.6,0.7,0.8,0.67));
  inner2_log->SetVisAttributes (visAtt);
}

////////////////////////////////////////////////////////////////
// ConstructPMT_UsingEllipsoid
//  -- makes PMT assembly using ellipsoids
//     For comparison only -- the TorusStack PMT model is preferred
//
void
dyw_PMT_LogicalVolume::
ConstructPMT_UsingEllipsoid
   (G4double r_equat,      // equatorial radius of phototube
    G4double h_face,       // height of face above eq.
    G4double h_back,       // depth of back below eq.
    G4double r_stem,       // radius of stem
    G4double l_stem,       // length of stem
    G4double r_dynode,     // radius of dynode stack
    G4double z_dynode,     // z coordinate of top of dynode stack, equator=0.
    G4double d_wall,       // thickness of the walls
    G4Material*  /* Exterior */  ,          // material outside tube
    G4Material* Glass,             // glass material
    G4OpticalSurface* OpPCSurface,  // photocathode surface
    G4Material* PMT_Vac,           // tube interior
    G4Material* Dynode_mat,        // dynode stack metal
    G4VSensitiveDetector* detector // detector hook
   )
{
  ////////////////////////////////////////////////////////////////
  // PARAMETER CHECKS
  ////
  if (d_wall > r_stem || d_wall > r_equat)
    {
      G4cout << "Error in ConstructPMT_UsingEllipsoid: wall is too thick! "
             << "r_stem=" << r_stem << ", r_equat=" << r_equat
             << ", d_wall=" << d_wall << G4endl;
      d_wall= (r_stem < r_equat) ? r_stem/8.0 : r_equat/8.0;
    }
  if (r_dynode > r_stem-d_wall || r_dynode > r_equat-d_wall)
    {
      G4cout << "Error in dyw_ConstructPMT_UsingEllipsoid: dynode is too wide! "
             << "r_dynode=" << r_dynode
             << ", r_stem=" << r_stem << ", r_equat=" << r_equat
             << ", d_wall=" << d_wall << G4endl;
      r_dynode= r_stem - d_wall;
    }
  if (z_dynode > 0.0)
    {
      G4cout << "Error in dyw_ConstructPMT_UsingEllipsoid: dynode extends into face! "
             << " z_dynode=" << z_dynode << ", must be < 0" << G4endl;
      z_dynode= 0.0;
    }

  ////////////////////////////////////////////////////////////////
  // MAKE SOLIDS
  ////
  
  // outer solids
  G4double z_neck= h_back * sqrt(1.0 - r_stem*r_stem/(r_equat*r_equat));
  G4double l_stem_cyl= l_stem+h_back-z_neck;
  dywEllipsoid* face_solid= new dywEllipsoid
    ( GetName()+"_face_solid", r_equat, r_equat, h_face, 0., r_equat+h_face);
  dywEllipsoid* back_solid= new dywEllipsoid
    ( GetName()+"_back_solid", r_equat, r_equat, -h_back, z_neck, 0.);
  G4Tubs*      stem_solid= new G4Tubs
    ( GetName()+"_stem_solid", 0.0, r_stem,
      l_stem_cyl/2., 0., 2.*M_PI);
  
  // inner solids
  dywEllipsoid* face_interior_solid= new dywEllipsoid
    ( GetName()+"_face_interior_solid",
      r_equat-d_wall, r_equat-d_wall,
      h_face-d_wall,
      0.0, kInfinity);
  dywEllipsoid* back_interior_solid= new dywEllipsoid
    ( GetName()+"_back_interior_solid",
      r_equat-d_wall, r_equat-d_wall,
      -h_back-d_wall,
      z_neck, 0.0);
  G4Tubs*      stem_interior_solid= new G4Tubs
    ( GetName()+"_stem_interior_solid",
      0.0, r_stem-d_wall,
      l_stem_cyl/2.0-d_wall, 0., 2.*M_PI);
  G4Tubs*      dynode1_solid;
  G4Tubs*      dynode2_solid;
  if (z_dynode < z_neck)
    {
      dynode1_solid= NULL;
      dynode2_solid= new G4Tubs
        ( GetName()+"_dynode2_solid", 0.0, r_dynode,
          (h_back+l_stem+z_dynode-d_wall)/2.0, 0., 2.*M_PI);
    }
  else
    {
      dynode1_solid= new G4Tubs
        ( GetName()+"_dynode1_solid", r_dynode/2., r_dynode,
          (-z_neck+z_dynode)/2., 0., 2.*M_PI);
      dynode2_solid= new G4Tubs
        ( GetName()+"_dynode2_solid", 0.0, 0.95*r_dynode,
          (l_stem_cyl-d_wall)/2.0, 0., 2.*M_PI);
    }  

  ////////////////////////////////////////////////////////////////
  // MAKE LOGICAL VOLUMES (add materials)
  ////
  
  G4LogicalVolume* face_log= new G4LogicalVolume
    ( face_solid,
      Glass,
      GetName()+"_face_log" );
  face_log->SetSensitiveDetector(detector);
  G4LogicalVolume* back_log= new G4LogicalVolume
    ( back_solid,
      Glass,
      GetName()+"_back_log" );
  G4LogicalVolume* stem_log= new G4LogicalVolume
    ( stem_solid,
      Glass,
      GetName()+"_stem_log" );
  G4LogicalVolume* face_interior_log= new G4LogicalVolume
    ( face_interior_solid,
      PMT_Vac,
      GetName()+"_face_interior_log" );
  face_interior_log->SetSensitiveDetector(detector);
  G4LogicalVolume* back_interior_log= new G4LogicalVolume
    ( back_interior_solid,
      PMT_Vac,
      GetName()+"_back_interior_log" );
  G4LogicalVolume* stem_interior_log= new G4LogicalVolume
    ( stem_interior_solid,
      PMT_Vac,
      GetName()+"_stem_interior_log" );
  G4LogicalVolume* dynode1_log= (!dynode1_solid) ? 0 : new G4LogicalVolume
    ( dynode1_solid,
      Dynode_mat,
      GetName()+"_dynode1_log" );
  G4LogicalVolume* dynode2_log= new G4LogicalVolume
    ( dynode2_solid,
      Dynode_mat,
      GetName()+"_dynode2_log" );

  ////////////////////////////////////////////////////////////////
  // MAKE PHYSICAL VOLUMES (place logical volumes)
  ////
  
  // calculate z coordinate of equatorial plane in envelope
  z_equator= ((G4Tubs *)(this->GetSolid()))->GetZHalfLength()
    - h_face - 0.1*mm; // face of tube 100 um from front of cylinder
  G4ThreeVector equatorTranslation(0.,0.,z_equator);
  G4ThreeVector stemTranslation(0.,0.,z_equator+z_neck-l_stem_cyl/2.);
  G4ThreeVector noTranslation(0.,0.,0.);

  // place outer solids in envelope
  G4PVPlacement* face_phys= new G4PVPlacement
    ( 0,                   // no rotation
      equatorTranslation,  // puts face equator in right place
      face_log,            // the logical volume
      GetName()+"_face_phys", // a name for this physical volume
      this,                // the mother volume
      false,               // no boolean ops
      0 );                 // copy number
  G4PVPlacement* back_phys= new G4PVPlacement
    ( 0,                   // no rotation
      equatorTranslation,  // puts back equator in right place
      back_log,            // the logical volume
      GetName()+"_back_phys", // a name for this physical volume
      this,                // the mother volume
      false,               // no boolean ops
      0 );                 // copy number
  G4PVPlacement* stem_phys= new G4PVPlacement
    ( 0,                   // no rotation
      stemTranslation,     // puts stem in right place
      stem_log,            // the logical volume
      GetName()+"_stem_phys", // a name for this physical volume
      this,                // the mother volume
      false,               // no boolean ops
      0 );                 // copy number

  // place inner solids in outer solids (vacuum)
  G4PVPlacement* face_interior_phys= new G4PVPlacement
    ( 0,                   // no rotation
      noTranslation,       // puts face equator in right place
      GetName()+"_face_interior_phys", // a name for this physical volume
      face_interior_log,            // the logical volume
      face_phys,            // the mother volume
      false,               // no boolean ops
      0 );                 // copy number
  G4PVPlacement* back_interior_phys= new G4PVPlacement
    ( 0,                   // no rotation
      noTranslation,       // puts equator in right place
      GetName()+"_back_interior_phys", // a name 
      back_interior_log,   // the logical volume
      back_phys,           // the mother volume
      false,               // no boolean ops
      0 );                 // copy number
  G4PVPlacement* stem_interior_phys= new G4PVPlacement
    ( 0,                   // no rotation
      noTranslation,       // puts equator in right place
      GetName()+"_stem_interior_phys", // a name 
      stem_interior_log,   // the logical volume
      stem_phys,           // the mother volume
      false,               // no boolean ops
      0 );                 // copy number

  // place dynode in stem/back
  /**  G4PVPlacement* dynode1_phys = 0;  **/
  if (dynode1_log) {
    /**  dynode1_phys =  **/
    new G4PVPlacement
      ( 0,
        G4ThreeVector(0.,0.,z_dynode - dynode1_solid->GetZHalfLength()),
        GetName()+"_dynode1_phys",
        dynode1_log,
        back_interior_phys,
        false,
        0 );
  }
  /**  G4PVPlacement* dynode2_phys =  **/
  new G4PVPlacement
    ( 0,
      noTranslation,
      GetName()+"_dynode2_phys",
      dynode2_log,
      stem_interior_phys,
      false,
      0 );

  ////////////////////////////////////////////////////////////////
  // Create optical surfaces
  ////
  new G4LogicalBorderSurface(GetName()+"_photocathode_logsurf1",
                             face_interior_phys, face_phys,
                             OpPCSurface);
  new G4LogicalBorderSurface(GetName()+"_photocathode_logsurf2",
                             face_phys, face_interior_phys,
                             OpPCSurface);
  new G4LogicalBorderSurface(GetName()+"_mirror_logsurf1",
                                back_interior_phys, back_phys,
                                our_Mirror_opsurf);
  new G4LogicalBorderSurface(GetName()+"_mirror_logsurf2",
                                back_phys, back_interior_phys,
                                our_Mirror_opsurf);

  ////////////////////////////////////////////////////////////////
  // FastSimulationModel
  ////
  /**  dywPMTOpticalModel * pmtOpticalModel =  **/
  G4Region* face_region = new G4Region(this->GetName()+"_face_region");
  face_region->AddRootLogicalVolume(face_log);
  new dywPMTOpticalModel( GetName()+"_optical_model", face_phys, face_region);
  
  ////////////////////////////////////////////////////////////////
  // Set colors and visibility
  ////
  this-> SetVisAttributes (G4VisAttributes::Invisible);
  // top PMT glass is very clear orangish-gray 
  G4VisAttributes * visAtt= new G4VisAttributes(G4Color(0.7,0.5,0.3,0.27));
  face_log->SetVisAttributes( visAtt );
  // bottom PMT glass is silvery-blue
  visAtt= new G4VisAttributes(G4Color(0.6,0.7,0.8,1.0));
  back_log->SetVisAttributes( visAtt );
  stem_log->SetVisAttributes( visAtt );
  // dynode is medium gray
  visAtt= new G4VisAttributes(G4Color(0.5,0.5,0.5,1.0));
  if (dynode1_log) dynode1_log->SetVisAttributes( visAtt );
  dynode2_log->SetVisAttributes( visAtt );
  // interior vacuum is invisible
  back_interior_log->SetVisAttributes (G4VisAttributes::Invisible);
  stem_interior_log->SetVisAttributes (G4VisAttributes::Invisible);
  face_interior_log->SetVisAttributes (G4VisAttributes::Invisible);
}


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
//
// $Id: G4STRead.hh,v 1.3 2008/07/17 14:05:50 gcosmo Exp $
// GEANT4 tag $Name: geant4-09-02 $
//
//
// class G4STRead
//
// Class description:
//
// DAE class for import of triangularised geometry descriptions
// (.geom and .tree structures) generated out of STEP files from
// CAD systems (STWriter STEP Tool and similar...).

// History:
// - Created.                                  Zoltan Torzsok, November 2007
// -------------------------------------------------------------------------

#ifndef _G4STREAD_INCLUDED_
#define _G4STREAD_INCLUDED_

#include <fstream>
#include <vector>
#include <map>

#include "G4TessellatedSolid.hh"
#include "G4QuadrangularFacet.hh"
#include "G4TriangularFacet.hh"
#include "G4LogicalVolume.hh"
#include "G4PVPlacement.hh"
#include "G4Material.hh"
#include "G4Box.hh"

class G4STRead
{
  public:  // with description

    G4LogicalVolume* Read(const G4String&, G4Material* mediumMaterial,
                                           G4Material* solidMaterial);
  private:

    void TessellatedRead(const std::string&);
    void FacetRead(const std::string&);
    void PhysvolRead(const std::string&);
    void ReadGeom(const G4String&);
    void ReadTree(const G4String&);

  private:

    G4Box* world_box;
    G4ThreeVector world_extent;
    G4Material* solid_material;
    G4Material* medium_material;
    G4LogicalVolume* world_volume;
    std::vector<G4TessellatedSolid*> tessellatedList;
    std::map<G4TessellatedSolid*,G4LogicalVolume*> volumeMap;
};

#endif

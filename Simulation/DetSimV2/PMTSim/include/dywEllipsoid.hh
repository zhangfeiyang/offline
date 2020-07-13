//----------------------------------------------------
// an ellipsoidal solid used by PMT Logical Volume
//------------------------------------------------------
// This file is part of the GenericLAND software library.
// $Id: dywEllipsoid.hh 882 2006-04-14 14:49:54Z caoj $
//
// This code implementation is derived from intellectual property of
// the RD44 GEANT4 collaboration.
//
// By copying, distributing or modifying the Program (or any work
// based on the Program) you indicate your acceptance of this statement,
// and all its terms.
//
// class GLG4Ellipsoid
//
// A GLG4Ellipsoid is an ellipsoidal solid, optionally cut at a given z.
//
// Member Data:
//
//	fRx	semi-axis, x
//	fRy	semi-axis, y
//	fRz	semi-axis, z
//      fZCut1  lower cut plane level, z (solid lies above this plane)
//      fZCut2  upper cut plane level, z (solid lies below this plane)
//
// First writing:  G. Horton-Smith, 10-Nov-1999

#ifndef dywEllipsoid_HH
#define dywEllipsoid_HH

#include "G4CSGSolid.hh"

class dywEllipsoid : public G4CSGSolid {
public:
          dywEllipsoid(const G4String& pName,
	           G4double pRx,
	           G4double pRy,
	           G4double pRz,
	           G4double pZCut1,
		   G4double pZCut2);
		   
	  virtual ~dywEllipsoid() ;
	  
	  // Access functions
		   
	  G4double    GetRadius (int i) const  { return (i==0) ? fRx
						   : (i==1) ? fRy
						   : fRz; }
	  G4double    GetZCut1() const { return fZCut1; }
	  G4double    GetZCut2() const { return fZCut2; }

	  void   SetRadii    (G4double newRx,
			      G4double newRy,
			      G4double newRz)
                   { fRx= newRx; fRy= newRy; fRz= newRz;
		     fRmax= fRx > fRy ? fRx : fRy;
		     if (fRz > fRmax) fRmax= fRz;
		     if (fZCut1 < -fRz) fZCut1= -fRz;
		     if (fZCut2 > +fRz) fZCut2= +fRz;
		   }
          void   SetZCuts (G4double newZ1, G4double newZ2)
                   { fZCut1= newZ1; fZCut2= newZ2;
		     if (fZCut1 < -fRz) fZCut1= -fRz;
		     if (fZCut2 > +fRz) fZCut2= +fRz;
		   }

          void ComputeDimensions(G4VPVParameterisation* p,
                                 const G4int n,
                                 const G4VPhysicalVolume* pRep);

          G4bool CalculateExtent(const EAxis pAxis,
			         const G4VoxelLimits& pVoxelLimit,
			         const G4AffineTransform& pTransform,
			         G4double& pmin, G4double& pmax) const;
				 
          EInside Inside(const G4ThreeVector& p) const;

          G4ThreeVector SurfaceNormal( const G4ThreeVector& p) const;

          G4double DistanceToIn(const G4ThreeVector& p,
	                        const G4ThreeVector& v) const;
	  
          G4double DistanceToIn(const G4ThreeVector& p) const;
	  
          G4double DistanceToOut(const G4ThreeVector& p,
	                         const G4ThreeVector& v,
			         const G4bool calcNorm=G4bool(false),
			         G4bool *validNorm=0,
				 G4ThreeVector *n=0) const;
				 
          G4double DistanceToOut(const G4ThreeVector& p) const;

             // Naming method (pseudo-RTTI : run-time type identification)

          virtual G4GeometryType  GetEntityType() const
                    { return G4String("dywEllipsoid"); }

              // Visualisation functions
  
          void   DescribeYourselfTo(G4VGraphicsScene& scene) const;
       
          G4VisExtent GetExtent() const;
       
          G4Polyhedron* CreatePolyhedron() const;
       
          G4NURBS*      CreateNURBS() const;
       
protected:
 
          G4ThreeVectorList*
          CreateRotatedVertices(const G4AffineTransform& pTransform,
	                        G4int& noPolygonVertices) const;
	
private:

    G4double fRx,
	     fRy,
	     fRz,
	     fRmax,
	     fZCut1,
 	     fZCut2;
};
   	
#endif

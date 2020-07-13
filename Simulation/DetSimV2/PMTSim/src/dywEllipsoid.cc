//----------------------------------------------------
// an ellipsoidal solid used by PMT Logical Volume
//------------------------------------------------------
// This file is part of the GenericLAND software library.
// $Id: dywEllipsoid.cc 1574 2007-07-20 14:10:19Z goettj $
//
// This code implementation is derived from intellectual property of
// the RD44 GEANT4 collaboration.
//
// By copying, distributing or modifying the Program (or any work
// based on the Program) you indicate your acceptance of this statement,
// and all its terms.
//
// class dywEllipsoid
//
// Implementation for dywEllipsoid class
//
// History:
// 10.11.99 G.Horton-Smith  -- first writing, based on G4Sphere class
// 

#include <assert.h>

#include "globals.hh"

#include "dywEllipsoid.hh"
#include "G4VoxelLimits.hh"
#include "G4AffineTransform.hh"

#include "G4VPVParameterisation.hh"

#include "meshdefs.hh"

#include "G4VGraphicsScene.hh"
#include "G4Polyhedron.hh"
#include "G4NURBS.hh"
#include "G4NURBSbox.hh"
#include "G4VisExtent.hh"

//#include "local_g4compat.hh"

#include "G4Version.hh"
//#if G4VERSION_NUMBER >= 900
   #include "G4GeometryTolerance.hh"
//#endif

// useful utility function
static inline G4double square(G4double x) { return x*x; }
// #if defined(__GNUC__) && (__GNUC__ < 3)
// [rayd] renamed hypot as dyw_hypot, to avoid problems with gcc 2.96
static inline double dyw_hypot(double x, double y) { return sqrt(x*x+y*y); }
// #endif

// Destructor

dywEllipsoid::~dywEllipsoid()
{
   ;
}

// constructor - check parameters, convert angles so 0<sphi+dpshi<=2_PI
//             - note if pDPhi>2PI then reset to 2PI

dywEllipsoid::dywEllipsoid(const G4String& pName,
                   G4double pRx,
                   G4double pRy,
                   G4double pRz,
                   G4double pZCut1,
                   G4double pZCut2)  : G4CSGSolid(pName)
{

// Check radii
    if (pRx>0.
        && pRy>0.
        && pRz>0. )
        {
          SetRadii(pRx, pRy, pRz);
        }
    else
        {
            G4Exception("Error in dywEllipsoid::dywEllipsoid - invalid radii", // issue
                        "", //Error Code
                        FatalErrorInArgument, // severity
                        "");
        }

    if (pZCut1 < pRz && pZCut2 > -pRz
        && pZCut1 < pZCut2)
      {
        SetZCuts(pZCut1, pZCut2);
      }
    else
      {
        G4Exception("Error in dywEllipsoid::dywEllipsoid - invalid z cut", // issue
                        "", //Error Code
                        FatalErrorInArgument, // severity
                        "");
      }
}

// -------------------------------------------------------------------------------------

// Dispatch to parameterisation for replication mechanism dimension
// computation & modification.
void dywEllipsoid::ComputeDimensions(G4VPVParameterisation* ,
                              const G4int ,
                              const G4VPhysicalVolume* )
{
  G4cout << "Warning: ComputeDimensions is not defined for dywEllipsoid. "
              "It shouldn't be called.\n";
  // but note that G4Polycone just silently ignores calls to ComputeDimensions!
  // ComputeDimensions seems to be unimplemented in all classes -- just
  // dispatches to methods that ultimately turn out to be no-ops!
}

// --------------------------------------------------------------------------------------

// Calculate extent under transform and specified limit
G4bool dywEllipsoid::CalculateExtent(const EAxis pAxis,
                              const G4VoxelLimits& pVoxelLimit,
                              const G4AffineTransform& pTransform,
                              G4double& pMin, G4double& pMax) const
{

#if G4VERSION_NUMBER >= 900
        G4double kCarTolerance = G4GeometryTolerance::GetInstance()->GetSurfaceTolerance();
#endif
            G4int i,j,noEntries,noBetweenSections;
            G4bool existsAfterClip=false;

// Calculate rotated vertex coordinates
            G4ThreeVectorList* vertices;
            G4int  noPolygonVertices ;
            vertices=CreateRotatedVertices(pTransform,noPolygonVertices);

            pMin=+kInfinity;
            pMax=-kInfinity;

            noEntries=vertices->size(); // noPolygonVertices*noPhiCrossSections
            noBetweenSections=noEntries-noPolygonVertices;
            
            G4ThreeVectorList ThetaPolygon ;
            for (i=0;i<noEntries;i+=noPolygonVertices)
                {
                   for(j=0;j<(noPolygonVertices/2)-1;j++)
                  {
                    ThetaPolygon.push_back((*vertices)[i+j]) ;            
                    ThetaPolygon.push_back((*vertices)[i+j+1]) ;                  
                    ThetaPolygon.push_back((*vertices)[i+noPolygonVertices-2-j]);
                    ThetaPolygon.push_back((*vertices)[i+noPolygonVertices-1-j]);
                    CalculateClippedPolygonExtent(ThetaPolygon,pVoxelLimit,pAxis,pMin,pMax);
                    ThetaPolygon.clear() ;
                  }
                }
            for (i=0;i<noBetweenSections;i+=noPolygonVertices)
                {
                   for(j=0;j<noPolygonVertices-1;j++)
                  {
                    ThetaPolygon.push_back((*vertices)[i+j]) ;            
                    ThetaPolygon.push_back((*vertices)[i+j+1]) ;                  
                    ThetaPolygon.push_back((*vertices)[i+noPolygonVertices+j+1]);
                    ThetaPolygon.push_back((*vertices)[i+noPolygonVertices+j]);
                    CalculateClippedPolygonExtent(ThetaPolygon,pVoxelLimit,pAxis,pMin,pMax);
                    ThetaPolygon.clear() ;
                  }
                    ThetaPolygon.push_back((*vertices)[i+noPolygonVertices-1]);
                    ThetaPolygon.push_back((*vertices)[i]) ;
                    ThetaPolygon.push_back((*vertices)[i+noPolygonVertices]) ;
                    ThetaPolygon.push_back((*vertices)[i+2*noPolygonVertices-1]);
                    CalculateClippedPolygonExtent(ThetaPolygon,pVoxelLimit,pAxis,pMin,pMax);
                    ThetaPolygon.clear() ;
                }
            
            if (pMin!=kInfinity || pMax!=-kInfinity)
                {
                    existsAfterClip=true;
                    
// Add 2*tolerance to avoid precision troubles
                    pMin-=kCarTolerance;
                    pMax+=kCarTolerance;

                }
            else
                {
// Check for case where completely enveloping clipping volume
// If point inside then we are confident that the solid completely
// envelopes the clipping volume. Hence set min/max extents according
// to clipping volume extents along the specified axis.
                    G4ThreeVector clipCentre(
                        (pVoxelLimit.GetMinXExtent()+pVoxelLimit.GetMaxXExtent())*0.5,
                        (pVoxelLimit.GetMinYExtent()+pVoxelLimit.GetMaxYExtent())*0.5,
                        (pVoxelLimit.GetMinZExtent()+pVoxelLimit.GetMaxZExtent())*0.5);
                    
                    if (Inside(pTransform.Inverse().TransformPoint(clipCentre))!=kOutside)
                        {
                            existsAfterClip=true;
                            pMin=pVoxelLimit.GetMinExtent(pAxis);
                            pMax=pVoxelLimit.GetMaxExtent(pAxis);
                        }
                }
            delete vertices;
            return existsAfterClip;
}

// --------------------------------------------------------------------------------------------

// Return whether point inside/outside/on surface
// Split into radius, phi, theta checks
// Each check modifies `in', or returns as approprate

EInside dywEllipsoid::Inside(const G4ThreeVector& p) const
{
  G4double rad2oo,  // outside surface outer tolerance
           rad2oi;  // outside surface inner tolerance
  EInside in;

  #if G4VERSION_NUMBER >= 900
        G4double kRadTolerance = G4GeometryTolerance::GetInstance()->GetRadialTolerance();
  #endif

  // check this side of z cut first, because that's fast
  if (p.z() < fZCut1-kRadTolerance/2.0)
    return in=kOutside;
  if (p.z() > fZCut2+kRadTolerance/2.0)
    return in=kOutside;

  rad2oo= square(p.x()/(fRx+kRadTolerance/2.))
      + square(p.y()/(fRy+kRadTolerance/2.))
      + square(p.z()/(fRz+kRadTolerance/2.));

  if (rad2oo > 1.0)
    return in=kOutside;
    
  rad2oi= square(p.x()*(1.0+kRadTolerance/2./fRx)/fRx)
      + square(p.y()*(1.0+kRadTolerance/2./fRy)/fRy)
      + square(p.z()*(1.0+kRadTolerance/2./fRz)/fRz);

//
// Check radial surfaces
//  sets `in'
// (already checked for rad2oo > 1.0)
//
    if (rad2oi < 1.0)
      {
        in=  (p.z() < fZCut1+kRadTolerance/2.0
              || p.z() > fZCut2-kRadTolerance/2.0) ? kSurface : kInside;
      }
    else 
      {
        in=kSurface;
      }

    return in;
}

// -----------------------------------------------------------------------------------------

// Return unit normal of surface closest to p
// not protected against p=0

G4ThreeVector dywEllipsoid::SurfaceNormal( const G4ThreeVector& p) const
{
    G4double distR, distZ1, distZ2;

//
// normal vector with special magnitude:  parallel to normal, units 1/length
// norm*p == 1.0 if on surface, >1.0 if outside, <1.0 if inside
//
    G4ThreeVector norm(p.x()/(fRx*fRx), p.y()/(fRy*fRy), p.z()/(fRz*fRz));
    G4double radius= 1.0/norm.mag();

//
// approximate distance to curved surface
//
    distR= fabs( (p*norm - 1.0) * radius ) / 2.0;
    
//
// Distance to z-cut plane
//
    distZ1= fabs( p.z() - fZCut1 );
    distZ2= fabs( p.z() - fZCut2 );

    if (distZ1 < distR || distZ2 < distR)
      {
        return G4ThreeVector(0.,0., (distZ1 < distZ2) ? -1.0 : 1.0);
      }
    else
      {
        return ( norm *= radius );
      }
}

//////////////////////////////////////////////////////////////////
//
// Calculate distance to shape from outside, along normalised vector
// - return kInfinity if no intersection, or intersection distance <= tolerance
//

G4double dywEllipsoid::DistanceToIn( const G4ThreeVector& p,
                                 const G4ThreeVector& v  ) const
{
  G4double distMin;
  
  distMin= kInfinity;

  #if G4VERSION_NUMBER >= 900
        G4double kRadTolerance = G4GeometryTolerance::GetInstance()->GetRadialTolerance();
  #endif

  // check to see if Z plane is relevant
  if (p.z() < fZCut1) {
    if (v.z() <= 0.0)
      return distMin;
    G4double distZ = (fZCut1 - p.z()) / v.z();
    if (distZ > kRadTolerance/2.0 && Inside(p+distZ*v) != kOutside )
      {
        // early exit since can't intercept curved surface if we reach here
        return distMin= distZ;
      }
  }
  if (p.z() > fZCut2) {
    if (v.z() >= 0.0)
      return distMin;
    G4double distZ = (fZCut2 - p.z()) / v.z();
    if (distZ > kRadTolerance/2.0 && Inside(p+distZ*v) != kOutside )
      {
        // early exit since can't intercept curved surface if we reach here
        return distMin= distZ;
      }
  }
  // if fZCut1 <= p.z() <= fZCut2, then must hit curved surface

  // now check curved surface intercept
  G4double A,B,C;

  A= square(v.x()/fRx) + square(v.y()/fRy) + square(v.z()/fRz);
  C= square(p.x()/fRx) + square(p.y()/fRy) + square(p.z()/fRz) - 1.0;
  B= 2.0 * ( p.x()*v.x()/(fRx*fRx) + p.y()*v.y()/(fRy*fRy)
             + p.z()*v.z()/(fRz*fRz) );

  C= B*B - 4.0*A*C;
  if (C > 0.0)
    {
      G4double distR= (-B - sqrt(C) ) / (2.0*A);
      G4double intZ= p.z()+distR*v.z();
      if (distR > kRadTolerance/2.0
          && intZ >= fZCut1-kRadTolerance/2.0
          && intZ <= fZCut2+kRadTolerance/2.0)
        {
          distMin= distR;
        }
      else
        {
          distR= (-B + sqrt(C) ) / (2.0*A);
          intZ= p.z()+distR*v.z();
          if (distR > kRadTolerance/2.0
              && intZ >= fZCut1-kRadTolerance/2.0
              && intZ <= fZCut2+kRadTolerance/2.0)
            {
              distMin= distR;
            }
        }
    }

  return distMin;
} 

//////////////////////////////////////////////////////////////////////
//
// Calculate distance (<= actual) to closest surface of shape from outside
// - Return 0 if point inside

G4double dywEllipsoid::DistanceToIn(const G4ThreeVector& p) const
{
    G4double distR, distZ;

//
// normal vector:  parallel to normal, magnitude 1/(characteristic radius)
//
    G4ThreeVector norm(p.x()/(fRx*fRx), p.y()/(fRy*fRy), p.z()/(fRz*fRz));
    G4double radius= 1.0/norm.mag();

//
// approximate distance to curved surface ( <= actual distance )
//
    distR= (p*norm - 1.0) * radius / 2.0;
    
//
// Distance to z-cut plane
//
    distZ= fZCut1 - p.z();
    if (distZ < 0.0)
      distZ= p.z() - fZCut2;

//
// Distance to closest surface from outside
//
    if (distZ < 0.0)
      {
        return (distR < 0.0) ? 0.0 : distR;
      }
    else if (distR < 0.0)
      {
        return distZ;
      }
    else
      {
        return (distZ < distR) ? distZ : distR;
      }
}

// -----------------------------------------------------------------------------------------

// Calculate distance to surface of shape from `inside', allowing for tolerance

G4double dywEllipsoid::DistanceToOut(const G4ThreeVector& p,
                                 const G4ThreeVector& v,
                                 const G4bool calcNorm,
                                 G4bool *validNorm,
                                 G4ThreeVector *n       ) const
{
  G4double distMin;
  enum surface_e {kPlaneSurf, kCurvedSurf, kNoSurf} surface;
  
  distMin= kInfinity;
  surface= kNoSurf;

  // check to see if Z plane is relevant
  if (v.z() < 0.0) {
    G4double distZ = (fZCut1 - p.z()) / v.z();
    if (distZ < 0.0)
      {
        distZ= 0.0;
        if (!calcNorm)
          return 0.0;
      }
    distMin= distZ;
    surface= kPlaneSurf;
  }
  if (v.z() > 0.0) {
    G4double distZ = (fZCut2 - p.z()) / v.z();
    if (distZ < 0.0)
      {
        distZ= 0.0;
        if (!calcNorm)
          return 0.0;
      }
    distMin= distZ;
    surface= kPlaneSurf;
  }

  // normal vector:  parallel to normal, magnitude 1/(characteristic radius)
  G4ThreeVector nearnorm(p.x()/(fRx*fRx), p.y()/(fRy*fRy), p.z()/(fRz*fRz));
  
  // now check curved surface intercept
  G4double A,B,C;
  
  A= square(v.x()/fRx) + square(v.y()/fRy) + square(v.z()/fRz);
  C= (p * nearnorm) - 1.0;
  B= 2.0 * (v * nearnorm);

  C= B*B - 4.0*A*C;
  if (C > 0.0)
    {
      G4double distR= (-B + sqrt(C) ) / (2.0*A);
      if (distR < 0.0)
        {
          distR= 0.0;
          if (!calcNorm)
            return 0.0;
        }
      if (distR < distMin)
        {
          distMin= distR;
          surface= kCurvedSurf;
        }
    }

  // set normal if requested
  if (calcNorm)
    {
      if (surface == kNoSurf)
        {
          *validNorm= FALSE;
        }
      else
        {
          *validNorm= TRUE;
          switch (surface)
            {
            case kPlaneSurf:
              *n= G4ThreeVector(0.,0.,(v.z() > 1.0 ? 1. : -1.));
              break;
            case kCurvedSurf:
              {
                G4ThreeVector pexit= p + distMin*v;
                G4ThreeVector truenorm(pexit.x()/(fRx*fRx),
                                       pexit.y()/(fRy*fRy),
                                       pexit.z()/(fRz*fRz));
                truenorm*= 1.0/truenorm.mag();
                *n= truenorm;
              }
              break;
            default:
              G4Exception("Logic error in dywEllipsoid::DistanceToOut!", // issue
                        "", //Error Code
                        FatalException, // severity
                        "");
              break;
            }
        }
    }
  
  return distMin;
}

// ----------------------------------------------------------------------------------------------

// Calcluate distance (<=actual) to closest surface of shape from inside

G4double dywEllipsoid::DistanceToOut(const G4ThreeVector& p) const
{
    G4double distR, distZ;

//
// normal vector:  parallel to normal, magnitude 1/(characteristic radius)
//
    G4ThreeVector norm(p.x()/(fRx*fRx), p.y()/(fRy*fRy), p.z()/(fRz*fRz));
    // the following is a safe inlined "radius= min(1.0/norm.mag(),p.mag())
    G4double radius= p.mag();
    {
      G4double tmp= norm.mag();
      if (tmp > 0.0 && 1.0 < radius*tmp) radius= 1.0/tmp;
    }

//
// approximate distance to curved surface ( <= actual distance )
//
    distR= (1.0 - p*norm) * radius / 2.0;
    
//
// Distance to z-cut plane
//
    distZ= p.z() - fZCut1;
    if (distZ < 0.0)
      distZ= fZCut2 - p.z();

//
// Distance to closest surface from inside
//
    if (distZ < 0.0 || distR < 0.0)
      {
        return 0.0;
      }
    else
      {
        return (distZ < distR) ? distZ : distR;
      }
}

// -------------------------------------------------------------------------------------------

// Create a List containing the transformed vertices
// Ordering [0-3] -fDz cross section
//          [4-7] +fDz cross section such that [0] is below [4],
//                                             [1] below [5] etc.
// Note:
//  Caller has deletion resposibility
//  Potential improvement: For last slice, use actual ending angle
//                         to avoid rounding error problems.

G4ThreeVectorList*
dywEllipsoid::CreateRotatedVertices(const G4AffineTransform& pTransform,
                                G4int& noPolygonVertices) const
{
  G4ThreeVectorList *vertices;
  G4ThreeVector vertex;
  G4double meshAnglePhi,meshRMaxFactor,
    crossAnglePhi,coscrossAnglePhi,sincrossAnglePhi,sAnglePhi;
  G4double meshTheta,crossTheta,startTheta;
  G4double rMaxX,rMaxY,rMaxZ,rMaxMax, rx,ry,rz;
  G4int crossSectionPhi,noPhiCrossSections,crossSectionTheta,noThetaSections;

  // Phi cross sections
    
  // noPhiCrossSections=G4int (M_PI/kMeshAngleDefault)+1;
  noPhiCrossSections=G4int (2*M_PI/kMeshAngleDefault)+1;
    
  if (noPhiCrossSections<kMinMeshSections)
    {
      noPhiCrossSections=kMinMeshSections;
    }
  else if (noPhiCrossSections>kMaxMeshSections)
    {
      noPhiCrossSections=kMaxMeshSections;
    }
  // meshAnglePhi=M_PI/(noPhiCrossSections-1);
  meshAnglePhi=2.0*M_PI/(noPhiCrossSections-1);
    
// Set start angle such that mesh will be at fRMax
// on the x axis. Will give better extent calculations when not rotated.
    
  sAnglePhi = -meshAnglePhi*0.5;

  // Theta cross sections
    
  noThetaSections = G4int(M_PI/kMeshAngleDefault)+3;
    
  if (noThetaSections<kMinMeshSections)
    {
      noThetaSections=kMinMeshSections;
    }
  else if (noThetaSections>kMaxMeshSections)
    {
      noThetaSections=kMaxMeshSections;
    }
  meshTheta= M_PI/(noThetaSections-2);
    
// Set start angle such that mesh will be at fRMax
// on the z axis. Will give better extent calculations when not rotated.
    
  startTheta = -meshTheta*0.5;

  meshRMaxFactor =  1.0/cos(0.5*dyw_hypot(meshAnglePhi,meshTheta));
  rMaxMax= (fRx > fRy ? fRx : fRy);
  if (fRz > rMaxMax) rMaxMax= fRz;
  rMaxX= fRx + rMaxMax*(meshRMaxFactor-1.0);
  rMaxY= fRy + rMaxMax*(meshRMaxFactor-1.0);
  rMaxZ= fRz + rMaxMax*(meshRMaxFactor-1.0);
  G4double* cosCrossTheta = new G4double[noThetaSections];
  G4double* sinCrossTheta = new G4double[noThetaSections];    
  vertices=new G4ThreeVectorList(noPhiCrossSections*noThetaSections);
  if (vertices && cosCrossTheta && sinCrossTheta)
    {
      for (crossSectionTheta=0;crossSectionTheta<noThetaSections;crossSectionTheta++)
        {
          // Compute sine and cosine table (for historical reasons)
          crossTheta=startTheta+crossSectionTheta*meshTheta;
          cosCrossTheta[crossSectionTheta]=cos(crossTheta);
          sinCrossTheta[crossSectionTheta]=sin(crossTheta);
        }
      for (crossSectionPhi=0;crossSectionPhi<noPhiCrossSections;crossSectionPhi++)
        {
          crossAnglePhi=sAnglePhi+crossSectionPhi*meshAnglePhi;
          coscrossAnglePhi=cos(crossAnglePhi);
          sincrossAnglePhi=sin(crossAnglePhi);
          for (crossSectionTheta=0;crossSectionTheta<noThetaSections;crossSectionTheta++)
            {
              // Compute coordinates of cross section at section crossSectionPhi
              rx= sinCrossTheta[crossSectionTheta]*coscrossAnglePhi*rMaxX;
              ry= sinCrossTheta[crossSectionTheta]*sincrossAnglePhi*rMaxY;
              rz= cosCrossTheta[crossSectionTheta]*rMaxZ;
              if (rz < fZCut1)
                rz= fZCut1;
              if (rz > fZCut2)
                rz= fZCut2;
              vertex= G4ThreeVector(rx,ry,rz);
              vertices->push_back(pTransform.TransformPoint(vertex));
            }    // Theta forward     
        }       // Phi
      noPolygonVertices = noThetaSections ;
    }
  else
    {
      G4Exception("dywEllipsoid::CreateRotatedVertices Out of memory - Cannot alloc vertices", // issue
                        "", //Error Code
                        FatalException, // severity
                        "");
    }

  delete[] cosCrossTheta;
  delete[] sinCrossTheta;

  return vertices;
}

// ---------------------------------------------------------------------------------------

void dywEllipsoid::DescribeYourselfTo (G4VGraphicsScene& scene) const
{
//#if (G4VERSIONCODE <= 40700)
//  scene.AddThis (*this);       // function was named AddThis for a long time...
//#else
  scene.AddSolid (*this);      // renamed to AddSolid in Geant4 7.01
//#endif
}

G4VisExtent dywEllipsoid::GetExtent() const
{
  // Define the sides of the box into which the dywEllipsoid instance would fit.
  return G4VisExtent (-fRmax, fRmax, -fRmax, fRmax, -fRmax, fRmax);
}

G4NURBS* dywEllipsoid::CreateNURBS () const
{
    return new G4NURBSbox (fRmax, fRmax, fRmax);       // Box for now!!!
}

// ================================================================

class dywPolyhedronEllipsoid : public G4Polyhedron {
 public:
  dywPolyhedronEllipsoid(G4double rx, G4double ry, G4double rz, G4double ZCut1,
                        G4double ZCut2);
  using G4Polyhedron::operator=;
  virtual G4Visible& operator=(const G4Visible &from)
    { return G4Visible::operator = (from); }
};

dywPolyhedronEllipsoid::dywPolyhedronEllipsoid(G4double rx, G4double ry,
                                             G4double rz, G4double ZCut1,
                                             G4double ZCut2)
/***********************************************************************
 *                                                                     *
 * Name: dywPolyhedronEllipsoid                                       *
 * Author: G.Horton-Smith (Tohoku)         Revised: 1999.11.11         *
 *                                                                     *
 * Function: Constructor of polyhedron for   Ellipsoid                 *
 *                                                                     *
 * Input: rx   - x "radius"                                            *
 *        ry   - y "radius"                                            *
 *        rz   - z "radius"                                            *
 *        ZCut1 - z-plane lower cut                                    *
 *        ZCut2 - z-plane upper cut                                    *
 *                                                                     *
 ***********************************************************************/
{
  //   C H E C K   I N P U T   P A R A M E T E R S

  if (ZCut1 >= rz || ZCut2 <= -rz || ZCut1 > ZCut2) {
    G4cout << "dywPolyhedronEllipsoid: wrong ZCut1 = " << ZCut1
           << " ZCut2 = " << ZCut2
           << " for given rz = " << rz << G4endl;
    return;
  }
  if (rz <= 0.0) {
    G4cout << "dywPolyhedronEllipsoid: bad z radius: rz = " << rz
      << G4endl;
    return;
  }

  G4double dthe, sthe;
  G4int cutflag;
  cutflag= 0;
  if (ZCut2 >= rz)
    {
      sthe= 0.0;
    }
  else
    {
      sthe= acos(ZCut2/rz);
      cutflag++;
    }
  if (ZCut1 <= -rz)
    {
      dthe= M_PI - sthe;
    }
  else
    {
      dthe= acos(ZCut1/rz)-sthe;
      cutflag++;
    }

  //   P R E P A R E   T W O   P O L Y L I N E S
  //   generate sphere of radius rz first, then rescale x and y later

  G4int ns = (GetNumberOfRotationSteps() + 1) / 2;
  G4int np1 = G4int(dthe*ns/M_PI) + 2 + cutflag;

  G4double *zz, *rr;
  zz = new G4double[np1+1];
  rr = new G4double[np1+1];
  if (!zz || !rr)
    {
      G4Exception("Out of memory in dywPolyhedronEllipsoid!", // issue
                        "", //Error Code
                        FatalException, // severity
                        "");
    }

  G4double a = dthe/(np1-cutflag-1);
  G4double cosa, sina;
  G4int j=0;
  if (sthe > 0.0)
    {
      zz[j]= ZCut2;
      rr[j]= 0.;
      j++;
    }
  for (G4int i=0; i<np1-cutflag; i++) {
    cosa  = cos(sthe+i*a);
    sina  = sin(sthe+i*a);
    zz[j] = rz*cosa;
    rr[j] = rz*sina;
    j++;
  }
  if (j < np1)
    {
      zz[j]= ZCut1;
      rr[j]= 0.;
      j++;
    }
  if (j > np1)
    G4Exception("Logic error in dywPolyhedronEllipsoid, memory corrupted!", // issue
                        "", //Error Code
                        FatalException, // severity
                        "");
  if (j < np1)
    {
      G4cout << "Warning: logic error in dywPolyhedronEllipsoid." << G4endl;
      np1= j;
    }
  zz[j] = 0.;
  rr[j] = 0.;

  
  //   R O T A T E    P O L Y L I N E S

  RotateAroundZ(0, 0.0, 2.0*M_PI, np1, 1, zz, rr, -1, 1); 
  SetReferences();

  delete [] zz;
  delete [] rr;

  // rescale x and y vertex coordinates
  {
    G4Point3D * p= pV;
    for (G4int i=0; i<nvert; i++, p++) {
      p->setX( p->x() * rx/rz );
      p->setY( p->y() * ry/rz );
    }
  }
}

G4Polyhedron* dywEllipsoid::CreatePolyhedron () const
{
    return new dywPolyhedronEllipsoid (fRx, fRy, fRz, fZCut1, fZCut2);
}

// ******************************  End of dywEllipsoid.cc  ****************************************

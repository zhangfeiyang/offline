#ifndef Calib_GuideTube_Construction_hh
#define Calib_GuideTube_Construction_hh

#include "SniperKernel/ToolBase.h"
#include "DetSimAlg/IDetElement.h"
#include "globals.hh"

#include"G4SubtractionSolid.hh"

class G4Tubs;
class G4Torus;
class G4Sphere;
class G4Ellipsoid;
class G4LogicalVolume;
class G4VPhysicalVolume;
class G4Material;

class Calib_GuideTube_Construction: public IDetElement,
                             public ToolBase{
public:
    G4LogicalVolume* getLV();
    bool inject(std::string motherName, IDetElement* other, IDetElementPos* pos);

    Calib_GuideTube_Construction(const std::string& name);
    ~Calib_GuideTube_Construction();

private:
    void initMaterials();
    void initVariables();

    void makeSurftubeLogical();
	void makevacSurftubeLogical();
	void makevacSurftubePhysical();
	void SetGuideTubeReflectivity();
	void makeGTLogical();
	void makeGTPhysical();
	void makeCableLogical();
	void makeCablePhysical();
    void makeSourceEnclosureLogical();
    void makeSourceEnclosurePhysical();

private:
	G4Torus*    solidSurftube;
    G4LogicalVolume* logicSurftube;

    G4Torus*    solidvacSurftube;
    G4LogicalVolume* logicvacSurftube;
    G4VPhysicalVolume* physivacSurftube;

    G4Torus*    solidGT;
    G4LogicalVolume* logicGT;
    G4VPhysicalVolume* physiGT;

    G4Torus*    solidCable;
    G4LogicalVolume* logicCable;
    G4VPhysicalVolume* physiCable;

    G4SubtractionSolid* solidSourceEnclosure;
    G4Tubs* solidSourceEnclosurea;
    G4Tubs* solidSourceEnclosureb;
    G4LogicalVolume* logicSourceEnclosure;
    G4VPhysicalVolume* physiSourceEnclosure;

private:
    G4Material* Acrylic;
    G4Material* Teflon;                                                               
    G4Material* SS;                                                               
    G4Material* Vacuum;                                                           
    G4Material* Mylar;  
    G4Material* Steel; 
    G4Material* Air;
    G4Material* Al;
    G4Material* Water;
	bool m_use_source;
	double m_theta;
};

#endif

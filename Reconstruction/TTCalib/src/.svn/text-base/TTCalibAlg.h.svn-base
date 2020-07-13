/*
TotTracker Calib


Author: A.Meregaglia, C.Jollet (IPHC)
*/


#ifndef TTCalibAlg_h
#define TTCalibAlg_h

#include "SniperKernel/AlgBase.h"
#include "TVector3.h"
#include "TF1.h"
#include "TTree.h"
#include "TMinuit.h"
#include <string>
#include "Geometry/TTGeomSvc.h"

//#include "DetSimAlg/IDetElement.h"

class NavBuffer;
class CdGeom;

class TTCalibAlg: public AlgBase
{
    public:
	TTCalibAlg(const std::string& name);
	~TTCalibAlg();

	bool initialize();
	bool execute();
	bool finalize();

    private:

   // private function
      std::string StringconvertDecimalToBinary(int, int);

      TTGeomSvc* tt_pos_svc;
	// Sniper
	JM::NavBuffer* m_buf;
	CdGeom*  m_cdGeom;	
	int m_evt_id;
	//IDetElement *de;
	double meangain;
};
#endif // TTCalibAlg.h

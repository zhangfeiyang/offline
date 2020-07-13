/*
TotTracker Tracking


Author: A.Meregaglia, C.Jollet (IPHC)
*/


#ifndef TTTrackingAlg_h
#define TTTrackingAlg_h

#include "SniperKernel/AlgBase.h"
#include "TVector3.h"
#include "TF1.h"
#include "TTree.h"
#include "TMinuit.h"
#include <string>

class NavBuffer;
class CdGeom;

class TTTrackingAlg: public AlgBase
{
    public:
	TTTrackingAlg(const std::string& name);
	~TTTrackingAlg();

	bool initialize();
	bool execute();
	bool finalize();

    private:
  // private function
   std::string StringconvertDecimalToBinary(int, int);

  // variable
	// geometry
	std::string m_det_type;

	// Sniper
	JM::NavBuffer* m_buf;
	CdGeom*  m_cdGeom;	
	int m_evt_id;

	// TREE
	TTree* m_evt_treeTTReco;
	int m_eventID;
	int m_NTracks;
	int m_NTotPoints;
	int m_NPoints[100];
	double m_PointX[200];
	double m_PointY[200];
	double m_PointZ[200];
	double m_Coeff0[20];
	double m_Coeff1[20];
	double m_Coeff2[20];
	double m_Coeff3[20];
	double m_Coeff4[20];
	double m_Coeff5[20];
	double m_Chi2[20];

};
#endif // TTTrackingAlg.h

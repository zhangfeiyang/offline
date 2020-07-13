/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#ifndef STEEPRISEALG_H
#define STEEPRISEALG_H

#include "SniperKernel/AlgBase.h"
#include "EvtNavigator/NavBuffer.h"
#include "Event/RecHeader.h"
#include "Event/CalibHeader.h"
#include "TVector3.h"
#include <list>
#include "SmartRecHelperSvc/HitHistogram.h"
using std::list;
#include "Math/Minimizer.h"
#include "Math/Functor.h"
#include "SmartRecHelperSvc/SmartRecHelperSvc.h"
#include "Identifier/CdID.h"

class TFitterMinuit;
class SteepRiseAlg: public AlgBase 
{
    public:
        SteepRiseAlg(const std::string& name); 
        ~SteepRiseAlg(); 

        bool initialize(); 
        bool execute(); 
        bool finalize(); 
       
	private:
		unsigned int m_iEvt;
		JM::NavBuffer* m_buf; 
		SmartRecHelperSvc *m_helperSvc;
		const std::list<JM::CalibPMTChannel*> *chhlistptr;
		HitHistogram clusterHits;
		JM::RecHeader* recHeader;
	private:
		void LoadInitialpos();
		bool FindSteepestRiseTime();

	private:
		void LoadParameters(const double *params);
		bool FindPeakAndStart();
		double RiseTimeGoodness();
	private:
		ROOT::Math::Minimizer* minimizer;
		ROOT::Math::Functor riseTimeFunctor;
		std::string type;
		std::string algorithm;
		int printLevel;
		TVector3 recPos;
		double rec_x;
		double rec_y;
		double rec_z;
		double sigma_x;
		double sigma_y;
		double sigma_z;
		unsigned int start_i;
		unsigned int peak_i;
		friend class FCNHelper;
};
class FCNHelper {
	public:
		static void SetAlg(SteepRiseAlg *alg) { fAlg = alg; };
		static double FCN(const double *par) {
			fAlg->LoadParameters(par);
			return fAlg->RiseTimeGoodness();
		};
	private:
		static SteepRiseAlg *fAlg;
}; 
#endif

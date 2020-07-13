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
using std::list;
#include "SmartRecHelperSvc/HitHistogram.h"
#include "SmartRecHelperSvc/SmartRecHelperSvc.h"
#include "SmartRecHelperSvc/ClusterHit.h"
#include "Identifier/CdID.h"
#include "Identifier/Identifier.h"

class ChargeCenterAlg: public AlgBase {
    public:
        ChargeCenterAlg(const std::string& name); 
        ~ChargeCenterAlg(); 

        bool initialize(); 
        bool execute(); 
        bool finalize(); 
       
	private:
		unsigned int m_iEvt;
		HitHistogram clusterHits;
		JM::NavBuffer* m_buf; 
		SmartRecHelperSvc *m_helperSvc;
		const std::list<JM::CalibPMTChannel*> *chhlistptr;
		unsigned int start_i;
		unsigned int peak_i;
		unsigned int end_i;
		double dark_hit_rate;
		TVector3 recPos;
		double rec_x;
		double rec_y;
		double rec_z;
		double m_preWindow;
		double m_postWindow;
		bool m_forceRec;
		std::string m_calibInputPath;
		std::string m_recOutputPath;
		double CL;
		double m_clusterLengthThreshold;
		double m_calibFactor;
		JM::RecHeader* recHeader;
	private:
		double expected_dark_hit() const {
			return m_helperSvc->GetExpectedDarkHit();
		}
		unsigned int PoissonLowerLimit(double mu) const;
		unsigned int PoissonUpperLimit(double mu) const;
		bool FindRecPos();
		bool FindPeakAndStart();
		bool WriteToRecHeader();
};
#endif

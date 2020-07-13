/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#ifndef PosRecTimeLikeAlg_H
#define PosRecTimeLikeAlg_H

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

class TFile;
class TH1D;
class TFitterMinuit;
class PosRecTimeLikeAlg: public AlgBase 
{
    public:
        PosRecTimeLikeAlg(const std::string& name); 
        ~PosRecTimeLikeAlg(); 

        bool initialize(); 
        bool execute(); 
        bool finalize(); 
       
	private:
		unsigned int m_iEvt;
		JM::NavBuffer* m_buf; 
		SmartRecHelperSvc *m_helperSvc;
		const std::list<JM::CalibPMTChannel*> *chhlistptr;
		HitHistogram clusterHits;
		JM::RecHeader* originRecHeader;
		JM::RecHeader* recHeader;
	private:
		bool LoadInitialpos();
		bool FitRecPos();

	private:
		bool PrepareInput();
		void LoadParameters(const double *params);
		bool FindPeakAndStart();
		bool Goodness();
		bool LoadPdf();
	private:
		bool use_firstHitOnly;
		list<double> time_v;
		list<unsigned int> pmtId_v;
		list<double> charge_v;
	private:
		std::string File_path; 
        TFile* Time_1hit;
        TFile* Time_2hit;
        TFile* Time_3hit;
        TFile* Time_4hit;
        TFile* Time_5hit;
        TH1D* pdf_1hit;
        TH1D* pdf_2hit;
        TH1D* pdf_3hit;
        TH1D* pdf_4hit;
        TH1D* pdf_5hit;
	private:
		ROOT::Math::Minimizer* minimizer;
		ROOT::Math::Functor riseTimeFunctor;
		std::string type;
		std::string algorithm;
		double tolerance;
		int printLevel;
		TVector3 recPos;
		double t0;
		double goodness;
		double rec_x;
		double rec_y;
		double rec_z;
		double peak_t;
		double sigma_x;
		double sigma_y;
		double sigma_z;
		double sigma_t;
		unsigned int start_i;
		unsigned int peak_i;
		friend class FCNHelper;
};
#endif

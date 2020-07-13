/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#ifndef NpmtLikeRecAlg_H
#define NpmtLikeRecAlg_H

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
class NpmtLikeRecAlg: public AlgBase 
{
    public:
        NpmtLikeRecAlg(const std::string& name); 
        ~NpmtLikeRecAlg(); 

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
		std::string m_calibInputPath;
		std::string m_recInputPath;
		std::string m_recOutputPath;
    std::string m_clusterInputPath;
  private:
    double originX(); 
    double originY();
    double originZ();
    double originPosQuality();
	private:
		bool LoadInitialpos();
		bool FitRecPos();

	private:
		bool PrepareInput();
		void LoadParameters(const double *params);
		bool FindStartAndEnd();
		bool Goodness();
		double lnPoissonlikelihood(double M,double T);
	private:
		bool fired[60000];
		bool darkzone[60000];
		double weight[60000];
	private:
		ROOT::Math::Minimizer* minimizer;
		ROOT::Math::Functor riseTimeFunctor;
		std::string type;
		std::string algorithm;
		double tolerance;
		int printLevel;
		bool use_3inchPMT;
		TVector3 recPos;
    double m_clusterLength;
		double npe;
		double npe0;
		double npe_sigma;
		double ly;
		double qch(double npe);
		double goodness;
		unsigned int start_i;
		unsigned int end_i;
		double Ndarkhits;
		double Ndarkhits_3inch;
		friend class FCNHelper;
};
#endif

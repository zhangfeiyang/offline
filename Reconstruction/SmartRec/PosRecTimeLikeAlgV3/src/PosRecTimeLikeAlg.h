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
    double m_clusterLength; // Unit: ns
		HitHistogram clusterHits;
		JM::RecHeader* originRecHeader;
		JM::RecHeader* recHeader;
		std::string m_calibInputPath;
		std::string m_recInputPath;
		std::string m_clusterInputPath;
		std::string m_recOutputPath;
	private:
		bool LoadInitialpos();
		bool FitRecPos();

	private:
		bool PrepareInput();
		void LoadParameters(const double *params);
		bool FindPeak();
		bool Goodness();
		bool LoadPdf();
		bool IncludeDNToPdf();
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
		bool use_firstHitOnly;
		list<double> time_v;
		list<unsigned int> pmtId_v;
		list<double> charge_v;
		double tolerance;
		TVector3 recPos;
		double t0;
		double goodness;
		double step_length;
		bool improved;
		double best_goodness;
    double m_N_dark_hit;
		TVector3 best_recPos;
		double best_t0;
		double best_step_length;
		double rec_x;
		double rec_y;
		double rec_z;
		double peak_t;
		double sigma_x;
		double sigma_y;
		double sigma_z;
		double sigma_t;
		unsigned int peak_i;
		int x_move;
		int y_move;
		int z_move;
		int t_move;
		int last_x_move;
		int last_y_move;
		int last_z_move;
		int last_t_move;
		int next_x_move;
		int next_y_move;
		int next_z_move;
		int next_t_move;
	private:
		bool Try8Direction(const double step_length);
		bool sychronize_with_cache();
		bool new_goodness();
		double cached_goodness[81];
		double cached_x[81];
		double cached_y[81];
		double cached_z[81];
		double cached_t[81];
		double cached_length;
		double new_cached_goodness[81];
		double new_cached_x[81];
		double new_cached_y[81];
		double new_cached_z[81];
		double new_cached_t[81];
		bool cach_filled;
		int required_index();
		int index();
};
#endif

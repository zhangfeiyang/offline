/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#ifndef SMARTRECHELPERSVC_H
#define SMARTRECHELPERSVC_H

#include "SniperKernel/SvcBase.h"
#include "TVector3.h"
#include "Identifier/Identifier.h"

#include <list>
using std::list;
#include <vector>
using std::vector;

#include "Event/CalibPMTChannel.h"
using JM::CalibPMTChannel;

#include "SmartRecHelperSvc/Cluster.h"
#include "SmartRecHelperSvc/HitHistogram.h"

class CdGeom; 
class TFile;
class TTree;
class SmartRecHelperSvc : public SvcBase {
  public :
    SmartRecHelperSvc(const std::string &name);
	~SmartRecHelperSvc();

    bool initialize();
    bool finalize();

	bool CachePMTCenter();
    double TOF(const TVector3 &recPos,const unsigned pmtId);
    bool CorrectTOFAndCollectHits(const TVector3 &recPos,const list<CalibPMTChannel*> &chhlist, HitHistogram &clusterHits);
    bool Clusterize(const TVector3 &recPos,const list<CalibPMTChannel*> &chhlist,vector<Cluster*> &clusters);
    bool WrapOneCluster(const HitHistogram &clusterHits,unsigned int cluster_start,unsigned int cluster_end,vector<Cluster*> &clusters);
    double GetDarkRate() const;
	double GetWaveformRecEff() const;
    double GetDarkRate3inch() const;
	double GetExpectedDarkHit() const;
    const TVector3 &GetPMTCenter(const unsigned int pmtId) const;
	unsigned int PoissonLowerLimit(double mu,double CL = 0.9) const;
	unsigned int PoissonUpperLimit(double mu,double CL = 0.9) const;
	bool IsInDarkZone(const TVector3 &recPos,const unsigned pmtId) const;
	double AbsWeight(const TVector3 &pos,const unsigned int pmtId) const ;
	double AccWeight(const TVector3 &pos,const unsigned int pmtId) const ;
  private:
	double TOF_fromRecTimeLike(const TVector3 &recPos,const unsigned int pmtId);
	double GetPhi(const TVector3 &pos,const TVector3 &pmtPos);
	bool GetScatterPos(const TVector3 &pos,const TVector3 &pmtPos,TVector3 &scatterPos) const;
  private:
    CdGeom*  m_cdGeom; 
    double m_darkRate;
    double m_darkRate3inch;
	double m_waveformRecEff;
	bool m_staticGeometryLib;
	bool m_useFindScatter;
	TFile *pmtpos_file;
	TTree *pmtpos_tree;
	TVector3 cached_center[60000];
	TVector3 *m_pmtCenter;
	double N_dark_hit;
  private:
	unsigned int m_startSearchWindow;
	unsigned int m_endSearchWindow;
	unsigned int m_endSearchWindowHE;
	double m_hEThreshold;
	double m_clusterLeastDur;
	double CL;
	double m_clusterLengthThreshold;
	double m_skippAfterCluster;
	double m_preWindow;
	double m_postWindow;
	double effAttLen;
  public:
    //double TOF(const TVector3 &recPos,const Identifier &logicCh);
	//const TVector3 GetPMTCenter(const Identifier &logicCh);
	//double AbsWeight(const TVector3 &pos,const Identifier &logicCh);
	//double AccWeight(const TVector3 &pos,const Identifier &logicCh);
	//double TOF_fromRecTimeLike(const TVector3 &recPos,const Identifier &logicCh);
	//double TOF_findscatter(const TVector3 &recPos,const Identifier &logicCh);
};

class ScatterHelper {
	public:
		static double equation(double x);
		static bool SetPos(const TVector3 &Pos, const TVector3 &PmtPos);
		static bool SetPhi(double x);
		static bool GetScatterPos(TVector3 &scatterPos);
		static bool Dump();
	private:
		static TVector3 pos;
		static TVector3 pmtPos;
		static double a;
		static double b;
		static double c;
		static double d;
		static double e;
		static double theta;
		static double cos_theta;
		static double alpha;
		static double phi;
		static double cos_theta_i;
		static double sin_theta_i;
		static double cos_theta_o;
		static double sin_theta_o;
		static double ni;
		static double no;
		static double r_threshold;
		friend class SmartRecHelperSvc;
};
#endif

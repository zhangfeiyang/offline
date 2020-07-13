/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#ifndef HITHISTOGRAM_H
#define HITHISTOGRAM_H
#include "Identifier/Identifier.h"
#include <list>
using std::list;
class ClusterHit;
class TTree;
class HitHistogram {
  public:
    HitHistogram(double BinWidth,double TL,double TR);
    ~HitHistogram();
    bool Insert(const unsigned pmtId, const double charge,const double rawTime,const double TOF);
    const list<ClusterHit*> *GetBin(unsigned int bin) const;
    unsigned int GetEntries(const unsigned int bin) const;
    unsigned int GetEntries(const unsigned int bin,const unsigned int end) const;
    unsigned int GetNbins() const { return Nbins; };
    double GetBinWidth() const { return binWidth; };
	double GetTL() const { return tL; };
	double GetTR() const { return tR; };
	double GetBinCenter(unsigned int bin) const { return tL+(bin+0.5)*binWidth; }; // bin start from 0
    bool InSafeWindow(unsigned int cluster_start_i,unsigned int cluster_end_i) const {
		return InSafeWindow(GetBinCenter(cluster_start_i),GetBinCenter(cluster_end_i));
	}
    bool InSafeWindow(double cluster_start,double cluster_end) const {
      return (cluster_start>0-TOF_min)&&(cluster_end<1250-TOF_max);
    };
	TTree *GetHits(unsigned int start_i,unsigned int end_i);
	bool Reset();
  private:
	list<ClusterHit*> *GetData(const unsigned int bin) const;
  private:
    double binWidth;
    double tL;
    double tR;
    unsigned int Nbins;
    double TOF_min;
    double TOF_max;
    list<ClusterHit*> **data;
};
#endif

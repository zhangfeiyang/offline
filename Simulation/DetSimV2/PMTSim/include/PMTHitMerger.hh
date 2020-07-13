/*
 * =====================================================================================
 *
 *       Filename:  PMTHitMerger.hh
 *
 *    Description:  This class is used to merge hits in a time window.
 *                  It is used by PMT SD and voxel method.
 *                  PMT SD will maintain Hit Collection.
 *                  The main owner of Merger is PMTSDMgr. 
 *      Work flow:  
 *                  1. doMerge, try to save the hit in merge mode
 *                  2. saveHit, if not merge, create new hit and put it into collection
 *
 *         Author:  Tao Lin (lintao@ihep.ac.cn), 
 *
 * =====================================================================================
 */
#ifndef PMTHitMerger_hh
#define PMTHitMerger_hh

#include "dywHit_PMT.hh"
#include "dywHit_PMT_muon.hh"
#include <cassert>
#include <map>

class PMTHitMerger {
public:
    PMTHitMerger();

    bool doMerge(int pmtid, double hittime);
    bool saveHit(dywHit_PMT* hit);
    bool saveHit(dywHit_PMT_muon* hit);

    // call init at begin of event
    bool init(dywHit_PMT_Collection* hitcol);
    bool init(dywHit_PMT_muon_Collection* hitcol);

    void setMergeFlag(bool flag) { m_merge_flag = flag; }
    bool getMergeFlag() { return m_merge_flag; }

    void setTimeWindow(double tw) { m_time_window = tw; }
    double getTimeWindow() { return m_time_window; }

    bool hasNormalHitType() { return hitCollection != 0; }
    bool hasMuonHitType() { return hitCollection_muon != 0; }
private:

  // bool doMerge_normal(int pmtid, double hittime);
  // bool doMerge_muon(int pmtid, double hittime);

  dywHit_PMT_Collection* hitCollection;
  dywHit_PMT_muon_Collection* hitCollection_muon;
  // copy from dywSD_PMT_v2
  bool m_merge_flag;
  double m_time_window;

  std::map<int, std::vector<dywHit_PMT*> > m_PMThit;
  std::map<int, std::vector<dywHit_PMT_muon*> > m_PMThit_muon;
};

#endif

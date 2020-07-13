/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#ifndef SMARTRECO_H
#define SMARTRECO_H
#include "SniperKernel/AlgBase.h"
#include "EvtNavigator/NavBuffer.h"
#include "TVector3.h"
#include <list>
using std::list;
#include <vector>
using std::vector;
#include <map>
using std::map;
#include "Identifier/Identifier.h"
#include "Event/CalibPMTChannel.h"
using JM::CalibPMTChannel;
#include "SmartRecHelperSvc/HitHistogram.h"
class SmartRecHelperSvc;
class ClusterHit;

class SmartRec : public AlgBase {
  public:

    SmartRec(const std::string &name);
    ~SmartRec();

    bool initialize();
    bool execute();
    bool finalize();
  private:
    unsigned int m_iEvt;
    JM::NavBuffer* m_buf; 
    SmartRecHelperSvc *m_helperSvc;
	bool m_save_second_cluster;
	bool m_fill_empty_event;
	bool m_killRecHeader;
	std::string m_recInputPath;
	std::string m_calibInputPath;
	std::string m_calibOutputPath;
  std::string m_clusterOutputPath;
};
#endif

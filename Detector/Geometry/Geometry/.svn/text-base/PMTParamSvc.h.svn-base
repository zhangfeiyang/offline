#ifndef PMTParamSvc_h
#define PMTParamSvc_h

//
//  Description: allow user query PMT paramters from this service.
//               The parameters could be loaded from plain text or database.
//
//               It includes:
//               * PMT position. Note it's better to use RecGeomSvc, 
//                 because RecGeomSvc could load geometry from GDML/ROOT file.
//               * PMT type. 3inch or 20inch. Hamamatsu or NNVT or HZC
//               * TTS.
//
//               During query, user could use Identifier or PMTID used in detsim
//
//         Note: In ElecSim, there is a service called PmtParamSvc:
//                 Simulation/ElecSimV3/PmtParamSvc
//               We need to consider to unify these two services.
//
//               In the future, the Identifier could be also encoded with more info.
//
//       Author: Tao Lin <lintao@ihep.ac.cn> 2017-05-27
//


#include "SniperKernel/SvcBase.h"
#include <map>

enum PMTID_OFFSET_DETSIM {
  kOFFSET_CD_LPMT=0,
  kOFFSET_WP_PMT=30000,
  kOFFSET_CD_SPMT=300000
};

enum PMT_CATEGORY {
  kPMT_Unknown=-1,
  kPMT_NNVT,
  kPMT_Hamamatsu,
  kPMT_HZC
};

class PMTParamSvc: public SvcBase {
public:
  PMTParamSvc(const std::string& name);
  virtual ~PMTParamSvc();

  bool initialize();
  bool finalize();

  // User interface

  bool isCD(int pmtid);
  bool isWP(int pmtid);

  bool is20inch(int pmtid);
  bool is3inch(int pmtid);
  
  bool isNNVT(int pmtid);
  bool isHamamatsu(int pmtid);
  bool isHZC(int pmtid);

private:
  bool init_default();
  bool init_file();
private:
  std::string m_db_type; // * File * ROOT * MySQL ...
  std::string m_db_path; // file path of data
  // Note about this file format:
  //   [<pmtid> [catagory] [...]]
  // If some pmts are not listed in that file, we use the default values.

  std::map<int, int> m_pmt_categories; // 
};


#endif

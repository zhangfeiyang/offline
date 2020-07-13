#include <boost/python.hpp>
#include <boost/filesystem.hpp>
#include <Geometry/PMTParamSvc.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include <SniperKernel/SniperLog.h>
#include "SniperKernel/SvcFactory.h"

DECLARE_SERVICE(PMTParamSvc);

PMTParamSvc::PMTParamSvc(const std::string& name)
  : SvcBase(name)
  , m_db_type("File"), m_db_path()
{
  declProp("DBType", m_db_type);
  declProp("Path", m_db_path);
}

PMTParamSvc::~PMTParamSvc()
{

}

bool PMTParamSvc::initialize() {
  bool st;

  // init global info
  st = init_default();
  if (!st) { return st; }

  // FILE MODE
  if (m_db_type == "File") {
    st = init_file();
  } else if (m_db_type == "ROOT") {

  } else if (m_db_type == "MySQL") {

  } else {
  }

  return st;
}

bool PMTParamSvc::finalize() {
  return true;
}

bool PMTParamSvc::isCD(int pmtid) {
  return (kOFFSET_CD_SPMT<=pmtid and pmtid<kOFFSET_WP_PMT) 
      or (kOFFSET_CD_SPMT<=pmtid);
}

bool PMTParamSvc::isWP(int pmtid) {
  return (kOFFSET_WP_PMT<=pmtid and pmtid<kOFFSET_CD_SPMT);
}

bool PMTParamSvc::is20inch(int pmtid) {
  // FIXME: how about the PMTs in WP?
  return (pmtid<kOFFSET_WP_PMT);
}

bool PMTParamSvc::is3inch(int pmtid) {
  return (kOFFSET_CD_SPMT<=pmtid);
}

bool PMTParamSvc::isNNVT(int pmtid) {
  return is20inch(pmtid) and m_pmt_categories[pmtid] == kPMT_NNVT;
}

bool PMTParamSvc::isHamamatsu(int pmtid) {
  return is20inch(pmtid) and m_pmt_categories[pmtid] == kPMT_Hamamatsu;
}

bool PMTParamSvc::isHZC(int pmtid) {
  return is3inch(pmtid) 
         /*and m_pmt_categories[pmtid] == kPMT_HZC*/ // for now, all 3inch PMTs are HZC
         ;
}

// END User Interface

// Below is private methods

bool PMTParamSvc::init_default() {
  
  // CD/LPMT

  // WP/PMT

  // CD/SPMT

  return true;
}

bool PMTParamSvc::init_file() {
  bool st = true;

  // if file path is empty, we try to discover the data
  // * $JUNOTOP/data/Simulation/ElecSim
  // * $WORKTOP/data/Simulation/ElecSim (will override $JUNOTOP)
  if (m_db_path.empty()) {
    if (getenv("JUNOTOP")) {
      std::string s = getenv("JUNOTOP");
      s += "/data/Simulation/ElecSim/Hamamatsu_pmtID.txt";
      if (boost::filesystem::exists(s)) {
        m_db_path = s;
      }
    }
    if (getenv("WORKTOP")) {
      std::string s = getenv("WORKTOP");
      s += "/data/Simulation/ElecSim/Hamamatsu_pmtID.txt";
      if (boost::filesystem::exists(s)) {
        m_db_path = s;
      }
    }
  }

  if (!m_db_path.empty() && boost::filesystem::exists(m_db_path)) {
      LogInfo << "Loading parameters from file: " << m_db_path << std::endl;
  } else {
      LogError << "Can't find PMT parameters file '" << m_db_path << "'." << std::endl;
      st = false;
      return st;
  }

  std::ifstream input(m_db_path.c_str());
  std::string tmp_line;
  int pmtid;            // col 1
  std::string category; // col 2 (optional, default is Hamamatsu)
                        // NNVT, Hamamatsu, HZC


  while (input.good()) {
    std::getline(input, tmp_line);
    if (input.fail()) { break; }

    std::stringstream ss;
    ss << tmp_line;
    
    ss >> pmtid;
    if (ss.fail()) { continue; }

    // reset the default value if failed to parse
    ss >> category;
    if (ss.fail()) { category = "Hamamatsu"; }

    // check if pmt is already set
    if (m_pmt_categories.find(pmtid) != m_pmt_categories.end()) {
      LogWarn << " pmtid " << pmtid << " is already set. " << std::endl;
    }
    // save into m_pmt_categories
    if (category == "Hamamatsu") { 
      m_pmt_categories[pmtid] = kPMT_Hamamatsu;
    } else if (category == "NNVT") {
      m_pmt_categories[pmtid] = kPMT_NNVT;
    } else if (category == "HZC") {
      m_pmt_categories[pmtid] = kPMT_HZC;
    } else {
      LogError << "Unknown PMT category name: " << category << std::endl;
    }
  }

  return st;
}

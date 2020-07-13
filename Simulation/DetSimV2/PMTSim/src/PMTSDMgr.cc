
#include "PMTSDMgr.hh"
#include "dywSD_PMT.hh"
#include "dywSD_PMT_v2.hh"

#include "SniperKernel/SniperPtr.h"
#include "SniperKernel/ToolFactory.h"
#include "SniperKernel/SniperLog.h"
#include "SniperKernel/SniperException.h"

DECLARE_TOOL(PMTSDMgr);

PMTSDMgr::PMTSDMgr(const std::string& name)
    : ToolBase(name)
{
    m_merge_flag = false;
    m_time_window = 1000*ns;

    m_pmthitmerger = new PMTHitMerger();

    declProp("EnableMergeHit", m_merge_flag);
    declProp("MergeTimeWindow", m_time_window);
    // XXX need to switch.
    declProp("PMTSD", m_pmt_sd="dywSD_PMT_v2");
    // declProp("PMTSD", m_pmt_sd="dywSD_PMT");
    declProp("CollEffiMode", m_ce_mode="None");

    declProp("HitType", m_hit_type=1);

    declProp("CEFlatValue", m_ce_flat_value=0.9);
    // Ref to JUNO-DOC-1245
    declProp("CEFunction", m_ce_func="0.9*[0]/(1+[1]*exp(-[2]*x))");
    m_ce_func_params.push_back(1.006); // p0
    m_ce_func_params.push_back(0.9023);// p1
    m_ce_func_params.push_back(0.1273);// p2
    declProp("CEFuncParams", m_ce_func_params);

    declProp("DisableSD", m_disableSD=false);
}

PMTSDMgr::~PMTSDMgr() 
{
    delete m_pmthitmerger;
}

G4VSensitiveDetector* 
PMTSDMgr::getSD()
{
    G4VSensitiveDetector* ifsd = 0;
    if (m_pmt_sd == "dywSD_PMT") {
        dywSD_PMT* sd = new dywSD_PMT(objName());

        sd->setMergeFlag(m_merge_flag);
        sd->setMergeWindows(m_time_window);
        ifsd = sd;
    } else if (m_pmt_sd == "dywSD_PMT_v2") {
        dywSD_PMT_v2* sd = new dywSD_PMT_v2(objName());
        sd->setCEMode(m_ce_mode);
        // if flat mode
        sd->setCEFlatValue(m_ce_flat_value);
        // func mode
        sd->setCEFunc(m_ce_func, m_ce_func_params);
        sd->setMergeFlag(m_merge_flag);
        sd->setMergeWindows(m_time_window);
        sd->setMerger(m_pmthitmerger);
        sd->setHitType(m_hit_type);
        // configure the merger
        m_pmthitmerger->setMergeFlag(m_merge_flag);
        m_pmthitmerger->setTimeWindow(m_time_window);
        ifsd = sd;
        if (m_disableSD) {
            LogInfo << "dywSD_PMT_v2::ProcessHits is disabled now. " << std::endl;
            sd->disableSD();
        }
    }

    return ifsd;
}

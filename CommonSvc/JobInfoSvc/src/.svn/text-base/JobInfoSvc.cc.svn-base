#include "SniperKernel/SvcFactory.h"
#include "SniperKernel/SniperPtr.h"
#include "RootIOSvc/RootInputSvc.h"
#include "RootIOSvc/RootOutputSvc.h"
#include "JobInfoSvc/JobInfoSvc.h"
#include "JobInfo.h"

DECLARE_SERVICE(JobInfoSvc);

JobInfoSvc::JobInfoSvc(const std::string& name) : SvcBase(name)
    , m_iJobInfo(0)
    , m_oJobInfo(0)
{
    declProp("OfflineVersion", m_offline_version);
    declProp("CommandLine", m_job_cmd);
}

JobInfoSvc::~JobInfoSvc()
{
}

bool JobInfoSvc::initialize()
{
    SniperPtr<RootOutputSvc> outputSvc(this->getScope(), "OutputSvc");
    if (outputSvc.valid()) {
        m_oJobInfo = new JobInfo;
        m_oJobInfo -> setJobOption(m_job_cmd);
        m_oJobInfo -> setOfflineVersion(m_offline_version);
        outputSvc->attachObj("all", m_oJobInfo);
    }
    return true;
}

bool JobInfoSvc::finalize()
{
    if (m_iJobInfo) {
        delete m_iJobInfo;
    }
    return true;
}

const std::string& JobInfoSvc::getOfflineVersion()
{
    static std::string unknown = "unknown";
    if (!this->getJobInfo()) {
        return unknown;
    }
    return m_iJobInfo->getOfflineVersion();
}

bool JobInfoSvc::getJobInfo() 
{
    if (m_iJobInfo) {
        return true;
    }

    SniperPtr<RootInputSvc> inputSvc(this->getScope(), "InputSvc");
    if (!inputSvc.valid()) {
        return false;
    }
    TObject* obj = 0;
    bool ok = inputSvc->getObj(obj, "JobInfo");
    m_iJobInfo = static_cast<JobInfo*>(obj);
    return ok;
}

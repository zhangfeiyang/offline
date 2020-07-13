#include "BeginEvtHdl.h"
#include "FullStateNavBuf.h"
#include "RootIOSvc/RootInputSvc.h"
#include "SniperKernel/Incident.h"
#include "SniperKernel/SniperPtr.h"
#include "SniperKernel/SniperDataPtr.h"
#include "SniperKernel/SniperLog.h"
#include "SniperKernel/SniperException.h"

BeginEvtHdl::BeginEvtHdl(Task* par)
    : m_1stCall(true),
      m_par(par)
{
    SniperPtr<RootInputSvc> iSvc(m_par, "InputSvc");
    if ( iSvc.invalid() ) {
        LogFatal << "cann't find InputSvc for "
                 << m_par->scope() << m_par->objName() << std::endl;
        throw SniperException("InputSvc is invalid");
    }
    m_iSvc = iSvc.data();

    SniperDataPtr<FullStateNavBuf> pBuf(m_par, "/Event");
    if ( pBuf.invalid() ) {
        LogError << "cann't get the EvtNavigator Buffer" << std::endl;
        throw SniperException("NavBuffer is invalid");
    }
    m_buf = pBuf.data();
}

bool BeginEvtHdl::handle(Incident& /*incident*/)
{
    if ( m_1stCall ) {
        m_buf->init(m_iSvc->getInputStream("EvtNavigator"));
        m_1stCall = false;
    }

    if ( m_buf->next() ) {
        return true;
    }
    return Incident::fire("StopRun");
}

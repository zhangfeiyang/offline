#ifndef BEGIN_EVENT_HANDLER_H
#define BEGIN_EVENT_HANDLER_H

#include "SniperKernel/IIncidentHandler.h"

class Task;
class FullStateNavBuf;
class RootInputSvc;

class BeginEvtHdl : public IIncidentHandler
{
    public :

        BeginEvtHdl(Task* par);

        bool handle(Incident& incident);

    private :

        bool              m_1stCall;
        Task*             m_par;
        FullStateNavBuf*  m_buf;
        RootInputSvc*     m_iSvc;
};

#endif

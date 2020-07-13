/*=============================================================================
#
# Author: ZHANG Kun - zhangkun@ihep.ac.cn
# Last modified:	2014-09-01 01:22
# Filename:		RecSampleAlg.h
# Description: 
=============================================================================*/
#ifndef RecSampleAlg_h
#define RecSampleAlg_h


#include "SniperKernel/AlgBase.h"
#include "EvtNavigator/NavBuffer.h"

#include <string>

class RecGeomSvc; 
class CdGeom; 

class RecSampleAlg: public AlgBase 
{
    public:
        RecSampleAlg(const std::string& name); 
        ~RecSampleAlg(); 

        bool initialize(); 
        bool execute(); 
        bool finalize(); 

    private:

        bool createInput(); 
        int m_iEvt; 
        int m_createInput; 

        CdGeom*  m_cdGeom; 
        JM::NavBuffer* m_buf; 
};
#endif

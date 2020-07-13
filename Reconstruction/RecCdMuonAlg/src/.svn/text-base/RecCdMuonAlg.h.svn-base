/*=============================================================================
#
# Author: ZHANG Kun - zhangkun@ihep.ac.cn
# Last modified:	2015-05-11 01:39
# Filename:		RecCdMuonAlg.h
# Description: 
#
=============================================================================*/
#ifndef RecCdMuonAlg_h
#define RecCdMuonAlg_h 1

#include "SniperKernel/AlgBase.h"

#include "EvtNavigator/NavBuffer.h"
#include "RecCdMuonAlg/PmtProp.h"
#include "RecCdMuonAlg/Params.h"
#include <string>


class RecGeomSvc; 
class CdGeom; 
class IReconTool; 

class RecCdMuonAlg : public AlgBase
{
    public:  

        RecCdMuonAlg(const std::string& name);
        virtual ~RecCdMuonAlg();

        virtual bool execute();
        virtual bool initialize();
        virtual bool finalize();


    private:

        bool iniBufSvc(); 
        bool iniGeomSvc(); 
        bool iniPmtPos(); 
        bool iniRecTool(); 

        bool freshPmtData(); 

    private:

        int m_iEvt; 

        unsigned int m_totPmtNum; 

        double m_sigmaPmt3inch;
        double m_sigmaPmt20inch; 

        bool m_flagUse3inch;
        bool m_flagUse20inch;

        CdGeom*  m_cdGeom; 
        JM::NavBuffer* m_buf; 


        PmtTable m_pmtTable; 
        Params m_params; //set of parameters' key/value

        std::string m_recToolName; 
        IReconTool* m_recTool; 

        bool m_flagOpPmtpos;
};

#endif // RecCdMuonAlg_h

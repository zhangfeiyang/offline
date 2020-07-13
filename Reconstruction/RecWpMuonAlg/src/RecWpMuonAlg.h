/*=============================================================================
#
# Author: Jilei Xu - xujl@ihep.ac.cn
# Last modified:	2016-11-13 01:39
# Filename:		RecWpMuonAlg.h
# Description: reference RecCdMuonAlg
#
=============================================================================*/
#ifndef RecWpMuonAlg_h
#define RecWpMuonAlg_h 1

#include "SniperKernel/AlgBase.h"

#include "EvtNavigator/NavBuffer.h"
#include "RecWpMuonAlg/PmtProp.h"
#include "RecWpMuonAlg/Params.h"
#include <string>


class RecGeomSvc; 
class WpGeom; 
class IReconTool; 

class RecWpMuonAlg : public AlgBase
{
    public:  

        RecWpMuonAlg(const std::string& name);
        virtual ~RecWpMuonAlg();

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

        WpGeom*  m_wpGeom; 
        JM::NavBuffer* m_buf; 


        PmtTable m_pmtTable; 
        Params m_params; //set of parameters' key/value

        std::string m_recToolName; 
        IReconTool* m_recTool; 

        bool m_flagOpPmtpos;
};

#endif // RecWpMuonAlg_h

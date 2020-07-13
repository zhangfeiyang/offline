#ifndef JUNO_VIS_EVT_MGR_H
#define JUNO_VIS_EVT_MGR_H

//
//  Juno Visualization Event Manager
//
//  Author: Zhengyun You  2014-5-26
//

#include "TString.h"

namespace JM
{
    class SimEvent;
    class CalibEvent;
    class CDRecEvent;
    class RecHeader;
}

class TFile;
class TTree;

class JVisOpMgr;

class JVisEvtMgr 
{
    public :

        JVisEvtMgr();
        virtual ~JVisEvtMgr();

        bool initialize(TString simFile, TString calibFile, TString recFile, TString simusFile);
        bool checkEvt(int iEvt);
        bool readEvt(int iEvt);
        bool finalize();

        bool hasSim()   { return m_hasSim;   }
        bool hasCalib() { return m_hasCalib; }
        bool hasRec()   { return m_hasRec;   }
        bool hasSimus() { return m_hasSimus; }

        JM::SimEvent*   getSimEvent()   { return m_se; }
        JM::CalibEvent* getCalibEvent() { return m_ce; }
        JM::CDRecEvent*   getRecEvent()  { return m_re; }
        JVisOpMgr*      getOpMgr()      { return m_opMgr; }

        TString getEvtInfoText(); 

        void setVerbosity(int verb) { m_verb = verb; }
        int  getVerbosity() { return m_verb; }

    private :

        bool m_hasSim;    // SimEvet exist in file
        bool m_hasCalib;
        bool m_hasRec;
        bool m_hasSimus;

        TFile* m_simFile;
        TFile* m_calibFile;
        TFile* m_recFile;
        TFile* m_simusFile;

        TTree* m_simEventTree;
        TTree* m_calibEventTree;
        TTree* m_recEventTree;
        TTree* m_simusOpStepsTree;

        JM::SimEvent*   m_se;  // SimEvent object
        JM::CalibEvent* m_ce;  // CalibEvent object
        // JM::RecHeader*  m_rh;  // RecHeader object
        JM::CDRecEvent*   m_re;  // CDRecEvent object

        JVisOpMgr* m_opMgr;

        int m_verb;
};

#endif // JUNO_VIS_EVT_MGR_H


#ifndef LsqMuonRecTool_h
#define LsqMuonRecTool_h
#include "RecCdMuonAlg/IReconTool.h"
#include "SniperKernel/ToolBase.h"
#include "Event/RecHeader.h"
#include <TFitterMinuit.h>

class ChiSquareTime; 
class LsqMuonRecTool :public IReconTool,  public ToolBase
{
    public:
        LsqMuonRecTool (const std::string& name);
        virtual ~LsqMuonRecTool ();

        bool reconstruct(JM::RecHeader*); 
        bool configure(const Params*, const PmtTable* ); 

    private:
        double fcnminuit(const std::vector<double>&par); 

        int iniargs(TVector3& r0, double& t0, TVector3& direction, double& length);

    private:
        double m_LSRadius;      //radius of LS
        double m_clight;        //speed of light in vacuum
        double m_nLSlight;      //refraction of LS
        double m_vmuon;         //speed of muon

        const PmtTable* m_ptable; 
        std::string m_fname; //name of TFile contain fix line; 

        TFitterMinuit* minuit; 
        ChiSquareTime* fcn; 

};

#endif

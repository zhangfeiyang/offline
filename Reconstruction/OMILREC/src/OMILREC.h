#ifndef OMILREC_h 
#define OMILREC_h 

#include "EvtNavigator/NavBuffer.h"
#include "TFitterMinuit.h"
#include "TString.h"
#include "Minuit2/FCNBase.h"
#include "SniperKernel/AlgBase.h"
#include "Geometry/RecGeomSvc.h"
#include "Identifier/Identifier.h"
#include "TH1.h"
#include "TF1.h"
#include "TFile.h"
#include "TTree.h"
#include "TVector3.h"
#include "TString.h"
#include "TProfile.h"
#include "RootWriter/RootWriter.h"
#include "TGraph.h"
#include <string>
#include <map>
#include <vector>
#include "TAxis.h"

using  std::string;
class RecGeomSvc;
class CdGeom;
 
class TTree;

class OMILREC: public AlgBase 
{
    public:
        OMILREC(const std::string& name); 
        ~OMILREC(); 

        bool initialize(); 
        bool execute(); 
        bool finalize(); 
    
        bool Load_ExpectedPE();
        double Calculate_Energy_Likelihood(double, double, double, double);
     
        class MyFCN: public ROOT::Minuit2::FCNBase {
            public:
                MyFCN(OMILREC *alg) {m_alg = alg;}
                double operator() (const std::vector<double>& x) const {
                    return m_alg->Calculate_Energy_Likelihood(x[0],x[1],x[2],x[3]);
                }

                double Up() const {return 0.5;}
            private:
                OMILREC *m_alg;
        };

        TF1* f_non_li_positron;
          
        TF1* f_correction_1;
        TF1* f_correction_2;
       // double non_li_parameter[4];
       
        // correction function
        TF1 *f_correction;
       // TFile* sfile;

        TAxis* axis;
        std::map<double, TFile*> PELikeFunFile;
        std::map<double,TFile*>::iterator map_file;
        std::map<double, TGraph*> PELikeFunGraph;
        std::map<double,TGraph*>::iterator map_it;

    private:
        std::vector<double> CalibPos;

        int m_iEvt;
        JM::NavBuffer* m_buf; 
        
        int num_PMT;
        int PMT_HIT[90000];
      
       //Charge and hit time information
        std::vector<double> Readout_PE;
        std::vector<double> Readout_hit_time; 
        std::vector<TVector3> PMT_pos;
        

        //TFile* PMT_Geom;
       
        std::vector<TVector3> ALL_PMT_pos;

        //center detector geometry
        CdGeom*  m_cdGeom;

        TFitterMinuit* recminuit;
 
        string File_path; 

        //simulation file
        //std::string m_simfile;
        //TTree* evt;
        std::vector<double> Coor_x;
        std::vector<double> Coor_y;
        std::vector<double> Coor_z;

        double Total_num_PMT;
        double PMT_R ;
        double Ball_R;
        double LS_R;
        double pmt_r;
        double ChaCenRec_ratio;
        double m_Energy_Scale;
        
        double fap0;
        double fap1;
        double fap2;
        double fap3;
        double fap4;
        double fap5;
    
};
#endif

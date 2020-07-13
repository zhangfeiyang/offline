#ifndef _DEEX_
#define _DEEX_

#include <iostream>
#include <TROOT.h>
#include <TRandom.h>
#include <TFile.h>
#include <TTree.h>
#include <TString.h>
#include <map>
#include <vector>

class deex {

  public:
    deex(int Z, int N, TString datadir);
    ~deex() {};
   
    void initial(); 
    void CloseDeeFile();
    void CloseDeeGammaFile();
    TString isotopename(int Z);
    int PDG(TString parName);
    void LoadDeeData();
    void LoadDeeGammaData();
    void GetDeeProcess();
    
    std::vector<double> GetDeeParE();
    std::vector<int> GetDeePDG();
    int GetResNuelZ();
    int GetResNuelN();
    int GetDeexChannelID();

    double GetDeeGammaProcess(int ResZ, int ResN);
            
  private:
    TFile *Deefile;
    TFile *DeeGammafile;
    TTree *Nucldee;
    TTree *NulDeeGamma;
    TString Deedata;
    TString DeeGammadata;
    
  private:
    int deexZ;
    int deexN;
    int ResidualZ;
    int ResidualN;
    int DeexID;
    std::map<int, TString> isoname;
    std::map<TString, int> pdg;

    std::vector<double> deeParE;
    std::vector<int> deePDG;

    int chiID;
    int nGamma;
    double GammaE[20];
    int nNeutron;
    double NeutronE[20];
    int nProton;
    double ProtonE[20];
    int nDeuteron;
    double DeuteronE[20];
    int nTritium;
    double TritiumE[20];
    int nHe3;
    double He3E[20];
    int nAlpha;
    double AlphaE[20];

    int nlevel;
    int ResNuclZ;
    int ResNuclN;
    int ResNucllevel[100];
    double ResNuclEn[100];
    double ResNuclPop[100];
    
    
};

#endif


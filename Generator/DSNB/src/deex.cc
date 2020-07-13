#include "deex.h"
#include <iostream>
#include <TROOT.h>
#include <TRandom.h>
#include <TFile.h>
#include <TTree.h>
#include <TString.h>
#include <map>
#include <stdio.h>

using namespace std;

deex::deex(int Z, int N, TString datadir){

  initial();
  TString name = isotopename(Z);
  //Deedata = "/junofs/users/chengj/workdir/NC/generator/talys/talys_sample/";
  Deedata = datadir;
  Deedata += "/talys_sample/";
  Deedata += name;
  int A = Z + N;
  Deedata += A;
  Deedata += "deexcitation.root";

  DeeGammadata = datadir;
  DeeGammadata += "/talys_sample/";
  DeeGammadata += name;
  DeeGammadata += A;
  DeeGammadata += "deexcitationgamma.root"; 
  deexZ = Z;
  deexN = N;
   
}

void deex::initial() {
  ResidualZ=0;
  ResidualN=0;
  isoname.clear();
  pdg.clear();
  deeParE.clear();
  deePDG.clear();
}

TString deex::isotopename(int Z) {
  isoname.clear();
  isoname[6] = "C";                                                                   
  isoname[5] = "B";
  isoname[4] = "Be";
  isoname[3] = "Li";
  return isoname[Z];
}

int deex::PDG(TString parName) {
  pdg.clear();
  pdg["gamma"] = 22;
  pdg["neutron"] = 2112;
  pdg["proton"] = 2212;
  pdg["deuteron"] = 1000010020;
  pdg["tritium"] = 1000010030;
  pdg["he3"] = 1000020030;
  pdg["alpha"] = 1000020040;
  
  return pdg[parName];
}


void deex::LoadDeeData() {
  Deefile = new TFile(Deedata,"read");
  if(!Deefile) {
    cout << "not find right file!" << endl;
    //exit(0);
  }
  
  Nucldee = (TTree*)Deefile->Get("TreeNucldee");
  Nucldee->SetBranchAddress("chiID", &chiID);
  Nucldee->SetBranchAddress("nGamma", &nGamma);
  Nucldee->SetBranchAddress("GammaE", GammaE);
  Nucldee->SetBranchAddress("nNeutron", &nNeutron);
  Nucldee->SetBranchAddress("NeutronE", NeutronE);
  Nucldee->SetBranchAddress("nProton", &nProton);
  Nucldee->SetBranchAddress("ProtonE", ProtonE);
  Nucldee->SetBranchAddress("nDeuteron", &nDeuteron);
  Nucldee->SetBranchAddress("DeuteronE", DeuteronE);
  Nucldee->SetBranchAddress("nTritium", &nTritium);
  Nucldee->SetBranchAddress("TritiumE", TritiumE);
  Nucldee->SetBranchAddress("nHe3", &nHe3);
  Nucldee->SetBranchAddress("He3E", He3E);
  Nucldee->SetBranchAddress("nAlpha", &nAlpha);
  Nucldee->SetBranchAddress("AlphaE", AlphaE);

}

void deex::CloseDeeFile() {
  Deefile->Close();
}
void deex::LoadDeeGammaData() {
  DeeGammafile = new TFile(DeeGammadata,"read");
  if(!DeeGammafile) {
    cout << "not find right file!" << endl;
    //exit(0);
  }
  
  NulDeeGamma = (TTree*)DeeGammafile->Get("TreeNulDee");
  NulDeeGamma->SetBranchAddress("nlevel", &nlevel);
  NulDeeGamma->SetBranchAddress("ResNuclZ", &ResNuclZ);
  NulDeeGamma->SetBranchAddress("ResNuclN", &ResNuclN);
  NulDeeGamma->SetBranchAddress("ResNucllevel", ResNucllevel);
  NulDeeGamma->SetBranchAddress("ResNuclEn", ResNuclEn);
  NulDeeGamma->SetBranchAddress("ResNuclPop", ResNuclPop);
}
void deex::CloseDeeGammaFile() {
  DeeGammafile->Close();
}

void deex::GetDeeProcess() {
  LoadDeeData();
  int entries = (int)Nucldee->GetEntries();
  int entry = int(gRandom->Uniform(0,entries));
  Nucldee->GetEntry(entry);
  int nZ=0;
  int nN=0;
  DeexID = 1000000 + chiID; 
  if(nGamma>0) {
    for(int jj=0; jj<nGamma; jj++) {
      deeParE.push_back(GammaE[jj]);
      deePDG.push_back(PDG("gamma"));
    }
  }
  if(nNeutron>0) {
    for(int jj=0; jj<nNeutron; jj++) {
      deeParE.push_back(NeutronE[jj]);
      deePDG.push_back(PDG("neutron"));
      nN = nN+1;
    }
  }
  if(nProton>0) {
    for(int jj=0; jj<nProton; jj++) {
      deeParE.push_back(ProtonE[jj]);
      deePDG.push_back(PDG("proton"));
      nZ = nZ+1;
    }
  }
  if(nDeuteron>0) {
    for(int jj=0; jj<nDeuteron; jj++) {
      deeParE.push_back(DeuteronE[jj]);
      deePDG.push_back(PDG("deuteron"));
      nN = nN+1;
      nZ = nZ+1;
    }
  }
  if(nTritium>0) {
    for(int jj=0; jj<nTritium; jj++) {
      deeParE.push_back(TritiumE[jj]);
      deePDG.push_back(PDG("tritium"));
      nN = nN+2;
      nZ = nZ+1;
    }
  }
  if(nHe3>0) {
    for(int jj=0; jj<nHe3; jj++) {
      deeParE.push_back(He3E[jj]);
      deePDG.push_back(PDG("he3"));
      nN = nN+1;
      nZ = nZ+2;
    }
  }
  if(nAlpha>0) {
    for(int jj=0; jj<nAlpha; jj++) {
      deeParE.push_back(AlphaE[jj]);
      deePDG.push_back(PDG("alpha"));
      nN = nN+2;
      nZ = nZ+2;
    }
  }
  ResidualZ = deexZ - nZ;
  ResidualN = deexN - nN;
  CloseDeeFile();
}

std::vector<double> deex::GetDeeParE() {
  return deeParE;
}

std::vector<int> deex::GetDeePDG() {
  return deePDG;
}

int deex::GetResNuelZ(){
  return ResidualZ;
}

int deex::GetResNuelN(){
  return ResidualN;
}

int deex::GetDeexChannelID(){
  return DeexID;
}
double deex::GetDeeGammaProcess(int ResZ, int ResN) {
  LoadDeeGammaData();
  int entries2 = (int)NulDeeGamma->GetEntries();
  double gammaE = 0;
  std::map<double,double> channel_pro;
  double pro_initial = 0;
  channel_pro.clear();
  for(int ii=0; ii<entries2; ii++) {
    NulDeeGamma->GetEntry(ii);
    if(ResNuclZ == ResZ && ResNuclN == ResN) {
      for(int jj=0; jj<nlevel; jj++) {
        pro_initial = pro_initial + ResNuclPop[jj];
        channel_pro.insert(map<double, double> :: value_type(ResNuclEn[jj],ResNuclPop[jj]));
      }
    }
  }
  
  std::map<double, double>::iterator it;
  double last_pro = 0.;
  double curr_pro = 0.;
 
  double seed = gRandom->Uniform(0.,pro_initial);
  for(it = channel_pro.begin(); it!=channel_pro.end(); ++it) {
    curr_pro = (it->second) + last_pro;
    if(seed < curr_pro && seed >= last_pro) {
      gammaE = it->first;
      break;
    }
    last_pro = (it->second) + last_pro;
  }
  CloseDeeGammaFile();
  return gammaE;
} 

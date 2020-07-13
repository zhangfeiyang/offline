#include <iostream>
#include <fstream>
#include <cassert>
#include <CLHEP/Vector/ThreeVector.h>
#include <CLHEP/Units/PhysicalConstants.h>
#include <TROOT.h>
#include <TRandom.h>
#include <vector>
#include <TSystem.h>
#include <TFile.h>
#include <TH1.h>
#include <TTree.h>
#include <cstdlib>
#include <TChain.h>
#include <TString.h>
#include "deex.h"
#include <map>

using namespace std;
using namespace CLHEP;

void Usage();

void ProcessArgs(int argc, char** argv, long* rseed, int*nevents, char**data_dir, char**user_output);
Hep3Vector PointPosition();
bool IsExcited();
double GetMass(int pdg);
Hep3Vector PointPv(double Energy);
map<int,double> pdg_mass;
double PI = 3.1415926;

void LoadReadFile(TString infile);
void LoadOutTree();
void initial();

int m_pPdg;
int m_tPdg;
double m_pEn;
int m_channelID;
int m_isoPdg;
double m_isoPx,m_isoPy, m_isoPz;
int m_Npars;
int m_pdg[100];
double m_px[100];//GeV
double m_py[100];//GeV
double m_pz[100];//GeV
double m_energy[100];//GeV
double m_mass[100];//GeV

TFile *genieFile;
TTree *geTree;

TFile *outFile;
TTree *outTree;

int t_evtID;
int t_pPdg;
int t_tPdg;
double t_pEn;
int t_channelID;
int t_deexID;
int t_isoPdg;
int t_Npars;
int t_pdg[100];
double t_px[100];//GeV
double t_py[100];//GeV
double t_pz[100];//GeV

int main(int argc, char** argv) {
  long rseed = 0;
  int nEvents = 1000000;
  char* data_dir = NULL;
  char* outFilename = NULL;
  char* user_output = NULL;
  ProcessArgs(argc,argv,&rseed,&nEvents,&data_dir, &user_output);
  //cout << data_dir << endl;
  if(data_dir == NULL) {
    data_dir = new char[80];
    const char* juno_path = getenv("JUNOTOP");
    std::string path_name = juno_path;
    path_name += "/data/Generator/DSNB/data";
    strcpy(data_dir, path_name.c_str());
    
  }
  
  FILE* stream = stdout;
  if(outFilename!=NULL) {
    stream = fopen(outFilename, "w");
    if(stream==NULL) {
      printf("Please enetr a valid filename.\n");
      Usage();
      exit(0);
    }
  }
  bool IsExistUserFile = false;
  if(user_output != NULL) { IsExistUserFile = true;}
  if(IsExistUserFile == true) {
    TString outfilename = user_output;                                                                                        
  //outfilename += "/gen_" ;
  //outfilename += rseed;
  //outfilename += ".root";
    outFile = new TFile(outfilename, "RECREATE"); 
    LoadOutTree();
  }

  TString genieFilename = data_dir;
  genieFilename += "/genie_data.root";
  LoadReadFile(genieFilename);
   
  gRandom->SetSeed(rseed);
  //Hep3Vector PointPos;
  Hep3Vector pv;
  bool IsExcitedFlag = false;
  bool IsStableFlag = false;
  
  
  int nentries = (int)geTree->GetEntries();
  for(int i=0; i<nEvents; i++) {
    int ievent = (int)(gRandom->Uniform()*(nentries-1));
    geTree->GetEntry(ievent);
    initial();
    t_evtID = i;
    t_pPdg = m_pPdg;
    t_tPdg = m_tPdg;
    t_isoPdg = m_isoPdg;
    t_channelID = m_channelID;
    t_pEn = m_pEn;

    int Num_Par = 0;
    int resN = 0;
    int resP = 0;
    if(m_isoPdg==1000060120 || m_isoPdg==1000040080 || m_isoPdg == 1000030060) {
      IsStableFlag = true;
    }
    if(m_isoPdg==0||m_channelID==2||m_channelID==3) {
      Num_Par = m_Npars;
      fprintf(stream,"%d\n", Num_Par);
      for(int jj=0;jj<m_Npars; jj++) {
        fprintf(stream,"1\t%d 0 0 %f %f %f %f\n", m_pdg[jj], m_px[jj], m_py[jj], m_pz[jj], m_mass[jj]);
        t_pdg[jj] = m_pdg[jj];
        t_px[jj] = m_px[jj];
        t_py[jj] = m_py[jj];
        t_pz[jj] = m_pz[jj];
      }
      t_Npars = m_Npars;
				} else {
      
						IsExcitedFlag = IsExcited();
						if(IsExcitedFlag==false || IsStableFlag == true) {
								fprintf(stream,"%d\n", m_Npars+1);
								for(int jj=0;jj<m_Npars; jj++) {
										fprintf(stream,"1\t%d 0 0 %f %f %f %f\n", m_pdg[jj], m_px[jj], m_py[jj], m_pz[jj], m_mass[jj]);
          t_pdg[jj] = m_pdg[jj];
          t_px[jj] = m_px[jj];
          t_py[jj] = m_py[jj];
          t_pz[jj] = m_pz[jj];
								}
								double isomass = GetMass(m_isoPdg);
								fprintf(stream,"1\t%d 0 0 %f %f %f %f\n", m_isoPdg, m_isoPx, m_isoPy, m_isoPz, isomass);
        t_pdg[m_Npars] = m_isoPdg;
        t_px[m_Npars] = m_isoPx;
        t_py[m_Npars] = m_isoPy;
        t_pz[m_Npars] = m_isoPz;
        t_Npars = m_Npars+1;
						} else {
								resP = int((m_isoPdg-1000000000)/10000);
								resN = int((m_isoPdg-1000000000-resP*10000)/10)-resP;
								//cout << "Jie test : " << "\t" << m_isoPdg << "\t" << resP << "\t" << resN << endl;
								vector<double> afterDeexEn;
								vector<int> afterDeexPDG;
								deex*DEProcess = new deex(resP,resN, data_dir);
								DEProcess->GetDeeProcess();
								afterDeexEn = DEProcess->GetDeeParE();
								afterDeexPDG = DEProcess->GetDeePDG();
								int residulZafterDee = DEProcess->GetResNuelZ();
								int residulNafterDee = DEProcess->GetResNuelN();
								int deexID = DEProcess->GetDeexChannelID();
        t_deexID = deexID;
								//cout << "Jie test : deexID = " << deexID << endl;
								int count = 0;
								count = m_Npars + afterDeexEn.size();
								if(residulZafterDee<3 || residulNafterDee<3) {
										fprintf(stream,"%d\n", count);
										for(int jj=0;jj<m_Npars; jj++) {
												fprintf(stream,"1\t%d 0 0 %f %f %f %f\n", m_pdg[jj], m_px[jj], m_py[jj], m_pz[jj], m_mass[jj]);
            t_pdg[jj] = m_pdg[jj];
            t_px[jj] = m_px[jj];
            t_py[jj] = m_py[jj];
            t_pz[jj] = m_pz[jj];
										}
										for(int kk=0; kk<afterDeexEn.size(); kk++) {
												pv = PointPv(afterDeexEn[kk]);
												double MASS = GetMass(afterDeexPDG[kk]);
												fprintf(stream,"1\t%d 0 0 %f %f %f %f\n", afterDeexPDG[kk], pv.x(), pv.y(), pv.z(), MASS);
            t_pdg[m_Npars+kk] = afterDeexPDG[kk];
            t_px[m_Npars+kk] = pv.x();
            t_py[m_Npars+kk] = pv.y();
            t_pz[m_Npars+kk] = pv.z();
										}                      
          t_Npars = count;
								} else {
										fprintf(stream,"%d\n", count+2);
										for(int jj=0;jj<m_Npars; jj++) {
												fprintf(stream,"1\t%d 0 0 %f %f %f %f\n", m_pdg[jj], m_px[jj], m_py[jj], m_pz[jj], m_mass[jj]);
            t_pdg[jj] = m_pdg[jj];
            t_px[jj] = m_px[jj];
            t_py[jj] = m_py[jj];
            t_pz[jj] = m_pz[jj];        
										}
										for(int kk=0; kk<afterDeexEn.size(); kk++) {
												pv = PointPv(afterDeexEn[kk]);
												double MASS = GetMass(afterDeexPDG[kk]);
												fprintf(stream,"1\t%d 0 0 %f %f %f %f\n", afterDeexPDG[kk], pv.x(), pv.y(), pv.z(), MASS); 
            t_pdg[m_Npars+kk] = afterDeexPDG[kk];
            t_px[m_Npars+kk] = pv.x();
            t_py[m_Npars+kk] = pv.y();
            t_pz[m_Npars+kk] = pv.z();              
										}
										double nextDeexEn = DEProcess->GetDeeGammaProcess(residulZafterDee,residulNafterDee);
										//cout << "next deex gamma :" << "\t" << nextDeexEn << endl;
										pv = PointPv(nextDeexEn);
										int gammapdg = 22;
										double gammamass = 0;
										fprintf(stream,"1\t%d 0 0 %f %f %f %f\n", gammapdg, pv.x(), pv.y(), pv.z(), gammamass);
          t_pdg[count] = gammapdg;
          t_px[count] = pv.x();
          t_py[count] = pv.y();
          t_pz[count] = pv.z(); 
										int isoPdgafterDeex = 1000000000 + residulZafterDee*10000 + (residulZafterDee+residulNafterDee)*10;
										double isomassafterDeex = GetMass(isoPdgafterDeex);
										fprintf(stream,"1\t%d 0 0 %f %f %f %f\n", isoPdgafterDeex, m_isoPx, m_isoPy, m_isoPz, isomassafterDeex);
          t_pdg[count+1] = isoPdgafterDeex;
          t_px[count+1] = m_isoPx;
          t_py[count+1] = m_isoPy;
          t_pz[count+1] = m_isoPz;
          t_Npars = count+2;
								}           
						}
				}
    if(IsExistUserFile == true){ outTree->Fill();}
		}
  if(IsExistUserFile == true){
    outFile->cd();
    outTree->Write();
    outFile->Close();
  } 
  
  return 0;
  
}

void initial() {
  t_evtID = 0;
  t_Npars = 0;
  t_pPdg = 0; 
  t_tPdg = 0;
  t_pEn = 0; 
  t_isoPdg = 0;
  t_channelID = 0;
  t_deexID = 0;   

  for(int jj=0; jj<100; jj++) {
    t_pdg[jj] = 0;
    t_px[jj] = 0.;
    t_py[jj] = 0.;
    t_pz[jj] = 0.;
  }   
}
void LoadReadFile(TString infile) {

  genieFile = TFile::Open(infile,"read");
  if(!genieFile) {
    cout << "Can not find file: " << infile << endl;
    exit(-1);
  }
  geTree = (TTree*)genieFile->Get("particleT");
  geTree->SetBranchAddress("pPdg",&m_pPdg);
  geTree->SetBranchAddress("tPdg",&m_tPdg);
  geTree->SetBranchAddress("pEn",&m_pEn);
  geTree->SetBranchAddress("channelID",&m_channelID);
  geTree->SetBranchAddress("m_isoPdg",&m_isoPdg);
  geTree->SetBranchAddress("m_isoPx",&m_isoPx);
  geTree->SetBranchAddress("m_isoPy",&m_isoPy);
  geTree->SetBranchAddress("m_isoPz",&m_isoPz);
  geTree->SetBranchAddress("Npars",&m_Npars);
  geTree->SetBranchAddress("pdg",m_pdg);
  geTree->SetBranchAddress("px",m_px);
  geTree->SetBranchAddress("py",m_py);
  geTree->SetBranchAddress("pz",m_pz);
  geTree->SetBranchAddress("energy",m_energy);
  geTree->SetBranchAddress("mass",m_mass);

}
void LoadOutTree() {
  
  outTree = new TTree("genEvt", "genEvent");
  outTree->Branch("t_evtID",&t_evtID,"t_evtID/I");
  outTree->Branch("t_pPdg",&t_pPdg,"t_pPdg/I");
  outTree->Branch("t_tPdg",&t_tPdg,"t_tPdg/I");
  outTree->Branch("t_pEn",&t_pEn,"t_pEn/D");
  outTree->Branch("t_channelID",&t_channelID,"t_channelID/I");
  outTree->Branch("t_deexID",&t_deexID,"t_deexID/I");
  outTree->Branch("t_isoPdg",&t_isoPdg,"t_isoPdg/I");
  outTree->Branch("t_Npars",&t_Npars,"t_Npars/I");
  outTree->Branch("t_pdg",t_pdg,"t_pdg[t_Npars]/I");
  outTree->Branch("t_px",t_px,"t_px[t_Npars]/D");
  outTree->Branch("t_py",t_py,"t_py[t_Npars]/D");
  outTree->Branch("t_pz",t_pz,"t_pz[t_Npars]/D");
}

Hep3Vector PointPosition() {

  Hep3Vector detectorCenter;
  double xoffset = 0;
  double yoffset = 0;
  double zoffset = 0;
  detectorCenter = Hep3Vector(xoffset,yoffset,zoffset);
  double xpoint = 0;
  double ypoint = 0;
  double zpoint = 0;
  double rpoint = 0;
  double radiuofBall = 17700; //mm
  bool IsPos = false;

  do { //  
    xpoint = gRandom->Uniform(-1.*radiuofBall , radiuofBall);
    ypoint = gRandom->Uniform(-1.*radiuofBall , radiuofBall);
    zpoint = gRandom->Uniform(-1.*radiuofBall , radiuofBall);
    rpoint = sqrt(xpoint*xpoint + ypoint*ypoint + zpoint*zpoint);
    if(rpoint<radiuofBall) IsPos=true;
  } while (IsPos == false);
  Hep3Vector Point;
  Point = Hep3Vector(xpoint,ypoint,zpoint);
  return Point;

}
Hep3Vector PointPv(double Energy) {
  double xdir = 0;
  double ydir = 0;
  double zdir = 0;
  double rdir = 0;
  double theta = 0.;
  double phi = 0.;

  theta = gRandom->Uniform(0., PI);
  phi = gRandom->Uniform(0,2*PI);
  xdir = sin(theta) * cos(phi);
  ydir = sin(theta) * sin(phi);
  zdir = cos(theta);
  rdir = sqrt(xdir*xdir+ydir*ydir+zdir*zdir);
  double px = xdir*Energy*1e-3;//GeV
  double py = ydir*Energy*1e-3;//GeV
  double pz = zdir*Energy*1e-3;//GeV
  Hep3Vector Pv;
  Pv = Hep3Vector(px,py,pz);
  return Pv;
}

bool IsExcited() {
  bool isExc = false;
  double flag = gRandom->Uniform(0,1);
  double chance = 1./3.;
  if(flag <= chance) {
    isExc = true;
  } else {
    isExc = false;
  }
  return isExc;
}

double GetMass(int pdg) {

  pdg_mass.clear();
  pdg_mass[22] = 0;
  pdg_mass[2112] = 0.93957;//GeV
  pdg_mass[2212] = 0.93827;
  pdg_mass[1000010020] = 1.8756;
  pdg_mass[1000010030] = 2.8089;
  pdg_mass[1000020030] = 2.8084;
  pdg_mass[1000020040] = 3.7274;
  pdg_mass[1000030060] = 5.6015;
  pdg_mass[1000030070] = 6.5335;
  pdg_mass[1000030080] = 7.4708;
  pdg_mass[1000030090] = 8.4061;
  pdg_mass[1000040070] = 6.5344;
  pdg_mass[1000040080] = 7.4548;
  pdg_mass[1000040090] = 8.3925;
  pdg_mass[1000040100] = 9.3249;
  pdg_mass[1000050080] = 7.4728;
  pdg_mass[1000050090] = 8.3935;
  pdg_mass[1000050100] = 9.3244;
  pdg_mass[1000050110] = 10.2522;
  pdg_mass[1000060090] = 8.4100;
  pdg_mass[1000060100] = 9.3280;
  pdg_mass[1000060110] = 10.2542;
  pdg_mass[1000060120] = 11.1748;
  return pdg_mass[pdg];

}
void ProcessArgs(int argc, char** argv, long* rseed,int*nevents,  char**data_dir, char**user_output) {
  for(int i=1; i<argc;i++) {
    if( strcmp(argv[i], "-seed")==0) {
      i++;
      sscanf(argv[i],"%ld",rseed);
    }else if(strcmp(argv[i],"-n") == 0) {
      i++;
      sscanf(argv[i],"%d",nevents);
    } else if( strcmp(argv[i],"-data_dir") == 0) {
      i++;
      *data_dir = new char[strlen(argv[i])+1];
      strcpy(*data_dir, argv[i]);
    } else if(strcmp(argv[i],"-user_output")==0) {
      i++;
      *user_output = new char[strlen(argv[i])+1];
      strcpy(*user_output, argv[i]);
    } else {
      Usage();
      exit(0);
    }
  }
}

void Usage() {
  cout << "-----> test" << endl;
}



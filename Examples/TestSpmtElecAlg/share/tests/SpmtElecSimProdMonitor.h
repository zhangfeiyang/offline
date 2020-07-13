//////////////////////////////////////////////////////////
// This class has been automatically generated on
// Tue Oct 17 08:27:52 2017 by ROOT version 5.34/11
// from TTree SIMEVT/Spmt fast elec tree
// found on file: electron_test1_0_1_0_0_0_output_user_spmt_elec.root
//////////////////////////////////////////////////////////

#ifndef SpmtElecSimProdMonitor_h
#define SpmtElecSimProdMonitor_h

#include <TROOT.h>
#include <TChain.h>
#include <TFile.h>

// Header file for the classes stored in the TTree if any.
#include <vector>

// Fixed size dimensions of array or collections stored in the TTree if any.

class SpmtElecSimProdMonitor {
public :
   TTree          *fChain;   //!pointer to the analyzed TTree or TChain
   Int_t           fCurrent; //!current Tree number in a TChain

   // Declaration of leaf types
   Int_t           evtID;
   vector<int>     *NPEs;
   vector<double>  *Times;
   vector<unsigned int> *Types;
   vector<unsigned int> *Gains;
   vector<unsigned int> *Boards;
   vector<unsigned int> *ChNums;
   vector<unsigned int> *CoarseTimes;
   vector<unsigned int> *EvtCounters;
   vector<unsigned int> *FineTimes;
   vector<unsigned int> *Charges;

   // List of branches
   TBranch        *b_evtID;   //!
   TBranch        *b_NPEs;   //!
   TBranch        *b_Times;   //!
   TBranch        *b_Types;   //!
   TBranch        *b_Gains;   //!
   TBranch        *b_Boards;   //!
   TBranch        *b_ChNums;   //!
   TBranch        *b_CoarseTimes;   //!
   TBranch        *b_EvtCounters;   //!
   TBranch        *b_FineTimes;   //!
   TBranch        *b_Charges;   //!

   SpmtElecSimProdMonitor(TTree *tree=0);
   virtual ~SpmtElecSimProdMonitor();
   virtual Int_t    Cut(Long64_t entry);
   virtual Int_t    GetEntry(Long64_t entry);
   virtual Long64_t LoadTree(Long64_t entry);
   virtual void     Init(TTree *tree);
   virtual void     Loop();
   virtual Bool_t   Notify();
   virtual void     Show(Long64_t entry = -1);

   const static std::string nameBase;
   const static std::string nameSuffix;

   std::string namePath;
   std::string nameTag;
};

#endif

#ifdef SpmtElecSimProdMonitor_cxx

const std::string SpmtElecSimProdMonitor::nameBase =  "SpmtSimMonitorHistos";
const std::string SpmtElecSimProdMonitor::nameSuffix = ".root";

SpmtElecSimProdMonitor::SpmtElecSimProdMonitor(TTree *tree) : fChain(0) 
{
// if parameter tree is not specified (or zero), connect the file
// used to generate this class and read the Tree.
   if (tree == 0) {
      TFile *f = (TFile*)gROOT->GetListOfFiles()->FindObject("electron_test1_0_1_0_0_0_output_user_spmt_elec.root");
      if (!f || !f->IsOpen()) {
         f = new TFile("electron_test1_0_1_0_0_0_output_user_spmt_elec.root");
      }
      f->GetObject("SIMEVT",tree);

   }
   Init(tree);
}

SpmtElecSimProdMonitor::~SpmtElecSimProdMonitor()
{
   if (!fChain) return;
   delete fChain->GetCurrentFile();
}

Int_t SpmtElecSimProdMonitor::GetEntry(Long64_t entry)
{
// Read contents of entry.
   if (!fChain) return 0;
   return fChain->GetEntry(entry);
}
Long64_t SpmtElecSimProdMonitor::LoadTree(Long64_t entry)
{
// Set the environment to read one entry
   if (!fChain) return -5;
   Long64_t centry = fChain->LoadTree(entry);
   if (centry < 0) return centry;
   if (fChain->GetTreeNumber() != fCurrent) {
      fCurrent = fChain->GetTreeNumber();
      Notify();
   }
   return centry;
}

void SpmtElecSimProdMonitor::Init(TTree *tree)
{
   // The Init() function is called when the selector needs to initialize
   // a new tree or chain. Typically here the branch addresses and branch
   // pointers of the tree will be set.
   // It is normally not necessary to make changes to the generated
   // code, but the routine can be extended by the user if needed.
   // Init() will be called many times when running on PROOF
   // (once per file to be processed).

   // Set object pointer
   NPEs = 0;
   Times = 0;
   Types = 0;
   Gains = 0;
   Boards = 0;
   ChNums = 0;
   CoarseTimes = 0;
   EvtCounters = 0;
   FineTimes = 0;
   Charges = 0;
   // Set branch addresses and branch pointers
   if (!tree) return;
   fChain = tree;
   fCurrent = -1;
   fChain->SetMakeClass(1);

   fChain->SetBranchAddress("evtID", &evtID, &b_evtID);
   fChain->SetBranchAddress("NPEs", &NPEs, &b_NPEs);
   fChain->SetBranchAddress("Times", &Times, &b_Times);
   fChain->SetBranchAddress("Types", &Types, &b_Types);
   fChain->SetBranchAddress("Gains", &Gains, &b_Gains);
   fChain->SetBranchAddress("Boards", &Boards, &b_Boards);
   fChain->SetBranchAddress("ChNums", &ChNums, &b_ChNums);
   fChain->SetBranchAddress("CoarseTimes", &CoarseTimes, &b_CoarseTimes);
   fChain->SetBranchAddress("EvtCounters", &EvtCounters, &b_EvtCounters);
   fChain->SetBranchAddress("FineTimes", &FineTimes, &b_FineTimes);
   fChain->SetBranchAddress("Charges", &Charges, &b_Charges);
   Notify();
}

Bool_t SpmtElecSimProdMonitor::Notify()
{
   // The Notify() function is called when a new file is opened. This
   // can be either for a new TTree in a TChain or when when a new TTree
   // is started when using PROOF. It is normally not necessary to make changes
   // to the generated code, but the routine can be extended by the
   // user if needed. The return value is currently not used.

   return kTRUE;
}

void SpmtElecSimProdMonitor::Show(Long64_t entry)
{
// Print contents of entry.
// If entry is not specified, print current entry
   if (!fChain) return;
   fChain->Show(entry);
}
Int_t SpmtElecSimProdMonitor::Cut(Long64_t entry)
{
// This function may be called from Loop.
// returns  1 if entry is accepted.
// returns -1 otherwise.
   return 1;
}
#endif // #ifdef SpmtElecSimProdMonitor_cxx

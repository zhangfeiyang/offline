#define SpmtElecSimProdMonitor_cxx
#include "SpmtElecSimProdMonitor.h"
#include <TH2.h>
#include <TStyle.h>
#include <TCanvas.h>

void SpmtElecSimProdMonitor::Loop()
{
  if (fChain == 0) return;

  std::string nameFull = namePath+nameBase+nameTag+nameSuffix;
  TFile l_f(nameFull.c_str(), "NEW");
  if( l_f.IsOpen() )
  {
    // init histos
    TH1F h1("h_NPE","h_NPE",10000,0,10000);

    Long64_t nentries = fChain->GetEntriesFast();
    Long64_t nbytes = 0, nb = 0;
    for (Long64_t jentry=0; jentry<nentries;jentry++) {
      Long64_t ientry = LoadTree(jentry);
      if (ientry < 0) break;
      nb = fChain->GetEntry(jentry);   nbytes += nb;
      for(int i = 0; i<(*NPEs).size(); i++){
        h1.Fill(NPEs->at(i));
      } 
      // if (Cut(ientry) < 0) continue;
    }

    h1.Write();
    l_f.Write();
  }
  else cout << " SpmtElecSimProdMonitor : Problem opening file " << endl; 

}

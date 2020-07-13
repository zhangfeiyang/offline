#include <TSystem.h>
#include <TRandom.h>
#include <TFile.h>
#include <TTree.h>
#include <TH1F.h>
#include <TDirectory.h>
#include <TApplication.h>
#include <Event/RecHeader.h>
#include <Event/CalibHeader.h>
#include <Event/CalibPMTHeader.h>

#include <vector>
#include <list>
#include <iostream>
#include <cassert>
void checkOutput() {
    gSystem->Load("$RECEVENTROOT/$CMTCONFIG/libRecEvent.so");
    TFile* f = new TFile("recEvtOut.root");
    TDirectory* dir = (TDirectory*)f->Get("Event");
    TDirectory* dir1 = (TDirectory*)dir->Get("Rec"); 
    TDirectory* dir2 = (TDirectory*)dir->Get("Calib"); 

    TTree* tree = (TTree*)dir2->Get("CalibHeader"); 
    JM::CalibHeader* chc = new JM::CalibHeader;
    tree->SetBranchAddress("CalibHeader", &chc);

    TTree* rectree = (TTree*)dir1->Get("RecHeader"); 
    JM::RecHeader* recevt = new JM::RecHeader; 
    rectree->SetBranchAddress("RecHeader", &recevt); 

    for (Int_t ev = 0; ev < tree->GetEntries(); ++ev) {
        std::cout << "###########################" << std::endl; 
        std::cout << "Event " << ev << " : " << std::endl; 
        tree->GetEntry(ev);
        rectree->GetEntry(ev); 
        const std::list<JM::CalibPMTHeader*>& vchh = chc->calibPMTCol();
        for(std::list<JM::CalibPMTHeader*>::const_iterator it=vchh.begin();
                it != vchh.end();
                ++it) {
            const JM::CalibPMTHeader* chh = *it;
            std::cout << "pmtId : " << chh->pmtId() 
                      << "  nPE : " << chh->nPE() 
                      << "  firstHitTime : " << chh->firstHitTime() 
                      << std::endl; 
        }
        std::cout << "-----  Reconstruction  -----" << std::endl; 
        std::cout << "x : " << recevt->x() << std::endl; 
        std::cout << "y : " << recevt->y() << std::endl; 
        std::cout << "z : " << recevt->z() << std::endl; 
        std::cout << "px : " << recevt->px() << std::endl; 
        std::cout << "py : " << recevt->py() << std::endl; 
        std::cout << "pz : " << recevt->pz() << std::endl; 
        std::cout << "energy : " << recevt->energy() << std::endl; 
        std::cout << "peSum : " << recevt->peSum() << std::endl; 

    }

}

int main(int argc, char* argv[]) {
    checkOutput();
}

#include <TSystem.h>
#include <TRandom.h>
#include <TFile.h>
#include <TTree.h>
#include <Event/CalibPMTHeader.h>
#include <Event/CalibHeader.h>
#include "Identifier/CdID.h"


#include <list>
#include <vector>
#include <map>
#include <iostream>

void createInput() {
    gSystem->Load("$RECEVENTROOT/$CMTCONFIG/libRecEvent.so");
    TFile* f = new TFile("recEvtIn.root", "RECREATE");
    TDirectory* dir = f->mkdir("Event")->mkdir("Calib"); 
    TTree* tree = new TTree("CalibHeader", "Calibration header");
    tree->SetDirectory(dir); 

    JM::CalibHeader* sh = new JM::CalibHeader;
    tree->Branch("CalibHeader", &sh);

    for (Int_t ev = 0; ev < 100; ++ev) {
        JM::CalibHeader* data = new JM::CalibHeader;
        std::list<JM::CalibPMTHeader*> vsph;

        for (Int_t pmtid=0; pmtid < 15; ++pmtid) {
            JM::CalibPMTHeader* sph = new JM::CalibPMTHeader;
            sph->setPmtId( CdID::id(pmtid, 0) ); 
            sph->setFirstHitTime(gRandom->Rndm());
            sph->setNPE((int)gRandom->Uniform(0,10));
            vsph.push_back(sph);
        }
        data->setCalibPMTCol(vsph);
        sh = data; 
        tree->Fill();
    }

    f->Write();
    f->Close(); 

}

int main() {
    createInput();
    std::cout << "Success to create \"recEvtIn.root\" " << std::endl; 
}

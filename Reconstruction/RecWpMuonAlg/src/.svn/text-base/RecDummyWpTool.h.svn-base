#ifndef RecDummyWpTool_h
#define RecDummyWpTool_h
#include "RecWpMuonAlg/IReconTool.h"
#include "SniperKernel/ToolBase.h"
#include "SniperKernel/ToolFactory.h"
#include "Event/RecHeader.h"

class RecDummyWpTool : public IReconTool, public ToolBase{
    public:
        RecDummyWpTool (const std::string& name);
        virtual ~RecDummyWpTool (){};

        bool reconstruct(JM::RecHeader*) ;
        bool configure(const Params*,const PmtTable*); 

    private:
        const PmtTable* m_ptab; 

};
#endif

DECLARE_TOOL(RecDummyWpTool); 


RecDummyWpTool::RecDummyWpTool(const std::string& name)
    :ToolBase(name){
    }

bool
RecDummyWpTool::reconstruct(JM::RecHeader* rh){
    CLHEP::HepLorentzVector start(9, 9, 9, 9); 
    CLHEP::HepLorentzVector end(99, 99, 99, 99); 
    JM::WPRecEvent* evt = new JM::WPRecEvent();
    JM::RecTrack* mtrk = new JM::RecTrack(start, end); 
    mtrk->setPESum(1024); 
    mtrk->setQuality(1); 
    evt->addTrack(mtrk);
    rh->setWPEvent(evt);
    
    LogDebug <<  "Dummy test to  reconstruct the event!"
        << std::endl; 
    return true; 
}

bool
RecDummyWpTool::configure(const Params* pars, const PmtTable* ptab){
    LogDebug  << "configure the Dummy reconstruct tool!"
        << std::endl; 
    LogDebug  << "Retrieve the key/value [Pmt20inchTimeReso: " 
         << pars->get("Pmt20inchTimeReso") << "] from Params" << std::endl; 
    m_ptab = ptab; 
    return true; 
}


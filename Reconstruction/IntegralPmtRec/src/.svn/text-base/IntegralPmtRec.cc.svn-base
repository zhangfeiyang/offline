#ifndef IntegralPmtRec_cc
#define IntegralPmtRec_cc

#include "IntegralPmtRec.h"
#include "SniperKernel/AlgFactory.h"
#include "SniperKernel/SniperLog.h"
#include "EvtNavigator/NavBuffer.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "Event/ElecHeader.h"
#include "Event/CalibHeader.h"
#include "Identifier/CdID.h"
#include <TFile.h>
#include <TTree.h>

using namespace std;

DECLARE_ALGORITHM(IntegralPmtRec);

IntegralPmtRec::IntegralPmtRec(const string& name): AlgBase(name)
{
    declProp("TotalPMT", m_totalPMT);
    declProp("GainFile", m_gainFile);
    declProp("Threshold", m_threshold);
    m_bin = 1.0;
}


IntegralPmtRec::~IntegralPmtRec(){}


bool IntegralPmtRec::initialize()
{
    // read gain file
    TFile* f = new TFile(m_gainFile.c_str(),"READ");
    TTree* t=(TTree*)f->Get("PmtData");
    double gain;
    t->SetBranchAddress("gain",&gain);
    // fill the gain map
    for(int i=0;i<m_totalPMT;i++){
        t->GetEntry(i);
        m_gainMap.insert( pair<int,double>(i,gain) );
    }

    m_memMgr = SniperPtr<IDataMemMgr>(getScope(),"BufferMemMgr").data();
    // SniperPtr<DataRegistritionSvc> drsSvc(getScope(),"DataRegistritionSvc");         
    // if ( ! drsSvc.valid() ) {
    //     LogError << "Failed to get DataRegistritionSvc instance!" << endl;      
    //     return false;
    // }   
    // drsSvc->registerData("JM::CalibEvent","/Event/Calib");    

    return true;
}


bool IntegralPmtRec::execute()
{
    LogDebug << "start Integral Pmt Rec" << endl;
    SniperDataPtr<JM::NavBuffer> navBuf(getScope(),"/Event");
    JM::EvtNavigator* nav = navBuf->curEvt();
    JM::ElecHeader* eh = dynamic_cast<JM::ElecHeader*>(nav->getHeader("/Event/Elec"));
    JM::ElecEvent* ee = dynamic_cast<JM::ElecEvent*>(eh->event());
    const JM::ElecFeeCrate& efc = ee->elecFeeCrate();
    m_crate = const_cast<JM::ElecFeeCrate*>(&efc);

    map<int,JM::ElecFeeChannel> feeChannels = m_crate->channelData();

    list<JM::CalibPMTChannel*> cpcl;//CalibPMTChannel list

    map<int,JM::ElecFeeChannel>::iterator it;
    for(it=feeChannels.begin();it!=feeChannels.end();++it){

        JM::ElecFeeChannel& channel = (it->second);

        if(channel.adc().size()==0){
            continue;
        }

        int pmtID = it->first;
        double nPE = getNPE(channel,m_gainMap[pmtID]);
        double firstHitTime = getFHT(channel);

        JM::CalibPMTChannel* cpc = new JM::CalibPMTChannel;
        cpc->setNPE(nPE);
        unsigned int detID = CdID::id(static_cast<unsigned int>(pmtID),0);
        cpc->setPmtId(detID);
        cpc->setFirstHitTime(firstHitTime);
        cpcl.push_back(cpc);
    }

    JM::CalibEvent* ce = new JM::CalibEvent;
    //JM::CalibHeader* ch = new JM::CalibHeader;
    ce->setCalibPMTCol(cpcl);
    JM::CalibHeader* ch = new JM::CalibHeader;
    ch->setEvent(ce);

    JM::EvtNavigator* newNav = new JM::EvtNavigator;
    newNav->addHeader("/Event/Calib",ch);
    newNav->setTimeStamp(nav->TimeStamp());

    m_memMgr->adopt(newNav,"/Event");

    LogDebug << "end Integral Pmt Rec" << endl;
    return true;
}


bool IntegralPmtRec::finalize()
{
    return true;
}


double IntegralPmtRec::getNPE(JM::ElecFeeChannel& channel, double gain)
{
    vector<unsigned int>& adc = channel.adc();
    if(adc.size()==0){
        return 0;
    }
    double temp = 0.0;
    vector<unsigned int>::iterator it;
    for(it=adc.begin();it!=adc.end()-1;it++){   
        if(*it>=0) temp += (*it+*(it+1))*m_bin/2;
    }   
    return temp/gain;
}


double IntegralPmtRec::getFHT(JM::ElecFeeChannel& channel)
{
    vector<unsigned int>& adc = channel.adc();
    vector<unsigned int>& tdc = channel.tdc();

    if (adc.size()==0){
        return 0.0;
    }

    for(int i=0; i < adc.size(); ++i){
        if( adc[i] > m_threshold ){
            return tdc[i];
        }
    }
    return 0.0;
}


#endif



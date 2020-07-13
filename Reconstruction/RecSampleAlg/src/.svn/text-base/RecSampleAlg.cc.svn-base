/*=============================================================================
#
# Author: ZHANG Kun - zhangkun@ihep.ac.cn
# Last modified: 2013-11-12 01:00
# Filename: RecSampleAlg.cc
# Description: 
=============================================================================*/
#include "RecSampleAlg.h"

#include "SniperKernel/AlgFactory.h"
#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "EvtNavigator/NavBuffer.h"
#include "Event/RecHeader.h"
#include "Event/CalibHeader.h"
#include "Geometry/RecGeomSvc.h"
#include "Identifier/Identifier.h"
#include "Identifier/CdID.h"


#include "TVector3.h"
#include "TRandom.h"
#include <list>

DECLARE_ALGORITHM(RecSampleAlg); 

 RecSampleAlg::RecSampleAlg(const std::string& name)
:   AlgBase(name)
{
    m_iEvt = -1; 
    declProp("CreateInputFlag",    m_createInput = 0);  
    //CreateInputFlag: 
    //0, not to create input; 
    //other, creating input first;
}

RecSampleAlg::~RecSampleAlg()
{

}

bool RecSampleAlg::initialize()
{

    LogInfo  << objName()
        << "   initialized successfully"
        << std::endl; 

    //Event navigator
    SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
    if ( navBuf.invalid() ) {
        LogError << "cannot get the NavBuffer @ /Event" << std::endl;
        return false;
    }
    m_buf = navBuf.data();

    //DataRegistritionSvc
    // SniperPtr<DataRegistritionSvc> drSvc("DataRegistritionSvc");
    // if ( drSvc.invalid() ) {
    //     LogError << "Failed to get DataRegistritionSvc instance!"
    //         << std::endl;
    //     return false;
    // }
    // drSvc->registerData("JM::RecEvent", "/Event/Rec");

    //Reconstruction Geometry service
    SniperPtr<RecGeomSvc> rgSvc("RecGeomSvc"); 
    if ( rgSvc.invalid()) {
        LogError << "Failed to get RecGeomSvc instance!" << std::endl;
        return false;
    }
    m_cdGeom = rgSvc->getCdGeom(); 

    // ... Only For Creating input data
    if ( m_createInput ) 
        drSvc->registerData("JM::CalibEvent", "/Event/Calib");

    return true; 

}

bool RecSampleAlg::execute()
{
    ++m_iEvt; 
    LogDebug << "---------------------------------------" << std::endl; 
    LogDebug << "Processing event " << m_iEvt << std::endl; 

    if(m_createInput)createInput(); 

    JM::EvtNavigator* nav = m_buf->curEvt(); 

    //read CalibHit data
    JM::CalibHeader* chcol =(JM::CalibHeader*) nav->getHeader("/Event/Calib"); 
    const std::list<JM::CalibPMTChannel*>& chhlist = chcol->event()->calibPMTCol(); 
    std::list<JM::CalibPMTChannel*>::const_iterator chit = chhlist.begin(); 
    while (chit!=chhlist.end()) {
        const JM::CalibPMTChannel  *calib = *chit; 

        unsigned int pmtId = calib->pmtId(); 
        Identifier id = Identifier(calib->pmtId());

        double nPE = calib->nPE(); 
        float firstHitTime = calib->firstHitTime(); 

        PmtGeom *pmt = m_cdGeom->getPmt(id); 
        if ( !pmt ) {
            LogError << "Wrong Pmt Id " << id << std::endl;
        }
        TVector3 pmtCenter = pmt->getCenter();

        chit++; 
        if (m_iEvt == 0) {
            LogDebug << "   pmtId : " << pmtId 
                << "    nPE : " << nPE 
                << "    firstHitTime : " << firstHitTime  
                << "  pmtCenter : " << pmtCenter.x() 
                << "  " <<  pmtCenter.y()
                << "  "  << pmtCenter.z() << std::endl; 
        }
    }
    LogDebug  << "Done to read CalibPMT" << std::endl; 

    JM::RecHeader* aData = new JM::RecHeader(); //unit: mm,  MeV, ...
    aData->setX(10*m_iEvt); 
    aData->setY(10*m_iEvt); 
    aData->setZ(10*m_iEvt); 
    aData->setEnergy(100*m_iEvt); 
    aData->setPESum(15*m_iEvt); 
    aData->setPx(1*m_iEvt); 
    aData->setPy(2*m_iEvt); 
    aData->setPz(3*m_iEvt); 

    nav->addHeader("/Event/Rec", aData); 
    LogDebug  << "Done to write RecHeader" << std::endl; 

    return true; 
}


bool RecSampleAlg::finalize()
{
    LogInfo  << objName()
        << "   finalized successfully" 
        << std::endl; 
    return true; 
}

bool RecSampleAlg::createInput()
{
    //make a dummy EvtNavigator
    JM::EvtNavigator* nav = new JM::EvtNavigator();
    static TTimeStamp time(2014, 9, 1, 10, 10, 2, 111);
    //time.Add(TTimeStamp(0, 5)));
    nav->setTimeStamp(time);

    //TODO: register the EvtNavigator to Memory Store
    SniperPtr<IDataMemMgr> mMgr(getScope(), "BufferMemMgr");
    mMgr->adopt(nav, "/Event");

    //set headers and events ...
    //
    JM::CalibHeader* ch = new JM::CalibHeader(); 
    for (Int_t pmtid = 0; pmtid < 15 ; ++pmtid)
    {
        JM::CalibPMTChannel* cph = ch->addCalibPmtChannel(CdID::id(pmtid, 0)); 
        cph->setFirstHitTime(gRandom->Rndm()); 
        cph->setNPE((int)gRandom->Uniform(0, 10)); 

    }
    nav->addHeader("/Event/Calib", ch); 

    return true; 
}


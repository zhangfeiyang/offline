/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#include "SmartRec.h"
#include "SniperKernel/AlgFactory.h"
#include "SmartRecHelperSvc/SmartRecHelperSvc.h"
#include "Event/ClusterHeader.h"
#include "Event/ClusterEvent.h"

using std::endl;

DECLARE_ALGORITHM(SmartRec);

SmartRec::SmartRec(const std::string & name) : AlgBase(name), m_iEvt(0) {
	declProp("SaveSecondCluster",m_save_second_cluster = false);
	declProp("FillEmptyEvent",m_fill_empty_event= true);
	declProp("RecInputPath",m_recInputPath = "/Event/Rec"); 
	declProp("CalibInputPath",m_calibInputPath = "/Event/Calib"); 
	declProp("CalibOutputPath",m_calibOutputPath= "/Event/Calib"); 
	declProp("ClusterOutputPath",m_clusterOutputPath= "/Event/Cluster"); 
	declProp("KillRecHeader",m_killRecHeader= true);
};

SmartRec::~SmartRec() {
};

#include "DataRegistritionSvc/DataRegistritionSvc.h"
bool SmartRec::initialize() {
	//Event navigator
	LogInfo << objName()
		<< " Loading NavBuffer"
		<< endl;
	// SniperDataPtr is a wrapper of RefBase. (data(), invalid());
	// SniperDataPtr will check DataMemSvc.
	// they are both defined in SniperKernel
	SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
	if ( navBuf.invalid() ) {
		LogError << "cannot get the NavBuffer @ /Event" << std::endl;
		return false;
	}
	// NavBuffer is the DataBuffer of EvtNavigator, former defined in SniperUtil
	m_buf = navBuf.data();
	LogInfo << objName()
		<< " buffer loaded: "<<m_buf << " "
		<< m_buf->size() <<" entries" 
		<< endl;

	SniperPtr<SmartRecHelperSvc> helperSvc(getScope(), "SmartRecHelperSvc");
	if(helperSvc.invalid() ) {
		LogError << "can not find the service SmartRecHelperSvc"<<std::endl;
		return false;
	}
	m_helperSvc = helperSvc.data();
	LogInfo << objName()
		<< " SmartRecHelperSvc loaded: "<<m_helperSvc
		<< endl;

    if(m_killRecHeader&&(m_calibInputPath!="/Event/Calib"||m_calibOutputPath!="/Event/Calib"||m_recInputPath!="/Event/Rec")) {
        LogError<<"If you use kill recheader, please set the path to the default value"<<endl;
        return false;
    }

	if(!(m_fill_empty_event&&!m_save_second_cluster)) {
		LogError << "Currently misaligned way is not implemented."<<endl;
		return false;
	}
	LogInfo << objName()
		<< " initialized successfully"
		<< endl;
	return true;
};

#include "Event/CalibHeader.h"
#include "Event/RecHeader.h"
#include "Identifier/Identifier.h"
#include "Identifier/CdID.h"

bool SmartRec::execute() {
	++m_iEvt; 
	LogDebug<< "---------------------------------------" << std::endl; 
	LogDebug<< "Processing event " << m_iEvt << std::endl; 

	JM::EvtNavigator* nav = m_buf->curEvt(); 
	LogDebug << "Valid path size: "<<nav->getPath().size() << endl;
	for(unsigned int i = 0;i<nav->getPath().size();++i) {
		LogDebug << "N["<<i<<"] :"<<nav->getPath().at(i) << endl;
	}

	LogDebug << "trying to fetch the CalibHeader for this event."<< endl;
	JM::CalibHeader* currentCalibHeader = (JM::CalibHeader*) nav->getHeader(m_calibInputPath); 
	if(currentCalibHeader)
		LogDebug << "succeeded: "<< currentCalibHeader <<endl;
	else {
		LogError << "got empty pointer EvtNavigator::getHeader(\""<<m_calibInputPath<<"\");"
			<<endl;
		return false;
	}
	const std::list<JM::CalibPMTChannel*>& chhlist = currentCalibHeader->event()->calibPMTCol(); 
	LogDebug << chhlist.size() <<" CalibPMTChannel loaded."<<endl;

	TVector3 recPos;
	LogDebug << "trying to load the RecHeader for this event."<< endl;
	JM::RecHeader* rech =(JM::RecHeader*) nav->getHeader(m_recInputPath); 
	if(rech) {
		LogDebug << "succeeded: "<< rech <<endl;
		LogDebug << "trying to load the recPos from the RecHeader."<< endl;
    JM::CDRecEvent *CD_event = rech->cdEvent();
		recPos.SetXYZ(CD_event->x(),CD_event->y(),CD_event->z());
		LogDebug << "succeeded: "<< recPos.x()<<" "<<recPos.y()<<" "<<recPos.z() <<endl;
	} else {
		LogInfo << "got empty pointer EvtNavigator::getHeader(\""
			<<m_recInputPath<<"\");"
			<<" take the center as recPos"
			<<endl;
	}


	vector<Cluster*> clusters;
	LogDebug << "Clusterizing CalibHits..."<<endl;
	m_helperSvc->Clusterize(recPos,chhlist,clusters);
	LogDebug << "CalibHits clusterized."<<endl;

    if(m_killRecHeader) {
        LogDebug <<"Erasing all other paths from EvtNavigator.."<<endl;
        std::vector<std::string> &paths = nav->getPath();
        std::vector<bool> writeflag;
        std::vector<JM::SmartRef*> &refs = nav->getRef();
        std::vector<std::string>::iterator pathsIt = paths.begin();
        std::vector<JM::SmartRef*>::iterator refsIt = refs.begin();
        LogDebug<<"erasing.."<<endl;
        pathsIt = paths.begin();
        refsIt = refs.begin();
        for(size_t path_i = 0; path_i < paths.size(); ++path_i) {
            pathsIt = paths.begin()+path_i;
            refsIt = refs.begin()+path_i;
            if((*pathsIt!=m_calibOutputPath&&*pathsIt!="/Event/Rec")||
                    (m_killRecHeader&&*pathsIt=="/Event/Rec")) {
                LogDebug<<"erasing "<<*pathsIt<<endl;
                paths.erase(pathsIt);
                refs.erase(refsIt);
                --path_i;
            }
        }
        nav->resetWriteFlag();
        LogDebug<<"Done."<<endl;
    }
	LogDebug << "Looping over "<<clusters.size()<<" clusters"<<endl;
	LogDebug << "Processing prime cluster"<<endl;
	Cluster *cluster = nullptr;
	if(clusters.size())
		cluster = clusters.at(0);
	else if(m_fill_empty_event) {
		unsigned int id = CdID::id(0,0);
		JM::CalibPMTChannel *channel = new JM::CalibPMTChannel(id);
		vector<double> charge_v,time_v;
		charge_v.push_back(0);
		time_v.push_back(200);
		channel->setCharge(charge_v);
		channel->setTime(time_v);
		channel->setNPE(0);
		channel->setFirstHitTime(200);
		std::list<JM::CalibPMTChannel*> chhlist;
		chhlist.push_back(channel);
    cluster = new Cluster;
		cluster->setCalibPMTCol(chhlist);
	} else {
		LogError <<"skipping empty events is not implemented."<<endl;
		return false;
	}

	if(m_calibOutputPath!=m_calibInputPath) {
		JM::CalibHeader* ch = new JM::CalibHeader;
		ch->setEvent(cluster);
		nav->addHeader(m_calibOutputPath,ch);
	} else
		currentCalibHeader->setEvent(cluster);
  JM::ClusterEvent *clusterLenEve = new JM::ClusterEvent;
  clusterLenEve->setLength(cluster->length);
  JM::ClusterHeader*clusterLenHeader= new JM::ClusterHeader;
  clusterLenHeader->setEvent(clusterLenEve);
  nav->addHeader(m_clusterOutputPath,clusterLenHeader);
	LogDebug<< "write "<<cluster->calibPMTCol().size()<<" hits from the prime cluster"<<endl;

	if(m_save_second_cluster&&clusters.size()>1) {
		LogError <<"saving the second cluster is not implemented."<<endl;
		return false;

		for(unsigned int clusters_i = 1;clusters_i<clusters.size();++clusters_i) {
			LogDebug << "Processing "<<clusters_i<<"-th cluster"<<endl;
			cluster = clusters.at(clusters_i);
			JM::CalibHeader* ch = new JM::CalibHeader;
			ch->setEvent(cluster);
			nav->addHeader(m_calibOutputPath,ch);
			LogInfo << "write "<<cluster->calibPMTCol().size()<<" hits from "<<clusters_i<<"-th cluster"<<endl;
		}
	}
	return true;
};

bool SmartRec::finalize() {
	LogInfo << objName()
		<< " finalized successfully"
		<< endl;
	return true;
};

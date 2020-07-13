/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#include "SmartRecHelperSvc/SmartRecHelperSvc.h"
#include "SniperKernel/SvcFactory.h"
#include "SniperKernel/AlgBase.h"
#include "Geometry/RecGeomSvc.h"
#include <iostream>
using std::endl;
#include "TMath.h"
#include "SmartRecHelperSvc/ClusterHit.h"
#include <algorithm>
#include "Identifier/CdID.h"

DECLARE_SERVICE(SmartRecHelperSvc);

TVector3 ScatterHelper::pos;
TVector3 ScatterHelper::pmtPos;
double ScatterHelper::a = 0;
double ScatterHelper::b = 0;
double ScatterHelper::c = 17.7e3;
double ScatterHelper::d = 0;
double ScatterHelper::e = 0;
double ScatterHelper::theta = 0;
double ScatterHelper::cos_theta = 0;
double ScatterHelper::alpha = 0;
double ScatterHelper::phi = 0;
double ScatterHelper::cos_theta_i = 0;
double ScatterHelper::sin_theta_i = 0;
double ScatterHelper::cos_theta_o = 0;
double ScatterHelper::sin_theta_o = 0;
double ScatterHelper::ni = 1.51;
double ScatterHelper::no = 1.33;
double ScatterHelper::r_threshold = 12.6552e3; // c*0.715;

SmartRecHelperSvc::SmartRecHelperSvc(const std::string &name)
  : SvcBase(name), m_pmtCenter(new TVector3)
{
    declProp("DarkRate",    m_darkRate = 10e3);  
    declProp("DarkRate3inch",    m_darkRate3inch = 0);  
    declProp("WaveformRecEff",    m_waveformRecEff = 0.9180);  
    declProp("StaticGeometryLib",    m_staticGeometryLib = false);  
	declProp("UseFindScatter", m_useFindScatter = false);
	declProp("StartSearchWindow",m_startSearchWindow = 50); // # of bins, 1ns/bin
	declProp("EndSearchWindow",m_endSearchWindow = 150); // # of bins, 1ns/bin
	declProp("EndSearchWindowHE",m_endSearchWindowHE = 300);
	declProp("HEThreshold",m_hEThreshold= 1500);
	declProp("ClusterLeastDur",m_clusterLeastDur = 300); //ns
	declProp("CL",CL = 0.999);
	declProp("ClusterLengthThreshold",m_clusterLengthThreshold = 0); // unit: ns
	declProp("SkipAfterCluster",m_skippAfterCluster = 21); // unit: ns
	declProp("PreWindow",m_preWindow = 20); // ns
	declProp("PostWindow",m_postWindow = 250); // ns
	declProp("EffAttLen",effAttLen = 25000); // ns
}

#include <TFile.h>
SmartRecHelperSvc::~SmartRecHelperSvc() {
}
#include <TTree.h>
#include <boost/filesystem.hpp>
namespace fs = boost::filesystem;
#include <string>
using std::string;
bool SmartRecHelperSvc::initialize() {
	if(!m_staticGeometryLib) {
		//Reconstruction Geometry service
		SniperPtr<RecGeomSvc> rgSvc("RecGeomSvc"); 
		if ( rgSvc.invalid()) {
			LogError << "Failed to get RecGeomSvc instance!" << std::endl;
			return false;
		}
		m_cdGeom = rgSvc->getCdGeom(); 
	} else {
		if(!getenv("SMARTRECHELPERSVCROOT")) {
			LogError << "source $JUNOTOP/offline/Reconstruction/SmartRec/SmartRecRelease/cmt/setup.sh first."<<endl;
			return false;
		}
		std::string base = getenv("SMARTRECHELPERSVCROOT");
		string File_path = (fs::path(base)/"share").string();
		fs::path s(File_path);
		pmtpos_file = TFile::Open(TString((s/"PMTPos_Acrylic.root").string()));
		pmtpos_tree = (TTree*)(pmtpos_file->Get("PMTPos"));
		pmtpos_tree->SetBranchAddress("pmtCenter",&m_pmtCenter);
		LogInfo<<"file: "<<TString((s/"PMTPos_Acrylic.root").string())
			<<" entries: "<<pmtpos_tree->GetEntries()
			<<endl;
	}
	CachePMTCenter();
	LogInfo << objName()
		<< " RecGeomSvc loaded: "<<m_cdGeom
		<< " PmtPos TTree loaded: "<<pmtpos_tree
		<< endl;
  return true;
};
bool SmartRecHelperSvc::finalize() {
  return true;
};

double SmartRecHelperSvc::TOF(const TVector3 &recPos,const unsigned int pmtId) {
	return TOF_fromRecTimeLike(recPos,pmtId);
}

const TVector3 &SmartRecHelperSvc::GetPMTCenter(const unsigned int pmtId) const {
	if(pmtId>=(unsigned int)(CdID::module20inchNumber()+CdID::module3inchNumber())) {
		throw SniperException(Form("Ilegal pmtId: %d",pmtId));
	}
	return cached_center[pmtId];
}

double SmartRecHelperSvc::TOF_fromRecTimeLike(const TVector3 &recPos,const unsigned int pmtId) {
	const TVector3 &pmtCenter(GetPMTCenter(pmtId));
	const double Ball_R = 19.316;
	const double LS_R = 17.7;
	double source_x = recPos.X();
	double source_y = recPos.Y();
	double source_z = recPos.Z();
	double pmt_pos_x = pmtCenter.X();
	double pmt_pos_y = pmtCenter.Y();
	double pmt_pos_z = pmtCenter.Z();

	double dx = (source_x - pmt_pos_x)/1000;
	double dy = (source_y - pmt_pos_y)/1000;
	double dz = (source_z - pmt_pos_z)/1000;

	double r0 = (TMath::Sqrt(source_x*source_x+source_y*source_y+source_z*source_z))/1000;
	double dist = TMath::Sqrt(dx*dx+dy*dy+dz*dz);

	double cos_theta = (Ball_R*Ball_R+dist*dist-r0*r0)/(2*Ball_R*dist);

	double theta = TMath::ACos(cos_theta);

	double dist_oil = Ball_R*cos_theta-TMath::Sqrt(LS_R*LS_R-Ball_R*Ball_R*TMath::Sin(theta)*TMath::Sin(theta));

	return (dist-dist_oil)*1e9*1.54/299792458+dist_oil*1e9*1.33/299792458;//currently
}


double SmartRecHelperSvc::GetDarkRate() const {
	return m_darkRate;
}

double SmartRecHelperSvc::GetDarkRate3inch() const {
	// currently assume they are the same
	return m_darkRate3inch;
}

double SmartRecHelperSvc::GetWaveformRecEff() const {
	return m_waveformRecEff;
}

double SmartRecHelperSvc::GetExpectedDarkHit() const {
	return (GetDarkRate()*CdID::module20inchNumber()+GetDarkRate3inch()*CdID::module3inchNumber())*GetWaveformRecEff();
}

bool SmartRecHelperSvc::CorrectTOFAndCollectHits(
		const TVector3 &recPos,const list<CalibPMTChannel*> &chhlist, 
		HitHistogram &clusterHits) {
	LogDebug << "Correcting TOF and collecting hits..."<<endl;
	clusterHits.Reset();
	int output_count = 0;
	for(list<CalibPMTChannel*>::const_iterator chhlistIt = chhlist.begin();
			chhlistIt != chhlist.end(); ++chhlistIt) {
		const JM::CalibPMTChannel  *calib = *chhlistIt; 
		const unsigned int pmtId = CdID::module(Identifier(calib->pmtId()));
		const vector<double> &charge_v = calib->charge();
		const vector<double> &time_v = calib->time();
		for(unsigned int i = 0;i<time_v.size();++i) {
			double tof= TOF(recPos,pmtId);
			clusterHits.Insert(pmtId,charge_v.at(i),time_v.at(i),tof);
			(output_count++<10?LogDebug:LogTest) << "["<<output_count<<
				"] Collecting another hit: ch="<<pmtId<<
				" charge="<<charge_v.at(i)<<
				" time="<<time_v.at(i)<<
				"(before) "<<time_v.at(i)-tof<<
				"(after)"<<endl;
		}
	}
	return true;
}

#include "TMath.h"
unsigned int SmartRecHelperSvc::PoissonLowerLimit(double mu,double CL) const {
	int lowerLimit = int(mu); 
	double probSum = 0;
	for(;probSum<CL/2;--lowerLimit)
		probSum += TMath::Poisson(lowerLimit,mu);
	if(lowerLimit<0) lowerLimit = 0;
	return lowerLimit;
};
#include "Math/DistFunc.h"
unsigned int SmartRecHelperSvc::PoissonUpperLimit(double mu,double CL) const {
	static double mu_cached = -1;
	static double CL_cached = -1;
	static unsigned int upperLimit= -1;
	if(!(mu==mu_cached&&CL==CL_cached)) {
		if(mu<100) {
			upperLimit = 0;
			while(ROOT::Math::poisson_cdf(upperLimit,mu)<=CL)
				++upperLimit;
		} else 
			upperLimit = ROOT::Math::gaussian_quantile(CL,sqrt(mu))+mu;
	}
	return upperLimit;
};

#include "Math/Functor.h"
#include "Math/RootFinder.h"

bool SmartRecHelperSvc::GetScatterPos(const TVector3 &pos,const TVector3 &pmtPos,TVector3 &scatterPos) const {
	//LogInfo<<"+++++++++++++++++++++++++"<<endl;
	//LogInfo <<"pos "<<pos.X()<<" "<<pos.Y()<<" "<<pos.Z()<<
	//	" pmtCenter "<<pmtPos.X()<<" "<<pmtPos.Y()<<" "<<pmtPos.Z()<<
	//	endl;
	ScatterHelper::SetPos(pos,pmtPos);
	ROOT::Math::Functor1D f1D(&ScatterHelper::equation);
	ROOT::Math::RootFinder rfb(ROOT::Math::RootFinder::kBRENT);
	//ROOT::Math::RootFinder rfb(ROOT::Math::RootFinder::kGSL_BISECTION);
	rfb.SetFunction(f1D, 0, ScatterHelper::theta);
	//LogInfo <<"set theta: "<<ScatterHelper::theta<<
	//	endl;
	rfb.Solve();
	double phi = rfb.Root();
	bool found = fabs(ScatterHelper::equation(phi))<1e-7;
	if(!found) return false;
	//LogInfo <<"phi: "<<phi/3.1415926*180<<
	//	" theta: "<<ScatterHelper::theta<<
	//	" ni*si-no*so: "<<ScatterHelper::equation(phi)<<
	//	endl;
	ScatterHelper::GetScatterPos(scatterPos);
	//LogInfo<<"--------------------------"<<endl;
	return true;
}

bool ScatterHelper::SetPhi(double x) {
	phi = x;
	alpha = theta-phi;
	a = sqrt(b*b+c*c-2*b*c*cos(alpha));
	cos_theta_o = -((a*a+c*c-b*b)/(2*a*c));
	if(phi>theta) cos_theta_o = - cos_theta_o;
	if(fabs(cos_theta_o)>1) cos_theta_o/=fabs(cos_theta_o);
	sin_theta_o = sqrt(fabs(1-cos_theta_o*cos_theta_o));
	e = sqrt(c*c+d*d-2*c*d*cos(phi));
	cos_theta_i = (c*c+e*e-d*d)/(2*c*e);
	if(fabs(cos_theta_i)>1) cos_theta_i/=fabs(cos_theta_i);
	if(phi<0) cos_theta_i = - cos_theta_i;
	sin_theta_i = sqrt(fabs(1-cos_theta_i*cos_theta_i));
	Dump();
	return true;
}

bool ScatterHelper::GetScatterPos(TVector3 &scatterPos) {
	double ratio = tan(phi)/(tan(alpha)+tan(phi));
	double k1 = c*ratio/cos(alpha);
	double k2 = c*(1-ratio)/cos(phi);
	scatterPos = k1*pmtPos.Unit()+k2*pos.Unit();
	return true;
}

double ScatterHelper::equation(double x) {
	SetPhi(x);
	return ni*sin_theta_i-no*sin_theta_o;
}

bool ScatterHelper::SetPos(const TVector3 &Pos, const TVector3 &PmtPos) {
	pos = Pos;
	pmtPos = PmtPos;
	b = pmtPos.Mag();
	d = pos.Mag();
	cos_theta = pos.Unit().Dot(pmtPos.Unit());
	theta = acos(cos_theta);
	return true;
}

bool ScatterHelper::Dump() {
	const double cvt = 1/3.1415926535*180;
	LogDebug <<" a-b-c-d-e: "<<
		a<<"-"<<b<<"-"<<c<<"-"<<d<<"-"<<e<<
		" theta-alpha-phi: "<<
		theta*cvt<<"-"<<alpha*cvt<<"-"<<phi*cvt<<
		" ct-ti-to: "<<
		asin(no/ni)*cvt<<"-"<<acos(cos_theta_i)*cvt<<"-"<<acos(cos_theta_o)*cvt<<
		" i-o: "<<
		cos_theta_i<<"-"<<sin_theta_i<<"-"<<cos_theta_o<<"-"<<sin_theta_o<<
		" eq: "<<ni*sin_theta_i-no*sin_theta_o<<
		endl;
	return true;
}

bool SmartRecHelperSvc::Clusterize(const TVector3 &recPos,const list<CalibPMTChannel*> &chhlist,vector<Cluster*> &clusters) {
	LogDebug << "Clusterization for "<<chhlist.size()<<" channels"<<endl;
	LogDebug <<"RecPos: "<<recPos.X()<<" "<<recPos.Y()<<" "<<recPos.Z()<<" "<<endl;
	HitHistogram clusterHits(1,-500,1750); // 1ns per bin; -500 ns to 1750 ns
	const double ns_to_s = 1e-9;
	N_dark_hit = GetExpectedDarkHit()*clusterHits.GetBinWidth()*ns_to_s;
	CorrectTOFAndCollectHits(recPos,chhlist,clusterHits); // automatically sorted
	enum find_cluster_status {
		looking_for_cluster_start,
		looking_for_cluster_end,
	} find_cluster_state(looking_for_cluster_start);
	unsigned int cluster_start = 0,cluster_end = 0,used_endSearchWindow = 0;
	for(unsigned int scan = 0;true;) {
		if(scan==clusterHits.GetNbins()-1) {
			if(find_cluster_state==looking_for_cluster_end)
				LogInfo <<" A broken cluster found at the end of the window."<<endl;
			break;
		}
		switch(find_cluster_state) {
			case looking_for_cluster_start:
				LogTest<<clusterHits.GetBinCenter(scan)<<" -> "<<clusterHits.GetEntries(scan,scan+m_startSearchWindow-1)
					<<((clusterHits.GetEntries(scan,scan+m_startSearchWindow-1))>(PoissonUpperLimit(N_dark_hit*m_startSearchWindow,CL))?">":"<=")
					<<(PoissonUpperLimit(N_dark_hit*m_startSearchWindow,CL)) 
					<<endl;
				if(clusterHits.GetEntries(scan,scan+m_startSearchWindow-1)>PoissonUpperLimit(N_dark_hit*m_startSearchWindow,CL)) {
					cluster_start = scan;
					find_cluster_state = looking_for_cluster_end;
					double energy = clusterHits.GetEntries(scan,scan+299)-N_dark_hit*300;
					if(energy>m_hEThreshold) 
						used_endSearchWindow = m_endSearchWindowHE;
					else
						used_endSearchWindow = m_endSearchWindow;
					if(cluster_start>m_preWindow/clusterHits.GetBinWidth()) cluster_start-=m_preWindow/clusterHits.GetBinWidth();
					LogTest<<"found a start. "<<clusterHits.GetBinCenter(scan)
						<<" (determined start "<<clusterHits.GetBinCenter(cluster_start)<<")"
						<<" "<<(clusterHits.GetEntries(scan,scan+m_startSearchWindow-1))
						<<">"<<(PoissonUpperLimit(N_dark_hit*m_startSearchWindow,CL)) 
						<<" is HE? "<<energy<<" vs "<<m_hEThreshold
						<<" used_endSearchWindow: "<<used_endSearchWindow
						<<endl;
				} else
					++scan;
				break;
			case looking_for_cluster_end:
				LogTest<<clusterHits.GetBinCenter(scan)<<" -> "<<clusterHits.GetEntries(scan,scan+used_endSearchWindow-1)
					<<((clusterHits.GetEntries(scan,scan+used_endSearchWindow-1))>(PoissonUpperLimit(N_dark_hit*used_endSearchWindow,CL))?">":"<=")
					<<(PoissonUpperLimit(N_dark_hit*used_endSearchWindow,CL)) 
					<<endl;
				if(clusterHits.GetEntries(scan,scan+used_endSearchWindow-1)<=PoissonUpperLimit(N_dark_hit*used_endSearchWindow,CL)) {
					cluster_end = scan;

					unsigned int cluster_determined_end = cluster_end+m_postWindow/clusterHits.GetBinWidth();
					unsigned int cluster_least_end = cluster_start+m_clusterLeastDur/clusterHits.GetBinWidth();
					if(cluster_determined_end<cluster_least_end) cluster_determined_end = cluster_least_end;
					unsigned int cluster_max_end = clusterHits.GetNbins()-1;
					if(cluster_determined_end>cluster_max_end) cluster_determined_end = cluster_max_end;
					LogTest<<"found an end. "<<clusterHits.GetBinCenter(cluster_end)
						<<" (determined end "<<clusterHits.GetBinCenter(cluster_determined_end)<<")"
						<<" "<<(clusterHits.GetEntries(scan,scan+used_endSearchWindow-1))
						<<((clusterHits.GetEntries(scan,scan+used_endSearchWindow-1))>(PoissonUpperLimit(N_dark_hit*used_endSearchWindow,CL))?">":"<=")<<(PoissonUpperLimit(N_dark_hit*used_endSearchWindow,CL)) 
						<<endl;
					scan+=m_skippAfterCluster/clusterHits.GetBinWidth();
					LogTest<<"After skip, scan = "<<clusterHits.GetBinCenter(scan)<<endl;
					// shrink the cluster
					for(; scan<=cluster_determined_end+m_skippAfterCluster/clusterHits.GetBinWidth();++scan) {
						LogTest<<clusterHits.GetBinCenter(scan)<<" -> "<<clusterHits.GetEntries(scan,scan+m_startSearchWindow-1)
							<<((clusterHits.GetEntries(scan,scan+m_startSearchWindow-1))>(PoissonUpperLimit(N_dark_hit*m_startSearchWindow,CL))?">":"<=")
							<<PoissonUpperLimit(N_dark_hit*m_startSearchWindow,CL)
							<<endl;
						if(clusterHits.GetEntries(scan,scan+m_startSearchWindow-1)>PoissonUpperLimit(N_dark_hit*m_startSearchWindow,CL))  {
							LogTest<<"found another cluster inside the tail: "<<clusterHits.GetBinCenter(scan)
								<<" "<<(clusterHits.GetEntries(scan,scan+m_startSearchWindow-1))
								<<((clusterHits.GetEntries(scan,scan+m_startSearchWindow-1))>(PoissonUpperLimit(N_dark_hit*m_startSearchWindow,CL))?">":"<=")
								<<(PoissonUpperLimit(N_dark_hit*m_startSearchWindow,CL)) 
								<<endl;
							break;
						}
					}
					if(scan-m_preWindow/clusterHits.GetBinWidth()<=cluster_end)
						LogWarn<<"SkipAfterCluster is not large enough! two cluster corrups: "
							<<scan-m_preWindow/clusterHits.GetBinWidth()
							<<" <= "<<cluster_end
							<<endl;
					cluster_end = scan-m_skippAfterCluster/clusterHits.GetBinWidth();
					LogInfo<<"found a cluster: "<<
						clusterHits.GetBinCenter(cluster_start)<<" to "<<
						clusterHits.GetBinCenter(cluster_end)<<" (ns) "<<
						"dh "<<N_dark_hit<<
						"(/ns) uplim "<<PoissonUpperLimit(N_dark_hit*m_startSearchWindow,CL)<<
						"(S) "<<PoissonUpperLimit(N_dark_hit*used_endSearchWindow,CL)<<
						"(E) ("<<clusterHits.GetEntries(cluster_start-1,cluster_start-1+m_startSearchWindow-1)<<") "
						<<clusterHits.GetEntries(cluster_start,cluster_start+m_startSearchWindow-1)<<
						" -> "<<clusterHits.GetEntries(cluster_end,cluster_end+used_endSearchWindow-1)<<
						" ("<<clusterHits.GetEntries(cluster_end+1,cluster_end+1+used_endSearchWindow-1)<<")"<<
						" nhit': "<<clusterHits.GetEntries(cluster_start,cluster_end)-N_dark_hit*(cluster_end-cluster_start+1)<<
						" nhit: "<<clusterHits.GetEntries(cluster_start,cluster_end)<<
						" nhit thres: "<<PoissonUpperLimit(N_dark_hit*(cluster_end-cluster_start+1),CL)<<
						endl;
					if(clusterHits.InSafeWindow(cluster_start,cluster_end))
						WrapOneCluster(clusterHits,cluster_start,cluster_end,clusters);
					else {
						LogInfo <<" This cluster is outside the safe window and abandoned: "<<clusterHits.GetBinCenter(cluster_start)<<" to "<<clusterHits.GetBinCenter(cluster_end)<<endl;
					}
					find_cluster_state = looking_for_cluster_start;
				} else
					++scan;
				break;
			default:
				LogFatal<<__func__<<" how can you get here?? "<<endl;
				return false;
		};
	}
	return true;
}
bool SmartRecHelperSvc::WrapOneCluster(const HitHistogram &clusterHits,unsigned int cluster_start,unsigned int cluster_end,vector<Cluster*> &clusters) {
	Cluster *cluster = new Cluster;
	//  LogDebug << " Inserting cluster ["<<cluster_start<<" to "<<cluster_end<<"]"<<endl;
	if(clusterHits.GetBinCenter(cluster_end)-clusterHits.GetBinCenter(cluster_start)<m_clusterLengthThreshold) {
		LogDebug << " short cluster, abandoned"<<endl;
		return false;
	}
	if(clusterHits.GetEntries(cluster_start,cluster_end)<PoissonUpperLimit(N_dark_hit*(cluster_end-cluster_start+1),CL)) {
		LogDebug << " no signal, abandoned"<<endl;
		return false;
	}

	unsigned int start_i = cluster_start;
	unsigned int end_i = cluster_end;
	for(unsigned int i = start_i; i<=end_i;++i) {
		const list<ClusterHit*> *hits = clusterHits.GetBin(i);
		//    LogDebug << " bin("<<i<<") got: "<<hits<<endl;
		if(!hits) {
			continue;
		}
		for(list<ClusterHit*>::const_iterator hitsIt = hits->begin();
				hitsIt!=hits->end();++hitsIt) {
			ClusterHit* clusterHit = *hitsIt;
			const unsigned int pmtid = CdID::id(clusterHit->pmtId,0);
			const double charge = clusterHit->charge;
			const double time = clusterHit->rawTime;

			cluster->addCalibPmtChannel(pmtid);
			CalibPMTChannel *channel = const_cast<CalibPMTChannel*>(cluster->getCalibPmtChannel(pmtid));
			vector<double> charge_v = channel->charge();
			vector<double> time_v = channel->time();
			double NPE;
			double firstHitTime;
			if(time_v.size()==0) {
				firstHitTime = 1e10;
			    NPE = 0;
			} else {
				firstHitTime = channel->firstHitTime();
				NPE = channel->nPE();
			}

			charge_v.push_back(charge);
			time_v.push_back(time);
			channel->setCharge(charge_v);
			channel->setTime(time_v);
			channel->setNPE(NPE+charge);
			channel->setFirstHitTime(firstHitTime<time?firstHitTime:time);
		};
	}
  cluster->length = cluster_end-cluster_start+1;
	clusters.push_back(cluster);
	return true;
}

bool SmartRecHelperSvc::CachePMTCenter() {
	LogInfo << "Caching PMT center..." << endl;
	if(!m_staticGeometryLib) {
		unsigned int tree_N = CdID::module20inchNumber()+CdID::module3inchNumber();
		for(unsigned int tree_i = 0;tree_i<tree_N;++tree_i) {
			PmtGeom *pmt = m_cdGeom->getPmt(Identifier(CdID::id(tree_i,0)));
			cached_center[tree_i] = pmt->getCenter();
		}
	} else {
		unsigned int tree_N = pmtpos_tree->GetEntries();
		for(unsigned int tree_i = 0;tree_i<tree_N;++tree_i) {
			pmtpos_tree->GetEntry(tree_i);
			cached_center[tree_i] = *m_pmtCenter;
		}
	}
	LogInfo << "Done."<< endl;
	return true;
}
//const TVector3 SmartRecHelperSvc::GetPMTCenter(const Identifier &logicCh) {
//	LogWarn<<"this method is super slow. please use another one!!!"<<endl;
//	if(m_staticGeometryLib) {
//        PmtGeom *pmt = m_cdGeom->getPmt(logicCh);
//        return pmt->getCenter();
//	} else {
//		unsigned int module = CdID::module(logicCh);
//		pmtpos_tree->GetEntry(module);
//		return *m_pmtCenter;
//	}
//}
//double SmartRecHelperSvc::TOF(const TVector3 &recPos,const Identifier &logicCh) {
//	if(m_useFindScatter)
//		return TOF_findscatter(recPos,logicCh);
//	else
//		return TOF_fromRecTimeLike(recPos,logicCh);
//}
//double SmartRecHelperSvc::TOF_fromRecTimeLike(const TVector3 &recPos,const Identifier &logicCh) {
//	TVector3 pmtCenter = GetPMTCenter(logicCh);
//	const double Ball_R = 19.316;
//	const double LS_R = 17.7;
//	double source_x = recPos.X();
//	double source_y = recPos.Y();
//	double source_z = recPos.Z();
//	double pmt_pos_x = pmtCenter.X();
//	double pmt_pos_y = pmtCenter.Y();
//	double pmt_pos_z = pmtCenter.Z();
//
//	double dx = (source_x - pmt_pos_x)/1000;
//	double dy = (source_y - pmt_pos_y)/1000;
//	double dz = (source_z - pmt_pos_z)/1000;
//
//	double r0 = (TMath::Sqrt(source_x*source_x+source_y*source_y+source_z*source_z))/1000;
//	double dist = TMath::Sqrt(dx*dx+dy*dy+dz*dz);
//
//	double cos_theta = (Ball_R*Ball_R+dist*dist-r0*r0)/(2*Ball_R*dist);
//
//	double theta = TMath::ACos(cos_theta);
//
//	double dist_oil = Ball_R*cos_theta-TMath::Sqrt(LS_R*LS_R-Ball_R*Ball_R*TMath::Sin(theta)*TMath::Sin(theta));
//
//	return (dist-dist_oil)*1e9*1.54/299792458+dist_oil*1e9*1.33/299792458;//currently
//}
//
//double SmartRecHelperSvc::TOF_findscatter(const TVector3 &recPos,const Identifier &logicCh) {
//	TVector3 pmtCenter = GetPMTCenter(logicCh);
//
//	const double LS_R = 17.7;
//
//	if(recPos.Mag()>LS_R*1e3) return 1e10;
//
//	ScatterHelper::SetPos(recPos,pmtCenter);
//
//	TVector3 scatterPos;
//	bool found = GetScatterPos(recPos,pmtCenter,scatterPos);
//	if(!found) {
//		LogInfo<<"Dark zone"<<endl;
//		return 2e10;
//	}
//
//	const double dist_LS = ScatterHelper::e;
//	const double dist_water = ScatterHelper::a;
//
//	LogInfo << "scatter pos: "<< scatterPos.X()<<" "<<scatterPos.Y()<<" "<<scatterPos.Z()<<
//		" dist_LS: "<<dist_LS<<" dist_water: "<<dist_water<<endl;
//
//	return dist_LS/1e3*1e9*1.64/299792458+dist_water/1e3*1e9*1.43/299792458;//currently
//};
double SmartRecHelperSvc::AbsWeight(const TVector3 &pos,const unsigned int pmtId) const {
	const TVector3 &pmtCenter(GetPMTCenter(pmtId));
	return exp(-(pmtCenter-pos).Mag()/effAttLen);
};

double SmartRecHelperSvc::AccWeight(const TVector3 &pos,const unsigned int pmtId) const {
	const TVector3 &pmtCenter(GetPMTCenter(pmtId));
	const TVector3 pmtNorm(pmtCenter-pos);
	const double areaPMT = 0.811; // m^2
	const double effAreaPMT = areaPMT*pmtCenter.Unit().Dot(pmtNorm.Unit());
	const double angPMT = effAreaPMT/pmtNorm.Mag2();
	const double norm = 2.173634e-9;
	return angPMT/norm;
};

bool SmartRecHelperSvc::IsInDarkZone(const TVector3 &recPos,const unsigned pmtId) const {
	if(recPos.Mag()<ScatterHelper::r_threshold) return false;
	const TVector3 &pmtCenter = GetPMTCenter(pmtId);
	TVector3 scatterPos;
	return !GetScatterPos(recPos,pmtCenter,scatterPos);
};

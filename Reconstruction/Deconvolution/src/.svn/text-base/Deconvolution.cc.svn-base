//////////////////////////////////
/*
Algorithm for PMT waveform reconstruction, with the deconvolution method.
v1, Zeyuan Yu.
Author: yuzy@ihep.ac.cn
July 12, 2016
*/
/*
v2. Add a simple hit counting algorithm on the deconvolution results.
If a hit has a charge integral less than 1.5 p.e., and it is far away from other other hit, its charge is set to 1 p.e.
Energy resolution is expected to be improved by at least 0.1% at 1MeV.
By Zeyuan Yu.
Oct. 18, 2016
*/
/*
v3. Update for the J17v1:
    1) Modify according to the FADC configurations and ouput format
By Zeyuan Yu.
Apr. 6, 2017
*/
//////////////////////////////////
#ifndef Deconvolution_cc
#define Deconvolution_cc
#include "Deconvolution.h"
#include "SniperKernel/AlgFactory.h"
#include "SniperKernel/SniperLog.h"
#include "EvtNavigator/NavBuffer.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "SniperKernel/SniperPtr.h"
#include "RootWriter/RootWriter.h"
#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "Event/ElecHeader.h"
#include "Event/CalibHeader.h"
#include "Identifier/CdID.h"
#include <TFile.h>
#include "TROOT.h"
#include <iostream>
#include <TTree.h>
#include <sstream>
#include "TVirtualFFT.h"
#include "math.h"
using namespace std;

DECLARE_ALGORITHM(Deconvolution);

Deconvolution::Deconvolution(const string& name): AlgBase(name)
        , m_memMgr(0)
	, m_totalPMT(17746)
	, m_threshold(0.08)
        , Raw(0)
        , Freq(0)
        , Back(0)
	, m_para1(50.)
	, m_para2(120.)
	, m_para3(30.)
	, m_length(1250)
	, m_window(9)
	, m_hc(0)
{
    std::string base = getenv("JUNOTOP");
    m_CalibFile = base+"/data/Reconstruction/Deconvolution/share/SPE.root";
    declProp("TotalPMT", m_totalPMT);
    declProp("CalibFile", m_CalibFile);
    declProp("Threshold", m_threshold); 
    declProp("Para1",m_para1);
    declProp("Para2",m_para2);
    declProp("Para3",m_para3);
    declProp("Length",m_length);
    declProp("Window",m_window);
    declProp("HitCounting",m_hc);
}


Deconvolution::~Deconvolution(){}


bool Deconvolution::initialize()
{
    m_stat=0;
    // read gain file
    TFile* f = TFile::Open(m_CalibFile.c_str());
    if(!f){
	LogError<<"Could not open SPE calibration file."<<endl;
	return false;
    }
    // fill the gain map
    int ReadoutLength=0;
    int warnings=0, warnings1=0;
    for(int i=0;i<m_totalPMT;i++){
	ostringstream ss1;
	ss1<<"PMTID_"<<i<<"_SPERE";
	ostringstream ss2;
        ss2<<"PMTID_"<<i<<"_SPEIM";
	TH1F* re = (TH1F*) f->Get(ss1.str().c_str());
	TH1F* im = (TH1F*) f->Get(ss2.str().c_str());
	if(!re||!im){
		if(warnings<10){
			LogWarn<<"SPE spectrum for PMTID "<<i<<" is missing. Will use PMT 0 as default."<<endl;
		}
		warnings++;
		continue;
	}
	vector<double> SPERE, SPEIM;
	if(re->GetNbinsX()!=im->GetNbinsX()){
		LogError<<"PMT SPE spectra for PMTID "<<i<<"are not consistent. Bye!"<<endl;
		return false;
	}
	ReadoutLength = re->GetNbinsX();
	if(ReadoutLength!=int(m_para2)){
		if(warnings1<10){
			LogWarn<<"Cut off frequency of spe and filter for PMTID "<<i<<" are not consistent. Will use the short one."<<endl;
		}
		warnings1++;
	}
	for(int j=0;j<ReadoutLength;j++){
		SPERE.push_back(re->GetBinContent(j+1));
		SPEIM.push_back(im->GetBinContent(j+1));
	}
        m_SPERE.insert( pair<int,std::vector<double> >(i,SPERE) );
        m_SPEIM.insert( pair<int,std::vector<double> >(i,SPEIM) );
	vector<double>(SPERE).swap(SPERE);
        vector<double>(SPEIM).swap(SPEIM);
	delete re;
	delete im;
    }
    LogInfo<<"A total of "<<warnings<<" PMTs do not have pre-defined SPE spectrum."<<endl;
    LogInfo<<"A total of "<<warnings1<<" PMTs have different cutoff frequencies for filter and SPE spectrum"<<endl;
    f->Close();
    if(m_SPERE.size()==0){
	LogError<<"NO PMT SPE WAVEFORM!"<<endl;
	return false;
    }
    // prepare the filter, specified for the J16v2
    for(int i=0;i<m_length;i++){
	if(i<m_para1) m_filter.push_back(1);
	else if(i<m_para2) m_filter.push_back(exp(-0.5*((i-m_para1)/m_para3)*((i-m_para1)/m_para3)));
	else{
		m_filter.push_back(0);
	} // Gaussian like filters. Paramters have been optimized for the current electronics simulation outputs
    }

    // prepare histograms to protect the memory
    Raw = new TH1D("raw","raw",m_length,0,m_length);
    //
    m_memMgr = SniperPtr<IDataMemMgr>(getScope(),"BufferMemMgr").data();
    // SniperPtr<DataRegistritionSvc> drsSvc(getScope(),"DataRegistritionSvc");         
    // if ( ! drsSvc.valid() ) {
    //     LogError << "Failed to get DataRegistritionSvc instance!" << endl;      
    //     return false;
    // }   
    // drsSvc->registerData("JM::CalibEvent","/Event/Calib");    
    // user data definitions
    SniperPtr<RootWriter> svc("RootWriter");
    if (svc.invalid()) {
        LogError << "Can't Locate RootWriter. If you want to use it, please "
                 << "enalbe it in your job option file."
                 << std::endl;
        return false;
    }
    gROOT->ProcessLine("#include <vector>");

    m_calib = svc->bookTree("CALIBEVT", "simple output of calibration data");
    m_calib->Branch("Charge",&m_charge);
    m_calib->Branch("Time",&m_time);
    m_calib->Branch("PMTID",&m_pmtId);
    m_calib->Branch("TotalPE",&m_totalpe,"TotalPE/F");
    return true;
}


bool Deconvolution::execute()
{
    LogDebug << "start PMT waveform unfolding" << endl; 
    // preparation of the user output  
    m_charge.clear();
    m_time.clear();
    m_pmtId.clear();
    m_totalpe=0;
    // read the electronics event
    SniperDataPtr<JM::NavBuffer> navBuf(getScope(),"/Event");
    JM::EvtNavigator* nav = navBuf->curEvt();
    JM::ElecHeader* eh = dynamic_cast<JM::ElecHeader*>(nav->getHeader("/Event/Elec"));
    JM::ElecEvent* ee = dynamic_cast<JM::ElecEvent*>(eh->event());
    const JM::ElecFeeCrate& efc = ee->elecFeeCrate();
    m_crate = const_cast<JM::ElecFeeCrate*>(&efc);

    map<int,JM::ElecFeeChannel> feeChannels = m_crate->channelData();

    list<JM::CalibPMTChannel*> cpcl;//CalibPMTChannel list

    map<int,JM::ElecFeeChannel>::iterator it;
    map<int,vector<double> >::iterator spe = m_SPERE.begin();
    for(it=feeChannels.begin();it!=feeChannels.end();++it){

        JM::ElecFeeChannel& channel = (it->second);
        if(channel.adc().size()==0){
            continue;
        }
	if(channel.adc().size()!=m_length){
		LogError<<"Length of the electronics simulation data is "<<channel.adc().size()<<" ns"<<endl;
		LogError<<"Length of the pre-defined length of deconvolution is "<<m_length<<" ns"<<endl;
		LogError<<"ERROR: inconsistent waveform length in the unfolding."<<endl;
		return false;
	}
        int pmtID = it->first; // remeber to check the conversion from electronics id to pmt id
	double nPE=0, firstHitTime=0;
	vector<double> charge;
	vector<double> time;
	bool StatusC = calibrate(channel,pmtID,charge,time);
	if(StatusC == false){
		LogError<<"ERROR when unfolding the waveform."<<endl;
		return false;
	}
	if(charge.size()==0) continue; // Does not pass the threshold. Do not save. 
	unsigned int detID = CdID::id(static_cast<unsigned int>(pmtID),0);
	for(int j=0;j<int(charge.size());j++){
		nPE+=charge[j];
		m_charge.push_back(charge[j]);
		m_time.push_back(time[j]);
		m_pmtId.push_back(detID);
	}
        m_totalpe += nPE;
	if(charge.size()>0)
		firstHitTime = time[0];
        JM::CalibPMTChannel* cpc = new JM::CalibPMTChannel;
        cpc->setNPE(nPE);
        cpc->setPmtId(detID);
        cpc->setFirstHitTime(firstHitTime);
	cpc->setTime(time);
	cpc->setCharge(charge);
        cpcl.push_back(cpc);
    }
    m_calib->Fill();
    JM::CalibEvent* ce = new JM::CalibEvent;
    ce->setCalibPMTCol(cpcl);
    JM::CalibHeader* ch = new JM::CalibHeader;
    ch->setEvent(ce);

    nav->addHeader("/Event/Calib",ch);

    LogDebug << "End of the PMT Waveform Unfolding" << endl;
    return true;
}


bool Deconvolution::finalize()
{
    return true;
}


bool Deconvolution::calibrate(JM::ElecFeeChannel& channel,int pmtId,vector<double>& charge, vector<double>& time)
{
    vector<unsigned int>& adc_int = channel.adc();
    if(adc_int.size()==0){
        return false;
    }
    vector<double> adc;
    for(int i=0; i<adc_int.size(); i++){
      if(adc_int.at(i)>>8 == 0) adc.push_back(double(adc_int.at(i)));
      if(adc_int.at(i)>>8 == 1) adc.push_back((double(adc_int.at(i)) - (1<<8)) * .4/.06);
      if(adc_int.at(i)>>8 == 2) adc.push_back((double(adc_int.at(i)) - (2<<8)) * 8./.06);
    }
    
    map<int,vector<double> >::iterator spe_re = m_SPERE.find(pmtId);
    map<int,vector<double> >::iterator spe_im = m_SPEIM.find(pmtId);
    if(spe_re==m_SPERE.end()){
	if(m_stat<10){
		LogWarn<<"Could not find the spe calibration waveform for PMT "<<pmtId<<", and will use channel 0 as default."<<endl;
	}
	else if(m_stat==10){
		LogWarn<<"Further spe waveform warning will be suppressed."<<endl;
	}
	m_stat++;
	spe_re = m_SPERE.begin();
	spe_im = m_SPEIM.begin();
    }
    double baseline=0;
    for(int i=0;i<50&&i<int(adc.size());i++)
	baseline+=adc[i];
    baseline/=50.;
    for(int i=0;i<int(adc.size());i++){
	Raw->SetBinContent(i+1,adc[i]-baseline);
    }
    delete TVirtualFFT::GetCurrentTransform();
    TVirtualFFT::SetTransform(0);
    Freq = Raw->FFT(Freq, "MAG");
    const int N = m_length;
    std::vector<double> re_full_vec(N);
    std::vector<double> im_full_vec(N);
    double *re_full = &re_full_vec.front();
    double *im_full = &im_full_vec.front();
    for(int i=0;i<N;i++){
	re_full[i] = 0;
	im_full[i] = 0;
    }
    TVirtualFFT *fft = TVirtualFFT::GetCurrentTransform();
    fft->GetPointsComplex(re_full,im_full);
    for(int i=0;i<N;i++){
    	re_full[i] *= m_filter[i];
        im_full[i] *= m_filter[i];
    }
    int NN = N;
    TVirtualFFT *fft_back = TVirtualFFT::FFT(1, &NN, "C2R M K");
    for(int i=0;i<(spe_re->second).size();i++){
    	if((spe_re->second)[i]!=0||(spe_im->second)[i]!=0){
        	double a11 = re_full[i], b11 = im_full[i], c11 = (spe_re->second)[i], d11 = (spe_im->second)[i];
        	double f11 = c11*c11+d11*d11;
        	re_full[i] = (a11*c11+b11*d11)/f11;
        	im_full[i] = (b11*c11-a11*d11)/f11;
        }
        else{
        	re_full[i] = 0;
                im_full[i] = 0;
        }
    }
    for(int i=(spe_re->second).size();i<m_length;i++){
	re_full[i] = 0;
        im_full[i] = 0;
    }
    re_full[0] = 0;
    im_full[0] = 0; 
    fft_back->SetPointsComplex(re_full,im_full);
    fft_back->Transform();
    Back = TH1::TransformHisto(fft_back,Back,"Re");
    Back->Scale(1./N);
    // double *AC = new double[N];
    std::vector<double> AC(N);
    for(int i=0;i<N;i++){
	AC[i] = Back->GetBinContent(i+1);
    }
    //delete Back;
    //Back = 0;
    baseline = 0;
    delete fft_back;
    fft_back = 0;

    for(int i=0;i<N;i++){
	Raw->SetBinContent(i+1,0);
	Back->SetBinContent(i+1,0);
    }

    double HitBTime[1000] = {0}, HitETime[1000] = {0};
    for(int i=0;i<40;i++) baseline+=AC[i];
    baseline/=40.;
    for(int i=0;i<N;i++)AC[i]-=baseline;
    int Pass = 0, HitCount=0;
    for(int i=0;i<N;i++){
    	if(Pass==0&&AC[i]>m_threshold){
        	for(int tt=i;tt>0;tt--){
                	if(AC[tt]<0){
                        	HitBTime[HitCount] = tt;
                                break;
                        }
                }
                Pass=1;
                continue;
        }
	if(Pass==1){
        	if(AC[i]<=0){
                        Pass=0;
                    	HitETime[HitCount] = i;
                       	if(HitETime[HitCount]-HitBTime[HitCount]>6)
                      		HitCount++;
                        else{
                                HitBTime[HitCount]=0;
                        	HitETime[HitCount]=0;
                	}
        	}
        }
        if(HitCount>990) break;
    }
    int cc=0;
    baseline=0;
    if(HitBTime[0]>40){
	baseline=0;
    }
    else if (HitETime[HitCount-1]<N-100){
    	for(int i=HitETime[HitCount-1]+20;i<HitETime[HitCount-1]+80;i++){
        	baseline += AC[i];
                cc++;
        }
        baseline/=(cc+0.0);
    }
    else
    	baseline=0;

    for(int i=0;i<N;i++) AC[i] -= baseline;
    HitCount = 0; Pass = 0;
    Pass = 0, HitCount=0;
    for(int i=0;i<1000;i++){
	HitBTime[i] = 0;
	HitETime[i] = 0;
    }
    for(int i=0;i<N;i++){
        if(Pass==0&&AC[i]>m_threshold){
                for(int tt=i;tt>0;tt--){
                        if(AC[tt]<0){
                                HitBTime[HitCount] = tt;
                                break;
                        }
                }
                Pass=1;
                continue;
        }
        if(Pass==1){
                if(AC[i]<=0){
                        Pass=0;
                        HitETime[HitCount] = i;
                        if(HitETime[HitCount]-HitBTime[HitCount]>6)
                                HitCount++;
                        else{
                                HitBTime[HitCount]=0;
                                HitETime[HitCount]=0;
                        }
                }
        }
        if(HitCount>990) break;
    }
    
    int inteW =m_window;
    if(HitCount==0){
	return true;
    }
    for(int i=0;i<HitCount;i++){
	time.push_back(HitBTime[i]);
	int inte_begin=0, inte_end = 0;
	int singleHit=0;
	if(HitCount==1){
		inte_begin = HitBTime[i]- inteW + 1;
		if(inte_begin<0) inte_begin = 0;
		inte_end = HitETime[i] + inteW;
		if(inte_end>N) inte_end = N;
		singleHit=1;
	}
	else{
		if(i==0) {
			inte_begin = HitBTime[i]- inteW + 1;
	                if(inte_begin<0) inte_begin = 0;
			int interval = HitBTime[1] - HitETime[0];
			if(interval>2*inteW) {
				inte_end = HitETime[0]+inteW;
				singleHit=1;
			}
			else inte_end = int(HitETime[0]+interval/2.);
		}
		else if(i==HitCount-1){
			inte_end = HitETime[i] + inteW;
	                if(inte_end>N) inte_end = N;
			int interval = HitBTime[i]-HitETime[i-1];
			if(interval>2*inteW) {
				inte_begin = HitBTime[i]- inteW + 1;
				singleHit=1;
			}
			else inte_begin = int(HitBTime[i]-interval/2.);
		}
		else{
			int single1=0, single2=0;
			int interval = HitBTime[i+1] - HitETime[i];
			if(interval>inteW*2) {
				inte_end = HitETime[i]+inteW;
				single1=1;
			}
			else inte_end = int(HitETime[i]+interval/2.);
			interval = HitBTime[i]-HitETime[i-1];
			if(interval>2*inteW) {
				inte_begin = HitBTime[i]- inteW + 1;
				single2=1;
			}
                        else inte_begin = int(HitBTime[i]-interval/2.);
			if(single1==1&&single2==1) singleHit=1;
		}
	}
	double tempC = 0;
	for(int j=inte_begin;j<inte_end;j++)
		tempC+=AC[j];
	if(m_hc){ // the hit counting method is opened
		if(singleHit){
			if(tempC<1.55) tempC = 1; // A simple hit counting, to remove the PMT amplitude fluctuations.
			//else if(tempC<2.5) tempC = 2;
			//else if(tempC<3.5) tempC = 3;	
		}
	}
	charge.push_back(tempC);
    }
    return true;
}


#endif



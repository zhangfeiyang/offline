/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#include "SmartRecHelperSvc/HitHistogram.h"
#include "SniperKernel/SniperLog.h"
#include <iostream>
using std::endl;
#include <algorithm>
using std::fill;
HitHistogram::HitHistogram(double BinWidth,double TL,double TR) :
	binWidth(BinWidth),tL(TL),tR(TR),Nbins((TR-TL)/BinWidth),TOF_min(1e99),TOF_max(-1e99)
{
	if((TR-TL)/BinWidth!=Nbins)
		LogWarn<< "bin width is not the divider of span: "<<Nbins<<" bins expected"<<endl;
	data = new list<ClusterHit*>*[Nbins];
	fill(data,data+Nbins,(list<ClusterHit*>*)0LL);
};

HitHistogram::~HitHistogram() {
	Reset();
	delete data;
}

const list<ClusterHit*> *HitHistogram::GetBin(unsigned int bin) const { 
	return GetData(bin);
};

#include "Identifier/CdID.h"
#include "SmartRecHelperSvc/ClusterHit.h"
bool HitHistogram::Insert(const unsigned int pmtId, const double charge,const double rawTime,const double TOF) {
	double time = rawTime-TOF;
	int bin = int((time-tL)/binWidth);
	if(!((bin>=0)&&((unsigned int)(bin)<Nbins))) {
		LogDebug <<" A hit is lost"<<
			" ch="<<pmtId<<
			" charge="<<charge<<
			" time="<<time<<
			" tL "<<tL<<" tR "<<tR<<endl;
		return false;
	}
	// cout << __func__<<" bin: "<<bin <<" "<<time<<" "<<tL<<" "<<binWidth<<" "<<tR<<endl;
	if(!data[bin])
		data[bin] = new list<ClusterHit*>;
	data[bin]->push_back(new ClusterHit(pmtId,charge,rawTime,time));
	TOF_min = TOF_min<TOF?TOF_min:TOF;
	TOF_max = TOF_max>TOF?TOF_max:TOF;
	return true;
};

unsigned int HitHistogram::GetEntries(const unsigned int bin) const {
	if(GetData(bin))
		return data[bin]->size();
	else
		return 0;
};

unsigned int HitHistogram::GetEntries(const unsigned int bin, const unsigned int end) const {
	static unsigned bin_cached(-1),end_cached(-1),value_cached(-1);
	//std::cout<<"calculating GetEntries("<<bin<<","<<end<<")"<<" cache: "<<bin_cached<<" "<<end_cached<<" "<<value_cached<<endl;
	unsigned int sum = 0;
	if((bin==bin_cached)&&(end==end_cached))
		sum = value_cached;
	else if((bin==bin_cached+1)&&(end==end_cached+1))
		sum = value_cached-GetEntries(bin_cached)+GetEntries(end);
	else
		for(unsigned int scan = bin; scan<=end; ++scan)
			sum += GetEntries(scan);
	bin_cached = bin;
	end_cached = end;
	value_cached = sum;
    return sum;
}

list<ClusterHit*> *HitHistogram::GetData(const unsigned int bin) const {
	if(bin>=Nbins)
		return 0LL;
	else
		return data[bin];
}



#include "TNtuple.h"
TTree *HitHistogram::GetHits(unsigned int start_i,unsigned int end_i) {
	TTree *tree = new TNtuple("hitTime","hit time","time");
	for(unsigned int i = start_i; i<=end_i;++i) {
		if(!GetData(i)) continue;
		for(list<ClusterHit*>::iterator binIt = data[i]->begin();
				binIt != data[i]->end(); ++binIt)
			dynamic_cast<TNtuple*>(tree)->Fill((*binIt)->time);
	}
	return tree;
}

bool HitHistogram::Reset() {
	for(unsigned int i = 0;i<Nbins;++i) {
		if(!data[i]) continue;
		for(list<ClusterHit*>::iterator dataIt = data[i]->begin();
				dataIt != data[i]->end(); ++dataIt ) {
			delete *dataIt;
		}
		data[i]->clear();
		delete data[i];
		data[i] = nullptr;
	}
	return true;
}

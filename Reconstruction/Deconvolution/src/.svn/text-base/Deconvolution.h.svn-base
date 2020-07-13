#ifndef Deconvolution_h
#define Deconvolution_h

#include <boost/python.hpp>
#include "SniperKernel/AlgBase.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include <map>
#include "TH1D.h"
#include "TTree.h"
#include <vector>
#include <fstream>
#include <string>
class ElecFeeCrate;
class DataBufSvcV2;

namespace JM
{
    class ElecFeeCrate;
    class ElecFeeChannel;
    class CalibHeader;
}


class Deconvolution: public AlgBase
{
    public:
        Deconvolution(const std::string& name);
        ~Deconvolution();

    public:
        bool initialize();
        bool execute();
        bool finalize();

    private:
        bool calibrate(JM::ElecFeeChannel& channel, int pmtId,std::vector<double>& charge, std::vector<double>& time);
   
    private:

        IDataMemMgr* m_memMgr;

        JM::ElecFeeCrate* m_crate;
        std::string m_CalibFile;
        std::map< int, std::vector<double> > m_SPERE;
        std::map< int, std::vector<double> > m_SPEIM;
	std::vector<double> m_filter;
        int m_totalPMT;
        double m_threshold;
	TH1D* Raw;
	TH1* Freq;
	TH1* Back;
	int m_stat;
	double m_para1;
        double m_para2;
        double m_para3;
	int m_length;
	int m_window;
	int m_hc;
	
	// user data definitions
	std::vector<float> m_charge;
	std::vector<float> m_time;
	std::vector<int> m_pmtId;
	float m_totalpe;
	TTree* m_calib;
};


#endif



#ifndef PMTCalib_h
#define PMTCalib_h

#include <boost/python.hpp>
#include "SniperKernel/AlgBase.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "TH1D.h"
#include <vector>
#include <fstream>
#include <string>
class ElecFeeCrate;
class DataBufSvcV2;

namespace JM
{
    class ElecFeeCrate;
    class ElecFeeChannel;
}

class PMTCalib: public AlgBase
{
    public:
        PMTCalib(const std::string& name);
        ~PMTCalib();

    public:
        bool initialize();
        bool execute();
        bool finalize();

    private:
        double integral(JM::ElecFeeChannel& channel);
    private:

        IDataMemMgr* m_memMgr;
	ofstream output1;
        JM::ElecFeeCrate* m_crate;
        std::string m_CalibFile;
	TH1D* m_meanWaveform[20000];
        TH1D* m_SPERE[20000];
        TH1D* m_SPEIM[20000];
	TH1D* m_Integral[20000];
	std::map< int, double> m_inte;
        std::map< int, double> m_intesigma;
	int m_length;
	int m_step;
        int m_totalPMT;
        double m_threshold;
	TH1* m_tempH;
	double m_stat[20000];
	int m_store;
};

#endif

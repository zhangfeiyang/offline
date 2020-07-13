#ifndef IntegralPmtRec_h
#define IntegralPmtRec_h

#include <boost/python.hpp>
#include "SniperKernel/AlgBase.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include <map>

class ElecFeeCrate;
class DataBufSvcV2;

namespace JM
{
    class ElecFeeCrate;
    class ElecFeeChannel;
    class CalibHeader;
}


class IntegralPmtRec: public AlgBase
{
    public:
        IntegralPmtRec(const std::string& name);
        ~IntegralPmtRec();

    public:
        bool initialize();
        bool execute();
        bool finalize();

    private:
        double getNPE(JM::ElecFeeChannel& channel, double gain);
        double getFHT(JM::ElecFeeChannel& channel);//FHT, first hit time
   
    private:

        IDataMemMgr* m_memMgr;

        JM::ElecFeeCrate* m_crate;
        std::string m_gainFile;
        std::map<int, double> m_gainMap;
        int m_totalPMT;
        double m_bin;
        double m_threshold;
};


#endif



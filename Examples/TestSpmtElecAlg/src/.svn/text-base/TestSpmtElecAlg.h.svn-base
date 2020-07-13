#ifndef TEST_SPMT_ELEC_ALG_H
#define TEST_SPMT_ELEC_ALG_H

#include "SniperKernel/AlgBase.h"
#include "EvtNavigator/NavBuffer.h"
#include "TRandom.h"

class TestSpmtElecAlg : public AlgBase
{
    public :

        TestSpmtElecAlg(const std::string& name);

        bool initialize();
        bool execute();
        bool finalize();

    private :

        int m_loop;
        int m_gap;
        int m_mode;

        JM::NavBuffer* m_buf;
        TRandom        m_r;
};

#endif

#ifndef GenTools_h
#define GenTools_h

#include "SniperKernel/AlgBase.h"
#include "TTimeStamp.h"

class IGenTool;
namespace HepMC {
    class GenEvent;
}
class IMCGlobalTimeSvc;

class GenTools: public AlgBase
{
    public:
        GenTools(const std::string& name);
        ~GenTools();

        bool initialize();
        bool execute();
        bool finalize();
    private:
        bool register_data(HepMC::GenEvent*);
        void update_pdg_database();

        // helper: when load previous event, we need to
        // substract the shift time and add it to current timestamp.
        void substract_shift_time(HepMC::GenEvent&);
    private:
        std::vector<std::string> m_genToolNames;
        std::vector<IGenTool*> m_genTools;

        int m_evtid;
        TTimeStamp m_current_timestamp;

        // flag to enable/disable Global Time Svc.
        bool m_use_global_time;
        IMCGlobalTimeSvc* m_global_time_svc;

        int evtMax;
};

#endif

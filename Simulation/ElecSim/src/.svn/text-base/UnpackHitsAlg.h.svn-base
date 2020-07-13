#ifndef UnpackHitsAlg_h
#define UnpackHitsAlg_h

#include "SniperKernel/AlgBase.h"
#include <vector>
#include <string>

namespace JM
{
    class SimEvent;
}

class UnpackHitsAlg: public AlgBase {
    public:

        struct Hit {
            double evttime; // unit: s; this will control by ourself
            double hittime; // unit: ns;
            int pmtid;
            int npe;

            Hit(int pmtid, int npe, double evttime, double hittime) {
                this->pmtid = pmtid;
                this->npe = npe;
                this->evttime = evttime;
                this->hittime = hittime;
            }
        };
        UnpackHitsAlg(const std::string& name);
        ~UnpackHitsAlg();

        bool initialize();
        bool execute();
        bool finalize();

    private:
        bool load_detsim_events();
        JM::SimEvent* load_detsim_event(const std::string& taskname);
        bool unpack_events();
        JM::SimEvent* group_hits();
        bool save_into_buffer(JM::SimEvent*);

        bool is_need_more_data();
    private:
        double m_time_window;
        std::vector<Hit*>::iterator get_group_fix_timewindow();

    private:
        std::vector<std::string> m_detsim_tasks;
        std::vector<JM::SimEvent*> m_simevt_cache;

        std::vector<Hit*> m_hits_cache;
};

#endif

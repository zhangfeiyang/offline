#ifndef PackSplitEventAlg_h
#define PackSplitEventAlg_h

#include "SniperKernel/AlgBase.h"
#include <vector>
#include <list>
namespace JM {
    class SimHeader;
    class SimEvent;
    class SimPMTHit;
    class EvtNavigator;
}

/*  
 * This algorithm can be used in an I/O Task.
 *
 * The final user only trigger the I/O task, and get the data from the data
 * buffer in the I/O task.
 **/

class PackSplitEventAlg: public AlgBase {
    public:
        PackSplitEventAlg(const std::string& name);
        ~PackSplitEventAlg();

        bool initialize();
        bool execute();
        bool finalize();

    private:
        bool merge_evt(JM::SimEvent* dest_evt, JM::SimEvent* src_evt);
    private:
        // cache for normal I/O task
        JM::EvtNavigator* cache_evtnav;
        JM::SimHeader* tmp_simheader;
        JM::SimEvent* tmp_simevent;

        // this alg will load the event in different tasks
        std::string m_task_name;
        Task* iotask;
};


#endif

#ifndef IESFEETOOL_H
#define IESFEETOOL_H
#include "EsClass.h"
#include "Event/ElecHeader.h"


class IEsFeeTool{

    public:

        virtual void initial()=0;

        virtual void SetSimTime(double earliest_item, double latest_item)=0;

        virtual void generateSignals(std::vector<Pulse>& pulse_vector,
                JM::ElecFeeCrate& crate,
                std::vector<FeeSimData>& fsd_vector)=0; 
    protected:
        virtual ~IEsFeeTool();

};










#endif

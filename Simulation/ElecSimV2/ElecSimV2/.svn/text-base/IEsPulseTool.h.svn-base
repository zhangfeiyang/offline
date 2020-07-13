#ifndef IESPULSETOOL_H
#define IESPULSETOOL_H
#include "EsClass.h"

class IEsPulseTool{


    public: 

        virtual void SetSimTime(double earliest_item, double latest_item)=0;
        virtual void generatePulses(vector<Pulse>& pulse_vector, 
                vector<Hit>& hit_vector, 
                vector<PmtData>& pd_vector)=0;

    protected:
        virtual ~IEsPulseTool();

};






















#endif

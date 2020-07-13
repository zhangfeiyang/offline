/*=============================================================================
#
# Author: Jilei Xu - xujl@ihep.ac.cn
# Last modified: 2016-11-13 00:03
# Filename: IReconTool.h
# Description:  reference RecCdMuonAlg
=============================================================================*/
#ifndef IRECONTOOL_H
#define IRECONTOOL_H
#include "RecWpMuonAlg/PmtProp.h"
#include "RecWpMuonAlg/Params.h"

namespace JM{
    class RecHeader; 
}
class IReconTool 
{
    public:

        virtual bool reconstruct( JM::RecHeader* ) = 0; 

        virtual bool configure(const Params*, const PmtTable*) = 0; 

        virtual ~IReconTool(){}; 
}; 
#endif

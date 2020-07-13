/*=============================================================================
#
# Author: Jilei Xu - xujl@ihep.ac.cn
# Last modified: 2016-11-13 00:03
# Filename: PmtProp.h
# Description: reference RecCdMuonAlg
=============================================================================*/
#ifndef PmtProp_H
#define PmtProp_H
//define PMT properity
#include "TVector3.h"
#include <vector>
enum Pmttype {
    _PMTNULL, 
    _PMTINCH20, 
}; 
struct PmtProp{
    TVector3 pos;
    double q;
    double fht;
    double res; 
    double trise; 
    double amp; 
    double integ; 
    bool used;
    Pmttype type; 
};
typedef std::vector<PmtProp> PmtTable; 
#endif

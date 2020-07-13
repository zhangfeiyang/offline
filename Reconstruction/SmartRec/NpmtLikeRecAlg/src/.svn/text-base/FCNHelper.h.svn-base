/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#ifndef FCNHelper_H
#define FCNHelper_H
#include "NpmtLikeRecAlg.h"
class FCNHelper {
	public:
		static void SetAlg(NpmtLikeRecAlg *alg) { fAlg = alg; };
		static double FCN(const double *par) {
			fAlg->LoadParameters(par);
			fAlg->Goodness();
			return fAlg->goodness;
		};
	private:
		static NpmtLikeRecAlg *fAlg;
}; 
#endif

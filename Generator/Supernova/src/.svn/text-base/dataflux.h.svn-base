#ifndef _DATAFLUX_
#include <vector>
#include <cmath>
#include "def.h"

typedef struct
{
	double eStart;
	double eEnd;
	double fluxNuE;
	double fluxNuBarE;
	double fluxNuX;
	double lumNuE;
	double lumNuBarE;
	double lumNuX;
} SPECTRUM;

typedef struct
{
	double time;	//s
	SPECTRUM spectrum[20];
} NODE;

class TDataFlux
{
public:
	TDataFlux(char *filename, double _D, bool _isNH);
	~TDataFlux();
	double GetLocalFlux(double t, double e, NuType type);
	double interpolate(double t, double e, NuType type);
private:
	std::vector <NODE> data;
	bool isNH;
	double D;

};
#define _DATAFLUX_
#endif

#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cmath>
#include <string>
#include <vector>
#include <TF1.h>
#include <TF2.h>
#include <TF3.h>
#include <TRandom3.h>
#include "dataflux.h"
#include "detector.h"
#include "sneventsoutput.h"
#include "sort.h"

using namespace std;

TDetector *detector = NULL;
TDataFlux *flux = NULL;

void CheckArgc(int argc, int needArgc)
{
        if(argc != needArgc && argc != needArgc - 1)
        {
                cerr<<"Need "<<needArgc-2<<" or "<<needArgc - 1
			<<" args: fluxfile, D, randomseed, isNH(y/n), [channelno]"<<endl;
		cerr<<"channelno meaning:"<<endl;
		cerr<<"0:IBD"<<endl<<"1:proton ES"<<endl<<"2:electron ES"<<endl
			<<"3:N12"<<endl<<"4:B12"<<endl<<"5:C12 NC"<<endl;
		cerr<<"Generate all channels if channelno is not present"<<endl;
                exit(1);
        }
}

//x[]: t, eNu, costheta
double IBDRate(double *x, double *par)
{
	return flux->GetLocalFlux(x[0], x[1], nuAE) * detector->GetIBD(x[1], x[2]);
}

double PESEp(double eNu, double costheta)
{
	double mP = 938.272046;
	double tmp1 = pow(eNu + mP, 2);
	double tmp2 = pow(eNu * costheta, 2);
	return mP * (tmp1 + tmp2) / (tmp1 - tmp2) - mP;
}

double dEpdCos(double eNu, double costheta)
{
	double mP = 938.272046;
	return 4 * costheta * pow(eNu * (eNu + mP), 2) * mP 
		/ pow(pow(eNu + mP, 2) - pow(eNu * costheta, 2), 2);
}
//x[]: t, eNu, costheta
double PESRate(double *x, double *par)
{
	double eP = PESEp(x[1], x[2]);
        return (flux->GetLocalFlux(x[0], x[1], nuAE) + flux->GetLocalFlux(x[0], x[1], nuAX)) 
		* detector->GetProtonES(x[1], eP, true) 
		+ (flux->GetLocalFlux(x[0], x[1], nuE) + flux->GetLocalFlux(x[0], x[1], nuX)) 
		* detector->GetProtonES(x[1], eP, false)
		*dEpdCos(x[1], x[2]);
}

double PESTotalRate(double *x, double *par)
{
        return (flux->GetLocalFlux(x[0], x[1], nuAE) + flux->GetLocalFlux(x[0], x[1], nuAX))
                * detector->GetTotalProtonES(x[1], true)
                + (flux->GetLocalFlux(x[0], x[1], nuE) + flux->GetLocalFlux(x[0], x[1], nuX))
                * detector->GetTotalProtonES(x[1], false);
}

double EESEe(double eNu, double costheta)
{
	double mE = 0.510998928;
	double tmp1 = pow(eNu + mE, 2);
	double tmp2 = pow(eNu * costheta, 2);
	return mE * (tmp1 + tmp2) / (tmp1 - tmp2);
}

double dEedCos(double eNu, double costheta)
{
	double mE = 0.510998928;
	return 4 * costheta * pow(eNu * (eNu + mE), 2) * mE 
		/ pow(pow(eNu + mE, 2) - pow(eNu * costheta, 2), 2);
}


//x[]: t, eNu, costheta
double EESRate(double *x, double *par)
{
	double eE = EESEe(x[1], x[2]);
        return (flux->GetLocalFlux(x[0], x[1], nuAE) * detector->GetElectronES(x[1], eE, nuAE) 
        	+ flux->GetLocalFlux(x[0], x[1], nuAX) * detector->GetElectronES(x[1], eE, nuAX) 
        	+ flux->GetLocalFlux(x[0], x[1], nuE) * detector->GetElectronES(x[1], eE, nuE) 
        	+ flux->GetLocalFlux(x[0], x[1], nuX) * detector->GetElectronES(x[1], eE, nuX))
		* dEedCos(x[1], x[2]);
}


/*double EESRate(double *x, double *par)
{               
        return flux->GetLocalFlux(x[0], x[1], nuAE) * detector->GetElectronES(x[1], x[2], nuAE) 
                + flux->GetLocalFlux(x[0], x[1], nuAX) * detector->GetElectronES(x[1], x[2], nuAX) 
                + flux->GetLocalFlux(x[0], x[1], nuE) * detector->GetElectronES(x[1], x[2], nuE) 
                + flux->GetLocalFlux(x[0], x[1], nuX) * detector->GetElectronES(x[1], x[2], nuX);
}       
*/
double EESTotalRate(double *x, double *par)
{
        return flux->GetLocalFlux(x[0], x[1], nuAE) * detector->GetTotalElectronES(x[1], nuAE)
                + flux->GetLocalFlux(x[0], x[1], nuAX) * detector->GetTotalElectronES(x[1], nuAX)
                + flux->GetLocalFlux(x[0], x[1], nuE) * detector->GetTotalElectronES(x[1], nuE)
                + flux->GetLocalFlux(x[0], x[1], nuX) * detector->GetTotalElectronES(x[1], nuX);
}

//x[]: t, eNu
double N12Rate(double *x, double *par)
{
	return flux->GetLocalFlux(x[0], x[1], nuE) * detector->GetN12(x[1]);
}

//x[]: p
double N12DecayRate(double *x, double *par)
{
	double e = sqrt(x[0] * x[0] + 0.511 * 0.511);
	return x[0] * e 
		* pow(16.827 - e, 2) 
		* sqrt(1.451 + 0.066525 / (sqrt(x[0] * x[0] / 0.511 / 0.511 + 1) - 1));
}

//x[]: t, eNu
double B12Rate(double *x, double *par)
{
	return flux->GetLocalFlux(x[0], x[1], nuAE) * detector->GetB12(x[1]);
}

//x[]: p
double B12DecayRate(double *x, double *par)
{
	double e = sqrt(x[0] * x[0] + 0.511 * 0.511);

	return x[0] * e 
		* pow(13.88 - e, 2) 
		* sqrt(1.305 + 0.0407416 / (sqrt(x[0] * x[0] / 0.511 / 0.511 + 1) - 1));
}

//x[]: t, eNu
double C12Rate(double *x, double *par)
{
	return (flux->GetLocalFlux(x[0], x[1], nuAE) + flux->GetLocalFlux(x[0], x[1], nuAX)) 
		* detector->GetC12(x[1], true) 
		+ (flux->GetLocalFlux(x[0], x[1], nuE) + flux->GetLocalFlux(x[0], x[1], nuX)) 
		* detector->GetC12(x[1], false);
}

double IBDEe(double eNu, double costheta)
{
        double mP = 938.272046;
        double mN = 939.565379;
        double mE = 0.510998928;
  double fDelta = mN - mP;
  double fE0 = eNu - fDelta;
  double fP0 = sqrt(fE0 * fE0 - mE * mE);
  double fV0 = fP0 / fE0;
  double sqBracket = 1 - eNu * (1 - fV0 * costheta) / mP;
  double fYsq = (fDelta*fDelta - mE * mE)/2;

	return fE0 * sqBracket - fYsq / mP;
}

double PESCosTheta(double eNu, double eP)
{
	double mP = 938.272046;
	double result = (eNu + mP) * sqrt(eP * (eP + 2 * mP)) / (eNu * (eP + 2 * mP));
	return result > 1.0 ? 1.0 : result;
}

double EESCosTheta(double eNu, double eE)
{
        double mE = 0.510998928;
        if(eE < mE)
        {
                return 0.0;
        }
        double result = (eNu + mE) * sqrt((eE - mE) * (eE + mE)) / (eNu * (eE + mE));
        return result > 1.0 ? 1.0 : result;
}

int main(int argc, char **argv)
{
	ofstream ofs;
	TF3 *ibdrate, *pesrate, *eesrate;
	TF2 *n12rate, *b12rate, *c12rate, *pestotalrate, *eestotalrate;
	TF1 *n12decay, *b12decay;
	double averageEvents;
	int  trueEvents;
        double mP = 938.272046;
        double mN = 939.565379;
        double mE = 0.510998928;
	int channelno = -1;

	double t, eNu, costheta, tmpE, tmpP, tmpPhi;

	vector <Myevent> v;
	Myevent tmpevt;
	CheckArgc(argc, 6);

	if(argc == 6)
	{
		channelno = atoi(argv[5]);
		if(channelno > 5 || channelno < 0)
		{
			channelno = -1;
		}
	}

	string filename("evt-");
	filename += argv[3];
	filename += ".root";

	TSNEventsOutput *output = new TSNEventsOutput(filename.c_str());

	detector = new TDetector(20.0, 0.12);
	flux = new TDataFlux(argv[1], atof(argv[2]), argv[4][0] == 'n' ? false : true);

	gRandom = new TRandom3(atoi(argv[3]));

if(channelno == -1 || channelno == 0)
{
	ibdrate = new TF3("IBDRate", IBDRate, -0.05, 20.0, 0.0, 100.0, -1.0, 1.0, 0);
	ibdrate->SetNpx(1000);
	ibdrate->SetNpy(200);
	ibdrate->SetNpz(200);
	averageEvents = ibdrate->Integral(-0.05, 20.0, 0.0, 100.0, -1.0, 1.0);
	trueEvents = gRandom->Poisson(averageEvents);
	cerr<<"IBD "<<trueEvents<<" events"<<", average "<<averageEvents<<endl;
	for(int i = 0; i < trueEvents; i++)
	{
		ibdrate->GetRandom3(t, eNu, costheta);
		tmpE = IBDEe(eNu, costheta);
		tmpP = sqrt(tmpE * tmpE - mE * mE);
		tmpPhi = 2 * M_PI * gRandom->Uniform();
		evt.nparticles = 2;
		evt.pdgid[0] = -11;
		evt.m[0] = mE;
		evt.t[0] = (t + 0.05) * 1e9;
		evt.px[0] = tmpP * sqrt(1 - costheta * costheta) * cos(tmpPhi);
		evt.py[0] = tmpP * sqrt(1 - costheta * costheta) * sin(tmpPhi);
		evt.pz[0] = tmpP * costheta;
		evt.pdgid[1] = 2112;
		evt.m[1] = mN;
		evt.t[1] = (t + 0.05) * 1e9;
		evt.px[1] = - evt.px[0];
		evt.py[1] = - evt.py[0];
		evt.pz[1] = eNu - evt.pz[0];
		tmpevt.Set(evt);
		v.push_back(tmpevt);
	}
	delete ibdrate;
}

if(channelno == -1 || channelno == 1)
{
	pesrate = new TF3("PESRate", PESRate, -0.05, 20.0, 0.0, 100.0, 0.0, 1.0, 0);
	pesrate->SetNpx(1000);
	pesrate->SetNpy(200);
	pesrate->SetNpz(200);
	pestotalrate = new TF2("PESTotalRate", PESTotalRate, -0.05, 20.0, 0.0, 100.0, 0);
	averageEvents = pestotalrate->Integral(-0.05, 20.0, 0.0, 100.0);
	delete pestotalrate;
	trueEvents = gRandom->Poisson(averageEvents);
	cerr<<"ProtonES "<<trueEvents<<" events"<<endl;
	for(int i = 0; i < trueEvents; i++)
	{
		pesrate->GetRandom3(t, eNu, costheta);
		tmpE = PESEp(eNu, costheta);
		tmpP = sqrt(pow(tmpE + mP, 2) - mP * mP);
		tmpPhi = 2 * M_PI * gRandom->Uniform();
		evt.nparticles = 1;
		evt.pdgid[0] = 2212;
		evt.m[0] = mP;
		evt.t[0] = (t + 0.05) * 1e9;
		evt.px[0] = tmpP * sqrt(1 - costheta * costheta) * cos(tmpPhi);
		evt.py[0] = tmpP * sqrt(1 - costheta * costheta) * sin(tmpPhi);
		evt.pz[0] = tmpP * costheta;
		evt.pdgid[1] = 0;
		evt.m[1] = 0;
		evt.t[1] = 0;
		evt.px[1] = 0;
		evt.py[1] = 0;
		evt.pz[1] = 0;
		tmpevt.Set(evt);
		v.push_back(tmpevt);
	}
	delete pesrate;
}

if(channelno == -1 || channelno == 2)
{
	eesrate = new TF3("EESRate", EESRate, -0.05, 20.0, 0.0, 100.0, 0.0, 1.0, 0);
	eesrate->SetNpx(1000);
	eesrate->SetNpy(200);
	eesrate->SetNpz(200);
	eestotalrate = new TF2("EESTotalRate", EESTotalRate, -0.05, 20.0, 0.0, 1.0, 0);
        averageEvents = eestotalrate->Integral(-0.05, 20.0, 0.0, 100.0);
        delete eestotalrate;
	trueEvents = gRandom->Poisson(averageEvents);
	cerr<<"ElectronES "<<trueEvents<<" events"<<", average "<<averageEvents<<endl;
	for(int i = 0; i < trueEvents; i++)
	{
		eesrate->GetRandom3(t, eNu, costheta);
//		eesrate->GetRandom3(t, eNu, tmpE);
//		costheta = EESCosTheta(eNu, tmpE);
		tmpE = EESEe(eNu, costheta);
		tmpP = sqrt(pow(tmpE, 2) - mE * mE);
		tmpPhi = 2 * M_PI * gRandom->Uniform();
		evt.nparticles = 1;
		evt.pdgid[0] = 11;
		evt.m[0] = mE;
		evt.t[0] = (t + 0.05) * 1e9;
		evt.px[0] = tmpP * sqrt(1 - costheta * costheta) * cos(tmpPhi);
		evt.py[0] = tmpP * sqrt(1 - costheta * costheta) * sin(tmpPhi);
		evt.pz[0] = tmpP * costheta;
		evt.pdgid[1] = 0;
		evt.m[1] = 0;
		evt.t[1] = 0;
		evt.px[1] = 0;
		evt.py[1] = 0;
		evt.pz[1] = 0;
		tmpevt.Set(evt);
		v.push_back(tmpevt);
	}
	delete eesrate;
}

if(channelno == -1 || channelno == 3)
{
	n12rate = new TF2("N12Rate", N12Rate, -0.05, 20.0, 17.339, 100.0, 0);
	n12rate->SetNpx(1000);
	n12rate->SetNpy(200);
	averageEvents = n12rate->Integral(-0.05, 20.0, 17.339, 100.0);
	trueEvents = gRandom->Poisson(averageEvents);
	cerr<<"N12 "<<trueEvents<<" events"<<endl;

	n12decay = new TF1("N12Decay", N12DecayRate, 0, 16.819);
	for(int i = 0; i < trueEvents; i++)
	{
		n12rate->GetRandom2(t, eNu);
		tmpE = eNu - 16.827;
		tmpP = sqrt(pow(tmpE, 2) - mE * mE);
		costheta = -1 + 2 * gRandom->Uniform();
		tmpPhi = 2 * M_PI * gRandom->Uniform();
		evt.nparticles = 2;
		evt.pdgid[0] = 11;
		evt.m[0] = mE;
		evt.t[0] = (t + 0.05) * 1e9;
		evt.px[0] = tmpP * sqrt(1 - costheta * costheta) * cos(tmpPhi);
		evt.py[0] = tmpP * sqrt(1 - costheta * costheta) * sin(tmpPhi);
		evt.pz[0] = tmpP * costheta;

		tmpP = n12decay->GetRandom();
		costheta = -1 + 2 * gRandom->Uniform();
                tmpPhi = 2 * M_PI * gRandom->Uniform();
		evt.pdgid[1] = -11;
		evt.m[1] = mE;
		evt.t[1] = (t + 0.05 + gRandom->Exp(0.011 / log(2))) * 1e9;
		evt.px[1] = tmpP * sqrt(1 - costheta * costheta) * cos(tmpPhi);
		evt.py[1] = tmpP * sqrt(1 - costheta * costheta) * sin(tmpPhi);
		evt.pz[1] = tmpP * costheta;
		tmpevt.Set(evt);
		v.push_back(tmpevt);
	}
	delete n12rate; 
	delete n12decay;
}

if(channelno == -1 || channelno == 4)
{
	b12rate = new TF2("B12Rate", B12Rate, -0.05, 20.0, 14.392, 100.0, 0);
	b12rate->SetNpx(1000);
	b12rate->SetNpy(200);
	averageEvents = b12rate->Integral(-0.05, 20.0, 14.392, 100.0);
	trueEvents = gRandom->Poisson(averageEvents);
	cerr<<"B12 "<<trueEvents<<" events"<<endl;

	b12decay = new TF1("B12Decay", B12DecayRate, 0, 13.87059);
	for(int i = 0; i < trueEvents; i++)
	{
		b12rate->GetRandom2(t, eNu);
		tmpE = eNu - 13.88;
		tmpP = sqrt(pow(tmpE, 2) - mE * mE);
		costheta = -1 + 2 * gRandom->Uniform();
		tmpPhi = 2 * M_PI * gRandom->Uniform();
		evt.nparticles = 2;
		evt.pdgid[0] = -11;
		evt.m[0] = mE;
		evt.t[0] = (t + 0.05) * 1e9;
		evt.px[0] = tmpP * sqrt(1 - costheta * costheta) * cos(tmpPhi);
		evt.py[0] = tmpP * sqrt(1 - costheta * costheta) * sin(tmpPhi);
		evt.pz[0] = tmpP * costheta;

		tmpP = b12decay->GetRandom();
		costheta = -1 + 2 * gRandom->Uniform();
                tmpPhi = 2 * M_PI * gRandom->Uniform();
		evt.pdgid[1] = 11;
		evt.m[1] = mE;
		evt.t[1] = (t + 0.05 + gRandom->Exp(0.0202 / log(2))) * 1e9;
		evt.px[1] = tmpP * sqrt(1 - costheta * costheta) * cos(tmpPhi);
		evt.py[1] = tmpP * sqrt(1 - costheta * costheta) * sin(tmpPhi);
		evt.pz[1] = tmpP * costheta;
		tmpevt.Set(evt);
		v.push_back(tmpevt);
	}
	delete b12rate;
	delete b12decay;
}

if(channelno == -1 || channelno == 5)
{
	c12rate = new TF2("C12Rate", C12Rate, -0.05, 20.0, 15.11, 100.0, 0);
	c12rate->SetNpx(1000);
	averageEvents = c12rate->Integral(-0.05, 20.0, 15.11, 100.0);
	trueEvents = gRandom->Poisson(averageEvents);
	cerr<<"C12 "<<trueEvents<<" events"<<endl;
	for(int i = 0; i < trueEvents; i++)
	{
		c12rate->GetRandom2(t, eNu);
		tmpE = 15.11;
		tmpP = tmpE;
		costheta = -1 + 2 * gRandom->Uniform();
		tmpPhi = 2 * M_PI * gRandom->Uniform();
		evt.nparticles = 1;
		evt.pdgid[0] = 22;
		evt.m[0] = 0;
		//C12 de-excitation width is 38.5 eV, which is 1.7e-17 s
		evt.t[0] = (t + 0.05) * 1e9;	
		evt.px[0] = tmpP * sqrt(1 - costheta * costheta) * cos(tmpPhi);
		evt.py[0] = tmpP * sqrt(1 - costheta * costheta) * sin(tmpPhi);
		evt.pz[0] = tmpP * costheta;

		evt.pdgid[1] = 0;
		evt.m[1] = 0;
		evt.t[1] = 0;
		evt.px[1] = 0;
		evt.py[1] = 0;
		evt.pz[1] = 0;
		tmpevt.Set(evt);
		v.push_back(tmpevt);
	}
	delete c12rate;
}
        cerr << "Start Sorting" << endl;
	NR::hpsort(v);
	int nevents = v.size();
	for(int i = 0; i < nevents; i++)
	{
		v[i].Get(evt);
		output->pushEvents();
	}

	output->writeFile();
	v.clear();	
	delete output;
}

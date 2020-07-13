#!/usr/bin/env python

from ROOT import TChain
import sys
#distance = sys.argv[1] 
#source = sys.argv[2] 
#wire = sys.argv[3] 

weights = [0.0784/4.12,0.7137/4.12,1.085/4.12,2.244/4.12]

def gen_data(source,scale):
	dirname =  source 
	t = TChain("evt")
	t.Add(dirname+'/evt*root')
	entries = float(t.GetEntries())
	cut0 = scale*float(t.GetEntries('edep>0.3'))
	cut1 = scale*float(t.GetEntries('edep>0.7'))
	cut2 = scale*float(t.GetEntries('edep>0.3 && sqrt(edepX**2 + edepY**2 + edepZ**2)<17200'))
	cut3 = scale*float(t.GetEntries('edep>1.9 && edep<2.5 && sqrt(edepX**2 + edepY**2 + edepZ**2)<17200'))
	
	file = open(dirname+'/data3','w')
	file.write(">0.3MeV\t err\t>0.7MeV\t err\t>0.3MeV (FV<17.2m)\terr\t >0.7MeV (FV<17.2m)\terr\n")
	#file.write(str(cut0/entries)+'\t'+str(cut0**0.5/entries)+'\t'+str(cut1/entries)+"\t"+str(cut1**0.5/entries)+'\t'+str(cut2/entries)+"\t"+str(cut2**0.5/entries)+'\t'+str(cut3/entries)+"\t"+str(cut3**0.5/entries)+'\n')
	file.write(str(cut0/entries)+'\t'+str((cut0/scale)**0.5*scale/entries)+'\t'+str(cut1/entries)+"\t"+str((cut1/scale)**0.5*scale/entries)+'\t'+str(cut2/entries)+"\t"+str((cut2/scale)**0.5*scale/entries)+'\t'+str(cut3/entries)+"\t"+str((cut3/scale)**0.5*scale/entries)+'\n')
	file.close()

if __name__ == "__main__":

	sources = ["K40","Th232","U238","Co60"]
	scales = {}
	scales['K40'] = 1
	scales['Co60'] = 1
	scales['Th232'] = 10
	scales['U238'] = 14
	for source in sources:
		gen_data(source,scales[source])

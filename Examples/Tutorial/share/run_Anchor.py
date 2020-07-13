#!/usr/bin/python
import sys
import os
import time
import random
import math
first = sys.argv[1]
last = sys.argv[2]
pi = 3.141592654
emass = 0.5109989
for run in range(int(first),int(last)):

	sources = ["K40","Th232","U238"]
	cmd = ""

	for source in sources:
		cmd =  cmd + "python /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/share/tut_detsim.py --no-gdml --evtmax 1000 --seed "+str(run)+" --user-output /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/share/Anchor/"+source+"/evt_"+str(run)+".root gendecay --nuclear "+source+" --volume pAnchor\n"

	cmdfilename = "condor/sim_"+str(run)+".sh"
	cmdfile = open(cmdfilename,"w")
	cmdfile.write("#!/bin/bash\n")
	cmdfile.write("source /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/share/junoenv\n")
	cmdfile.write("source /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/cmt/setup.sh\n")
	cmdfile.write("cd /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/share/\n")
	cmdfile.write(cmd)
	cmdfile.close()
	os.chmod(cmdfilename,0775)
	
	cmd  = "hep_sub "+str(cmdfilename)
	os.system(cmd)
	run = run + 1

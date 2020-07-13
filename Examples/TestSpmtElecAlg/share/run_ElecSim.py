#!/usr/bin/python

import sys
import os
import Sniper
import TestSpmtElecAlg
import BufferMemMgr
import DataRegistritionSvc
import RootIOSvc
import RootWriter
import platform
import argparse

# print the current machine info
print "*** NODE Info:", platform.uname(), "***"
print "*** CURRENT PID: ", os.getpid(), "***"

# parse arguments
parser = argparse.ArgumentParser()
parser.add_argument("--inFile", default="sample_detsim.root",help="Name of the input file")
parser.add_argument("--outFile", default="result_SpmtElecSim.root", help="Name of the output file")
parser.add_argument("--usrOutFile", default="spmt_elec_analysis.root", help="Name of the user output file")
parser.add_argument("--evt", default=10, help="Number of events to process", type=int)
args = parser.parse_args()

task = Sniper.Task("task")
task.asTop()
task.setLogLevel(3)

alg = task.createAlg("SpmtFastDet2ElecAlg/PrototypeSimulation")
alg.setLogLevel(1)

#set io files for persistent data
bufMgr = task.createSvc("BufferMemMgr")
bufMgr.property("TimeWindow").set([-0.01, 0.01]);
task.property("svcs").append("DataRegistritionSvc")
riSvc = task.createSvc("RootInputSvc/InputSvc")
riSvc.property("InputFile").set(args.inFile)
roSvc = task.createSvc("RootOutputSvc/OutputSvc")
roSvc.property("OutputStreams").set({"/Event/Elec": args.outFile,"/Event/Sim": args.outFile })

#set io files for user tree
rootwriter = task.createSvc("RootWriter")
rootwriter.property("Output").set({"SIMEVT":args.usrOutFile})

task.setEvtMax(args.evt)
task.show()
task.run()

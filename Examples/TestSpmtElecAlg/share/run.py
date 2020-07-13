#!/usr/bin/python

import sys
import os
import Sniper
import TestSpmtElecAlg
import BufferMemMgr
import DataRegistritionSvc
import RootIOSvc
import platform
import argparse


# print the current machine info
print "*** NODE Info:", platform.uname(), "***"
print "*** CURRENT PID: ", os.getpid(), "***"

# parse arguments
parser = argparse.ArgumentParser()
parser.add_argument("--inFile", default="result.root",help="Name of the input file")
parser.add_argument("--outFile", default="result.root", help="Name of the output file")
parser.add_argument("--evt", default=10, help="Number of events to process", type=int)
args = parser.parse_args()
print args.inFile


task = Sniper.Task("task")
task.asTop()
task.setLogLevel(3)

alg = task.createAlg("TestSpmtElecAlg/alg_example")
alg.property("EvtTimeGap").set(300000)
alg.setLogLevel(1)

bufMgr = task.createSvc("BufferMemMgr")
bufMgr.property("TimeWindow").set([-0.01, 0.01]);

task.property("svcs").append("DataRegistritionSvc")

if os.path.exists(args.inFile) :
    ## for reading
    riSvc = task.createSvc("RootInputSvc/InputSvc")
    riSvc.property("InputFile").set([args.inFile])
    alg.property("RunMode").set(1)
    alg.setLogLevel(2)
else :
    ## for generating
    roSvc = task.createSvc("RootOutputSvc/OutputSvc")
    roSvc.property("OutputStreams").set({"/Event/Elec": args.outFile})
    alg.property("RunMode").set(2)

task.setEvtMax(args.evt)
task.show()
task.run()

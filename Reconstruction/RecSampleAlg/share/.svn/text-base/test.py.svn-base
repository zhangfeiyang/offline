#!/usr/bin/python

import Sniper
task = Sniper.Task("task")
task.asTop()
task.setLogLevel(3)

import RecSampleAlg
alg = task.createAlg("RecSampleAlg/rec_sample")
alg.setLogLevel(2)

import BufferMemMgr
bufMgr = task.createSvc("BufferMemMgr")
bufMgr.property("TimeWindow").set([-0.01, 0.01]);

import DataRegistritionSvc
task.property("svcs").append("DataRegistritionSvc")

import RootIOSvc
roSvc = task.createSvc("RootOutputSvc/OutputSvc")
roSvc.property("OutputStreams").set({"/Event/Rec": "recOut.root", "/Event/Calib":"recOut.root"})

import Geometry
geom = task.createSvc("RecGeomSvc")
geom.property("GeomFile").set("default")

import os
if os.path.exists("recIn.root") : 
    riSvc = task.createSvc("RootInputSvc/InputSvc")
    riSvc.property("InputFile").set(["recIn.root"])
else :
    alg.property("CreateInputFlag").set(1)

task.setEvtMax(10)
task.show()
task.run()

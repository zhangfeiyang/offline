#!/usr/bin/python
# -*- coding:utf-8 -*-
#
# Author: ZHANG Kun - zhangkun@ihep.ac.cn
# Last modified:	2015-05-11 05:20
# Filename:		test.py
# Description: 

import Sniper
Sniper.setLogLevel(1)
task = Sniper.Task("task")
task.asTop()
task.setLogLevel(1)

import BufferMemMgr
bufMgr = task.createSvc("BufferMemMgr")
bufMgr.property("TimeWindow").set([0, 0]);

import DataRegistritionSvc
task.property("svcs").append("DataRegistritionSvc")

import RootIOSvc
roSvc = task.createSvc("RootOutputSvc/OutputSvc")
roSvc.property("OutputStreams").set({"/Event/RecTrack": "recOut.root", "/Event/Calib":"recOut.root"})
riSvc = task.createSvc("RootInputSvc/InputSvc")
riSvc.property("InputFile").set(["sample_muonsim.root" ])

import Geometry
geom = task.createSvc("RecGeomSvc")
gdmlgeo = "/afs/ihep.ac.cn/users/z/zhangk/workfs/slc6/j16v1r2test/offline/Examples/Tutorial/share/geom.root"
geom.property("GeomFile").set(gdmlgeo)
geom_path_inroot = "JunoGeom"
geom.property("GeomPathInRoot").set(geom_path_inroot)
geom.property("FastInit").set(True)

Sniper.loadDll("libPmtRec.so")
task.property("algs").append("PullSimHeaderAlg")

import RecCdMuonAlg
import LsqMuonRecTool
recalg = RecCdMuonAlg.createAlg(task)
recalg.setLogLevel(1)
recalg.property("Use3inchPMT").set(True);
recalg.property("Use20inchPMT").set(True);
recalg.property("Pmt3inchTimeReso").set(1)            # ns
recalg.property("Pmt20inchTimeReso").set(3)            # ns
recalg.useRecTool("LsqMuonRecTool")
recalg.rectool.property("LSRadius").set(17700)
recalg.rectool.property("LightSpeed").set(299.792458)
recalg.rectool.property("LSRefraction").set(1.485)
recalg.rectool.property("MuonSpeed").set(299.792458)
recalg.rectool.property("FhtCorrFile").set("fhtcorr.root")


task.setEvtMax(3)
task.show()
task.run()

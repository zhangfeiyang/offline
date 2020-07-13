#!/usr/bin/python

import argparse
parser = argparse.ArgumentParser(description='RecTime like pos reco')
parser.add_argument("--input", default="test_simplePath_long_bugfixed_60_200_smartRec_chargecenter_calib_e-_0_0_10.root")
parser.add_argument("--output", default="test_simplePath_long_bugfixed_60_200_smartRec_chargecenter_calib_e-_0_0_10.root")
parser.add_argument("--PrintLevel", default=100, type=int)
parser.add_argument("--Tolerance", default=0.1, type=float)
parser.add_argument("--evtmax", default=1, type=int)
parser.add_argument("--UseFirstHitOnly", default=False,action="store_true")
parser.add_argument("--StaticGeometryLib", action='store_true')
args = parser.parse_args()

import Sniper
Sniper.setLogLevel(0)
task = Sniper.Task("task")
task.asTop()
task.setLogLevel(3)

import DataRegistritionSvc
task.createSvc("DataRegistritionSvc")

import BufferMemMgr
bufMgr = task.createSvc("BufferMemMgr")
bufMgr.property("TimeWindow").set([-0.01, 0.01]);

import SmartRecHelperSvc
helperSvc = task.createSvc("SmartRecHelperSvc")
#helperSvc.property("DarkRate").set(10e3); # 10kHz
helperSvc.setLogLevel(1)
helperSvc.property("StaticGeometryLib").set(args.StaticGeometryLib);

if not args.StaticGeometryLib:
    import Geometry
    geom = task.createSvc("RecGeomSvc")
    gdml_filename="sample_detsim.root"
    geom_path_inroot = "JunoGeom"
    geom.property("GeomFile").set(gdml_filename)
    geom.property("GeomPathInRoot").set(geom_path_inroot)
    geom.property("FastInit").set(True)
    geom.setLogLevel(3)


import PosRecTimeLikeAlg
alg = task.createAlg("PosRecTimeLikeAlg/posRecT")
alg.setLogLevel(1)
import os
alg.property("File_path").set(os.path.join(os.environ["RECTIMELIKEALGROOT"],"share","elec"))
alg.property("UseFirstHitOnly").set(args.UseFirstHitOnly)
alg.property("Tolerance").set(args.Tolerance)

Sniper.loadDll("libCalibEvent.so")
Sniper.loadDll("libRecEvent.so")
import RootIOSvc
riSvc = task.createSvc("RootInputSvc/InputSvc")
#riSvc.property("InputFile").set(["/home/dingxf/juno-trunk/offline/Reconstruction/SmartRec/SmartRecAlg/share/"+args.InputFile])
riSvc.property("InputFile").set([args.input])

roSvc = task.createSvc("RootOutputSvc/OutputSvc")
outputFileName = args.output
roSvc.property("OutputStreams").set({"/Event/Rec":outputFileName,"/Event/Calib":outputFileName,"/Event/Cluster":outputFileName})

task.setEvtMax(args.evtmax)
task.show()
task.run()

#!/usr/bin/python

import argparse
parser = argparse.ArgumentParser(description='Charge center pos reco')
parser.add_argument("--evtmax", default=-1,type=int)
parser.add_argument("--input", default="calib_e-_0_0_5.root")
parser.add_argument("--output", default="test_calib_e-_0_0_5.root")
parser.add_argument("--CalibInputPath", default="/Event/Calib")
parser.add_argument("--RecInputPath", default="/Event/Rec")
parser.add_argument("--CalibOutputPath", default="/Event/Calib")
parser.add_argument("--ClusterOutputPath", default="/Event/Cluster")
parser.add_argument("--PreWindow", default=60,type=float)
parser.add_argument("--PostWindow", default=200,type=float)
parser.add_argument("--StartSearchWindow", default=50,type=int)
parser.add_argument("--EndSearchWindow", default=150,type=int)
parser.add_argument("--EndSearchWindowHE", default=300,type=int)
parser.add_argument("--Log", default=0,type=int)
parser.add_argument("--Test", default=False,action="store_true")
parser.add_argument("--KillRecHeader", default=False,action="store_true")
parser.add_argument("--StaticGeometryLib", action='store_true')
args = parser.parse_args()

import Sniper
#Sniper.setLogLevel(0)
task = Sniper.Task("task")
task.asTop()
task.setLogLevel(0)

import DataRegistritionSvc
datSvc = task.createSvc("DataRegistritionSvc")
datSvc.setLogLevel(0)


import BufferMemMgr
bufMgr = task.createSvc("BufferMemMgr")
bufMgr.property("TimeWindow").set([-0.01, 0.01]);
bufMgr.setLogLevel(0)

import SmartRecHelperSvc
helperSvc = task.createSvc("SmartRecHelperSvc")
helperSvc.property("DarkRate").set(10e3); # 10kHz
#helperSvc.property("PreWindow").set(args.PreWindow)
#helperSvc.property("PostWindow").set(args.PostWindow)
helperSvc.property("StartSearchWindow").set(args.StartSearchWindow)
helperSvc.property("EndSearchWindow").set(args.EndSearchWindow)
helperSvc.property("EndSearchWindowHE").set(args.EndSearchWindowHE)
helperSvc.property("ClusterLengthThreshold").set(0)
helperSvc.property("SkipAfterCluster").set(21)
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


import SmartRec
alg = task.createAlg("SmartRec/myrec")
alg.property("CalibInputPath").set(args.CalibInputPath)
alg.property("RecInputPath").set(args.RecInputPath)
alg.property("CalibOutputPath").set(args.CalibOutputPath)
alg.property("ClusterOutputPath").set(args.ClusterOutputPath)
alg.setLogLevel(args.Log)
alg.property("KillRecHeader").set(args.KillRecHeader)

import RootIOSvc
riSvc = task.createSvc("RootInputSvc/InputSvc")
riSvc.property("InputFile").set([args.input])
riSvc.setLogLevel(0)

roSvc = task.createSvc("RootOutputSvc/OutputSvc")
#outputFileName = "simplePath_long_bugfixed_"+str(int(args.PreWindow))+"_"+str(int(args.PostWindow))+"_smartRec_"+args.InputFile
outputFileName = args.output
if args.Test:
	outputFileName = "test_"+outputFileName
if(args.KillRecHeader):
	output={args.CalibOutputPath:outputFileName,
      args.ClusterOutputPath:outputFileName}
else:
	output={args.CalibOutputPath:outputFileName,
      args.ClusterOutputPath:outputFileName,
			args.RecInputPath:outputFileName}
roSvc.property("OutputStreams").set(output)
roSvc.setLogLevel(0)

task.setEvtMax(args.evtmax)
task.show()
task.run()

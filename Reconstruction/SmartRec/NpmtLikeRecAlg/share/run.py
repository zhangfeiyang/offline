#!/usr/bin/python

import argparse
parser = argparse.ArgumentParser(description='RecTime like energy reco')
parser.add_argument("--input", default="posRecTimeLike_fullHit_withRecHeader_simplePath_long_bugfixed_60_200_smartRec_chargecenter_calib_e-_0_0_10.root")
parser.add_argument("--output", default="posRecTimeLike_fullHit_withRecHeader_simplePath_long_bugfixed_60_200_smartRec_chargecenter_calib_e-_0_0_10.root")
parser.add_argument("--PrintLevel", default=0, type=int)
parser.add_argument("--Tolerance", default=0.1, type=float)
parser.add_argument("--evtmax", default=1, type=int)
parser.add_argument("--StaticGeometryLib", action='store_true')
args = parser.parse_args()

import Sniper
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
helperSvc.property("DarkRate").set(10e3); # 10kHz
helperSvc.setLogLevel(0)
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


import NpmtLikeRecAlg
alg = task.createAlg("NpmtLikeRecAlg/energyRec")
alg.setLogLevel(0)
alg.property("PrintLevel").set(args.PrintLevel)
alg.property("MinimizerType").set("Minuit2")
alg.property("MinimizerAlgorithm").set("Migrad")
alg.property("Tolerance").set(args.Tolerance)
#  ROOT::Math::Factory::CreateMinimizer("Minuit2", "Migrad");
#  ROOT::Math::Factory::CreateMinimizer("Minuit2", "Simplex");
#  ROOT::Math::Factory::CreateMinimizer("Minuit2", "Combined");
#  ROOT::Math::Factory::CreateMinimizer("Minuit2", "Scan");
#  ROOT::Math::Factory::CreateMinimizer("Minuit2", "Fumili");
#  ROOT::Math::Factory::CreateMinimizer("GSLMultiMin", "ConjugateFR");
#  ROOT::Math::Factory::CreateMinimizer("GSLMultiMin", "ConjugatePR");
#  ROOT::Math::Factory::CreateMinimizer("GSLMultiMin", "BFGS");
#  ROOT::Math::Factory::CreateMinimizer("GSLMultiMin", "BFGS2");
#  ROOT::Math::Factory::CreateMinimizer("GSLMultiMin", "SteepestDescent");
#  ROOT::Math::Factory::CreateMinimizer("GSLMultiFit", "");
#  ROOT::Math::Factory::CreateMinimizer("GSLSimAn", "");


Sniper.loadDll("libCalibEvent.so")
Sniper.loadDll("libRecEvent.so")
import RootIOSvc
riSvc = task.createSvc("RootInputSvc/InputSvc")
riSvc.property("InputFile").set([args.input])

roSvc = task.createSvc("RootOutputSvc/OutputSvc")
outputFileName = args.output
roSvc.property("OutputStreams").set({"/Event/Rec":outputFileName,"/Event/Calib":outputFileName,"/Event/Cluster":outputFileName})

task.setEvtMax(args.evtmax)
task.show()
task.run()

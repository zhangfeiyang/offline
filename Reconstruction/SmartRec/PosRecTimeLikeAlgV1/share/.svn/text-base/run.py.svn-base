#!/usr/bin/python

import argparse
parser = argparse.ArgumentParser(description='RecTime like pos reco')
parser.add_argument("--InputFile", default="withRecHeader_simplePath_long_bugfixed_60_200_smartRec_chargecenter_calib_e-_0_0_10.root")
parser.add_argument("--PrintLevel", default=100, type=int)
parser.add_argument("--Tolerance", default=0.1, type=float)
parser.add_argument("--EvtMax", default=1, type=int)
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
helperSvc.property("DarkRate").set(50e3); # 50kHz
helperSvc.setLogLevel(4)

UseRecGeomSvc = False
helperSvc.property("UseRecGeomSvc").set(UseRecGeomSvc);
#helperSvc.property("UseRecGeomSvc").set(True);

if UseRecGeomSvc:
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
alg.setLogLevel(0)
alg.property("File_path").set("/home/dingxf/juno-trunk/offline/Reconstruction/RecTimeLikeAlg/share/elec/")
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
#riSvc.property("InputFile").set(["/home/dingxf/juno-trunk/offline/Reconstruction/SmartRec/SmartRecAlg/share/"+args.InputFile])
#riSvc.property("InputFile").set(["/home/dingxf/juno-trunk/offline/Reconstruction/SmartRec/PosRecTimeLikeAlgV3/share/posRecTimeLike_fullHit_withRecHeader_simplePath_long_bugfixed_60_200_smartRec_chargecenter_calib_e-_0_0_10.root"])
riSvc.property("InputFile").set(["/home/dingxf/juno-trunk/offline/Reconstruction/SmartRec/PosRecTimeLikeAlgV3/share/"+args.InputFile])

roSvc = task.createSvc("RootOutputSvc/OutputSvc")
outputFileName = "posRecTimeLike_"+args.InputFile
roSvc.property("OutputStreams").set({"/Event/Rec":outputFileName,"/Event/Calib":outputFileName})

task.setEvtMax(args.EvtMax)
task.show()
task.run()

#!/usr/bin/python

import argparse
parser = argparse.ArgumentParser(description='Steep rise pos reco')
parser.add_argument("--InputFile", default="calib_e-_0_0_5.root")
parser.add_argument("--PrintLevel", default=-1, type=int)
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


import SteepRiseAlg
alg = task.createAlg("SteepRiseAlg/steepRise")
alg.setLogLevel(3)
alg.property("PrintLevel").set(args.PrintLevel)
alg.property("MinimizerType").set("Minuit2")
alg.property("MinimizerAlgorithm").set("Scan")
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


import RootIOSvc
riSvc = task.createSvc("RootInputSvc/InputSvc")
riSvc.property("InputFile").set(["/home/dingxf/juno-trunk/offline/Reconstruction/SmartRec/ChargeCenterAlg/share/test_0_0_"+args.InputFile])

roSvc = task.createSvc("RootOutputSvc/OutputSvc")
outputFileName = "steepRise_"+args.InputFile
roSvc.property("OutputStreams").set({"/Event/Rec":outputFileName,"/Event/Calib":outputFileName,"/Event/SteepRise":outputFileName})

task.setEvtMax(-1)
task.show()
task.run()

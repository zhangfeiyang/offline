#!/usr/bin/python

import argparse
parser = argparse.ArgumentParser(description='Charge center pos reco')
#parser.add_argument("--ForceRec", action='store_true', help='avoid skipping events without cluster')
parser.add_argument("--PreWindow", default=0, type=float, help='extra window before the determined cluster window')
parser.add_argument("--PostWindow", default=0, type=float, help='extra window after the determined cluster window')
parser.add_argument("--input", default="calib_e-_0_0_5.root")
parser.add_argument("--output", default="test_calib_e-_0_0_5.root")
parser.add_argument("--ClusterLengthThreshold", default=10, type=float)
parser.add_argument("--CalibInputPath", default="/Event/Calib")
parser.add_argument("--RecOutputPath", default="/Event/Rec")
parser.add_argument("--CalibOutputPath", default="/Event/Calib")
parser.add_argument("--evtmax", default=1,type=int)
parser.add_argument("--StaticGeometryLib", action='store_true')
args = parser.parse_args()

import Sniper
task = Sniper.Task("task")
task.asTop()
task.setLogLevel(3)

# needed for 
#SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
# if DataMemSvc does not exists, the navigator won't work.
#    DataMemSvc* svc = dynamic_cast<DataMemSvc*>(_par->find("DataMemSvc"));
#    this->m_obj = (svc!=0) ? dynamic_cast<Data*>(svc->find(name)) : 0;
import DataRegistritionSvc
task.createSvc("DataRegistritionSvc")

import BufferMemMgr
bufMgr = task.createSvc("BufferMemMgr")
bufMgr.property("TimeWindow").set([-0.01, 0.01]);

import SmartRecHelperSvc
helperSvc = task.createSvc("SmartRecHelperSvc")
helperSvc.property("DarkRate").set(10e3); # 10kHz
helperSvc.property("WaveformRecEff").set(0.918)
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


import ChargeCenterAlg
alg = task.createAlg("ChargeCenterAlg/chargeCenter")
alg.property("PreWindow").set(args.PreWindow)
alg.property("PostWindow").set(args.PostWindow)
alg.property("ClusterLengthThreshold").set(args.ClusterLengthThreshold)
#alg.property("ForceRec").set(args.ForceRec)
alg.property("CalibInputPath").set(args.CalibInputPath)
alg.property("RecOutputPath").set(args.RecOutputPath)
alg.setLogLevel(0)

Sniper.loadDll("libCalibEvent.so")
Sniper.loadDll("libRecEvent.so")
import RootIOSvc
riSvc = task.createSvc("RootInputSvc/InputSvc")
riSvc.property("InputFile").set([args.input])

roSvc = task.createSvc("RootOutputSvc/OutputSvc")
outputFileName = args.output
output={args.CalibOutputPath:outputFileName,
		args.RecOutputPath:outputFileName}
roSvc.property("OutputStreams").set(output)
roSvc.setLogLevel(0)

task.setEvtMax(args.evtmax)
task.show()
task.run()

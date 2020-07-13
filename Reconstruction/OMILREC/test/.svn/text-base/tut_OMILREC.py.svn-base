#!/usr/bin/env python
# -*- coding:utf-8 -*-
# author: wuwenjie@ihep.ac.cn

import Sniper

def get_parser():

    import argparse

    parser = argparse.ArgumentParser(description='Run Optical Model Independent Likelihood REConstruction.')
    parser.add_argument("--evtmax", type=int, default=-1, help='events to be processed')
    parser.add_argument("--seed", type=int, default=42, help='seed')
    parser.add_argument("--input", default="sample_calib.root", help="input file name")
    parser.add_argument("--output", default="sample_rec.root", help="output file name")
    parser.add_argument("--detoption", default="Acrylic",
                                       choices=["Acrylic", "Balloon"],
                                       help="Detector Option")
    parser.add_argument("--gdml", default="True", action="store_true", help="Use GDML.")
    parser.add_argument("--gdml-file", help="the file contains the geometry info.")

    # read xdep/ydep/zdep from simulation data #
    #parser.add_argument("--simfile", default="sample_sim.root",help="user-defined simulation file")
    return parser

TOTALPMTS = {"Acrylic": 54318, "Balloon": 18306}
DEFAULT_GDML_OUTPUT = {"Acrylic": "sample_detsim.root",  #"geometry_acrylic.gdml"
                       "Balloon": "sample_detsim.root"}  #"geometry_balloon.gdml"
    
if __name__ == "__main__":
    parser = get_parser()
    args = parser.parse_args()

    total_pmt = TOTALPMTS[args.detoption]
    # load the geom info from root file by default.
    gdml_filename = DEFAULT_GDML_OUTPUT[args.detoption]
    geom_path_inroot = "JunoGeom"
    if args.gdml:
        if args.gdml_file:
            gdml_filename = args.gdml_file
    if gdml_filename.endswith("gdml"):
        geom_path_inroot = ""
    # === check the existance of the geometry file ===
    import os.path
    if not os.path.exists(gdml_filename):
        import sys
        print "can't find the geometry file %s"%gdml_filename
        sys.exit(-1)

    task = Sniper.Task("rectask")
    task.asTop()
    task.setEvtMax(args.evtmax)
    task.setLogLevel(0)

    # == Create Data Buffer Svc ==
    import DataRegistritionSvc
    drs = task.createSvc("DataRegistritionSvc")
    drs.property("EventToPath").set({
            #"JM::RecEvent": "/Event/Rec"
        })

    import BufferMemMgr
    bufMgr = task.createSvc("BufferMemMgr")
    bufMgr.property("TimeWindow").set([-0.01, 0.01])

    # == Create IO Svc ==
    import RootIOSvc
    inputsvc = task.createSvc("RootInputSvc/InputSvc")
    inputsvc.property("InputFile").set([args.input])

    # == load dict ==
    Sniper.loadDll("libCalibEvent.so")
    Sniper.loadDll("libRecEvent.so")
    roSvc = task.createSvc("RootOutputSvc/OutputSvc")
    outputdata = {"/Event/Rec": args.output,
                  "/Event/Calib": args.output}
    roSvc.property("OutputStreams").set(outputdata)

    # == Geometry Svc ==
    import Geometry
    geom = task.createSvc("RecGeomSvc")
    geom.property("GeomFile").set(gdml_filename)
    geom.property("GeomPathInRoot").set(geom_path_inroot)
    geom.property("FastInit").set(True)

    # == RecTimeLikeAlg ==
    import RecTimeLikeAlg
    import os
    # FIXME: should user set the PMT_R and Ball_R ???
    TimeLikeAlg = task.createAlg("RecTimeLikeAlg")
    TimeLikeAlg.property("TotalPMT").set(total_pmt)
    TimeLikeAlg.property("PMT_R").set(19.50)
    TimeLikeAlg.property("Ball_R").set(19.246)
    TimeLikeAlg.property("Energy_Scale").set(3414.5454)
    TimeLikeAlg.property("File_path").set( 
                    os.path.join(os.environ["RECTIMELIKEALGROOT"],"share",""))
    #TimeLikeAlg.property("SimFile").set(args.simfile)
    TimeLikeAlg.setLogLevel(2)

    ## == OMILREC ==
    import OMILREC
    #import os
    alg = task.createAlg("OMILREC")
    alg.property("TotalPMT").set(total_pmt)
    alg.property("PMT_R").set(19.5)
    alg.property("Ball_R").set(19.246)
    alg.property("Energy_Scale").set(10577.2994)
    alg.property("File_path").set(
                    os.path.join(os.environ["OMILRECROOT"],"share",""))
    # transfer simulation file to algorithm #
    #alg.property("SimFile").set(args.simfile)
    alg.setLogLevel(2)

    task.show()
    task.run()


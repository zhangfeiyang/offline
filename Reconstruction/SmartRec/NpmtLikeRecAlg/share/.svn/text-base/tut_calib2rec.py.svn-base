#!/usr/bin/env python
# -*- coding:utf-8 -*-
# author: lintao

import Sniper

def get_parser():

    import argparse

    parser = argparse.ArgumentParser(description='Run Atmospheric Simulation.')
    parser.add_argument("--evtmax", type=int, default=-1, help='events to be processed')
    parser.add_argument("--seed", type=int, default=42, help='seed')
    parser.add_argument("--input", default="sample_calib.root", help="input file name")
    parser.add_argument("--output", default="sample_rec.root", help="output file name")
    parser.add_argument("--user-output", default="sample_rec_user.root", help="output user file name")

    parser.add_argument("--detoption", default="Acrylic", 
                                       choices=["Acrylic", "Balloon", "TT"],
                                       help="Det Option")
    parser.add_argument("--gdml", default="True", action="store_true", help="Use GDML.")
    parser.add_argument("--gdml-file", help="the file contains the geometry info.")
    parser.add_argument("--elec",default="no",
                                 choices=["yes","no"],
                                 help="with electronics simulation or not.")
    parser.add_argument("--FHS", default="0", type = int,  help="Use the first hit selection method for dark noise or not")
    # Muon switch
    parser.add_argument("--method", default="point", choices=["point", "clusterized-point", "track", "wp-track", "spmt-track", "energy-point", "tt-track"], 
                                    help="Rec for point-like or track-like (muon) events")
    
    return parser

TOTALPMTS = {"Acrylic": 54318, "Balloon": 18306, "TT": 0}
DEFAULT_GDML_OUTPUT = {"Acrylic": "sample_detsim.root",  #"geometry_acrylic.gdml"
                       "Balloon": "sample_detsim.root",
                       "TT": "sample_detsim.root",
                       }  #"geometry_balloon.gdml"
ENERGY_SCALE = {"no":2633.61,"yes":2668.69}; # yes:2640.90
SUBDIR = {"no":"no-elec","yes":"elec"};
IS_NEUTRON = {"no":0,"yes":1};
PDF_VALUE = {"no":0,"yes":1};

if __name__ == "__main__":
    parser = get_parser()
    args = parser.parse_args()

    total_pmt = TOTALPMTS[args.detoption]
    energy_scale = ENERGY_SCALE[args.elec]
    subdir = SUBDIR[args.elec]
    pdf_value = PDF_VALUE[args.elec]
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
            #"JM::SimEvent": "/Event/Sim"
        })

    import BufferMemMgr
    bufMgr = task.createSvc("BufferMemMgr")
    bufMgr.property("TimeWindow").set([-0.01, 0.01])

    # == Create IO Svc ==
    import RootIOSvc
    inputsvc = task.createSvc("RootInputSvc/InputSvc")
    inputsvc.property("InputFile").set([args.input])

    # === load dict ===
    #Sniper.loadDll("libSimEventV2.so")
    Sniper.loadDll("libCalibEvent.so")
    Sniper.loadDll("libRecEvent.so")
    roSvc = task.createSvc("RootOutputSvc/OutputSvc")
    outputdata = {
                  "/Event/Calib": args.output,
                  "/Event/Rec": args.output
                  }
    # For TT:
    if args.method == "tt-track":
        outputdata["/Event/Sim"] = args.output
    roSvc.property("OutputStreams").set(outputdata)

    # == Geometry Svc ==
    import Geometry
    geom = task.createSvc("RecGeomSvc")
    geom.property("GeomFile").set(gdml_filename)
    geom.property("GeomPathInRoot").set(geom_path_inroot)
    geom.property("FastInit").set(True)

    # possibilities: Muon or other
    if args.method == "track":
        # do muon rec
        import RecCdMuonAlg
        import LsqMuonRecTool
        recalg = RecCdMuonAlg.createAlg(task)
        recalg.setLogLevel(1)
        # whether to use data of 3 inch pmts
        recalg.property("Use3inchPMT").set(False);
        # whether to use data of 20 inch pmts
        recalg.property("Use20inchPMT").set(True);
        # 3inch pmt time resolution,  unit: ns
        recalg.property("Pmt3inchTimeReso").set(1)
        #20inch pmt time resolution,  unit: ns
        recalg.property("Pmt20inchTimeReso").set(3)

        #configure the specific rec tool
        recalg.useRecTool("LsqMuonRecTool")
        recalg.rectool.property("LSRadius").set(17700)
        recalg.rectool.property("LightSpeed").set(299.792458)
        recalg.rectool.property("LSRefraction").set(1.485)
        recalg.rectool.property("MuonSpeed").set(299.792458)
        recalg.rectool.property("FhtCorrFile").set("$LSQMUONRECTOOLROOT/test/fhtcorr.root")
    elif args.method == "point":
        # == RecTimeLikeAlg ==
        import RecTimeLikeAlg
        import os
        # FIXME: should user set the PMT_R and Ball_R ???
        alg = task.createAlg("RecTimeLikeAlg")
        alg.property("TotalPMT").set(total_pmt)
        alg.property("PMT_R").set(19.50)
        alg.property("Ball_R").set(19.316)
        alg.property("Energy_Scale").set(energy_scale)
        alg.property("Pdf_Value").set(pdf_value)
        alg.property("FHS").set(args.FHS)
        alg.property("File_path").set( 
                        os.path.join(os.environ["RECTIMELIKEALGROOT"],"share",subdir))
        alg.setLogLevel(2)
    elif args.method == "energy-point":
        # == Use RecTimeLikeAlg to rec. the vertex firstly == 
        import RecTimeLikeAlg
        import os
        # FIXME: should user set the PMT_R and Ball_R ???
        alg = task.createAlg("RecTimeLikeAlg")
        alg.property("TotalPMT").set(total_pmt)
        alg.property("PMT_R").set(19.50)
        alg.property("Ball_R").set(19.316)
        alg.property("Energy_Scale").set(energy_scale)
        alg.property("Pdf_Value").set(pdf_value)
        alg.property("FHS").set(args.FHS)
        alg.property("File_path").set( 
                        os.path.join(os.environ["RECTIMELIKEALGROOT"],"share",subdir))
        alg.setLogLevel(2)
        # == Then use OMILREC to rec. the energy
        import OMILREC
        alg = task.createAlg("OMILREC")
        alg.property("TotalPMT").set(total_pmt)
        alg.property("PMT_R").set(19.50)
        alg.property("Ball_R").set(19.316)
        alg.property("Energy_Scale").set(10349.6080)
        alg.property("File_path").set( 
                        os.path.join(os.environ["OMILRECROOT"],"share",""))
        alg.setLogLevel(2)
    elif args.method == "clusterized-point":
        import SmartRecHelperSvc
        helperSvc = task.createSvc("SmartRecHelperSvc")
        helperSvc.property("DarkRate").set(10e3); # 10kHz
        helperSvc.property("WaveformRecEff").set(0.918)
        helperSvc.setLogLevel(2)
        import ChargeCenterAlg
        chargeCenter = task.createAlg("ChargeCenterAlg/chargeCenter")
        chargeCenter.property("RecOutputPath").set("/Event/ChargeCenterPosRec")
        chargeCenter.setLogLevel(2)
        import SmartRec
        smartRec = task.createAlg("SmartRec/smartRec")
        smartRec.property("RecInputPath").set("/Event/ChargeCenterPosRec")
        smartRec.property("CalibOutputPath").set("/Event/ClusterizedCalibEvent")
        smartRec.property("ClusterOutputPath").set("/Event/Cluster")
        smartRec.property("KillRecHeader").set(False)
        smartRec.setLogLevel(2)
        import PosRecTimeLikeAlg
        posRecTimeLike = task.createAlg("PosRecTimeLikeAlg/posRecTimeLike")
        posRecTimeLike.property("CalibInputPath").set("/Event/ClusterizedCalibEvent")
        posRecTimeLike.property("ClusterInputPath").set("/Event/Cluster")
        posRecTimeLike.property("RecInputPath").set("/Event/ChargeCenterPosRec")
        posRecTimeLike.setLogLevel(2)
        import NpmtLikeRecAlg
        npmtLike = task.createAlg("NpmtLikeRecAlg/npmtLike")
        npmtLike.property("CalibInputPath").set("/Event/ClusterizedCalibEvent")
        npmtLike.property("ClusterInputPath").set("/Event/Cluster")
        npmtLike.setLogLevel(2)
    elif args.method == "wp-track":
        import RecWpMuonAlg
        import PoolMuonRecTool
        recalg = RecWpMuonAlg.createAlg(task)
        recalg.setLogLevel(1)
        recalg.property("Use3inchPMT").set(True);
        recalg.property("Use20inchPMT").set(True);
        recalg.property("Pmt3inchTimeReso").set(1)            # ns
        recalg.property("Pmt20inchTimeReso").set(3)            # ns
        recalg.useRecTool("PoolMuonRecTool")
        recalg.rectool.property("MaxPoints").set(7)
        recalg.rectool.property("PECut").set(19)
        recalg.rectool.property("NpmtCut").set(1)
        recalg.rectool.property("DistanceCut").set(7000)
    elif args.method == "spmt-track":
        import RecCdMuonAlg
        import SpmtMuonRecTool
        recalg = RecCdMuonAlg.createAlg(task)
        recalg.setLogLevel(1)
        recalg.property("Use3inchPMT").set(True);
        recalg.property("Use20inchPMT").set(True);
        recalg.property("Pmt3inchTimeReso").set(1)            # ns
        recalg.property("Pmt20inchTimeReso").set(3)            # ns
        recalg.useRecTool("SpmtMuonRecTool")
        recalg.rectool.property("MaxPoints").set(7)
        recalg.rectool.property("PECut").set(53)
        recalg.rectool.property("NpmtCut").set(1)
        recalg.rectool.property("DistanceCut").set(7000)
    elif args.method == "tt-track":
        # TODO: now we use detsim as input, 
        #       in the future, we will use calib data.
        # cmd:
        # $ python tut_calib2rec.py --detoption TT --method tt-track --input sample_detsim.root --output sample_rec_tt.root 

        import RootWriter
        rootwriter = task.createSvc("RootWriter")
        rootwriter.property("Output").set({"SIMEVT":args.user_output})
        Sniper.loadDll("libSimEventV2.so")
        import TTTrackingAlg
        alg = task.createAlg("TTTrackingAlg")
        alg.property("Det_Type").set(args.detoption)
        alg.setLogLevel(0)


    task.show()
    task.run()

#!/usr/bin/env python
# -*- coding:utf-8 -*-
# author: lintao


import Sniper

def get_parser():
    import argparse
    parser = argparse.ArgumentParser(description='Run JUNO Detector Simulation.')
    parser.add_argument("--evtmax", type=int, default=10, help='events to be processed')
    parser.add_argument("--seed", type=int, default=42, help='seed')
    parser.add_argument("--output", default="sample_detsim.root", help="output file name")
    parser.add_argument("--user-output", default="sample_detsim_user.root", help="output file name")

    parser.add_argument("--vis", action="store_true", default=False)
    parser.add_argument("--pmt-name", default="R12860", 
                                      choices=["R12860",
                                               "OnlyPMT", "20inchPMT",
                                               "R3600",
                                               "Tub3inch",
                                               "Tub3inchV2",
                                               "Hello3inch",
                                               "Hello8inch",
                                               "PMTMask",
                                               "GLw1",
                                               "GLw2",
                                               "GLw3",
                                               "GLb1",
                                               "GLb2",
                                               "GLb3",
                                               "GLb4",
                                               "GLc1",
                                               "GZ1",
                                               "ZC1",
                                               "ZC2",
                                               ])
    parser.add_argument("--ce-mode", default="20inch",
                                     choices=["None",
                                              "20inch",
                                              "20inchflat",
                                              "20inchfunc"],
                 help="Different CE mode for PMTs. Only available in PMTSD-v2")
    parser.add_argument("--extra-file",
                 help="extra configuration file")

    return parser

if __name__ == "__main__":
    parser = get_parser()
    args = parser.parse_args()
    print args

    task = Sniper.Task("task")
    task.asTop()
    task.setEvtMax(args.evtmax)
    task.setLogLevel(3)
    # = Data Buffer =
    import BufferMemMgr
    bufMgr = task.createSvc("BufferMemMgr")

    # = random svc =
    import RandomSvc
    task.property("svcs").append("RandomSvc")
    rndm = task.find("RandomSvc")
    rndm.property("Seed").set(args.seed)

    # = root writer =
    import RootWriter
    rootwriter = task.createSvc("RootWriter")

    rootwriter.property("Output").set({"SIMEVT": args.user_output})

    # = generator related =
    import GenTools
    from GenTools import makeTV
    gt = task.createAlg("GenTools")

    gun = gt.createTool("GtGunGenTool/gun")
    gun.property("particleNames").set(["gamma"])
    gun.property("particleMomentums").set([1.0])
    ##gun.property("DirectionMode").set("Fix")
    ##gun.property("Directions").set([makeTV(0,0,0), makeTV(0,0,-1), makeTV(0,0,-1)])
    ##gun.property("PositionMode").set("FixMany")
    #gun.property("Positions").set([makeTV(0,0,0)])
    #gun = gt.createTool("GtPelletronBeamerTool/gun")
    #gun.property("particleName").set("opticalphoton")
    #gun.property("planeCentrePos").set(makeTV(0,0,0.9e3)) # (0,0,0.9m)
    #gun.property("planeDirection").set(makeTV(0,0,-1)) # down
    #gun.property("planeRadius").set(254) # 254mm
    #import math
    #gun.property("beamThetaMax").set(math.radians(0)) # 10deg -> rad
    #gun.property("beamMomentum").set(3e-6) # 3eV
    #gun.property("beamMomentumSpread").set(0.) # 0.1MeV
    #gun.property("nparticles").set(10000)

    pos = gt.createTool("GtPositionerTool")
    pos.setLogLevel(1)
    pos.property("GenInVolume").set("pPrototypeDetector")
    pos.property("Material").set("LS")
    gt.property("GenToolNames").set([gun.objName(), pos.objName()])

    # = geant4 related =
    import DetSimOptions
    g4svc = task.createSvc("G4Svc")

    # == DetSimOptions ==
    factory = task.createSvc("DetSim0Svc")
    factory.property("CDName").set("PrototypeOnePMT")
    factory.property("PMTMother").set("lBuffer")
    factory.property("PMTName").set(args.pmt_name)
    factory.property("TTName").set("")
    detsimalg = task.createAlg("DetSimAlg")
    detsimalg.property("DetFactory").set(factory.objName())
    detsimalg.property("RunMac").set("run.mac")
    if args.vis:
        detsimalg.property("VisMac").set("vis.mac")
    #detfactory.property("3inchPMTPosFile").set("")
    # === Prototype Construction ===
    prototype = detsimalg.createTool("PrototypeOnePMTConstruction")
    placement = detsimalg.createTool("OnePMTPlacement")
    # unit: mm
    placement.property("x").set(0.)
    placement.property("y").set(0.)
    placement.property("z").set(0.)
    # unit: deg
    placement.property("0RotateZ").set(0.)
    placement.property("1RotateY").set(0.)
    placement.property("2RotateZ").set(0.)
    # === PMT ===
    pmtsdmgr = detsimalg.createTool("PMTSDMgr")
    pmtsdmgr.property("PMTSD").set("dywSD_PMT_v2")
    pmtsdmgr.property("CollEffiMode").set(args.ce_mode)
    op = detsimalg.createTool("DsPhysConsOptical")
    op.property("UsePMTOpticalModel").set(False)

    if args.pmt_name == "R12860":
        r12860pmt = detsimalg.createTool("R12860PMTManager")
        r12860pmt.property("FastCover").set(True)
    elif args.pmt_name in ["GLw1", "GLw2", "GLw3", "GLb1", "GLb2", "GLb3", "GLb4", "GLc1", "GZ1", "ZC1", "ZC2",]:
        factory.property("PMTName").set("%s.1000"%args.pmt_name)
        GL = detsimalg.createTool("HBeamConstruction/%s.1000"%args.pmt_name)
        GL.property("L").set(1000.)
    import os.path
    if args.extra_file and os.path.exists(args.extra_file):
        print "loading %s" %args.extra_file
        execfile(args.extra_file)

    # = begin run =
    task.show()
    task.run()

#!/usr/bin/env python
# -*- coding:utf-8 -*-

import Sniper

def get_parser():

    import argparse

    parser = argparse.ArgumentParser(description='Waveform Reconstrtion.')
    parser.add_argument("--evtmax", type=int, default=-1, help='events to be processed')
    parser.add_argument("--input", default="sample_elecsim.root", help="input file name")
    parser.add_argument("--input-list", default=None, help="input file name")
    parser.add_argument("--output", default="sample_calib.root", help="output file name")
    parser.add_argument("--loglevel", default="Info", 
                            choices=["Test", "Debug", "Info", "Warn", "Error", "Fatal"],
                            )
    # different methods
    parser.add_argument("--method", default="decon", 
                                    choices=["pmtrec", "wavefit", "decon", "muon"],
                                    help="pmtrec: Integral PMT Rec, wavefit: Waveform fit, decon: Deconvolution, muon: Muon Waveform Reco")
    # parameters for the deconvolution method
    # The default parameters are for J16v2. Never modify them. 
    parser.add_argument("--para1", default="50", type = float, help="Filter parameter 1")
    parser.add_argument("--para2", default="120", type = float, help="Filter parameter 2")
    parser.add_argument("--para3", default="30", type = float, help="Filter parameter 3")
    parser.add_argument("--TotalPMT", default="17746", type = int,  help="Total PMT number")
    parser.add_argument("--Threshold", default="0.06", type = float,  help="threshold for hit finding") # This is a.u.. Don't change it.
    parser.add_argument("--Length", default="1250", type = int,  help="Readout window length ns")
    parser.add_argument("--Window", default="3", type = int,  help="Charge integral ns")
    parser.add_argument("--HitCounting", default="0", type = int,  help="Use the hit counting method or not")
    parser.add_argument("--user-output", default="sample_calib_user.root", help="output user file name")
    parser.add_argument("--CalibFile", help="calibration file")
    return parser

DATA_LOG_MAP = {
        "Test":0, "Debug":2, "Info":3, "Warn":4, "Error":5, "Fatal":6
        }

TOTAL_PMT = 17739

if __name__ == "__main__":
    parser = get_parser()
    args = parser.parse_args()
    print args

    task = Sniper.Task("task")
    task.asTop()
    task.setEvtMax(args.evtmax)
    task.setLogLevel(DATA_LOG_MAP[args.loglevel])

    # Create Data Buffer Svc
    import DataRegistritionSvc
    task.createSvc("DataRegistritionSvc")

    #create buffer Svc
    import BufferMemMgr
    bufMgr = task.createSvc("BufferMemMgr")
    bufMgr.property("TimeWindow").set([0, 0])

    # Create IO Svc
    import RootIOSvc
    inputsvc = task.createSvc("RootInputSvc/InputSvc")
    # input files could be one or a list of files
    inputs = []
    if args.input_list:
        import sys
        import os.path
        if not os.path.exists(args.input_list):
            sys.exit(-1)
        with open(args.input_list) as f:
            for line in f:
                line = line.strip()
                inputs.append(line)
    else:
        inputs.append(args.input)
    inputsvc.property("InputFile").set(inputs)

    roSvc = task.createSvc("RootOutputSvc/OutputSvc")
    roSvc.property("OutputStreams").set({"/Event/Calib":args.output})

    # user output
    import RootWriter
    rootwriter = task.createSvc("RootWriter")
    rootwriter.property("Output").set({"CALIBEVT":args.user_output})

    # different waveform reconstruction alg
    if args.method == "pmtrec": 
        Sniper.loadDll("libIntegralPmtRec.so") 
        import os
        elecroot = os.environ["ELECSIMROOT"] 
        pmt_data = os.path.join(elecroot, "share", "PmtData.root") 
        intPmtRec=task.createAlg("IntegralPmtRec") 
        intPmtRec.property("TotalPMT").set(TOTAL_PMT) 
        intPmtRec.property("GainFile").set(pmt_data) 
        intPmtRec.property("Threshold").set(0.25*0.0035) #1/4 PE 
        pass 
    elif args.method == "wavefit": 
        # == Wave Fit Alg == 
        Sniper.loadDll("libWaveFit.so") 
        wavefit = task.createAlg("WaveFitAlg") 
        wavefit.property("PmtTotal").set(TOTAL_PMT)
    elif args.method == "decon":
        #import Deconvolution 
        Sniper.loadDll("libDeconvolution.so")
        decon=task.createAlg("Deconvolution")
        if args.CalibFile:
            decon.property("CalibFile").set(args.CalibFile)
        decon.property("TotalPMT").set(args.TotalPMT)
        decon.property("Threshold").set(args.Threshold) # Default value is 1/3 PE. The current version has relative large electronics noises
        decon.property("Length").set(args.Length)
        decon.property("Para1").set(args.para1)
        decon.property("Para2").set(args.para2)
        decon.property("Para3").set(args.para3)
        decon.property("Window").set(args.Window)
	decon.property("HitCounting").set(args.HitCounting)
    elif args.method == "muon":
        Sniper.loadDll("libMuonWaveRec.so")
        muon = task.createAlg("MuonWaveRec")
        muon.property("Threshold").set(args.Threshold)
        muon.property("Length").set(args.Length)
        muon.property("TotalPMT").set(TOTAL_PMT)
    task.show()
    task.run()




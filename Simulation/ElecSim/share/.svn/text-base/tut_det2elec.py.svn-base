#!/usr/bin/env python
# -*- coding:utf-8 -*-
# author: lintao

import Sniper

def get_parser():         

    import argparse       

    parser = argparse.ArgumentParser(description='Run Atmospheric Simulation.') 
    parser.add_argument("--evtmax", type=int, default=1, help='events to be processed')
    parser.add_argument("--seed", type=int, default=42, help='seed')
    parser.add_argument("--input", default="sample_detsim.root", help="input file name")
    parser.add_argument("--output", default="sample_calib.root", help="output file name")

    parser.add_argument("--wavefit", action="store_true", 
                                     help="Enable WaveFitAlg")
    parser.add_argument("--pmtrec", action="store_true", 
                                    help="Enable Integral PMT Rec")

    parser.add_argument("--detoption", default="Acrylic", 
                                       choices=["Acrylic", "Balloon"], 
                                       help="Det Option")

    parser.add_argument("--splittime", default=10000, help="Split time (ns)") 
    parser.add_argument("--enableAfterPulse", default=True, type=bool, help="enableAfterPulse or not")
    parser.add_argument("--enableDarkPulse", default=True, type=bool, help="enableDarkPulse or not")
    parser.add_argument("--enableOvershoot", default=True, type=bool, help="enableOvershoot or not")
    parser.add_argument("--enableRinging", default=False, type=bool, help="enableRinging or not")
    parser.add_argument("--enableSatuation", default=False, type=bool, help="enableSatuation or not")
    parser.add_argument("--enableNoise", default=False, type=bool, help="enableNoise or not")
    parser.add_argument("--enablePretrigger", default=False, type=bool, help="enablePretrigger or not")

    #############
    parser.add_argument("--simFrequency", default=1e9, help="the simulation frequerncy")
    parser.add_argument("--noiseAmp", default=0.5e-3, help="the electronic noise amplitude")
    parser.add_argument("--speAmp", default=10e-3, help="the single pe amplitude")
    parser.add_argument("--preTimeTolerance", default=50, help="the preTimeTolerance")
    parser.add_argument("--postTimeTolerance", default=100, help="the postTimeTolerance")
    parser.add_argument("--expWeight", default=0.01, help="the parameter of single pe response")
    parser.add_argument("--speExpDecay", default=1.1, help="the parameter of single pe response")
    parser.add_argument("--darkRate", default=15e3, help="the parameter of single pe response")

    parser.add_argument("--enableFADC", default=False, type=bool ,help="enable FADC or not")
    parser.add_argument("--FadcBit", default=14, help="the Bit of FADC")

    return parser


TOTALPMTS = {"Acrylic": 17746, "Balloon": 18306}

def config_detsim_task_nosim(task):       
    # = I/O Related =
    import DataRegistritionSvc
    task.createSvc("DataRegistritionSvc")

    import RootIOSvc
    inputsvc = task.createSvc("RootInputSvc/InputSvc")
    inputsvc.property("InputFile").set([args.input])   

    # = Data Buffer =
    import BufferMemMgr
    bufMgr = task.createSvc("BufferMemMgr")


if __name__ == "__main__":       
    parser = get_parser() 
    args = parser.parse_args() 

    total_pmt = TOTALPMTS[args.detoption]

    Sniper.setLogLevel(0)
    task = Sniper.Task("elecsimtask")
    task.asTop()
    task.setEvtMax(args.evtmax)
    task.setLogLevel(0)

    # = random svc =
    import RandomSvc
    task.property("svcs").append("RandomSvc")
    rndm = task.find("RandomSvc")
    rndm.property("Seed").set(args.seed)

    # = second task =
    sec_task = task.createTask("Task/detsimtask")
    config_detsim_task_nosim(sec_task)

    # = create alg in top task =
    #Sniper.loadDll("libTwoTask.so")
    #task.createAlg("AlgWithFire")
    # = Elec Sim =
    # == Data Buffer ==
    import BufferMemMgr
    bufMgr = task.createSvc("BufferMemMgr")
    # == Data Registrition SVc ==
    import DataRegistritionSvc
    task.createSvc("DataRegistritionSvc")
    # == I/O Svc ==
    # === load dict ===
    Sniper.loadDll("libSimEventV2.so")
    Sniper.loadDll("libCalibEvent.so")
    Sniper.loadDll("libRecEvent.so")
    roSvc = task.createSvc("RootOutputSvc/OutputSvc")
    outputdata = {"/Event/Elec": args.output}
    if args.pmtrec or args.wavefit:  
        outputdata["/Event/Calib"] = args.output
    roSvc.property("OutputStreams").set(outputdata)
    # == Elec Sim ==
    Sniper.loadDll("libElecSim.so")  
    elecsim = task.createAlg("ElecSimAlg")
    elecsim.property("PmtTotal").set(total_pmt)
    import os
    elecroot = os.environ["ELECSIMROOT"]  
    pmt_data = os.path.join(elecroot, "share", "PmtData.root") 

    elecsim.property("PmtDataFile").set(pmt_data)
    elecsim.property("split_evt_time").set(args.splittime)
    elecsim.property("enableAfterPulse").set(args.enableAfterPulse)
    elecsim.property("enableDarkPulse").set(args.enableDarkPulse)

    elecsim.property("enableOvershoot").set(args.enableOvershoot)
    elecsim.property("enableRinging").set(args.enableRinging)
    elecsim.property("enableSatuation").set(args.enableSatuation)
    elecsim.property("enableNoise").set(args.enableNoise)
    elecsim.property("enablePretrigger").set(args.enablePretrigger)

    elecsim.property("simFrequency").set(args.simFrequency)
    elecsim.property("noiseAmp").set(args.noiseAmp)
    elecsim.property("speAmp").set(args.speAmp)
    elecsim.property("preTimeTolerance").set(args.preTimeTolerance)
    elecsim.property("postTimeTolerance").set(args.postTimeTolerance)
    elecsim.property("expWeight").set(args.expWeight)
    elecsim.property("speExpDecay").set(args.speExpDecay)
    elecsim.property("darkRate").set(args.darkRate)
    elecsim.property("enableFADC").set(args.enableFADC)
    elecsim.property("FadcBit").set(args.FadcBit)

    #Add algorithm to draw waveform 
    #draw_wavefor=task.createAlg("TestBuffDataAlg")



    # = Calib =
    if args.pmtrec:
        Sniper.loadDll("libIntegralPmtRec.so")
        intPmtRec=task.createAlg("IntegralPmtRec")
        intPmtRec.property("TotalPMT").set(int(total_pmt))
        intPmtRec.property("GainFile").set(pmt_data)
        intPmtRec.property("Threshold").set(0.25*0.0035) #1/4 PE
        pass
    if args.wavefit:
        # == Wave Fit Alg ==
        Sniper.loadDll("libWaveFit.so")
        wavefit = task.createAlg("WaveFitAlg")
        wavefit.property("PmtTotal").set(int(total_pmt))
    # = begin run =
    task.show()
    task.run()

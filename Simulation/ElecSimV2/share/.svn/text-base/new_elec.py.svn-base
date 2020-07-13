#!/usr/bin/env python
# -*- coding:utf-8 -*-
# author: fangxiao

import Sniper

def get_parser():         

    import argparse       

    parser = argparse.ArgumentParser(description='Run Atmospheric Simulation.') 
    parser.add_argument("--evtmax", type=int, default=1, help='events to be processed')
    parser.add_argument("--seed", type=int, default=42, help='seed')
    parser.add_argument("--input", default="sample_detsim.root", help="input file name")
    parser.add_argument("--output", default="", help="output file name")
    parser.add_argument("--detoption", default="Acrylic", 
            choices=["Acrylic", "Balloon"], 
            help="Det Option")


    #pmt Tool related
    parser.add_argument('--enableAfterPulse', dest='enableAfterPulse', action='store_true')
    parser.add_argument('--disableAfterPulse', dest='enableAfterPulse', action='store_false')
    parser.set_defaults(enableAfterPulse=False)

    parser.add_argument('--enableDarkPulse', dest='enableDarkPulse', action='store_true')
    parser.add_argument('--disableDarkPulse', dest='enableDarkPulse', action='store_false')
    parser.set_defaults(enableDarkPulse=False)

    parser.add_argument('--enableEfficiency', dest='enableEfficiency', action='store_true')
    parser.add_argument('--disableEfficiency', dest='enableEfficiency', action='store_false')
    parser.set_defaults(enableEfficiency=False)

    parser.add_argument('--enableAssignGain', dest='enableAssignGain', action='store_true')
    parser.add_argument('--disableAssignGain', dest='enableAssignGain', action='store_false')
    parser.set_defaults(enableAssignGain=False)

    parser.add_argument('--enableAssignSigmaGain', dest='enableAssignSigmaGain', action='store_true')
    parser.add_argument('--disableAssignSigmaGain', dest='enableAssignSigmaGain', action='store_false')
    parser.set_defaults(enableAssignSigmaGain=False)

    parser.add_argument("--inputGain", default=1, type=float, help="the user input gain")
    parser.add_argument("--inputSigmaGain", default=0.3, type=float, help="the user input SigmaGain")

    parser.add_argument("--preTimeTolerance", default=50, type=float, help="the preTimeTolerance")
    parser.add_argument("--postTimeTolerance", default=200, type=float, help="the postTimeTolerance")
    parser.add_argument("--expWeight", default=0.01, type=float, help="the parameter of single pe response")
    parser.add_argument("--speExpDecay", default=1.1, type=float, help="the parameter of single pe response")
    parser.add_argument("--darkRate", default=50e3, type=float, help="the mean value of darkRate")


    #Fee Tool related
    parser.add_argument('--enableOvershoot', dest='enableOvershoot', action='store_true')
    parser.add_argument('--disableOvershoot', dest='enableOvershoot', action='store_false')
    parser.set_defaults(enableOvershoot=False)


    parser.add_argument('--enableRinging', dest='enableRinging', action='store_true')
    parser.add_argument('--disableRinging', dest='enableRinging', action='store_false')
    parser.set_defaults(enableRinging=False)


    parser.add_argument('--enableSatuation', dest='enableSatuation', action='store_true')
    parser.add_argument('--disableSatuation', dest='enableSatuation', action='store_false')
    parser.set_defaults(enableSatuation=False)
    

    parser.add_argument('--enableNoise', dest='enableNoise', action='store_true')
    parser.add_argument('--disableNoise', dest='enableNoise', action='store_false')
    parser.set_defaults(enableNoise=False)


    parser.add_argument('--enablePretrigger', dest='enablePretrigger', action='store_true')
    parser.add_argument('--disablePretrigger', dest='enablePretrigger', action='store_false')
    parser.set_defaults(enablePretrigger=False)


    parser.add_argument('--enableFADC', dest='enableFADC', action='store_true')
    parser.add_argument('--disableFADC', dest='enableFADC', action='store_false')
    parser.set_defaults(enableFADC=False)



    parser.add_argument("--simFrequency", default=1e9, type=float, help="the simulation frequerncy")
    parser.add_argument("--noiseAmp", default=0.5e-3, type=float, help="the electronic noise amplitude")
    parser.add_argument("--speAmp", default=5.6e-3, type=float, help="the single pe amplitude")
    parser.add_argument("--FadcBit", default=14, type=float, help="the Bit of FADC")

    parser.add_argument("--FadcRange", default=1, type=float, help="the Range of FADC, unit: the number of pe")

    parser.add_argument("--waveform_width", default=14e-9, type=float, help="the parameter to change waveform width, default is 20inch MCP-PMT")
    parser.add_argument("--waveform_mu", default=0.45, type=float, help="the parameter to change waveform")


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

    #print args
    #import sys
    #sys.exit(0)


    total_pmt = TOTALPMTS[args.detoption]

    Sniper.setLogLevel(0)
    task = Sniper.Task("ElecSim_task")
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


    # == Data Buffer ==
    import BufferMemMgr
    bufMgr = task.createSvc("BufferMemMgr")

    # == Data Registrition SVc ==
    import DataRegistritionSvc
    task.createSvc("DataRegistritionSvc")
   ## # == I/O Svc ==

   #import RootIOSvc
   #inputsvc = task.createSvc("RootInputSvc/InputSvc")
   #inputsvc.property("InputFile").set([args.input])   
   # === load dict ===
    Sniper.loadDll("libSimEventV2.so")

    roSvc = task.createSvc("RootOutputSvc/OutputSvc")

    if args.output != "":        #if not assign output file name,there is no output file
        outputdata = {"/Event/Elec": args.output}
        roSvc.property("OutputStreams").set(outputdata)

    # Tool name
    m_pmtTool_name="EsPulseTool"
    m_FeeTool_name="EsFeeTool"


    # ElecSim Alg
    Sniper.loadDll("libElecSimV2.so")  
    ElecSim=task.createAlg("EsFrontEndAlg")

    ElecSim.property("pmtTool_name").set(m_pmtTool_name)
    ElecSim.property("FeeTool_name").set(m_FeeTool_name)
    ElecSim.property("PmtTotal").set(total_pmt)


    import os
    elecroot = os.environ["ELECSIMROOT"]  
    pmt_data = os.path.join(elecroot, "share", "PmtData.root") 

    #ElecSim.property("PmtDataFile").set(pmt_data)
    ElecSim.property("PmtDataFile").set("PmtData.root")


    # pmt Tool
    pmtTool=ElecSim.createTool(m_pmtTool_name)

    pmtTool.property("PmtTotal").set(total_pmt)
    pmtTool.property("enableAfterPulse").set(args.enableAfterPulse)
    pmtTool.property("enableDarkPulse").set(args.enableDarkPulse)
    pmtTool.property("enableEfficiency").set(args.enableEfficiency)

    pmtTool.property("enableAssignGain").set(args.enableAssignGain)
    pmtTool.property("enableAssignSigmaGain").set(args.enableAssignSigmaGain)

    pmtTool.property("inputGain").set(args.inputGain)
    pmtTool.property("inputSigmaGain").set(args.inputSigmaGain)

    pmtTool.property("preTimeTolerance").set(args.preTimeTolerance)
    pmtTool.property("postTimeTolerance").set(args.postTimeTolerance)
    pmtTool.property("expWeight").set(args.expWeight)
    pmtTool.property("speExpDecay").set(args.speExpDecay)
    pmtTool.property("darkRate").set(args.darkRate)


    # Fee Tool 
    FeeTool=ElecSim.createTool(m_FeeTool_name)

    FeeTool.property("PmtTotal").set(total_pmt)
    FeeTool.property("enableOvershoot").set(args.enableOvershoot)
    FeeTool.property("enableRinging").set(args.enableRinging)
    FeeTool.property("enableSatuation").set(args.enableSatuation)
    FeeTool.property("enableNoise").set(args.enableNoise)
    FeeTool.property("enablePretrigger").set(args.enablePretrigger)
    FeeTool.property("simFrequency").set(args.simFrequency)
    FeeTool.property("noiseAmp").set(args.noiseAmp)
    FeeTool.property("speAmp").set(args.speAmp)
    FeeTool.property("preTimeTolerance").set(args.preTimeTolerance)
    FeeTool.property("postTimeTolerance").set(args.postTimeTolerance)
    FeeTool.property("enableFADC").set(args.enableFADC)
    FeeTool.property("FadcBit").set(args.FadcBit)
    FeeTool.property("FadcRange").set(args.FadcRange)
    FeeTool.property("waveform_width").set(args.waveform_width)
    FeeTool.property("waveform_mu").set(args.waveform_mu)




    #Add algorithm to draw waveform 
    draw_waveform=task.createAlg("TestBuffDataAlg")



    # = begin run =
    task.show()
    task.run()

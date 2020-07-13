#!/usr/bin/env python
# -*- coding:utf-8 -*-
#anthor: fangxiao

import Sniper

def get_parser():
    import argparse
    parser = argparse.ArgumentParser(description='Run Simulation.')
    parser.add_argument("--evtmax", type=int, default=3, help='events to be processed')
    parser.add_argument("--seed", type=int, default=5, help='seed')
    parser.add_argument("--start", default="1970-01-01 00:00:00", help='starting time')#year, month, day, h, min, s; don't chang the format
    #parser.add_argument("--end", default="2014-09-01 12:05:00", help='ending time')#year, month, day, h, min, s
    parser.add_argument("--output", default="sample_elecsim.root", help="output file name")
    parser.add_argument("--user-output", default="Elec_user.root", help="output user file name")
    #parser.add_argument("--mode", type=int, default=1, choices=[1,2], help="mixing mode, 1:hit level, 2:readout level")
    #parser.add_argument("--elec", action="store_true", help="add elecsim")
    #parser.add_argument("--detoption", default="Acrylic",choices=["Acrylic", "Balloon"], help="Det Option")

    parser.add_argument("--input", action="append", # default="sample_detsim.root", 
                                   help="input file name for TAG: IBD:ibd.root, U:ibd.root")
    parser.add_argument("--rate", action="append", # default="1.0", Hz
                                   help="rate for TAG: IBD:1.0")
    parser.add_argument("--startidx", action="append", # default is 0.
                                   help="startidx for TAG. example: IBD:0")
    parser.add_argument("--loop", action="append", # default is 0.
                                   help="Whether circularly for TAG, 0 for disable loop, 1 for enable. example: --loop IBD:0 --loop U:1")


    #PmtParamSvc related
    parser.add_argument("--PmtDataFile", default="PmtData.root",  help="Pmt data file")
    parser.add_argument("--PmtTotal", type=int, default=17746,  help="total pmt number")


    #PreTrgAlg related
    parser.add_argument("--PulseBufferLength", type=float, default=2000,  help="pulse buffer length , unit ns")
    parser.add_argument("--PreTrigger_PulseNum", type=float, default=200,  help="if pulse num in vector less than PreTrigger_PulseNum it means no enough pulse in PulseVector_for_trigger")
    parser.add_argument("--Trigger_FiredPmtNum", type=float, default=800,  help="Trigger Num threshold")
    parser.add_argument("--Trigger_window", type=float, default=300,  help="trigger window default 300ns")
    parser.add_argument("--Trigger_slip_window", type=float, default=25,  help="slip window default 25ns")
    parser.add_argument("--Interval_of_two_TriggerTime", type=float, default=1000,  help="interval of two trigger time")


    #RootWriter related

    parser.add_argument('--enableUserRootFile', dest='enableUserRootFile', action='store_true')
    parser.add_argument('--disableUserRootFile', dest='enableUserRootFile', action='store_false')
    parser.set_defaults(enableUserRootFile=True)


    #PMTSimAlg related
    parser.add_argument("--HitBufferLength", type=float, default=3500,  help="")
    parser.add_argument("--HitVectorLength", type=float, default=3000,  help="")


    parser.add_argument('--enableAfterPulse', dest='enableAfterPulse', action='store_true')
    parser.add_argument('--disableAfterPulse', dest='enableAfterPulse', action='store_false')
    parser.set_defaults(enableAfterPulse=False)

    parser.add_argument('--enableDarkPulse', dest='enableDarkPulse', action='store_true')
    parser.add_argument('--disableDarkPulse', dest='enableDarkPulse', action='store_false')
    parser.set_defaults(enableDarkPulse=True)

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

    parser.add_argument("--expWeight", default=0.01, type=float, help="the parameter of single pe response")
    parser.add_argument("--speExpDecay", default=1.1, type=float, help="the parameter of single pe response")
    parser.add_argument("--darkRate", default=30e3, type=float, help="the mean value of darkRate")


    #WaveformSimAlg related

    parser.add_argument('--enableAssignSimTime', dest='enableAssignSimTime', action='store_true')
    parser.add_argument('--disableAssignSimTime', dest='enableAssignSimTime', action='store_false')
    parser.set_defaults(enableAssignSimTime=True)

    parser.add_argument("--simTime", type=float, default=1250,  help="")

    parser.add_argument("--preWaveSimWindow", type=float, default=500,  help="")
    parser.add_argument("--postWaveSimWindow", type=float, default=1250,  help="")
    parser.add_argument("--preTimeTolerance", type=float, default=100,  help="")
    parser.add_argument("--postTimeTolerance", type=float, default=900,  help="")
    parser.add_argument("--PulseSampleWidth", type=float, default=150,  help="")

    parser.add_argument('--enableOvershoot', dest='enableOvershoot', action='store_true')
    parser.add_argument('--disableOvershoot', dest='enableOvershoot', action='store_false')
    parser.set_defaults(enableOvershoot=True)

    parser.add_argument('--enableSatuation', dest='enableSatuation', action='store_true')
    parser.add_argument('--disableSatuation', dest='enableSatuation', action='store_false')
    parser.set_defaults(enableSatuation=False)

    parser.add_argument('--enableNoise', dest='enableNoise', action='store_true')
    parser.add_argument('--disableNoise', dest='enableNoise', action='store_false')
    parser.set_defaults(enableNoise=True)

    parser.add_argument('--enableFADC', dest='enableFADC', action='store_true')
    parser.add_argument('--disableFADC', dest='enableFADC', action='store_false')
    parser.set_defaults(enableFADC=True)

    parser.add_argument("--simFrequency", default=1e9, type=float, help="the simulation frequerncy")
    parser.add_argument("--noiseAmp", default=0.5e-3, type=float, help="the electronic noise amplitude")

    parser.add_argument("--waveform_width", default=13e-9, type=float, help="the parameter to change waveform width, default is 20inch MCP-PMT")

    parser.add_argument("--waveform_mu", default=0.43, type=float, help="the parameter to change waveform")

    parser.add_argument("--speAmp", default=5.6e-3, type=float, help="the single pe amplitude")
    parser.add_argument("--FadcOffset", default=5.6e-3, type=float, help="FADC Offset")
    parser.add_argument("--FadcBit", default=8, type=float, help="the Bit of FADC")

    parser.add_argument("--FadcRange", default=100, type=float, help="the Range of FADC, unit: the number of pe")


    return parser


TOTALPMTS = {"Acrylic": 17746, "Balloon": 18306}


def setup_WaveSim(task):
    #data registrition
    drs = task.createSvc("DataRegistritionSvc")
    #buffer service
    bufMgr=task.createSvc("BufferMemMgr")
    #bufMgr.property("TimeWindow").set([-1.0,1.0])
    #add UnpackingAlg 
    import WaveformSimAlg
    WaveAlg = task.createAlg("WaveformSimAlg") 
    WaveAlg.property("preWaveSimWindow").set(args.preWaveSimWindow);
    WaveAlg.property("postWaveSimWindow").set(args.postWaveSimWindow);
    WaveAlg.property("preTimeTolerance").set(args.preTimeTolerance);
    WaveAlg.property("postTimeTolerance").set(args.postTimeTolerance);
    WaveAlg.property("PulseSampleWidth").set(args.PulseSampleWidth);
    WaveAlg.property("PmtTotal").set(args.PmtTotal)
    WaveAlg.property("enableOvershoot").set(args.enableOvershoot)
    WaveAlg.property("enableSatuation").set(args.enableSatuation)
    WaveAlg.property("enableNoise").set(args.enableNoise)
    WaveAlg.property("simFrequency").set(args.simFrequency)
    WaveAlg.property("noiseAmp").set(args.noiseAmp)
    WaveAlg.property("speAmp").set(args.speAmp)
    WaveAlg.property("enableFADC").set(args.enableFADC)
    WaveAlg.property("FadcBit").set(args.FadcBit)
    WaveAlg.property("FadcRange").set(args.FadcRange)
    WaveAlg.property("FadcOffset").set(args.FadcOffset)
    WaveAlg.property("waveform_width").set(args.waveform_width)
    WaveAlg.property("waveform_mu").set(args.waveform_mu)
    WaveAlg.property("enableAssignSimTime").set(args.enableAssignSimTime)
    WaveAlg.property("simTime").set(args.simTime)



def setup_PreTrg(task):
    #data registrition
    drs = task.createSvc("DataRegistritionSvc")
    #buffer service
    bufMgr=task.createSvc("BufferMemMgr")
    #bufMgr.property("TimeWindow").set([-1.0,1.0])
    #add UnpackingAlg 
    import PreTrgAlg
    PreTrg = task.createAlg("PreTrgAlg") 
    PreTrg.property("PulseBufferLength").set(args.PulseBufferLength)
    PreTrg.property("PreTrigger_PulseNum").set(args.PreTrigger_PulseNum)
    PreTrg.property("Trigger_FiredPmtNum").set(args.Trigger_FiredPmtNum)
    PreTrg.property("Trigger_window").set(args.Trigger_window)
    PreTrg.property("Trigger_slip_window").set(args.Trigger_slip_window)
    PreTrg.property("Interval_of_two_TriggerTime").set(args.Interval_of_two_TriggerTime)


def setup_PMTSim(task):
    #data registrition
    drs = task.createSvc("DataRegistritionSvc")
    #buffer service
    bufMgr=task.createSvc("BufferMemMgr")
    #bufMgr.property("TimeWindow").set([-1.0,1.0])
    #add UnpackingAlg 
    import PMTSimAlg
    PMTSim = task.createAlg("PMTSimAlg") 
    PMTSim.property("HitBufferLength").set(args.HitBufferLength)
    PMTSim.property("HitVectorLength").set(args.HitVectorLength)
    PMTSim.property("PmtTotal").set(args.PmtTotal)
    PMTSim.property("enableAfterPulse").set(args.enableAfterPulse)
    PMTSim.property("enableDarkPulse").set(args.enableDarkPulse)
    PMTSim.property("enableEfficiency").set(args.enableEfficiency)

    PMTSim.property("enableAssignGain").set(args.enableAssignGain)
    PMTSim.property("enableAssignSigmaGain").set(args.enableAssignSigmaGain)

    PMTSim.property("inputGain").set(args.inputGain)
    PMTSim.property("inputSigmaGain").set(args.inputSigmaGain)

    PMTSim.property("expWeight").set(args.expWeight)
    PMTSim.property("speExpDecay").set(args.speExpDecay)
    PMTSim.property("darkRate").set(args.darkRate)

    PMTSim.property("preTimeTolerance").set(args.preTimeTolerance);
    PMTSim.property("postTimeTolerance").set(args.postTimeTolerance);


def setup_unpacking(task):
    #data registrition
    drs = task.createSvc("DataRegistritionSvc")
    #buffer service
    bufMgr=task.createSvc("BufferMemMgr")
    #bufMgr.property("TimeWindow").set([-1.0,1.0])
    #add UnpackingAlg 
    import UnpackingAlg
    Unpack = task.createAlg("UnpackingAlg") 

def setup_EvtMixing(task):
    #data registrition
    drs = task.createSvc("DataRegistritionSvc")
    #buffer service
    bufMgr=task.createSvc("BufferMemMgr")
    #bufMgr.property("TimeWindow").set([-1.0,1.0])
    #add EvtMixingAlg
    import EvtMixingAlg
    mixAlg=task.createAlg("EvtMixingAlg")
    mixAlg.property("RateMap").set(rateMap)
    mixAlg.property("TaskMap").set(taskMap)
    mixAlg.property("StartIdxMap").set(startidxMap)
    mixAlg.property("LoopMap").set(loopMap)
    #mixAlg.property("SimTime").set(simTime) 
    #mixAlg.property("BufSize").set(bufSize)
    #mixAlg.property("Mode").set(args.mode)
    #mixAlg.property("seed").set(args.seed)



if __name__ == "__main__":

    import DataRegistritionSvc
    import BufferMemMgr
    import RootIOSvc

    Sniper.setLogLevel(3)
    #Sniper.setLogLevel(6)
    parser = get_parser()
    args = parser.parse_args()

    # check PmtData
    import os
    import os.path
    if not os.path.exists(args.PmtDataFile):
        os.path.join(os.environ["JUNOTOP"], "data/trunk/Simulation/ElecSim/", "PmtData.root")
        args.PmtDataFile = os.path.join(os.environ["JUNOTOP"], "data/trunk/Simulation/ElecSim/", "PmtData.root")
    if not os.path.exists(args.PmtDataFile):
        args.PmtDataFile = os.path.join(os.environ["ELECSIMROOT"], "share", "PmtData.root")
    # construct samples according to the user input
    # example 0 (single file): 
    #   --input sample_detsim.root --rate 60.0
    # example 1 (multi files): 
    #   --input IBD:ibd1.root --input IBD:ibd2.root --input U:u.root --input Th:th.root \
    #   --rate IBD:60.0                             --rate U:100000  --rate Th:20000

    # first, parse the command lines
    filelists = {}
    ratelists = {}
    startidxlist = {}
    looplist = {} 
    #print args.input
    #print args.rate

    # default value
    if args.input is None:
        args.input = [ "sample_detsim.root" ]
    if args.rate is None:
        args.rate = [ "1.0" ]
    if args.startidx is None:
        args.startidx = ["0"]
    if args.loop is None:
        args.loop = ["0"]



    for f in args.input:
        kv = f.split(":")
        if len(kv) == 1: kv.insert(0, "default")
        k, v = kv

        filelists.setdefault(k, [])
        filelists[k].append(v)
    for r in args.rate:
        kv = r.split(":")
        if len(kv) == 1: kv.insert(0, "default")
        k, v = kv
        # for rate, we should avoid different values for same tag
        if ratelists.has_key(k):
            print "ERROR: Don't allow specify different rate values for same tag"
            import sys
            sys.exit(-1)
        # convert from string to float
        ratelists[k] = float(v)
    for i in args.startidx:
        kv = i.split(":")
        if len(kv) == 1: kv.insert(0, "default")
        k, v = kv
        # for rate, we should avoid different values for same tag
        if startidxlist.has_key(k):
            print "ERROR: Don't allow specify different start index for same tag"
            import sys
            sys.exit(-1)
        # convert from string to float
        startidxlist[k] = int(v)
    for c in args.loop:
        kv = c.split(":")
        if len(kv) == 1: kv.insert(0,"default")
        k, v = kv
        if looplist.has_key(k):
            print "ERROR: Don't allow specify different loop option for same tag"
            import sys 
            sys.exit(-1)
        looplist[k] = int(v)
    #print filelists
    #print ratelists
    #print circulationlist 
    # now, construct this structure
    samples = []
    for tag, fl in filelists.iteritems():
        d = {}
        d["name"] = tag
        d["input"] = fl
        if not ratelists.has_key(tag):
            print "ERROR: missing rate for tag: %s"%tag
            import sys
            sys.exit(-1)
        d["rate"] = ratelists[tag]
        if looplist.has_key(tag):
            d["loop"] = looplist[tag]
        if startidxlist.has_key(tag):
            d["start_index"] = startidxlist[tag]
        samples.append(d)

    print samples


    #import sys
    #sys.exit(0)

    #samples = [ 
    #        {"name": "IBD_sample_1",
    #            "rate": 10000, #Hz 
    #            "input": ["IBD_1.root", "IBD_2.root"]},
    #        {"name": "IBD_sample_2",
    #            "rate": 20000, #Hz 
    #            "input": ["IBD_3.root", "IBD_4.root"]},
    #        {"name": "IBD_sample_3",
    #            "rate": 30000, #Hz
    #            "input": ["IBD_5.root", "IBD_6.root"]}
    #        ]

    #samples = [ 
    #    {"name": "sample_1",
    #        "rate": 1000, #Hz 
    #        "input": ["sample_detsim.root"]},
    #    ]

    bufSize = 5.0 #second

    sampleNum = len(samples)
    taskList=[]
    inputList=[]
    rateMap={}
    taskMap={}
    startidxMap = {}
    loopMap = {}
    for i in range(sampleNum):
        key_sample_name = (samples[i]["name"])
        rate = (samples[i]["rate"])
        inputList.append(samples[i]["input"])
        taskList.append(samples[i]["name"])
        rateMap[key_sample_name]=rate
        taskMap[key_sample_name]=taskList[i]
        if samples[i].has_key("start_index"):
            startidxMap[key_sample_name] = samples[i]["start_index"]
        if samples[i].has_key("loop"):
            loopMap[key_sample_name] = samples[i]["loop"]

    #create top task
    task_top = Sniper.Task("task_top")
    task_top.asTop()
    task_top.setEvtMax(args.evtmax)
    #task_top.setLogLevel(0)


    #add RootWriter
    import RootWriter
    rootwriter = task_top.createSvc("RootWriter")


    if args.enableUserRootFile:
        rootwriter.property("Output").set({"SIMEVT":args.user_output})



    #add RootRandomSvc
    import RootRandomSvc
    task_top.property("svcs").append("RootRandomSvc")
    rndm = task_top.find("RootRandomSvc")
    rndm.property("Seed").set(args.seed)

    #add GlobalTimeSvc
    import GlobalTimeSvc
    task_top.property("svcs").append("GlobalTimeSvc")
    time = task_top.find("GlobalTimeSvc")
    time.property("start").set(args.start)


    #add ElecBufferMgrSvc
    import ElecBufferMgrSvc
    task_top.property("svcs").append("ElecBufferMgrSvc")
    bufferMgr = task_top.find("ElecBufferMgrSvc")


    #add PmtParamSvc
    import PmtParamSvc
    task_top.property("svcs").append("PmtParamSvc")
    pmt_param_svc = task_top.find("PmtParamSvc")
    pmt_param_svc.property("PmtDataFile").set(args.PmtDataFile)
    pmt_param_svc.property("PmtTotal").set(args.PmtTotal)





    #add ReadOutAlg
    import ReadOutAlg
    readoutAlg = task_top.createAlg("ReadOutAlg")
    bufMgr=task_top.createSvc("BufferMemMgr")




    #add WaveformSimTask
    sub_task_WaveSim = task_top.createTask("Task/WaveformSimTask")
    setup_WaveSim(sub_task_WaveSim)


    #add PreTrgTask
    sub_task_PreTrg = task_top.createTask("Task/PreTrgTask")
    setup_PreTrg(sub_task_PreTrg)


    #add PMTSimTask
    sub_task_PMTSim = task_top.createTask("Task/PMTSimTask")
    setup_PMTSim(sub_task_PMTSim)


    #add unpacking task
    sub_task_unpack = task_top.createTask("Task/UnpackingTask")
    setup_unpacking(sub_task_unpack)


    #add EvtMix tasks
    sub_task_EvtMix = task_top.createTask("Task/EvtMixingTask")
    setup_EvtMixing(sub_task_EvtMix)




    #add input task
    subTask={}
    readin={}
    for i in range(sampleNum):
        subTask[i] = task_top.createTask("Task/"+taskList[i])    #taskList[2]: sample2
        #subTask[i].setLogLevel(0)
        subTask[i].createSvc("DataRegistritionSvc")
        readin[i]=subTask[i].createSvc("RootInputSvc/InputSvc")
        readin[i].property("InputFile").set(inputList[i])
        bufMgrTmp=subTask[i].createSvc("BufferMemMgr")
        bufMgrTmp.property("TimeWindow").set([-1.0,1.0])

    #output
    task_top.createSvc("DataRegistritionSvc")
    roSvc = task_top.createSvc("RootOutputSvc/OutputSvc")
    if args.output != "":        #if not assign output file name,there is no output file
        outputdata = {"/Event/Elec": args.output}
        roSvc.property("OutputStreams").set(outputdata)









    #draw waveform
    #Sniper.loadDll("libElecSimV2.so")
    #draw_waveform=task_top.createAlg("TestBuffDataAlg")





    #run    
    task_top.show()
    task_top.run()

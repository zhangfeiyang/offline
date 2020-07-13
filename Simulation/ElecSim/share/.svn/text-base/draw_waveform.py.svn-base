#!/usr/bin/env python
# -*- coding:utf-8 -*-
# author: lintao

import Sniper

def get_parser():         

    import argparse       

    parser = argparse.ArgumentParser(description='Run Atmospheric Simulation.') 
    parser.add_argument("--evtmax", type=int, default=1, help='events to be processed')
    parser.add_argument("--seed", type=int, default=42, help='seed')
    parser.add_argument("--input", default="sample_calib.root", help="input file name")
    #parser.add_argument("--output", default="sample_calib.root", help="output file name")
    parser.add_argument("--detoption", default="Acrylic", 
                                       choices=["Acrylic", "Balloon"], 
                                       help="Det Option")
    return parser


TOTALPMTS = {"Acrylic": 17746, "Balloon": 18306}


if __name__ == "__main__":       
    parser = get_parser() 
    args = parser.parse_args() 

    total_pmt = TOTALPMTS[args.detoption]

    Sniper.setLogLevel(0)
    task = Sniper.Task("draw_waveform")
    task.asTop()
    task.setEvtMax(args.evtmax)
    task.setLogLevel(0)

    # = random svc =
    import RandomSvc
    task.property("svcs").append("RandomSvc")
    rndm = task.find("RandomSvc")
    rndm.property("Seed").set(args.seed)


    # == Data Buffer ==
    import BufferMemMgr
    bufMgr = task.createSvc("BufferMemMgr")

    # == Data Registrition SVc ==
    import DataRegistritionSvc
    task.createSvc("DataRegistritionSvc")
    # == I/O Svc ==

    import RootIOSvc
    inputsvc = task.createSvc("RootInputSvc/InputSvc")
    inputsvc.property("InputFile").set([args.input])   

    # draw waveform
    Sniper.loadDll("libElecSim.so")  
    draw_waveform=task.createAlg("TestBuffDataAlg")


    # = begin run =
    task.show()
    task.run()

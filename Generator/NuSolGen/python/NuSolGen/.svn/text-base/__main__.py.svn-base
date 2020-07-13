#!/usr/bin/env python
# -*- coding:utf-8 -*-

# parse arg
import sys
print sys.argv

def get_parser():
    import argparse
    parser = argparse.ArgumentParser(description='Run Solar Generator.')
    parser.add_argument("--evtmax", type=int, default=-1, help='events to be processed')
    parser.add_argument("--seed", type=int, default=42, help='seed')
    parser.add_argument("--type", default="B8", help="neutrino type", choices = ["pp", "Be7", "Be7_862", "Be7_384", "B8", "N13", "O15", "F17", "pep", "hep"])
    return parser


parser = get_parser()
args = parser.parse_args()

import Sniper
import NuSolGen

task = Sniper.Task("task")
task.asTop()
task.setEvtMax(args.evtmax)
task.setLogLevel(3)

# = Data Buffer Mgr =
import BufferMemMgr
bufMgr = task.createSvc("BufferMemMgr")

# = gen tools =
import GenTools
gt = task.createAlg("GenTools")

# = random svc =
import RandomSvc
task.property("svcs").append("RandomSvc")
rndm = task.find("RandomSvc")
rndm.property("Seed").set(args.seed)

# = root writer =
import RootWriter
rootwriter = task.createSvc("RootWriter")

# create alg and tool
gun = gt.createTool("GtNuSolTool/gun")
gun.property("inputMode").set("generateRealTime")
gun.property("neutrinoType").set(args.type)
gt.property("GenToolNames").set([gun.objName()])

gt = task.createAlg("PostGenTools")

task.show()
task.run()

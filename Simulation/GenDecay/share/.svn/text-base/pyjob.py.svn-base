#!/usr/bin/env python
# -*- coding:utf-8 -*_
import Sniper
#-----------------------------------------------------------------
# Global Setting
#-----------------------------------------------------------------
task = Sniper.Task("task")
task.asTop()
task.setEvtMax(10)
task.setLogLevel(0)

#-----------------------------------------------------------------
# Svc Related
#-----------------------------------------------------------------
# Data Buffer Svc
import BufferMemMgr
bufMgr = task.createSvc("BufferMemMgr")

# Random service
import RandomSvc
task.property("svcs").append("RandomSvc")
rndm = task.find("RandomSvc")
rndm.property("Seed").set(42)

# = root writer =
import RootWriter
rootwriter = task.createSvc("RootWriter")

rootwriter.property("Output").set({"GENEVT":"genevt.root"})

#-----------------------------------------------------------------
# Tool Related
#-----------------------------------------------------------------

import GenTools
gt = task.createAlg("GenTools")
print gt

# == GenDecay ==
Sniper.loadDll("libGenDecay.so")
era = gt.createTool("GtDecayerator")
era.property("ParentNuclide").set("Th-232")
era.property("ParentAbundance").set(5e16)
era.property("CorrelationTime").set(280)

# == GtTimeOffsetTool ==
toffset = gt.createTool("GtTimeOffsetTool")

gt.property("GenToolNames").set([era.objName(), toffset.objName()])

pgt = task.createAlg("PostGenTools")

#-----------------------------------------------------------------
# Run
#-----------------------------------------------------------------
task.show()
task.run()

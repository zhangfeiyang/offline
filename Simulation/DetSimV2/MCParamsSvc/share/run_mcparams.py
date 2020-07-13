#!/usr/bin/env python
# -*- coding:utf-8 -*-
# author: lintao

import Sniper

task = Sniper.Task("testtask")
task.asTop()
task.setEvtMax(1)

import RootWriter
rootwriter = task.createSvc("RootWriter")
rootwriter.property("Output").set({"SIMEVT": "params.root"})

Sniper.loadDll("libMCParamsSvc.so")
mcsvc = task.createSvc("MCParamsFileSvc/MCParamsSvc")

Sniper.loadDll("libTestMCParamsSvc.so")
mcalg = task.createAlg("TestAlg")

task.show()
task.run()

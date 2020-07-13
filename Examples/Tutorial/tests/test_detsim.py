#!/usr/bin/env python
# -*- coding:utf-8 -*-
# author: lintao

import logging

logging.basicConfig(level=logging.INFO)

from JunoTest import *

detsim_test = UnitTest()
detsim_test.enableGenLog()
detsim_test.runner.verbosity = 2

# our detsim script
import os
default_path = os.path.dirname(os.path.realpath(__file__)) # test
default_path = os.path.dirname(default_path) # Tutorial
tutorial_dir = os.getenv("TUTORIALROOT", default_path)

logging.info("TUTORIAL DIR (default): %s"% default_path)
logging.info("TUTORIAL DIR: %s"% tutorial_dir)

script = os.path.join(tutorial_dir, "share", "tut_detsim.py")

logging.info(script)

if not os.path.exists(script):
    logging.error("%s does not exist"%script)
    import sys
    sys.exit(-1)

# = add different test cases =

# == gun ==
cmd_name = "detsim/gun/default"
cmd = "python %s --evtmax 10 --no-gdml gun"%script
detsim_test.addCase(cmd_name, cmd)

# === gun: fixed position ===
cmd_name = "detsim/gun/fixed"
cmd = "python %s --evtmax 10 --no-gdml gun --positions 10e3 0 0"%script
detsim_test.addCase(cmd_name, cmd)

# === gun: random position ===
cmd_name = "detsim/gun/random"
cmd = "python %s --evtmax 10 --no-gdml gun --volume pTarget --material LS"%script
detsim_test.addCase(cmd_name, cmd)

# == gendecay ==
cmd_name = "detsim/gendecay/default"
cmd = "python %s --evtmax 10 --no-gdml gendecay"%script
detsim_test.addCase(cmd_name, cmd)

# == hepevt ==
cmd_name = "detsim/hepevt/default"
cmd = "python %s --evtmax 10 --no-gdml hepevt"%script
detsim_test.addCase(cmd_name, cmd)

# == photon ==
cmd_name = "detsim/photon/default"
cmd = "python %s --evtmax 10 --no-gdml photon"%script
detsim_test.addCase(cmd_name, cmd)

# run all the tests
detsim_test.run()

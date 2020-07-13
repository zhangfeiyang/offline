#!/bin/sh
# author: Zhengyun You

EVT=10

python tut_detsim.py --gdml --no-pmt3inch --evtmax $EVT gun --volume pTarget
python tut_det2calib.py --evtmax $EVT
python tut_calib2rec.py --gdml --evtmax $EVT
serena.exe
#serena.exe --geom=sample_detsim.root --sim=sample_detsim.root --calib=sample_calib.root --rec=sample_rec.root [--simus=sample_detsim_user_op.root]

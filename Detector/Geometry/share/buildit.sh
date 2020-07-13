#!/bin/bash

# run Examples/Tutorial
function run-detsim() {
    python $TUTORIALROOT/share/tut_detsim.py --evtmax 1 gun
}

# convert it
function convert-it() {
    # copy the Gdml File
    cp geometry_acrylic.gdml CdGeom.gdml
    # convert root file
    # * remove the CdGeom.root
    rm CdGeom.root
    python c.py
}

$*

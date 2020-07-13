#!/bin/bash -

function job-top-dir() {
    echo ${TOPDIR:-/junofs/users/liuq/J16v1r2-validation/center}
}

function particle-type() {
    echo ${PARTICLE:-e+}
}

function particle-energy() {
    echo ${ENERGY:-0MeV}
}

function tag() {
      echo ${TAG:-test}
}

function run-script() {
      echo ${SCRIPTDIR:-/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J16v1r2/offline/Examples/Tutorial/share}
}

function setup-script() {
    echo ${SETUPSCRIPT:-/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J16v1r2/setup.sh}
}

function gen-name() {
    local prefix=$1; shift
    local seed=$1; shift
    local evtmax=$1; shift
    local suffix=$1; shift

#echo ${prefix}-${seed}-${evtmax}.${suffix}
    echo ${prefix}-${seed}.${suffix}
}

jobdir=$(job-top-dir)/$(particle-type)_$(particle-energy)
echo $jobdir
[ -d "$jobdir" ] || mkdir -p $jobdir

# parse arguments
# - seed
# - evtmax
seed=${1:-0}; shift
evtmax=${1:-10}; shift

echo \$SEED: $SEED
seedstart=${SEED:-200000}
seed=$(($seed+$seedstart))

output=$(gen-name sim $seed $evtmax root)
user_output=$(gen-name user-sim $seed $evtmax root)
log=$(gen-name simlog $seed $evtmax txt)

cd $jobdir
source $(setup-script)
(time python $(run-script)/tut_detsim.py --evtmax $evtmax \
                           --seed $seed \
                           --output $output \
                           --user-output $user_output \
                           --pmtsd-v2 \
                           --ce-mode 20inchfunc \
                           --no-pmt3inch \
                           --no-gdml \
                gun --particles e+ \
                    --momentums $P \
                    --positions 0 0 0) >& $log

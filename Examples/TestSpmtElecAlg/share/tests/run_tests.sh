#!/bin/bash

echo "parameters: " $1 $2 $3 $4

cd ~
source  setup_juno.sh ""
cd $JUNOTOP/offline/Examples/TestSpmtElecAlg/share/tests/

cp $JUNOTOP/offline/Examples/Tutorial/share/tut_detsim.py .

generator=$1
num=$2
seed=$3
tag=$4

echo `pwd`

if [ ${generator} == "1" ]; then

  momentum=$5
  posx=$6
  posy=$7
  posz=$8  

  of_name=positrons_${tag}_${seed}_${momentum}_${posx}_${posy}_${posz}_output
  python tut_detsim.py --evtmax ${num} --seed ${seed} --output ROOT/${of_name}.root --user-output ROOT_user/${of_name}_user.root --no-gdml gun --particles e+ --momentums ${momentum} --positions ${posx} ${posy} ${posz} 
  python ../run_ElecSim.py  --evt ${num} --inFile ROOT/${of_name}.root --outFile ROOT/${of_name}_spmt_elec.root --usrOutFile ROOT_user/${of_name}_user_spmt_elec.root

fi

if [ ${generator} == "2" ]; then

  momentum=$5
  posx=$6
  posy=$7
  posz=$8  

  of_name=electron_${tag}_${seed}_${momentum}_${posx}_${posy}_${posz}_output
  python tut_detsim.py --evtmax ${num} --seed ${seed} --output ROOT/${of_name}.root --user-output ROOT_user/${of_name}_user.root --no-gdml gun --particles e- --momentums ${momentum} --positions ${posx} ${posy} ${posz} 
  python ../run_ElecSim.py  --evt ${num} --inFile ROOT/${of_name}.root --outFile ROOT/${of_name}_spmt_elec.root --usrOutFile ROOT_user/${of_name}_user_spmt_elec.root

fi


if [ ${generator} == "3" ]; then

  of_name=IBD_${tag}_${seed}_output
  python tut_detsim.py --evtmax ${num} --seed ${seed} --output ROOT/${of_name}.root --user-output ROOT_user/${of_name}_user.root --no-gdml hepevt --exe IBD --volume pTarget
  python ../run_ElecSim.py  --evt ${num} --inFile ROOT/${of_name}.root --outFile ROOT/${of_name}_spmt_elec.root --usrOutFile ROOT_user/${of_name}_user_spmt_elec.root

fi

if [ ${generator} == "4" ]; then

  of_name=IBD-eplus_${tag}_${seed}_output
  python tut_detsim.py --evtmax ${num} --seed ${seed} --output ROOT/${of_name}.root --user-output ROOT_user/${of_name}_user.root --no-gdml hepevt --exe IBD-eplus --volume pTarget
  python ../run_ElecSim.py  --evt ${num} --inFile ROOT/${of_name}.root --outFile ROOT/${of_name}_spmt_elec.root --usrOutFile ROOT_user/${of_name}_user_spmt_elec.root

fi

if [ ${generator} == "5" ]; then

  of_name=IBD-neutron_${tag}_${seed}_output
  python tut_detsim.py --evtmax ${num} --seed ${seed} --output ROOT/${of_name}.root --user-output ROOT_user/${of_name}_user.root --no-gdml hepevt --exe IBD-neutron --volume pTarget
  python ../run_ElecSim.py  --evt ${num} --inFile ROOT/${of_name}.root --outFile ROOT/${of_name}_spmt_elec.root --usrOutFile ROOT_user/${of_name}_user_spmt_elec.root

fi

if [ ${generator} == "6" ]; then

  of_name=Mu_${tag}_${seed}_output
  python tut_detsim.py  --evtmax ${num} --seed ${seed} --output ROOT/${of_name}.root --user-output ROOT_user/${of_name}_user.root --no-gdml --no-anamgr-normal --no-anamgr-deposit --no-anamgr-interesting-process --anamgr-list MuProcessAnaMgr --pmtsd-v2 --pmtsd-merge-twindow 1.0 --pmt-hit-type 2 hepevt --exe Muon
  python ../run_ElecSim.py  --evt ${num} --inFile ROOT/${of_name}.root --outFile ROOT/${of_name}_spmt_elec.root --usrOutFile ROOT_user/${of_name}_user_spmt_elec.root

fi







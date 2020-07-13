#!/bin/bash

if [ $1 == "1" ] || [ $1 == "2" ]; then
(
cat << zzzEndOfFilezzz
 Universe = vanilla
 Executable = run_tests.sh
 Arguments = $1 $2 \$(Process) $3 $4 $5 $6 $7
 Output = Out/conf_$1_$2_$3_$4_$5_$6_$7_\$(Process).out
 Error = Err/conf_$1_$2_$3_$4_$5_$6_$7_\$(Process).err
 Log = Log/conf_$1_$2_$3_$4_$5_$6_$7_\$(Process).log
 Accounting_Group = juno
 Requirements = Target.OpSysAndVer =?= "SL6"
 Queue $8
zzzEndOfFilezzz
) > Confs/conf_$1_$2_$3_$4_$5_$6_$7.descr

condor_submit Confs/conf_$1_$2_$3_$4_$5_$6_$7.descr -name job@schedd01.ihep.ac.cn
fi


if [ $1 == "3" ] || \
   [ $1 == "4" ] || \
   [ $1 == "5" ] || \
   [ $1 == "6" ]; then
(
cat << zzzEndOfFilezzz
 Universe = vanilla
 Executable = run_tests.sh
 Arguments = $1 $2 \$(Process) $3 
 Output = Out/conf_$1_$2_$3_\$(Process).out
 Error = Err/conf_$1_$2_$3_\$(Process).err
 Log = Log/conf_$1_$2_$3_\$(Process).log
 Accounting_Group = juno
 Requirements = Target.OpSysAndVer =?= "SL6"
 Queue $4
zzzEndOfFilezzz
) > Confs/conf_$1_$2_$3.descr

condor_submit Confs/conf_$1_$2_$3.descr -name job@schedd01.ihep.ac.cn
fi



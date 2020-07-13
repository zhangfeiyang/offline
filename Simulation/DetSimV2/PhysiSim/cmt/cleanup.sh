# echo "cleanup PhysiSim v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtPhysiSimtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtPhysiSimtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=PhysiSim -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  $* >${cmtPhysiSimtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=PhysiSim -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  $* >${cmtPhysiSimtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtPhysiSimtempfile}
  unset cmtPhysiSimtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtPhysiSimtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtPhysiSimtempfile}
unset cmtPhysiSimtempfile
return $cmtcleanupstatus


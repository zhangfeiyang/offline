# echo "cleanup EvtMixingAlg v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtEvtMixingAlgtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtEvtMixingAlgtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=EvtMixingAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  $* >${cmtEvtMixingAlgtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=EvtMixingAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  $* >${cmtEvtMixingAlgtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtEvtMixingAlgtempfile}
  unset cmtEvtMixingAlgtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtEvtMixingAlgtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtEvtMixingAlgtempfile}
unset cmtEvtMixingAlgtempfile
return $cmtcleanupstatus


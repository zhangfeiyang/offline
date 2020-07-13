# echo "cleanup GenSim v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGenSimtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtGenSimtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=GenSim -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  $* >${cmtGenSimtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=GenSim -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  $* >${cmtGenSimtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtGenSimtempfile}
  unset cmtGenSimtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtGenSimtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtGenSimtempfile}
unset cmtGenSimtempfile
return $cmtcleanupstatus


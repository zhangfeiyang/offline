# echo "setup MCGlobalTimeSvc v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtMCGlobalTimeSvctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtMCGlobalTimeSvctempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=MCGlobalTimeSvc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtMCGlobalTimeSvctempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=MCGlobalTimeSvc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtMCGlobalTimeSvctempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtMCGlobalTimeSvctempfile}
  unset cmtMCGlobalTimeSvctempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtMCGlobalTimeSvctempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtMCGlobalTimeSvctempfile}
unset cmtMCGlobalTimeSvctempfile
return $cmtsetupstatus


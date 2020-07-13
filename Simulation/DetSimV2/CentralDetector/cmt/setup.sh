# echo "setup CentralDetector v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtCentralDetectortempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtCentralDetectortempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=CentralDetector -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtCentralDetectortempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=CentralDetector -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtCentralDetectortempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtCentralDetectortempfile}
  unset cmtCentralDetectortempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtCentralDetectortempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtCentralDetectortempfile}
unset cmtCentralDetectortempfile
return $cmtsetupstatus


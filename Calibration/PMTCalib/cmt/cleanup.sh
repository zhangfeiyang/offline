# echo "cleanup PMTCalib v0 in /junofs/production/public/users/zhangfy/offline_bgd/Calibration"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtPMTCalibtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtPMTCalibtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=PMTCalib -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Calibration  $* >${cmtPMTCalibtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=PMTCalib -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Calibration  $* >${cmtPMTCalibtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtPMTCalibtempfile}
  unset cmtPMTCalibtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtPMTCalibtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtPMTCalibtempfile}
unset cmtPMTCalibtempfile
return $cmtcleanupstatus


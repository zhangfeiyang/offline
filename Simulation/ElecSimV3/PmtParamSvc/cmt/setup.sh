# echo "setup PmtParamSvc v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtPmtParamSvctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtPmtParamSvctempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=PmtParamSvc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  -no_cleanup $* >${cmtPmtParamSvctempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=PmtParamSvc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  -no_cleanup $* >${cmtPmtParamSvctempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtPmtParamSvctempfile}
  unset cmtPmtParamSvctempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtPmtParamSvctempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtPmtParamSvctempfile}
unset cmtPmtParamSvctempfile
return $cmtsetupstatus


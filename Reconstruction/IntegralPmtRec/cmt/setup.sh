# echo "setup IntegralPmtRec v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtIntegralPmtRectempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtIntegralPmtRectempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=IntegralPmtRec -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtIntegralPmtRectempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=IntegralPmtRec -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtIntegralPmtRectempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtIntegralPmtRectempfile}
  unset cmtIntegralPmtRectempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtIntegralPmtRectempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtIntegralPmtRectempfile}
unset cmtIntegralPmtRectempfile
return $cmtsetupstatus


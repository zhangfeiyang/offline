# echo "setup RandomSvc v0 in /junofs/production/public/users/zhangfy/offline_bgd/CommonSvc"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtRandomSvctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtRandomSvctempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=RandomSvc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/CommonSvc  -no_cleanup $* >${cmtRandomSvctempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=RandomSvc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/CommonSvc  -no_cleanup $* >${cmtRandomSvctempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtRandomSvctempfile}
  unset cmtRandomSvctempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtRandomSvctempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtRandomSvctempfile}
unset cmtRandomSvctempfile
return $cmtsetupstatus


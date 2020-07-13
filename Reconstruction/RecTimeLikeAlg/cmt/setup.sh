# echo "setup RecTimeLikeAlg v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtRecTimeLikeAlgtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtRecTimeLikeAlgtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=RecTimeLikeAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtRecTimeLikeAlgtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=RecTimeLikeAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtRecTimeLikeAlgtempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtRecTimeLikeAlgtempfile}
  unset cmtRecTimeLikeAlgtempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtRecTimeLikeAlgtempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtRecTimeLikeAlgtempfile}
unset cmtRecTimeLikeAlgtempfile
return $cmtsetupstatus


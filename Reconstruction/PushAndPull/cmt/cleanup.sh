# echo "cleanup PushAndPull ./ in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtPushAndPulltempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtPushAndPulltempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=PushAndPull -version=./ -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  $* >${cmtPushAndPulltempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=PushAndPull -version=./ -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  $* >${cmtPushAndPulltempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtPushAndPulltempfile}
  unset cmtPushAndPulltempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtPushAndPulltempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtPushAndPulltempfile}
unset cmtPushAndPulltempfile
return $cmtcleanupstatus


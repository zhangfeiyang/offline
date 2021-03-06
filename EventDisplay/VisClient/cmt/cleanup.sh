# echo "cleanup VisClient v0 in /junofs/production/public/users/zhangfy/offline_bgd/EventDisplay"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtVisClienttempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtVisClienttempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=VisClient -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/EventDisplay  $* >${cmtVisClienttempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=VisClient -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/EventDisplay  $* >${cmtVisClienttempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtVisClienttempfile}
  unset cmtVisClienttempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtVisClienttempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtVisClienttempfile}
unset cmtVisClienttempfile
return $cmtcleanupstatus


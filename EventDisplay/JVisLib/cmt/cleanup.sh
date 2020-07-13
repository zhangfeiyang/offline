# echo "cleanup JVisLib v0 in /junofs/production/public/users/zhangfy/offline_bgd/EventDisplay"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtJVisLibtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtJVisLibtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=JVisLib -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/EventDisplay  $* >${cmtJVisLibtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=JVisLib -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/EventDisplay  $* >${cmtJVisLibtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtJVisLibtempfile}
  unset cmtJVisLibtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtJVisLibtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtJVisLibtempfile}
unset cmtJVisLibtempfile
return $cmtcleanupstatus


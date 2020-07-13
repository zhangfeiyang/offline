# echo "cleanup RootIOUtil v0 in /junofs/production/public/users/zhangfy/offline_bgd/RootIO"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtRootIOUtiltempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtRootIOUtiltempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=RootIOUtil -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/RootIO  $* >${cmtRootIOUtiltempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=RootIOUtil -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/RootIO  $* >${cmtRootIOUtiltempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtRootIOUtiltempfile}
  unset cmtRootIOUtiltempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtRootIOUtiltempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtRootIOUtiltempfile}
unset cmtRootIOUtiltempfile
return $cmtcleanupstatus


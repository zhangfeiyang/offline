# echo "cleanup RootIOTools v0 in /junofs/production/public/users/zhangfy/offline_bgd/RootIO"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtRootIOToolstempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtRootIOToolstempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=RootIOTools -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/RootIO  $* >${cmtRootIOToolstempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=RootIOTools -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/RootIO  $* >${cmtRootIOToolstempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtRootIOToolstempfile}
  unset cmtRootIOToolstempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtRootIOToolstempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtRootIOToolstempfile}
unset cmtRootIOToolstempfile
return $cmtcleanupstatus


# echo "cleanup InputReviser v0 in /junofs/production/public/users/zhangfy/offline_bgd/Utilities"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtInputRevisertempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtInputRevisertempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=InputReviser -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Utilities  $* >${cmtInputRevisertempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=InputReviser -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Utilities  $* >${cmtInputRevisertempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtInputRevisertempfile}
  unset cmtInputRevisertempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtInputRevisertempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtInputRevisertempfile}
unset cmtInputRevisertempfile
return $cmtcleanupstatus


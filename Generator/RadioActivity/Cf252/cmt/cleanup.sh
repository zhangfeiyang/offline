# echo "cleanup Cf252 v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtCf252tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtCf252tempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=Cf252 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  $* >${cmtCf252tempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=Cf252 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  $* >${cmtCf252tempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtCf252tempfile}
  unset cmtCf252tempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtCf252tempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtCf252tempfile}
unset cmtCf252tempfile
return $cmtcleanupstatus


# echo "cleanup TTTracking v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtTTTrackingtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtTTTrackingtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=TTTracking -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  $* >${cmtTTTrackingtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=TTTracking -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  $* >${cmtTTTrackingtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtTTTrackingtempfile}
  unset cmtTTTrackingtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtTTTrackingtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtTTTrackingtempfile}
unset cmtTTTrackingtempfile
return $cmtcleanupstatus


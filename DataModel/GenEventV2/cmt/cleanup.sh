# echo "cleanup GenEventV2 v0 in /junofs/production/public/users/zhangfy/offline_bgd/DataModel"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGenEventV2tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtGenEventV2tempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=GenEventV2 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/DataModel  $* >${cmtGenEventV2tempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=GenEventV2 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/DataModel  $* >${cmtGenEventV2tempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtGenEventV2tempfile}
  unset cmtGenEventV2tempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtGenEventV2tempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtGenEventV2tempfile}
unset cmtGenEventV2tempfile
return $cmtcleanupstatus


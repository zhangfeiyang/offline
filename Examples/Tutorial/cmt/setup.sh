# echo "setup Tutorial v0 in /junofs/production/public/users/zhangfy/offline_bgd/Examples"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtTutorialtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtTutorialtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=Tutorial -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Examples  -no_cleanup $* >${cmtTutorialtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=Tutorial -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Examples  -no_cleanup $* >${cmtTutorialtempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtTutorialtempfile}
  unset cmtTutorialtempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtTutorialtempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtTutorialtempfile}
unset cmtTutorialtempfile
return $cmtsetupstatus


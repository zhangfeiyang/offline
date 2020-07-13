# echo "setup K40 v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtK40tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtK40tempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=K40 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  -no_cleanup $* >${cmtK40tempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=K40 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  -no_cleanup $* >${cmtK40tempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtK40tempfile}
  unset cmtK40tempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtK40tempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtK40tempfile}
unset cmtK40tempfile
return $cmtsetupstatus


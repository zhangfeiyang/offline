# echo "setup JVisLib v0 in /junofs/production/public/users/zhangfy/offline_bgd/EventDisplay"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtJVisLibtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtJVisLibtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=JVisLib -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/EventDisplay  -no_cleanup $* >${cmtJVisLibtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=JVisLib -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/EventDisplay  -no_cleanup $* >${cmtJVisLibtempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtJVisLibtempfile}
  unset cmtJVisLibtempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtJVisLibtempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtJVisLibtempfile}
unset cmtJVisLibtempfile
return $cmtsetupstatus


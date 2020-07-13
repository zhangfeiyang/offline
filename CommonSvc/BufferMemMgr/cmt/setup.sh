# echo "setup BufferMemMgr v0 in /junofs/production/public/users/zhangfy/offline_bgd/CommonSvc"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtBufferMemMgrtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtBufferMemMgrtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=BufferMemMgr -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/CommonSvc  -no_cleanup $* >${cmtBufferMemMgrtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=BufferMemMgr -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/CommonSvc  -no_cleanup $* >${cmtBufferMemMgrtempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtBufferMemMgrtempfile}
  unset cmtBufferMemMgrtempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtBufferMemMgrtempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtBufferMemMgrtempfile}
unset cmtBufferMemMgrtempfile
return $cmtsetupstatus


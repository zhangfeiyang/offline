# echo "setup Identifier v0 in /junofs/production/public/users/zhangfy/offline_bgd/Detector"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtIdentifiertempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtIdentifiertempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=Identifier -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Detector  -no_cleanup $* >${cmtIdentifiertempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=Identifier -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Detector  -no_cleanup $* >${cmtIdentifiertempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtIdentifiertempfile}
  unset cmtIdentifiertempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtIdentifiertempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtIdentifiertempfile}
unset cmtIdentifiertempfile
return $cmtsetupstatus


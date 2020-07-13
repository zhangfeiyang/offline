# echo "setup RecEvent v0 in /junofs/production/public/users/zhangfy/offline_bgd/DataModel"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtRecEventtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtRecEventtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=RecEvent -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/DataModel  -no_cleanup $* >${cmtRecEventtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=RecEvent -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/DataModel  -no_cleanup $* >${cmtRecEventtempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtRecEventtempfile}
  unset cmtRecEventtempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtRecEventtempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtRecEventtempfile}
unset cmtRecEventtempfile
return $cmtsetupstatus


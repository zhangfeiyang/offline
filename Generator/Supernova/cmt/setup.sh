# echo "setup Supernova v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtSupernovatempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtSupernovatempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=Supernova -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator  -no_cleanup $* >${cmtSupernovatempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=Supernova -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator  -no_cleanup $* >${cmtSupernovatempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtSupernovatempfile}
  unset cmtSupernovatempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtSupernovatempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtSupernovatempfile}
unset cmtSupernovatempfile
return $cmtsetupstatus


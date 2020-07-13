# echo "setup Chimney v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtChimneytempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtChimneytempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=Chimney -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtChimneytempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=Chimney -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtChimneytempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtChimneytempfile}
  unset cmtChimneytempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtChimneytempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtChimneytempfile}
unset cmtChimneytempfile
return $cmtsetupstatus


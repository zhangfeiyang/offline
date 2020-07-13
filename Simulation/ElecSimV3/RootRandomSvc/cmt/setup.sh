# echo "setup RootRandomSvc v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtRootRandomSvctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtRootRandomSvctempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=RootRandomSvc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  -no_cleanup $* >${cmtRootRandomSvctempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=RootRandomSvc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  -no_cleanup $* >${cmtRootRandomSvctempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtRootRandomSvctempfile}
  unset cmtRootRandomSvctempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtRootRandomSvctempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtRootRandomSvctempfile}
unset cmtRootRandomSvctempfile
return $cmtsetupstatus


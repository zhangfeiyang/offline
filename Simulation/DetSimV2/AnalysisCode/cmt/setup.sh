# echo "setup AnalysisCode v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtAnalysisCodetempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtAnalysisCodetempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=AnalysisCode -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtAnalysisCodetempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=AnalysisCode -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtAnalysisCodetempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtAnalysisCodetempfile}
  unset cmtAnalysisCodetempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtAnalysisCodetempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtAnalysisCodetempfile}
unset cmtAnalysisCodetempfile
return $cmtsetupstatus


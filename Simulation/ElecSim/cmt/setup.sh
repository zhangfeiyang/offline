# echo "setup ElecSim v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtElecSimtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtElecSimtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=ElecSim -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation  -no_cleanup $* >${cmtElecSimtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=ElecSim -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation  -no_cleanup $* >${cmtElecSimtempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtElecSimtempfile}
  unset cmtElecSimtempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtElecSimtempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtElecSimtempfile}
unset cmtElecSimtempfile
return $cmtsetupstatus


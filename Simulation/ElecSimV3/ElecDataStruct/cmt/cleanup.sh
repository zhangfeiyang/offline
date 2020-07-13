# echo "cleanup ElecDataStruct v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtElecDataStructtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtElecDataStructtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=ElecDataStruct -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  $* >${cmtElecDataStructtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=ElecDataStruct -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  $* >${cmtElecDataStructtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtElecDataStructtempfile}
  unset cmtElecDataStructtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtElecDataStructtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtElecDataStructtempfile}
unset cmtElecDataStructtempfile
return $cmtcleanupstatus


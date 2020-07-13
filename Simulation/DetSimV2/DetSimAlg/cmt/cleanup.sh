# echo "cleanup DetSimAlg v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtDetSimAlgtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtDetSimAlgtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=DetSimAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  $* >${cmtDetSimAlgtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=DetSimAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  $* >${cmtDetSimAlgtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtDetSimAlgtempfile}
  unset cmtDetSimAlgtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtDetSimAlgtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtDetSimAlgtempfile}
unset cmtDetSimAlgtempfile
return $cmtcleanupstatus


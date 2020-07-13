# echo "cleanup GenDecay v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGenDecaytempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtGenDecaytempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=GenDecay -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation  $* >${cmtGenDecaytempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=GenDecay -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation  $* >${cmtGenDecaytempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtGenDecaytempfile}
  unset cmtGenDecaytempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtGenDecaytempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtGenDecaytempfile}
unset cmtGenDecaytempfile
return $cmtcleanupstatus


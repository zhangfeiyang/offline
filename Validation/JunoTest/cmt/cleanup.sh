# echo "cleanup JunoTest v0 in /junofs/production/public/users/zhangfy/offline_bgd/Validation"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtJunoTesttempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtJunoTesttempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=JunoTest -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Validation  $* >${cmtJunoTesttempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=JunoTest -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Validation  $* >${cmtJunoTesttempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtJunoTesttempfile}
  unset cmtJunoTesttempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtJunoTesttempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtJunoTesttempfile}
unset cmtJunoTesttempfile
return $cmtcleanupstatus


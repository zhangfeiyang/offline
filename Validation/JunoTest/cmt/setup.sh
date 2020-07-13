# echo "setup JunoTest v0 in /junofs/production/public/users/zhangfy/offline_bgd/Validation"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtJunoTesttempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtJunoTesttempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=JunoTest -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Validation  -no_cleanup $* >${cmtJunoTesttempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=JunoTest -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Validation  -no_cleanup $* >${cmtJunoTesttempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtJunoTesttempfile}
  unset cmtJunoTesttempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtJunoTesttempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtJunoTesttempfile}
unset cmtJunoTesttempfile
return $cmtsetupstatus


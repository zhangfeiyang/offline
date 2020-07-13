# echo "cleanup JunoRelease v0 in /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/offline"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtJunoReleasetempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtJunoReleasetempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=JunoRelease -version=v0 -path=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/offline  $* >${cmtJunoReleasetempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=JunoRelease -version=v0 -path=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/offline  $* >${cmtJunoReleasetempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtJunoReleasetempfile}
  unset cmtJunoReleasetempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtJunoReleasetempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtJunoReleasetempfile}
unset cmtJunoReleasetempfile
return $cmtcleanupstatus


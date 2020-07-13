# echo "setup JunoRelease v0 in /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/offline"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtJunoReleasetempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtJunoReleasetempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=JunoRelease -version=v0 -path=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/offline  -no_cleanup $* >${cmtJunoReleasetempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=JunoRelease -version=v0 -path=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/offline  -no_cleanup $* >${cmtJunoReleasetempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtJunoReleasetempfile}
  unset cmtJunoReleasetempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtJunoReleasetempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtJunoReleasetempfile}
unset cmtJunoReleasetempfile
return $cmtsetupstatus


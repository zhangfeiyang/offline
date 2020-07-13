# echo "setup JunoRelease v0 in /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/offline"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtJunoReleasetempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtJunoReleasetempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=JunoRelease -version=v0 -path=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/offline  -no_cleanup $* >${cmtJunoReleasetempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=JunoRelease -version=v0 -path=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/offline  -no_cleanup $* >${cmtJunoReleasetempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtJunoReleasetempfile}
  unset cmtJunoReleasetempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtJunoReleasetempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtJunoReleasetempfile}
unset cmtJunoReleasetempfile
exit $cmtsetupstatus


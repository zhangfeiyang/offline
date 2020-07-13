# echo "setup AmBe v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtAmBetempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtAmBetempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=AmBe -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  -no_cleanup $* >${cmtAmBetempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=AmBe -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  -no_cleanup $* >${cmtAmBetempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtAmBetempfile}
  unset cmtAmBetempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtAmBetempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtAmBetempfile}
unset cmtAmBetempfile
exit $cmtsetupstatus


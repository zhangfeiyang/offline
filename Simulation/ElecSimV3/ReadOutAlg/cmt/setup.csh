# echo "setup ReadOutAlg v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtReadOutAlgtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtReadOutAlgtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=ReadOutAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  -no_cleanup $* >${cmtReadOutAlgtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=ReadOutAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  -no_cleanup $* >${cmtReadOutAlgtempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtReadOutAlgtempfile}
  unset cmtReadOutAlgtempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtReadOutAlgtempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtReadOutAlgtempfile}
unset cmtReadOutAlgtempfile
exit $cmtsetupstatus


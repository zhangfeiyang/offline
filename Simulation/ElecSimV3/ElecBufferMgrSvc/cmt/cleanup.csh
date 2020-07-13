# echo "cleanup ElecBufferMgrSvc v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtElecBufferMgrSvctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtElecBufferMgrSvctempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=ElecBufferMgrSvc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  $* >${cmtElecBufferMgrSvctempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=ElecBufferMgrSvc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  $* >${cmtElecBufferMgrSvctempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtElecBufferMgrSvctempfile}
  unset cmtElecBufferMgrSvctempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtElecBufferMgrSvctempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtElecBufferMgrSvctempfile}
unset cmtElecBufferMgrSvctempfile
exit $cmtcleanupstatus


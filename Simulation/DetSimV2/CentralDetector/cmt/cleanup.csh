# echo "cleanup CentralDetector v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtCentralDetectortempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtCentralDetectortempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=CentralDetector -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  $* >${cmtCentralDetectortempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=CentralDetector -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  $* >${cmtCentralDetectortempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtCentralDetectortempfile}
  unset cmtCentralDetectortempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtCentralDetectortempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtCentralDetectortempfile}
unset cmtCentralDetectortempfile
exit $cmtcleanupstatus


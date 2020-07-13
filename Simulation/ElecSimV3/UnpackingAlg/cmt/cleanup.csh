# echo "cleanup UnpackingAlg v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtUnpackingAlgtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtUnpackingAlgtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=UnpackingAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  $* >${cmtUnpackingAlgtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=UnpackingAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  $* >${cmtUnpackingAlgtempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtUnpackingAlgtempfile}
  unset cmtUnpackingAlgtempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtUnpackingAlgtempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtUnpackingAlgtempfile}
unset cmtUnpackingAlgtempfile
exit $cmtcleanupstatus


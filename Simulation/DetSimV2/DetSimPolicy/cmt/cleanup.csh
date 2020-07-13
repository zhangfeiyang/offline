# echo "cleanup DetSimPolicy v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtDetSimPolicytempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtDetSimPolicytempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=DetSimPolicy -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  $* >${cmtDetSimPolicytempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=DetSimPolicy -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  $* >${cmtDetSimPolicytempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtDetSimPolicytempfile}
  unset cmtDetSimPolicytempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtDetSimPolicytempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtDetSimPolicytempfile}
unset cmtDetSimPolicytempfile
exit $cmtcleanupstatus


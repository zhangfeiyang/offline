# echo "cleanup DetSimOptions v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtDetSimOptionstempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtDetSimOptionstempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=DetSimOptions -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  $* >${cmtDetSimOptionstempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=DetSimOptions -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  $* >${cmtDetSimOptionstempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtDetSimOptionstempfile}
  unset cmtDetSimOptionstempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtDetSimOptionstempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtDetSimOptionstempfile}
unset cmtDetSimOptionstempfile
exit $cmtcleanupstatus


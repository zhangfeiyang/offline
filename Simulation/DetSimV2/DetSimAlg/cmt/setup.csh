# echo "setup DetSimAlg v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtDetSimAlgtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtDetSimAlgtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=DetSimAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtDetSimAlgtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=DetSimAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtDetSimAlgtempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtDetSimAlgtempfile}
  unset cmtDetSimAlgtempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtDetSimAlgtempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtDetSimAlgtempfile}
unset cmtDetSimAlgtempfile
exit $cmtsetupstatus


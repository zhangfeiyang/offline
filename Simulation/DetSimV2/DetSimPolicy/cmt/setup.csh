# echo "setup DetSimPolicy v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtDetSimPolicytempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtDetSimPolicytempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=DetSimPolicy -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtDetSimPolicytempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=DetSimPolicy -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtDetSimPolicytempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtDetSimPolicytempfile}
  unset cmtDetSimPolicytempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtDetSimPolicytempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtDetSimPolicytempfile}
unset cmtDetSimPolicytempfile
exit $cmtsetupstatus


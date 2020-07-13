# echo "cleanup PreTrgAlg v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtPreTrgAlgtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtPreTrgAlgtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=PreTrgAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  $* >${cmtPreTrgAlgtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=PreTrgAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  $* >${cmtPreTrgAlgtempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtPreTrgAlgtempfile}
  unset cmtPreTrgAlgtempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtPreTrgAlgtempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtPreTrgAlgtempfile}
unset cmtPreTrgAlgtempfile
exit $cmtcleanupstatus


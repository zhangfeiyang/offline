# echo "cleanup JVisLib v0 in /junofs/production/public/users/zhangfy/offline_bgd/EventDisplay"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtJVisLibtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtJVisLibtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=JVisLib -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/EventDisplay  $* >${cmtJVisLibtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=JVisLib -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/EventDisplay  $* >${cmtJVisLibtempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtJVisLibtempfile}
  unset cmtJVisLibtempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtJVisLibtempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtJVisLibtempfile}
unset cmtJVisLibtempfile
exit $cmtcleanupstatus


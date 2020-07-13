# echo "cleanup RootIOUtil v0 in /junofs/production/public/users/zhangfy/offline_bgd/RootIO"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtRootIOUtiltempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtRootIOUtiltempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=RootIOUtil -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/RootIO  $* >${cmtRootIOUtiltempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=RootIOUtil -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/RootIO  $* >${cmtRootIOUtiltempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtRootIOUtiltempfile}
  unset cmtRootIOUtiltempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtRootIOUtiltempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtRootIOUtiltempfile}
unset cmtRootIOUtiltempfile
exit $cmtcleanupstatus


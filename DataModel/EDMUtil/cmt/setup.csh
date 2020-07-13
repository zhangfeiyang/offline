# echo "setup EDMUtil v0 in /junofs/production/public/users/zhangfy/offline_bgd/DataModel"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtEDMUtiltempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtEDMUtiltempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=EDMUtil -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/DataModel  -no_cleanup $* >${cmtEDMUtiltempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=EDMUtil -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/DataModel  -no_cleanup $* >${cmtEDMUtiltempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtEDMUtiltempfile}
  unset cmtEDMUtiltempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtEDMUtiltempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtEDMUtiltempfile}
unset cmtEDMUtiltempfile
exit $cmtsetupstatus


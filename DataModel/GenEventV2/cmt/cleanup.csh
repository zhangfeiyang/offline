# echo "cleanup GenEventV2 v0 in /junofs/production/public/users/zhangfy/offline_bgd/DataModel"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGenEventV2tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtGenEventV2tempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=GenEventV2 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/DataModel  $* >${cmtGenEventV2tempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=GenEventV2 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/DataModel  $* >${cmtGenEventV2tempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtGenEventV2tempfile}
  unset cmtGenEventV2tempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtGenEventV2tempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtGenEventV2tempfile}
unset cmtGenEventV2tempfile
exit $cmtcleanupstatus


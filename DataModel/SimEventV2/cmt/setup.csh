# echo "setup SimEventV2 v0 in /junofs/production/public/users/zhangfy/offline_bgd/DataModel"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtSimEventV2tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtSimEventV2tempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=SimEventV2 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/DataModel  -no_cleanup $* >${cmtSimEventV2tempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=SimEventV2 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/DataModel  -no_cleanup $* >${cmtSimEventV2tempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtSimEventV2tempfile}
  unset cmtSimEventV2tempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtSimEventV2tempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtSimEventV2tempfile}
unset cmtSimEventV2tempfile
exit $cmtsetupstatus


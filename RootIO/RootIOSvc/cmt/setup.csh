# echo "setup RootIOSvc v0 in /junofs/production/public/users/zhangfy/offline_bgd/RootIO"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtRootIOSvctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtRootIOSvctempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=RootIOSvc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/RootIO  -no_cleanup $* >${cmtRootIOSvctempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=RootIOSvc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/RootIO  -no_cleanup $* >${cmtRootIOSvctempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtRootIOSvctempfile}
  unset cmtRootIOSvctempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtRootIOSvctempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtRootIOSvctempfile}
unset cmtRootIOSvctempfile
exit $cmtsetupstatus


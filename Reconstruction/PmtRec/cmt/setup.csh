# echo "setup PmtRec v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtPmtRectempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtPmtRectempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=PmtRec -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtPmtRectempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=PmtRec -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtPmtRectempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtPmtRectempfile}
  unset cmtPmtRectempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtPmtRectempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtPmtRectempfile}
unset cmtPmtRectempfile
exit $cmtsetupstatus


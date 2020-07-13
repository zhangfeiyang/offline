# echo "setup PushAndPull ./ in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtPushAndPulltempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtPushAndPulltempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=PushAndPull -version=./ -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtPushAndPulltempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=PushAndPull -version=./ -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtPushAndPulltempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtPushAndPulltempfile}
  unset cmtPushAndPulltempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtPushAndPulltempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtPushAndPulltempfile}
unset cmtPushAndPulltempfile
exit $cmtsetupstatus


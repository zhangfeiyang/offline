# echo "setup RecTimeLikeAlg v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtRecTimeLikeAlgtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtRecTimeLikeAlgtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=RecTimeLikeAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtRecTimeLikeAlgtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=RecTimeLikeAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtRecTimeLikeAlgtempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtRecTimeLikeAlgtempfile}
  unset cmtRecTimeLikeAlgtempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtRecTimeLikeAlgtempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtRecTimeLikeAlgtempfile}
unset cmtRecTimeLikeAlgtempfile
exit $cmtsetupstatus


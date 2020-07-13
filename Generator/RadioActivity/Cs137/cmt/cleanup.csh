# echo "cleanup Cs137 v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtCs137tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtCs137tempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=Cs137 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  $* >${cmtCs137tempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=Cs137 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  $* >${cmtCs137tempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtCs137tempfile}
  unset cmtCs137tempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtCs137tempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtCs137tempfile}
unset cmtCs137tempfile
exit $cmtcleanupstatus


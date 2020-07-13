# echo "cleanup Supernova v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtSupernovatempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtSupernovatempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=Supernova -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator  $* >${cmtSupernovatempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=Supernova -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator  $* >${cmtSupernovatempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtSupernovatempfile}
  unset cmtSupernovatempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtSupernovatempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtSupernovatempfile}
unset cmtSupernovatempfile
exit $cmtcleanupstatus


# echo "cleanup Co60 v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtCo60tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtCo60tempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=Co60 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  $* >${cmtCo60tempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=Co60 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  $* >${cmtCo60tempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtCo60tempfile}
  unset cmtCo60tempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtCo60tempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtCo60tempfile}
unset cmtCo60tempfile
exit $cmtcleanupstatus


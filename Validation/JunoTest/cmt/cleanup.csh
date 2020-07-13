# echo "cleanup JunoTest v0 in /junofs/production/public/users/zhangfy/offline_bgd/Validation"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtJunoTesttempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtJunoTesttempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=JunoTest -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Validation  $* >${cmtJunoTesttempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=JunoTest -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Validation  $* >${cmtJunoTesttempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtJunoTesttempfile}
  unset cmtJunoTesttempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtJunoTesttempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtJunoTesttempfile}
unset cmtJunoTesttempfile
exit $cmtcleanupstatus


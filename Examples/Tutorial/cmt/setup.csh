# echo "setup Tutorial v0 in /junofs/production/public/users/zhangfy/offline_bgd/Examples"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtTutorialtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtTutorialtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=Tutorial -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Examples  -no_cleanup $* >${cmtTutorialtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=Tutorial -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Examples  -no_cleanup $* >${cmtTutorialtempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtTutorialtempfile}
  unset cmtTutorialtempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtTutorialtempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtTutorialtempfile}
unset cmtTutorialtempfile
exit $cmtsetupstatus


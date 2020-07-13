# echo "setup Cf252 v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtCf252tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtCf252tempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=Cf252 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  -no_cleanup $* >${cmtCf252tempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=Cf252 -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  -no_cleanup $* >${cmtCf252tempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtCf252tempfile}
  unset cmtCf252tempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtCf252tempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtCf252tempfile}
unset cmtCf252tempfile
exit $cmtsetupstatus


# echo "setup PuC v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtPuCtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtPuCtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=PuC -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  -no_cleanup $* >${cmtPuCtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=PuC -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  -no_cleanup $* >${cmtPuCtempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtPuCtempfile}
  unset cmtPuCtempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtPuCtempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtPuCtempfile}
unset cmtPuCtempfile
exit $cmtsetupstatus


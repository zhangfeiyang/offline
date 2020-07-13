# echo "setup Chimney v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtChimneytempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtChimneytempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=Chimney -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtChimneytempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=Chimney -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtChimneytempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtChimneytempfile}
  unset cmtChimneytempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtChimneytempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtChimneytempfile}
unset cmtChimneytempfile
exit $cmtsetupstatus


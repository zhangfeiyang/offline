# echo "setup Identifier v0 in /junofs/production/public/users/zhangfy/offline_bgd/Detector"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtIdentifiertempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtIdentifiertempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=Identifier -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Detector  -no_cleanup $* >${cmtIdentifiertempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=Identifier -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Detector  -no_cleanup $* >${cmtIdentifiertempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtIdentifiertempfile}
  unset cmtIdentifiertempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtIdentifiertempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtIdentifiertempfile}
unset cmtIdentifiertempfile
exit $cmtsetupstatus


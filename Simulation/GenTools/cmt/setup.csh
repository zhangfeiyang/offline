# echo "setup GenTools v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGenToolstempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtGenToolstempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=GenTools -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation  -no_cleanup $* >${cmtGenToolstempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=GenTools -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation  -no_cleanup $* >${cmtGenToolstempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtGenToolstempfile}
  unset cmtGenToolstempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtGenToolstempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtGenToolstempfile}
unset cmtGenToolstempfile
exit $cmtsetupstatus


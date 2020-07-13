# echo "setup GenSim v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGenSimtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtGenSimtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=GenSim -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtGenSimtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=GenSim -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/DetSimV2  -no_cleanup $* >${cmtGenSimtempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtGenSimtempfile}
  unset cmtGenSimtempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtGenSimtempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtGenSimtempfile}
unset cmtGenSimtempfile
exit $cmtsetupstatus


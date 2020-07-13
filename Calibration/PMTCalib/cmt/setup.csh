# echo "setup PMTCalib v0 in /junofs/production/public/users/zhangfy/offline_bgd/Calibration"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtPMTCalibtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtPMTCalibtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=PMTCalib -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Calibration  -no_cleanup $* >${cmtPMTCalibtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=PMTCalib -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Calibration  -no_cleanup $* >${cmtPMTCalibtempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtPMTCalibtempfile}
  unset cmtPMTCalibtempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtPMTCalibtempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtPMTCalibtempfile}
unset cmtPMTCalibtempfile
exit $cmtsetupstatus


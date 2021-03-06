# echo "setup LsqMuonRecTool v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtLsqMuonRecTooltempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtLsqMuonRecTooltempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=LsqMuonRecTool -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtLsqMuonRecTooltempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=LsqMuonRecTool -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtLsqMuonRecTooltempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtLsqMuonRecTooltempfile}
  unset cmtLsqMuonRecTooltempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtLsqMuonRecTooltempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtLsqMuonRecTooltempfile}
unset cmtLsqMuonRecTooltempfile
exit $cmtsetupstatus


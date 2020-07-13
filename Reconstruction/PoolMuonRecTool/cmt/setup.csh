# echo "setup PoolMuonRecTool v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtPoolMuonRecTooltempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtPoolMuonRecTooltempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=PoolMuonRecTool -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtPoolMuonRecTooltempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=PoolMuonRecTool -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtPoolMuonRecTooltempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtPoolMuonRecTooltempfile}
  unset cmtPoolMuonRecTooltempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtPoolMuonRecTooltempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtPoolMuonRecTooltempfile}
unset cmtPoolMuonRecTooltempfile
exit $cmtsetupstatus


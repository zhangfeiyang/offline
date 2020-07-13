# echo "setup ConeMuonRecTool v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtConeMuonRecTooltempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtConeMuonRecTooltempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=ConeMuonRecTool -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtConeMuonRecTooltempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=ConeMuonRecTool -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtConeMuonRecTooltempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtConeMuonRecTooltempfile}
  unset cmtConeMuonRecTooltempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtConeMuonRecTooltempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtConeMuonRecTooltempfile}
unset cmtConeMuonRecTooltempfile
exit $cmtsetupstatus


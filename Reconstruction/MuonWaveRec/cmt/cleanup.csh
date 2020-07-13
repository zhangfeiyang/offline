# echo "cleanup MuonWaveRec v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtMuonWaveRectempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtMuonWaveRectempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=MuonWaveRec -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  $* >${cmtMuonWaveRectempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=MuonWaveRec -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  $* >${cmtMuonWaveRectempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtMuonWaveRectempfile}
  unset cmtMuonWaveRectempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtMuonWaveRectempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtMuonWaveRectempfile}
unset cmtMuonWaveRectempfile
exit $cmtcleanupstatus


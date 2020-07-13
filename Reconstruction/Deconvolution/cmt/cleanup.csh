# echo "cleanup Deconvolution v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtDeconvolutiontempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtDeconvolutiontempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=Deconvolution -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  $* >${cmtDeconvolutiontempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=Deconvolution -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  $* >${cmtDeconvolutiontempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtDeconvolutiontempfile}
  unset cmtDeconvolutiontempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtDeconvolutiontempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtDeconvolutiontempfile}
unset cmtDeconvolutiontempfile
exit $cmtcleanupstatus


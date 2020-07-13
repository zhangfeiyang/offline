# echo "cleanup NuSolGen v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtNuSolGentempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtNuSolGentempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=NuSolGen -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator  $* >${cmtNuSolGentempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=NuSolGen -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator  $* >${cmtNuSolGentempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtNuSolGentempfile}
  unset cmtNuSolGentempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtNuSolGentempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtNuSolGentempfile}
unset cmtNuSolGentempfile
exit $cmtcleanupstatus


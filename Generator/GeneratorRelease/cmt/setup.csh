# echo "setup GeneratorRelease v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGeneratorReleasetempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtGeneratorReleasetempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=GeneratorRelease -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator  -no_cleanup $* >${cmtGeneratorReleasetempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=GeneratorRelease -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator  -no_cleanup $* >${cmtGeneratorReleasetempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtGeneratorReleasetempfile}
  unset cmtGeneratorReleasetempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtGeneratorReleasetempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtGeneratorReleasetempfile}
unset cmtGeneratorReleasetempfile
exit $cmtsetupstatus


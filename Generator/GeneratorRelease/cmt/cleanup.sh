# echo "cleanup GeneratorRelease v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGeneratorReleasetempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtGeneratorReleasetempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=GeneratorRelease -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator  $* >${cmtGeneratorReleasetempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=GeneratorRelease -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator  $* >${cmtGeneratorReleasetempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtGeneratorReleasetempfile}
  unset cmtGeneratorReleasetempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtGeneratorReleasetempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtGeneratorReleasetempfile}
unset cmtGeneratorReleasetempfile
return $cmtcleanupstatus


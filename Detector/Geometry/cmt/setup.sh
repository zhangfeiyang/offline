# echo "setup Geometry v0 in /junofs/production/public/users/zhangfy/offline_bgd/Detector"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGeometrytempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtGeometrytempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=Geometry -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Detector  -no_cleanup $* >${cmtGeometrytempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=Geometry -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Detector  -no_cleanup $* >${cmtGeometrytempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtGeometrytempfile}
  unset cmtGeometrytempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtGeometrytempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtGeometrytempfile}
unset cmtGeometrytempfile
return $cmtsetupstatus


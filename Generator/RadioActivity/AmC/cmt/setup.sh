# echo "setup AmC v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtAmCtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtAmCtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=AmC -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  -no_cleanup $* >${cmtAmCtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=AmC -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator/RadioActivity  -no_cleanup $* >${cmtAmCtempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtAmCtempfile}
  unset cmtAmCtempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtAmCtempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtAmCtempfile}
unset cmtAmCtempfile
return $cmtsetupstatus


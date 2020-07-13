# echo "cleanup XmlObjDesc v0 in /junofs/production/public/users/zhangfy/offline_bgd"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtXmlObjDesctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtXmlObjDesctempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=XmlObjDesc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd  $* >${cmtXmlObjDesctempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=XmlObjDesc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd  $* >${cmtXmlObjDesctempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtXmlObjDesctempfile}
  unset cmtXmlObjDesctempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtXmlObjDesctempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtXmlObjDesctempfile}
unset cmtXmlObjDesctempfile
return $cmtcleanupstatus


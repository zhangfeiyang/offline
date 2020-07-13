# echo "cleanup ConeMuonRecTool v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtConeMuonRecTooltempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtConeMuonRecTooltempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=ConeMuonRecTool -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  $* >${cmtConeMuonRecTooltempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=ConeMuonRecTool -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  $* >${cmtConeMuonRecTooltempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtConeMuonRecTooltempfile}
  unset cmtConeMuonRecTooltempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtConeMuonRecTooltempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtConeMuonRecTooltempfile}
unset cmtConeMuonRecTooltempfile
return $cmtcleanupstatus


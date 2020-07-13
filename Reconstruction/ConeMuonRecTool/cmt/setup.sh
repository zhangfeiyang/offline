# echo "setup ConeMuonRecTool v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtConeMuonRecTooltempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtConeMuonRecTooltempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=ConeMuonRecTool -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtConeMuonRecTooltempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=ConeMuonRecTool -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtConeMuonRecTooltempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtConeMuonRecTooltempfile}
  unset cmtConeMuonRecTooltempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtConeMuonRecTooltempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtConeMuonRecTooltempfile}
unset cmtConeMuonRecTooltempfile
return $cmtsetupstatus


# echo "setup SpmtMuonRecTool v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtSpmtMuonRecTooltempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtSpmtMuonRecTooltempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=SpmtMuonRecTool -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtSpmtMuonRecTooltempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=SpmtMuonRecTool -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtSpmtMuonRecTooltempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtSpmtMuonRecTooltempfile}
  unset cmtSpmtMuonRecTooltempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtSpmtMuonRecTooltempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtSpmtMuonRecTooltempfile}
unset cmtSpmtMuonRecTooltempfile
return $cmtsetupstatus


# echo "setup MuonWaveRec v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtMuonWaveRectempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtMuonWaveRectempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=MuonWaveRec -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtMuonWaveRectempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=MuonWaveRec -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtMuonWaveRectempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtMuonWaveRectempfile}
  unset cmtMuonWaveRectempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtMuonWaveRectempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtMuonWaveRectempfile}
unset cmtMuonWaveRectempfile
return $cmtsetupstatus


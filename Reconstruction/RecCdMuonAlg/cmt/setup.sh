# echo "setup RecCdMuonAlg v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtRecCdMuonAlgtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtRecCdMuonAlgtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=RecCdMuonAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtRecCdMuonAlgtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=RecCdMuonAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtRecCdMuonAlgtempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtRecCdMuonAlgtempfile}
  unset cmtRecCdMuonAlgtempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtRecCdMuonAlgtempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtRecCdMuonAlgtempfile}
unset cmtRecCdMuonAlgtempfile
return $cmtsetupstatus


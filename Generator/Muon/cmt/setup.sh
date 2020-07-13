# echo "setup Muon v0 in /junofs/production/public/users/zhangfy/offline_bgd/Generator"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtMuontempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtMuontempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=Muon -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator  -no_cleanup $* >${cmtMuontempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=Muon -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Generator  -no_cleanup $* >${cmtMuontempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtMuontempfile}
  unset cmtMuontempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtMuontempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtMuontempfile}
unset cmtMuontempfile
return $cmtsetupstatus


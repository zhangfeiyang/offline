# echo "setup Deconvolution v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtDeconvolutiontempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtDeconvolutiontempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=Deconvolution -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtDeconvolutiontempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=Deconvolution -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtDeconvolutiontempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtDeconvolutiontempfile}
  unset cmtDeconvolutiontempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtDeconvolutiontempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtDeconvolutiontempfile}
unset cmtDeconvolutiontempfile
return $cmtsetupstatus


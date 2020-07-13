# echo "setup OMILREC v0 in /junofs/production/public/users/zhangfy/offline_bgd/Reconstruction"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtOMILRECtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtOMILRECtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=OMILREC -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtOMILRECtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=OMILREC -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Reconstruction  -no_cleanup $* >${cmtOMILRECtempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtOMILRECtempfile}
  unset cmtOMILRECtempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtOMILRECtempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtOMILRECtempfile}
unset cmtOMILRECtempfile
return $cmtsetupstatus


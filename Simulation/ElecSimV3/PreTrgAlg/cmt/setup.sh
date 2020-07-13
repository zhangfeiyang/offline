# echo "setup PreTrgAlg v0 in /junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtPreTrgAlgtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtPreTrgAlgtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=PreTrgAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  -no_cleanup $* >${cmtPreTrgAlgtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=PreTrgAlg -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd/Simulation/ElecSimV3  -no_cleanup $* >${cmtPreTrgAlgtempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtPreTrgAlgtempfile}
  unset cmtPreTrgAlgtempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtPreTrgAlgtempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtPreTrgAlgtempfile}
unset cmtPreTrgAlgtempfile
return $cmtsetupstatus


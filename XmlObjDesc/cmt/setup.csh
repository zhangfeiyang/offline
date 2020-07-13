# echo "setup XmlObjDesc v0 in /junofs/production/public/users/zhangfy/offline_bgd"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtXmlObjDesctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtXmlObjDesctempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=XmlObjDesc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd  -no_cleanup $* >${cmtXmlObjDesctempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=XmlObjDesc -version=v0 -path=/junofs/production/public/users/zhangfy/offline_bgd  -no_cleanup $* >${cmtXmlObjDesctempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtXmlObjDesctempfile}
  unset cmtXmlObjDesctempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtXmlObjDesctempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtXmlObjDesctempfile}
unset cmtXmlObjDesctempfile
exit $cmtsetupstatus


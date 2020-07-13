CMTPATH=/junofs/production/public/users/zhangfy/offline_bgd:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface
CMT_tag=$(tag)
CMTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
CMT_root=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26
CMTVERSION=v1r26
CMT_offset=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs
cmt_hardware_query_command=uname -m
cmt_hardware=`$(cmt_hardware_query_command)`
cmt_system_version_query_command=${CMTROOT}/mgr/cmt_linux_version.sh | ${CMTROOT}/mgr/cmt_filter_version.sh
cmt_system_version=`$(cmt_system_version_query_command)`
cmt_compiler_version_query_command=${CMTROOT}/mgr/cmt_gcc_version.sh | ${CMTROOT}/mgr/cmt_filter3_version.sh
cmt_compiler_version=`$(cmt_compiler_version_query_command)`
PATH=/junofs/production/public/users/zhangfy/offline_bgd/InstallArea/${CMTCONFIG}/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/InstallArea/${CMTCONFIG}/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26/${CMTBIN}:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/mysql-connector-cpp/1.1.8/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/mysql-connector-c/6.1.9/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/libmore/0.8.3/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/Geant4/9.4.p04/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/HepMC/2.06.09/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/ROOT/5.34.11/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/CLHEP/2.1.0.1/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/fftw3/3.2.1/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/gsl/1.16/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/Xercesc/3.1.1/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/Cmake/2.8.12.1/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/Boost/1.55.0/bin:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/Python/2.7.6/bin:/afs/ihep.ac.cn/soft/common/Python64/bin:/afs/ihep.ac.cn/soft/common/sysgroup/hep_job/bin:/junofs/production/public/users/zhangfy/local/matlab/bin:/usr/lib64/qt-3.3/bin:/usr/kerberos/sbin:/usr/kerberos/bin:/bin:/usr/bin:/usr/externals/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/sbin:/usr/java/latest/bin:/opt/puppetlabs/bin
CLASSPATH=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CMT/v1r26/java
debug_option=-g
cc=gcc
ccomp=$(cc) -c $(includes) $(cdebugflags) $(cflags) $(pp_cflags)
clink=$(cc) $(clinkflags) $(cdebugflags)
ppcmd=-I
preproc=c++ -MD -c 
cpp=g++
cppflags=-O2 -fPIC -pipe -ansi -W -Wall -Wwrite-strings -Wpointer-arith -Woverloaded-virtual 
pp_cppflags=-D_GNU_SOURCE
cppcomp=$(cpp) -c $(includes) $(cppdebugflags) $(cppflags) $(pp_cppflags)
cpplink=$(cpp) $(cpplinkflags) $(cppdebugflags)
for=g77
fflags=$(debug_option)
fcomp=$(for) -c $(fincludes) $(fflags) $(pp_fflags)
flink=$(for) $(flinkflags)
javacomp=javac -classpath $(src):$(CLASSPATH) 
javacopy=cp
jar=jar
X11_cflags=-I/usr/include
Xm_cflags=-I/usr/include
X_linkopts=-L/usr/X11R6/lib -lXm -lXt -lXext -lX11 -lm
lex=lex $(lexflags)
yaccflags= -l -d 
yacc=yacc $(yaccflags)
ar=ar cr
ranlib=ranlib
make_shlib=${CMTROOT}/mgr/cmt_make_shlib_common.sh extract
shlibsuffix=so
shlibbuilder=g++ $(cmt_installarea_linkopts) 
shlibflags=-shared
symlink=/bin/ln -fs 
symunlink=/bin/rm -f 
library_install_command=python $(SniperPolicy_root)/cmt/fragments/install.py -xCVS -x.svn -x*~ -x*.stamp -s --log=./install.history 
build_library_links=$(cmtexe) build library_links -tag=$(tags)
remove_library_links=$(cmtexe) remove library_links -tag=$(tags)
cmtexe=${CMTROOT}/${CMTBIN}/cmt.exe
build_prototype=$(cmtexe) build prototype
build_dependencies=$(cmtexe) -tag=$(tags) build dependencies
build_triggers=$(cmtexe) build triggers
format_dependencies=${CMTROOT}/mgr/cmt_format_deps.sh
implied_library_prefix=-l
SHELL=/bin/sh
q="
src=../src/
doc=../doc/
inc=../src/
mgr=../cmt/
application_suffix=.exe
library_prefix=lib
unlock_command=rm -rf 
lock_name=cmt
lock_suffix=.lock
lock_file=${lock_name}${lock_suffix}
svn_checkout_command=python ${CMTROOT}/mgr/cmt_svn_checkout.py 
gmake_hosts=lx1 rsplus lxtest as7 dxplus ax7 hp2 aleph hp1 hpplus papou1-fe atlas
make_hosts=virgo-control1 rio0a vmpc38a
everywhere=hosts
install_command=python $(SniperPolicy_root)/cmt/fragments/install.py -xCVS -x.svn -x*~ -x*.stamp --log=./install.history 
uninstall_command=python $(SniperPolicy_root)/cmt/fragments/install.py -u --log=./install.history 
cmt_installarea_command=python $(SniperPolicy_root)/cmt/fragments/install.py -xCVS -x.svn -x*~ -x*.stamp -s --log=./install.history 
cmt_uninstallarea_command=/bin/rm -f 
cmt_install_area_command=$(cmt_installarea_command)
cmt_uninstall_area_command=$(cmt_uninstallarea_command)
cmt_install_action=$(CMTROOT)/mgr/cmt_install_action.sh
cmt_installdir_action=$(CMTROOT)/mgr/cmt_installdir_action.sh
cmt_uninstall_action=$(CMTROOT)/mgr/cmt_uninstall_action.sh
cmt_uninstalldir_action=$(CMTROOT)/mgr/cmt_uninstalldir_action.sh
mkdir=mkdir
cmt_cvs_protocol_level=v1r1
cmt_installarea_prefix=InstallArea
CMT_PATH_remove_regexp=/[^/]*/
CMT_PATH_remove_share_regexp=/share/
NEWCMTCONFIG=x86_64-sl69-gcc447
RecEvent_tag=$(tag)
RECEVENTROOT=/junofs/production/public/users/zhangfy/offline_bgd/DataModel/RecEvent
RecEvent_root=/junofs/production/public/users/zhangfy/offline_bgd/DataModel/RecEvent
RECEVENTVERSION=v0
RecEvent_cmtpath=/junofs/production/public/users/zhangfy/offline_bgd
RecEvent_offset=DataModel
RecEvent_project=offline
RecEvent_project_release=offline_bgd
XmlObjDesc_tag=$(tag)
XMLOBJDESCROOT=/junofs/production/public/users/zhangfy/offline_bgd/XmlObjDesc
XmlObjDesc_root=/junofs/production/public/users/zhangfy/offline_bgd/XmlObjDesc
XMLOBJDESCVERSION=v0
XmlObjDesc_cmtpath=/junofs/production/public/users/zhangfy/offline_bgd
XmlObjDesc_project=offline
XmlObjDesc_project_release=offline_bgd
xmlsrc=xml
SniperPolicy_tag=$(tag)
SNIPERPOLICYROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/SniperPolicy
SniperPolicy_root=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/SniperPolicy
SNIPERPOLICYVERSION=v0
SniperPolicy_cmtpath=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper
SniperPolicy_project=sniper
libraryshr_linkopts=-fPIC -ldl -Wl,--as-needed -Wl,--no-undefined 
application_linkopts=-Wl,--export-dynamic 
BINDIR=$(tag)
remove_command=$(cmt_uninstallarea_command)
ROOT_tag=$(tag)
ROOTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface/Externals/ROOT
ROOT_root=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface/Externals/ROOT
ROOTVERSION=v0
ROOT_cmtpath=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface
ROOT_offset=Externals
ROOT_project=ExternalInterface
ROOT_home=${JUNO_EXTLIB_ROOT_HOME}
ROOT_cppflags=`root-config --cflags` -Wno-long-long 
ROOT_linkopts=`root-config --evelibs`
rootcint="$(ROOT_home)/bin/rootcint"
SniperKernel_tag=$(tag)
SNIPERKERNELROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/SniperKernel
SniperKernel_root=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/SniperKernel
SNIPERKERNELVERSION=v2
SniperKernel_cmtpath=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper
SniperKernel_project=sniper
Boost_tag=$(tag)
BOOSTROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface/Externals/Boost
Boost_root=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface/Externals/Boost
BOOSTVERSION=v0
Boost_cmtpath=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface
Boost_offset=Externals
Boost_project=ExternalInterface
Python_tag=$(tag)
PYTHONROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface/Externals/Python
Python_root=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface/Externals/Python
PYTHONVERSION=v0
Python_cmtpath=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface
Python_offset=Externals
Python_project=ExternalInterface
Python_linkopts= `pkg-config --libs python` 
Python_cppflags= `pkg-config --cflags python` 
Boost_home=${JUNO_EXTLIB_Boost_HOME}
Boost_linkopts= -L$(Boost_home)/lib  -lboost_python 
includes= $(ppcmd)"$(RecEvent_root)"  $(ppcmd)"$(srcdir)" $(ppcmd)"/junofs/production/public/users/zhangfy/offline_bgd/DataModel/RecEvent/Event" $(ppcmd)"/junofs/production/public/users/zhangfy/offline_bgd/InstallArea/include" $(ppcmd)"/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/InstallArea/include" $(use_includes)
PYTHONPATH=/junofs/production/public/users/zhangfy/offline_bgd/InstallArea/python:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/InstallArea/python:/junofs/production/public/users/zhangfy/offline_bgd/InstallArea/amd64_linux26/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/InstallArea/amd64_linux26/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/ROOT/5.34.11/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/Python/2.7.6/lib/./python2.7/lib-dynload:/junofs/users/zhukangfu/workdesktop/offline/InstallArea/python:/junofs/users/zhukangfu/workdesktop/offline/InstallArea/amd64_linux26/lib:/usr/lib64/python
SniperKernel_linkopts= -lSniperKernel  -lSniperPython 
SniperKernel_stamps=${SNIPERKERNELROOT}/${BINDIR}/SniperPython.stamp 
SniperKernel_linker_library=SniperPython
SniperPython_dependencies=SniperKernel
SniperPython_shlibflags= -lSniperKernel 
CLHEP_tag=$(tag)
CLHEPROOT=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface/Externals/CLHEP
CLHEP_root=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface/Externals/CLHEP
CLHEPVERSION=v0
CLHEP_cmtpath=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface
CLHEP_offset=Externals
CLHEP_project=ExternalInterface
CLHEP_linkopts= `clhep-config --libs` 
CLHEP_cppflags= `clhep-config --include` 
CLHEPDict_tag=$(tag)
CLHEPDICTROOT=/junofs/production/public/users/zhangfy/offline_bgd/DataModel/Dict/CLHEPDict
CLHEPDict_root=/junofs/production/public/users/zhangfy/offline_bgd/DataModel/Dict/CLHEPDict
CLHEPDICTVERSION=v0
CLHEPDict_cmtpath=/junofs/production/public/users/zhangfy/offline_bgd
CLHEPDict_offset=DataModel/Dict
CLHEPDict_project=offline
CLHEPDict_project_release=offline_bgd
CLHEPDict_dependencies= CLHEPDictDict 
CLHEPDictDict_dependencies= CLHEPDictObj2Doth  install_more_includes 
CLHEPInc_cintflags= `clhep-config --include` -p 
CLHEPDict_linkopts= -Wl,--no-as-needed  -lCLHEPDict  -Wl,--as-needed 
CLHEPDict_stamps=${CLHEPDICTROOT}/${BINDIR}/CLHEPDict.stamp 
CLHEPDict_linker_library=CLHEPDict
BaseEvent_tag=$(tag)
BASEEVENTROOT=/junofs/production/public/users/zhangfy/offline_bgd/DataModel/BaseEvent
BaseEvent_root=/junofs/production/public/users/zhangfy/offline_bgd/DataModel/BaseEvent
BASEEVENTVERSION=v0
BaseEvent_cmtpath=/junofs/production/public/users/zhangfy/offline_bgd
BaseEvent_offset=DataModel
BaseEvent_project=offline
BaseEvent_project_release=offline_bgd
XODflags= -n JM  -n JM 
BaseEvent_dependencies= BaseEventObj2Doth  BaseEventDict  BaseEventxodsrc 
install_more_includes_dependencies= BaseEventObj2Doth  RecEventObj2Doth 
BaseEventDict_dependencies= BaseEventObj2Doth  install_more_includes 
BaseEventxodsrc_dependencies= BaseEventObj2Doth 
BaseEvent_linkopts= -lBaseEvent 
BaseEvent_stamps=${BASEEVENTROOT}/${BINDIR}/BaseEvent.stamp 
BaseEvent_linker_library=BaseEvent
EDMUtil_tag=$(tag)
EDMUTILROOT=/junofs/production/public/users/zhangfy/offline_bgd/DataModel/EDMUtil
EDMUtil_root=/junofs/production/public/users/zhangfy/offline_bgd/DataModel/EDMUtil
EDMUTILVERSION=v0
EDMUtil_cmtpath=/junofs/production/public/users/zhangfy/offline_bgd
EDMUtil_offset=DataModel
EDMUtil_project=offline
EDMUtil_project_release=offline_bgd
EDMUtil_dependencies= EDMUtilDict  EDMUtilDict  EDMUtilDict  EDMUtilDict 
EDMUtilDict_dependencies= EDMUtilObj2Doth  install_more_includes  EDMUtilObj2Doth  install_more_includes  EDMUtilObj2Doth  install_more_includes  EDMUtilObj2Doth  install_more_includes 
EDMUtil_linkopts= -lEDMUtil 
EDMUtil_stamps=${EDMUTILROOT}/${BINDIR}/EDMUtil.stamp 
EDMUtil_linker_library=EDMUtil
CDRecEvent_cintflags=-I$(CMTINSTALLAREA)/include
RecHeader_cintflags=-I$(CMTINSTALLAREA)/include  `clhep-config --include`
RecTrack_cintflags=-I$(CMTINSTALLAREA)/include  `clhep-config --include`
CDTrackRecEvent_cintflags=-I$(CMTINSTALLAREA)/include  `clhep-config --include`
WPRecEvent_cintflags=-I$(CMTINSTALLAREA)/include  `clhep-config --include`
TTRecEvent_cintflags=-I$(CMTINSTALLAREA)/include  `clhep-config --include`
RecEvent_dependencies= RecEventObj2Doth  RecEventDict  RecEventxodsrc 
RecEventDict_dependencies= RecEventObj2Doth  install_more_includes 
RecEventxodsrc_dependencies= RecEventObj2Doth 
RecEvent_linkopts= -lRecEvent 
RecEvent_shlibflags=$(libraryshr_linkopts) $(cmt_installarea_linkopts) $(RecEvent_use_linkopts)
RecEvent_use_linkopts=    $(CLHEPDict_linkopts)  $(EDMUtil_linkopts)  $(BaseEvent_linkopts)  $(SniperKernel_linkopts)  $(SniperPolicy_linkopts)  $(ROOT_linkopts)  $(Boost_linkopts)  $(Python_linkopts)  $(CLHEP_linkopts) 
RecEvent_stamps=${RECEVENTROOT}/${BINDIR}/RecEvent.stamp 
RecEvent_linker_library=RecEvent
tag=amd64_linux26
package=RecEvent
version=v0
PACKAGE_ROOT=$(RECEVENTROOT)
srcdir=../src
bin=../$(RecEvent_tag)/
javabin=../classes/
mgrdir=cmt
BIN=/junofs/production/public/users/zhangfy/offline_bgd/DataModel/RecEvent/amd64_linux26/
project=offline
cmt_installarea_paths= $(cmt_installarea_prefix)/$(CMTCONFIG)/bin $(sniper_installarea_prefix)/$(CMTCONFIG)/lib $(sniper_installarea_prefix)/share/lib $(sniper_installarea_prefix)/share/bin $(offline_installarea_prefix)/$(CMTCONFIG)/lib $(offline_installarea_prefix)/share/lib $(offline_installarea_prefix)/share/bin
use_linkopts= $(cmt_installarea_linkopts)   $(RecEvent_linkopts)  $(CLHEPDict_linkopts)  $(EDMUtil_linkopts)  $(BaseEvent_linkopts)  $(SniperKernel_linkopts)  $(SniperPolicy_linkopts)  $(ROOT_linkopts)  $(Boost_linkopts)  $(Python_linkopts)  $(CLHEP_linkopts) 
ExternalInterface_installarea_prefix=$(cmt_installarea_prefix)
ExternalInterface_installarea_prefix_remove=$(ExternalInterface_installarea_prefix)
LD_LIBRARY_PATH=/junofs/production/public/users/zhangfy/offline_bgd/InstallArea/${CMTCONFIG}/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/InstallArea/${CMTCONFIG}/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/mysql-connector-cpp/1.1.8/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/mysql-connector-c/6.1.9/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/libmore/0.8.3/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/Geant4/9.4.p04/lib/geant4-9.4.4/Linux-g++:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs/CLHEP/2.1.0.1/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/Geant4/9.4.p04/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/HepMC/2.06.09/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/ROOT/5.34.11/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/CLHEP/2.1.0.1/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/fftw3/3.2.1/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/gsl/1.16/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/Xercesc/3.1.1/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/Boost/1.55.0/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/Python/2.7.6/lib:/junofs/production/public/users/zhangfy/local/matlab/bin/glnxa64:/junofs/production/public/users/zhangfy/local/matlab/sys/os/glnxa64:/usr/lib64/classads:/usr/lib64:/usr/lib
sniper_installarea_prefix=$(cmt_installarea_prefix)
sniper_installarea_prefix_remove=$(sniper_installarea_prefix)
offline_installarea_prefix=$(cmt_installarea_prefix)
offline_installarea_prefix_remove=$(offline_installarea_prefix)
cmt_installarea_linkopts= -L/junofs/production/public/users/zhangfy/offline_bgd/$(offline_installarea_prefix)/$(CMTCONFIG)/lib  -L/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/$(sniper_installarea_prefix)/$(CMTCONFIG)/lib 
ExternalInterface_home=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface
sniper_home=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper
offline_home=/junofs/production/public/users/zhangfy/offline_bgd
offline_install_include= /junofs/production/public/users/zhangfy/offline_bgd/$(offline_installarea_prefix)/include 
sniper_install_include= /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/$(sniper_installarea_prefix)/include 
sniper_python_path=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/$(sniper_installarea_prefix)/$(tag)/lib
offline_python_path=/junofs/production/public/users/zhangfy/offline_bgd/$(offline_installarea_prefix)/$(tag)/lib
sniper_install_python=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/$(sniper_installarea_prefix)/python
offline_install_python=/junofs/production/public/users/zhangfy/offline_bgd/$(offline_installarea_prefix)/python
CMTINSTALLAREA=/junofs/production/public/users/zhangfy/offline_bgd/$(cmt_installarea_prefix)
use_requirements=requirements $(CMT_root)/mgr/requirements $(CLHEPDict_root)/cmt/requirements $(EDMUtil_root)/cmt/requirements $(BaseEvent_root)/cmt/requirements $(XmlObjDesc_root)/cmt/requirements $(SniperKernel_root)/cmt/requirements $(SniperPolicy_root)/cmt/requirements $(ROOT_root)/cmt/requirements $(Boost_root)/cmt/requirements $(Python_root)/cmt/requirements $(CLHEP_root)/cmt/requirements 
use_includes= $(ppcmd)"$(CLHEPDict_root)/src" $(ppcmd)"$(EDMUtil_root)/src" $(ppcmd)"/junofs/production/public/users/zhangfy/offline_bgd/DataModel/EDMUtil/include" $(ppcmd)"/junofs/production/public/users/zhangfy/offline_bgd/DataModel/EDMUtil/EDMUtil" $(ppcmd)"$(BaseEvent_root)/src" $(ppcmd)"/junofs/production/public/users/zhangfy/offline_bgd/DataModel/BaseEvent/Event" $(ppcmd)"$(SniperKernel_root)/src" $(ppcmd)"$(SniperPolicy_root)/src" $(ppcmd)"/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/ROOT/5.34.11/include" $(ppcmd)"/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/Boost/1.55.0/include" $(ppcmd)"$(Python_root)/src" $(ppcmd)"$(CLHEP_root)/src" 
use_fincludes= $(use_includes)
use_stamps=  $(RecEvent_stamps)  $(CLHEPDict_stamps)  $(EDMUtil_stamps)  $(BaseEvent_stamps)  $(SniperKernel_stamps)  $(SniperPolicy_stamps)  $(ROOT_stamps)  $(Boost_stamps)  $(Python_stamps)  $(CLHEP_stamps) 
use_cflags=  $(RecEvent_cflags)  $(CLHEPDict_cflags)  $(EDMUtil_cflags)  $(BaseEvent_cflags)  $(SniperKernel_cflags)  $(SniperPolicy_cflags)  $(ROOT_cflags)  $(Boost_cflags)  $(Python_cflags)  $(CLHEP_cflags) 
use_pp_cflags=  $(RecEvent_pp_cflags)  $(CLHEPDict_pp_cflags)  $(EDMUtil_pp_cflags)  $(BaseEvent_pp_cflags)  $(SniperKernel_pp_cflags)  $(SniperPolicy_pp_cflags)  $(ROOT_pp_cflags)  $(Boost_pp_cflags)  $(Python_pp_cflags)  $(CLHEP_pp_cflags) 
use_cppflags=  $(RecEvent_cppflags)  $(CLHEPDict_cppflags)  $(EDMUtil_cppflags)  $(BaseEvent_cppflags)  $(SniperKernel_cppflags)  $(SniperPolicy_cppflags)  $(ROOT_cppflags)  $(Boost_cppflags)  $(Python_cppflags)  $(CLHEP_cppflags) 
use_pp_cppflags=  $(RecEvent_pp_cppflags)  $(CLHEPDict_pp_cppflags)  $(EDMUtil_pp_cppflags)  $(BaseEvent_pp_cppflags)  $(SniperKernel_pp_cppflags)  $(SniperPolicy_pp_cppflags)  $(ROOT_pp_cppflags)  $(Boost_pp_cppflags)  $(Python_pp_cppflags)  $(CLHEP_pp_cppflags) 
use_fflags=  $(RecEvent_fflags)  $(CLHEPDict_fflags)  $(EDMUtil_fflags)  $(BaseEvent_fflags)  $(SniperKernel_fflags)  $(SniperPolicy_fflags)  $(ROOT_fflags)  $(Boost_fflags)  $(Python_fflags)  $(CLHEP_fflags) 
use_pp_fflags=  $(RecEvent_pp_fflags)  $(CLHEPDict_pp_fflags)  $(EDMUtil_pp_fflags)  $(BaseEvent_pp_fflags)  $(SniperKernel_pp_fflags)  $(SniperPolicy_pp_fflags)  $(ROOT_pp_fflags)  $(Boost_pp_fflags)  $(Python_pp_fflags)  $(CLHEP_pp_fflags) 
use_libraries= $(CLHEPDict_libraries)  $(EDMUtil_libraries)  $(BaseEvent_libraries)  $(XmlObjDesc_libraries)  $(SniperKernel_libraries)  $(SniperPolicy_libraries)  $(ROOT_libraries)  $(Boost_libraries)  $(Python_libraries)  $(CLHEP_libraries) 
fincludes= $(includes)
RecEventObj2Doth_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
install_more_includes_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
RecEventDict_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
RecEventxodsrc_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
RecEvent_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
make_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
constituents= RecEventObj2Doth install_more_includes RecEventDict RecEventxodsrc RecEvent 
all_constituents= $(constituents)
constituentsclean= RecEventclean RecEventxodsrcclean RecEventDictclean install_more_includesclean RecEventObj2Dothclean 
all_constituentsclean= $(constituentsclean)
cmt_actions_constituents= make 
cmt_actions_constituentsclean= makeclean 
RecEventcompile_dependencies= RecEventObj2Doth RecEventDict RecEventxodsrc
RecEventprototype_dependencies= $(RecEventcompile_dependencies)

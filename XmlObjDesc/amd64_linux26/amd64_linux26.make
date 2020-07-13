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
tag=amd64_linux26
package=XmlObjDesc
version=v0
PACKAGE_ROOT=$(XMLOBJDESCROOT)
srcdir=../src
bin=../$(XmlObjDesc_tag)/
javabin=../classes/
mgrdir=cmt
BIN=/junofs/production/public/users/zhangfy/offline_bgd/XmlObjDesc/amd64_linux26/
project=offline
cmt_installarea_paths= $(cmt_installarea_prefix)/$(CMTCONFIG)/bin $(sniper_installarea_prefix)/$(CMTCONFIG)/lib $(sniper_installarea_prefix)/share/lib $(sniper_installarea_prefix)/share/bin $(offline_installarea_prefix)/$(CMTCONFIG)/lib $(offline_installarea_prefix)/share/lib $(offline_installarea_prefix)/share/bin
use_linkopts= $(cmt_installarea_linkopts)   $(XmlObjDesc_linkopts)  $(SniperPolicy_linkopts)  $(ROOT_linkopts) 
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
PYTHONPATH=/junofs/production/public/users/zhangfy/offline_bgd/InstallArea/python:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/InstallArea/python:/junofs/production/public/users/zhangfy/offline_bgd/InstallArea/amd64_linux26/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/InstallArea/amd64_linux26/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/ROOT/5.34.11/lib:/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/Python/2.7.6/lib/./python2.7/lib-dynload:/junofs/users/zhukangfu/workdesktop/offline/InstallArea/python:/junofs/users/zhukangfu/workdesktop/offline/InstallArea/amd64_linux26/lib:/usr/lib64/python
sniper_python_path=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/$(sniper_installarea_prefix)/$(tag)/lib
offline_python_path=/junofs/production/public/users/zhangfy/offline_bgd/$(offline_installarea_prefix)/$(tag)/lib
sniper_install_python=/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/$(sniper_installarea_prefix)/python
offline_install_python=/junofs/production/public/users/zhangfy/offline_bgd/$(offline_installarea_prefix)/python
CMTINSTALLAREA=/junofs/production/public/users/zhangfy/offline_bgd/$(cmt_installarea_prefix)
use_requirements=requirements $(CMT_root)/mgr/requirements $(SniperPolicy_root)/cmt/requirements $(ROOT_root)/cmt/requirements 
use_includes= $(ppcmd)"$(SniperPolicy_root)/src" $(ppcmd)"/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/ROOT/5.34.11/include" 
use_fincludes= $(use_includes)
use_stamps=  $(XmlObjDesc_stamps)  $(SniperPolicy_stamps)  $(ROOT_stamps) 
use_cflags=  $(XmlObjDesc_cflags)  $(SniperPolicy_cflags)  $(ROOT_cflags) 
use_pp_cflags=  $(XmlObjDesc_pp_cflags)  $(SniperPolicy_pp_cflags)  $(ROOT_pp_cflags) 
use_cppflags=  $(XmlObjDesc_cppflags)  $(SniperPolicy_cppflags)  $(ROOT_cppflags) 
use_pp_cppflags=  $(XmlObjDesc_pp_cppflags)  $(SniperPolicy_pp_cppflags)  $(ROOT_pp_cppflags) 
use_fflags=  $(XmlObjDesc_fflags)  $(SniperPolicy_fflags)  $(ROOT_fflags) 
use_pp_fflags=  $(XmlObjDesc_pp_fflags)  $(SniperPolicy_pp_fflags)  $(ROOT_pp_fflags) 
use_libraries= $(SniperPolicy_libraries)  $(ROOT_libraries) 
includes= $(ppcmd)"/junofs/production/public/users/zhangfy/offline_bgd/InstallArea/include" $(ppcmd)"/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper/InstallArea/include" $(use_includes)
fincludes= $(includes)
make_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
constituents= 
all_constituents= $(constituents)
constituentsclean= 
all_constituentsclean= $(constituentsclean)
cmt_actions_constituents= make 
cmt_actions_constituentsclean= makeclean 

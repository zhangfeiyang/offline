#-- start of make_header -----------------

#====================================
#  Library EDMUtil
#
#   Generated Fri Jul 10 19:17:39 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_EDMUtil_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_EDMUtil_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_EDMUtil

EDMUtil_tag = $(tag)

#cmt_local_tagfile_EDMUtil = $(EDMUtil_tag)_EDMUtil.make
cmt_local_tagfile_EDMUtil = $(bin)$(EDMUtil_tag)_EDMUtil.make

else

tags      = $(tag),$(CMTEXTRATAGS)

EDMUtil_tag = $(tag)

#cmt_local_tagfile_EDMUtil = $(EDMUtil_tag).make
cmt_local_tagfile_EDMUtil = $(bin)$(EDMUtil_tag).make

endif

include $(cmt_local_tagfile_EDMUtil)
#-include $(cmt_local_tagfile_EDMUtil)

ifdef cmt_EDMUtil_has_target_tag

cmt_final_setup_EDMUtil = $(bin)setup_EDMUtil.make
cmt_dependencies_in_EDMUtil = $(bin)dependencies_EDMUtil.in
#cmt_final_setup_EDMUtil = $(bin)EDMUtil_EDMUtilsetup.make
cmt_local_EDMUtil_makefile = $(bin)EDMUtil.make

else

cmt_final_setup_EDMUtil = $(bin)setup.make
cmt_dependencies_in_EDMUtil = $(bin)dependencies.in
#cmt_final_setup_EDMUtil = $(bin)EDMUtilsetup.make
cmt_local_EDMUtil_makefile = $(bin)EDMUtil.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)EDMUtilsetup.make

#EDMUtil :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'EDMUtil'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = EDMUtil/
#EDMUtil::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

EDMUtillibname   = $(bin)$(library_prefix)EDMUtil$(library_suffix)
EDMUtillib       = $(EDMUtillibname).a
EDMUtilstamp     = $(bin)EDMUtil.stamp
EDMUtilshstamp   = $(bin)EDMUtil.shstamp

EDMUtil :: dirs  EDMUtilLIB
	$(echo) "EDMUtil ok"

cmt_EDMUtil_has_prototypes = 1

#--------------------------------------

ifdef cmt_EDMUtil_has_prototypes

EDMUtilprototype :  ;

endif

EDMUtilcompile : $(bin)JobInfoDict.o $(bin)PassiveStream.o $(bin)FileMetaData.o $(bin)SmartRefDict.o $(bin)UniqueIDTable.o $(bin)BookEDM.o $(bin)EDMManager.o $(bin)UniqueIDTableDict.o $(bin)RootFileInter.o $(bin)SmartRef.o $(bin)JunoEDMDefinitions.o $(bin)SmartRefTable.o $(bin)InputFileManager.o $(bin)JobInfo.o $(bin)FileMetaDataDict.o $(bin)InputElementKeeper.o $(bin)SmartRefTableImpl.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

EDMUtilLIB :: $(EDMUtillib) $(EDMUtilshstamp)
	$(echo) "EDMUtil : library ok"

$(EDMUtillib) :: $(bin)JobInfoDict.o $(bin)PassiveStream.o $(bin)FileMetaData.o $(bin)SmartRefDict.o $(bin)UniqueIDTable.o $(bin)BookEDM.o $(bin)EDMManager.o $(bin)UniqueIDTableDict.o $(bin)RootFileInter.o $(bin)SmartRef.o $(bin)JunoEDMDefinitions.o $(bin)SmartRefTable.o $(bin)InputFileManager.o $(bin)JobInfo.o $(bin)FileMetaDataDict.o $(bin)InputElementKeeper.o $(bin)SmartRefTableImpl.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(EDMUtillib) $(bin)JobInfoDict.o $(bin)PassiveStream.o $(bin)FileMetaData.o $(bin)SmartRefDict.o $(bin)UniqueIDTable.o $(bin)BookEDM.o $(bin)EDMManager.o $(bin)UniqueIDTableDict.o $(bin)RootFileInter.o $(bin)SmartRef.o $(bin)JunoEDMDefinitions.o $(bin)SmartRefTable.o $(bin)InputFileManager.o $(bin)JobInfo.o $(bin)FileMetaDataDict.o $(bin)InputElementKeeper.o $(bin)SmartRefTableImpl.o
	$(lib_silent) $(ranlib) $(EDMUtillib)
	$(lib_silent) cat /dev/null >$(EDMUtilstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

#
# We add one level of dependency upon the true shared library 
# (rather than simply upon the stamp file)
# this is for cases where the shared library has not been built
# while the stamp was created (error??) 
#

$(EDMUtillibname).$(shlibsuffix) :: $(EDMUtillib) requirements $(use_requirements) $(EDMUtilstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" EDMUtil $(EDMUtil_shlibflags)
	$(lib_silent) cat /dev/null >$(EDMUtilshstamp)

$(EDMUtilshstamp) :: $(EDMUtillibname).$(shlibsuffix)
	$(lib_silent) if test -f $(EDMUtillibname).$(shlibsuffix) ; then cat /dev/null >$(EDMUtilshstamp) ; fi

EDMUtilclean ::
	$(cleanup_echo) objects EDMUtil
	$(cleanup_silent) /bin/rm -f $(bin)JobInfoDict.o $(bin)PassiveStream.o $(bin)FileMetaData.o $(bin)SmartRefDict.o $(bin)UniqueIDTable.o $(bin)BookEDM.o $(bin)EDMManager.o $(bin)UniqueIDTableDict.o $(bin)RootFileInter.o $(bin)SmartRef.o $(bin)JunoEDMDefinitions.o $(bin)SmartRefTable.o $(bin)InputFileManager.o $(bin)JobInfo.o $(bin)FileMetaDataDict.o $(bin)InputElementKeeper.o $(bin)SmartRefTableImpl.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)JobInfoDict.o $(bin)PassiveStream.o $(bin)FileMetaData.o $(bin)SmartRefDict.o $(bin)UniqueIDTable.o $(bin)BookEDM.o $(bin)EDMManager.o $(bin)UniqueIDTableDict.o $(bin)RootFileInter.o $(bin)SmartRef.o $(bin)JunoEDMDefinitions.o $(bin)SmartRefTable.o $(bin)InputFileManager.o $(bin)JobInfo.o $(bin)FileMetaDataDict.o $(bin)InputElementKeeper.o $(bin)SmartRefTableImpl.o) $(patsubst %.o,%.dep,$(bin)JobInfoDict.o $(bin)PassiveStream.o $(bin)FileMetaData.o $(bin)SmartRefDict.o $(bin)UniqueIDTable.o $(bin)BookEDM.o $(bin)EDMManager.o $(bin)UniqueIDTableDict.o $(bin)RootFileInter.o $(bin)SmartRef.o $(bin)JunoEDMDefinitions.o $(bin)SmartRefTable.o $(bin)InputFileManager.o $(bin)JobInfo.o $(bin)FileMetaDataDict.o $(bin)InputElementKeeper.o $(bin)SmartRefTableImpl.o) $(patsubst %.o,%.d.stamp,$(bin)JobInfoDict.o $(bin)PassiveStream.o $(bin)FileMetaData.o $(bin)SmartRefDict.o $(bin)UniqueIDTable.o $(bin)BookEDM.o $(bin)EDMManager.o $(bin)UniqueIDTableDict.o $(bin)RootFileInter.o $(bin)SmartRef.o $(bin)JunoEDMDefinitions.o $(bin)SmartRefTable.o $(bin)InputFileManager.o $(bin)JobInfo.o $(bin)FileMetaDataDict.o $(bin)InputElementKeeper.o $(bin)SmartRefTableImpl.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf EDMUtil_deps EDMUtil_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
EDMUtilinstallname = $(library_prefix)EDMUtil$(library_suffix).$(shlibsuffix)

EDMUtil :: EDMUtilinstall ;

install :: EDMUtilinstall ;

EDMUtilinstall :: $(install_dir)/$(EDMUtilinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(EDMUtilinstallname) :: $(bin)$(EDMUtilinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(EDMUtilinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##EDMUtilclean :: EDMUtiluninstall

uninstall :: EDMUtiluninstall ;

EDMUtiluninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(EDMUtilinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),EDMUtilprototype)

$(bin)EDMUtil_dependencies.make : $(use_requirements) $(cmt_final_setup_EDMUtil)
	$(echo) "(EDMUtil.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)JobInfoDict.cc $(src)PassiveStream.cc $(src)FileMetaData.cc $(src)SmartRefDict.cc $(src)UniqueIDTable.cc $(src)BookEDM.cc $(src)EDMManager.cc $(src)UniqueIDTableDict.cc $(src)RootFileInter.cc $(src)SmartRef.cc $(src)JunoEDMDefinitions.cc $(src)SmartRefTable.cc $(src)InputFileManager.cc $(src)JobInfo.cc $(src)FileMetaDataDict.cc $(src)InputElementKeeper.cc $(src)SmartRefTableImpl.cc -end_all $(includes) $(app_EDMUtil_cppflags) $(lib_EDMUtil_cppflags) -name=EDMUtil $? -f=$(cmt_dependencies_in_EDMUtil) -without_cmt

-include $(bin)EDMUtil_dependencies.make

endif
endif
endif

EDMUtilclean ::
	$(cleanup_silent) \rm -rf $(bin)EDMUtil_deps $(bin)EDMUtil_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JobInfoDict.d

$(bin)$(binobj)JobInfoDict.d :

$(bin)$(binobj)JobInfoDict.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)JobInfoDict.o : $(src)JobInfoDict.cc
	$(cpp_echo) $(src)JobInfoDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(JobInfoDict_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(JobInfoDict_cppflags) $(JobInfoDict_cc_cppflags)  $(src)JobInfoDict.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(JobInfoDict_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)JobInfoDict.cc

$(bin)$(binobj)JobInfoDict.o : $(JobInfoDict_cc_dependencies)
	$(cpp_echo) $(src)JobInfoDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(JobInfoDict_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(JobInfoDict_cppflags) $(JobInfoDict_cc_cppflags)  $(src)JobInfoDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PassiveStream.d

$(bin)$(binobj)PassiveStream.d :

$(bin)$(binobj)PassiveStream.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)PassiveStream.o : $(src)PassiveStream.cc
	$(cpp_echo) $(src)PassiveStream.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(PassiveStream_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(PassiveStream_cppflags) $(PassiveStream_cc_cppflags)  $(src)PassiveStream.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(PassiveStream_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)PassiveStream.cc

$(bin)$(binobj)PassiveStream.o : $(PassiveStream_cc_dependencies)
	$(cpp_echo) $(src)PassiveStream.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(PassiveStream_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(PassiveStream_cppflags) $(PassiveStream_cc_cppflags)  $(src)PassiveStream.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FileMetaData.d

$(bin)$(binobj)FileMetaData.d :

$(bin)$(binobj)FileMetaData.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)FileMetaData.o : $(src)FileMetaData.cc
	$(cpp_echo) $(src)FileMetaData.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(FileMetaData_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(FileMetaData_cppflags) $(FileMetaData_cc_cppflags)  $(src)FileMetaData.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(FileMetaData_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)FileMetaData.cc

$(bin)$(binobj)FileMetaData.o : $(FileMetaData_cc_dependencies)
	$(cpp_echo) $(src)FileMetaData.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(FileMetaData_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(FileMetaData_cppflags) $(FileMetaData_cc_cppflags)  $(src)FileMetaData.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SmartRefDict.d

$(bin)$(binobj)SmartRefDict.d :

$(bin)$(binobj)SmartRefDict.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)SmartRefDict.o : $(src)SmartRefDict.cc
	$(cpp_echo) $(src)SmartRefDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(SmartRefDict_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(SmartRefDict_cppflags) $(SmartRefDict_cc_cppflags)  $(src)SmartRefDict.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(SmartRefDict_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)SmartRefDict.cc

$(bin)$(binobj)SmartRefDict.o : $(SmartRefDict_cc_dependencies)
	$(cpp_echo) $(src)SmartRefDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(SmartRefDict_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(SmartRefDict_cppflags) $(SmartRefDict_cc_cppflags)  $(src)SmartRefDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)UniqueIDTable.d

$(bin)$(binobj)UniqueIDTable.d :

$(bin)$(binobj)UniqueIDTable.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)UniqueIDTable.o : $(src)UniqueIDTable.cc
	$(cpp_echo) $(src)UniqueIDTable.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(UniqueIDTable_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(UniqueIDTable_cppflags) $(UniqueIDTable_cc_cppflags)  $(src)UniqueIDTable.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(UniqueIDTable_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)UniqueIDTable.cc

$(bin)$(binobj)UniqueIDTable.o : $(UniqueIDTable_cc_dependencies)
	$(cpp_echo) $(src)UniqueIDTable.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(UniqueIDTable_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(UniqueIDTable_cppflags) $(UniqueIDTable_cc_cppflags)  $(src)UniqueIDTable.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BookEDM.d

$(bin)$(binobj)BookEDM.d :

$(bin)$(binobj)BookEDM.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)BookEDM.o : $(src)BookEDM.cc
	$(cpp_echo) $(src)BookEDM.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(BookEDM_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(BookEDM_cppflags) $(BookEDM_cc_cppflags)  $(src)BookEDM.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(BookEDM_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)BookEDM.cc

$(bin)$(binobj)BookEDM.o : $(BookEDM_cc_dependencies)
	$(cpp_echo) $(src)BookEDM.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(BookEDM_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(BookEDM_cppflags) $(BookEDM_cc_cppflags)  $(src)BookEDM.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EDMManager.d

$(bin)$(binobj)EDMManager.d :

$(bin)$(binobj)EDMManager.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)EDMManager.o : $(src)EDMManager.cc
	$(cpp_echo) $(src)EDMManager.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(EDMManager_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(EDMManager_cppflags) $(EDMManager_cc_cppflags)  $(src)EDMManager.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(EDMManager_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)EDMManager.cc

$(bin)$(binobj)EDMManager.o : $(EDMManager_cc_dependencies)
	$(cpp_echo) $(src)EDMManager.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(EDMManager_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(EDMManager_cppflags) $(EDMManager_cc_cppflags)  $(src)EDMManager.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)UniqueIDTableDict.d

$(bin)$(binobj)UniqueIDTableDict.d :

$(bin)$(binobj)UniqueIDTableDict.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)UniqueIDTableDict.o : $(src)UniqueIDTableDict.cc
	$(cpp_echo) $(src)UniqueIDTableDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(UniqueIDTableDict_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(UniqueIDTableDict_cppflags) $(UniqueIDTableDict_cc_cppflags)  $(src)UniqueIDTableDict.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(UniqueIDTableDict_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)UniqueIDTableDict.cc

$(bin)$(binobj)UniqueIDTableDict.o : $(UniqueIDTableDict_cc_dependencies)
	$(cpp_echo) $(src)UniqueIDTableDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(UniqueIDTableDict_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(UniqueIDTableDict_cppflags) $(UniqueIDTableDict_cc_cppflags)  $(src)UniqueIDTableDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootFileInter.d

$(bin)$(binobj)RootFileInter.d :

$(bin)$(binobj)RootFileInter.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)RootFileInter.o : $(src)RootFileInter.cc
	$(cpp_echo) $(src)RootFileInter.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(RootFileInter_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(RootFileInter_cppflags) $(RootFileInter_cc_cppflags)  $(src)RootFileInter.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(RootFileInter_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)RootFileInter.cc

$(bin)$(binobj)RootFileInter.o : $(RootFileInter_cc_dependencies)
	$(cpp_echo) $(src)RootFileInter.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(RootFileInter_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(RootFileInter_cppflags) $(RootFileInter_cc_cppflags)  $(src)RootFileInter.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SmartRef.d

$(bin)$(binobj)SmartRef.d :

$(bin)$(binobj)SmartRef.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)SmartRef.o : $(src)SmartRef.cc
	$(cpp_echo) $(src)SmartRef.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(SmartRef_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(SmartRef_cppflags) $(SmartRef_cc_cppflags)  $(src)SmartRef.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(SmartRef_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)SmartRef.cc

$(bin)$(binobj)SmartRef.o : $(SmartRef_cc_dependencies)
	$(cpp_echo) $(src)SmartRef.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(SmartRef_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(SmartRef_cppflags) $(SmartRef_cc_cppflags)  $(src)SmartRef.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JunoEDMDefinitions.d

$(bin)$(binobj)JunoEDMDefinitions.d :

$(bin)$(binobj)JunoEDMDefinitions.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)JunoEDMDefinitions.o : $(src)JunoEDMDefinitions.cc
	$(cpp_echo) $(src)JunoEDMDefinitions.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(JunoEDMDefinitions_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(JunoEDMDefinitions_cppflags) $(JunoEDMDefinitions_cc_cppflags)  $(src)JunoEDMDefinitions.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(JunoEDMDefinitions_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)JunoEDMDefinitions.cc

$(bin)$(binobj)JunoEDMDefinitions.o : $(JunoEDMDefinitions_cc_dependencies)
	$(cpp_echo) $(src)JunoEDMDefinitions.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(JunoEDMDefinitions_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(JunoEDMDefinitions_cppflags) $(JunoEDMDefinitions_cc_cppflags)  $(src)JunoEDMDefinitions.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SmartRefTable.d

$(bin)$(binobj)SmartRefTable.d :

$(bin)$(binobj)SmartRefTable.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)SmartRefTable.o : $(src)SmartRefTable.cc
	$(cpp_echo) $(src)SmartRefTable.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(SmartRefTable_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(SmartRefTable_cppflags) $(SmartRefTable_cc_cppflags)  $(src)SmartRefTable.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(SmartRefTable_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)SmartRefTable.cc

$(bin)$(binobj)SmartRefTable.o : $(SmartRefTable_cc_dependencies)
	$(cpp_echo) $(src)SmartRefTable.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(SmartRefTable_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(SmartRefTable_cppflags) $(SmartRefTable_cc_cppflags)  $(src)SmartRefTable.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)InputFileManager.d

$(bin)$(binobj)InputFileManager.d :

$(bin)$(binobj)InputFileManager.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)InputFileManager.o : $(src)InputFileManager.cc
	$(cpp_echo) $(src)InputFileManager.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(InputFileManager_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(InputFileManager_cppflags) $(InputFileManager_cc_cppflags)  $(src)InputFileManager.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(InputFileManager_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)InputFileManager.cc

$(bin)$(binobj)InputFileManager.o : $(InputFileManager_cc_dependencies)
	$(cpp_echo) $(src)InputFileManager.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(InputFileManager_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(InputFileManager_cppflags) $(InputFileManager_cc_cppflags)  $(src)InputFileManager.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JobInfo.d

$(bin)$(binobj)JobInfo.d :

$(bin)$(binobj)JobInfo.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)JobInfo.o : $(src)JobInfo.cc
	$(cpp_echo) $(src)JobInfo.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(JobInfo_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(JobInfo_cppflags) $(JobInfo_cc_cppflags)  $(src)JobInfo.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(JobInfo_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)JobInfo.cc

$(bin)$(binobj)JobInfo.o : $(JobInfo_cc_dependencies)
	$(cpp_echo) $(src)JobInfo.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(JobInfo_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(JobInfo_cppflags) $(JobInfo_cc_cppflags)  $(src)JobInfo.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FileMetaDataDict.d

$(bin)$(binobj)FileMetaDataDict.d :

$(bin)$(binobj)FileMetaDataDict.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)FileMetaDataDict.o : $(src)FileMetaDataDict.cc
	$(cpp_echo) $(src)FileMetaDataDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(FileMetaDataDict_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(FileMetaDataDict_cppflags) $(FileMetaDataDict_cc_cppflags)  $(src)FileMetaDataDict.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(FileMetaDataDict_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)FileMetaDataDict.cc

$(bin)$(binobj)FileMetaDataDict.o : $(FileMetaDataDict_cc_dependencies)
	$(cpp_echo) $(src)FileMetaDataDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(FileMetaDataDict_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(FileMetaDataDict_cppflags) $(FileMetaDataDict_cc_cppflags)  $(src)FileMetaDataDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)InputElementKeeper.d

$(bin)$(binobj)InputElementKeeper.d :

$(bin)$(binobj)InputElementKeeper.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)InputElementKeeper.o : $(src)InputElementKeeper.cc
	$(cpp_echo) $(src)InputElementKeeper.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(InputElementKeeper_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(InputElementKeeper_cppflags) $(InputElementKeeper_cc_cppflags)  $(src)InputElementKeeper.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(InputElementKeeper_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)InputElementKeeper.cc

$(bin)$(binobj)InputElementKeeper.o : $(InputElementKeeper_cc_dependencies)
	$(cpp_echo) $(src)InputElementKeeper.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(InputElementKeeper_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(InputElementKeeper_cppflags) $(InputElementKeeper_cc_cppflags)  $(src)InputElementKeeper.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EDMUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SmartRefTableImpl.d

$(bin)$(binobj)SmartRefTableImpl.d :

$(bin)$(binobj)SmartRefTableImpl.o : $(cmt_final_setup_EDMUtil)

$(bin)$(binobj)SmartRefTableImpl.o : $(src)SmartRefTableImpl.cc
	$(cpp_echo) $(src)SmartRefTableImpl.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(SmartRefTableImpl_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(SmartRefTableImpl_cppflags) $(SmartRefTableImpl_cc_cppflags)  $(src)SmartRefTableImpl.cc
endif
endif

else
$(bin)EDMUtil_dependencies.make : $(SmartRefTableImpl_cc_dependencies)

$(bin)EDMUtil_dependencies.make : $(src)SmartRefTableImpl.cc

$(bin)$(binobj)SmartRefTableImpl.o : $(SmartRefTableImpl_cc_dependencies)
	$(cpp_echo) $(src)SmartRefTableImpl.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EDMUtil_pp_cppflags) $(lib_EDMUtil_pp_cppflags) $(SmartRefTableImpl_pp_cppflags) $(use_cppflags) $(EDMUtil_cppflags) $(lib_EDMUtil_cppflags) $(SmartRefTableImpl_cppflags) $(SmartRefTableImpl_cc_cppflags)  $(src)SmartRefTableImpl.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: EDMUtilclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(EDMUtil.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

EDMUtilclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library EDMUtil
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)EDMUtil$(library_suffix).a $(library_prefix)EDMUtil$(library_suffix).$(shlibsuffix) EDMUtil.stamp EDMUtil.shstamp
#-- end of cleanup_library ---------------

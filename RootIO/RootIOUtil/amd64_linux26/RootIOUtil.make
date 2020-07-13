#-- start of make_header -----------------

#====================================
#  Library RootIOUtil
#
#   Generated Fri Jul 10 19:18:00 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootIOUtil_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootIOUtil_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootIOUtil

RootIOUtil_tag = $(tag)

#cmt_local_tagfile_RootIOUtil = $(RootIOUtil_tag)_RootIOUtil.make
cmt_local_tagfile_RootIOUtil = $(bin)$(RootIOUtil_tag)_RootIOUtil.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootIOUtil_tag = $(tag)

#cmt_local_tagfile_RootIOUtil = $(RootIOUtil_tag).make
cmt_local_tagfile_RootIOUtil = $(bin)$(RootIOUtil_tag).make

endif

include $(cmt_local_tagfile_RootIOUtil)
#-include $(cmt_local_tagfile_RootIOUtil)

ifdef cmt_RootIOUtil_has_target_tag

cmt_final_setup_RootIOUtil = $(bin)setup_RootIOUtil.make
cmt_dependencies_in_RootIOUtil = $(bin)dependencies_RootIOUtil.in
#cmt_final_setup_RootIOUtil = $(bin)RootIOUtil_RootIOUtilsetup.make
cmt_local_RootIOUtil_makefile = $(bin)RootIOUtil.make

else

cmt_final_setup_RootIOUtil = $(bin)setup.make
cmt_dependencies_in_RootIOUtil = $(bin)dependencies.in
#cmt_final_setup_RootIOUtil = $(bin)RootIOUtilsetup.make
cmt_local_RootIOUtil_makefile = $(bin)RootIOUtil.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootIOUtilsetup.make

#RootIOUtil :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootIOUtil'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootIOUtil/
#RootIOUtil::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RootIOUtillibname   = $(bin)$(library_prefix)RootIOUtil$(library_suffix)
RootIOUtillib       = $(RootIOUtillibname).a
RootIOUtilstamp     = $(bin)RootIOUtil.stamp
RootIOUtilshstamp   = $(bin)RootIOUtil.shstamp

RootIOUtil :: dirs  RootIOUtilLIB
	$(echo) "RootIOUtil ok"

cmt_RootIOUtil_has_prototypes = 1

#--------------------------------------

ifdef cmt_RootIOUtil_has_prototypes

RootIOUtilprototype :  ;

endif

RootIOUtilcompile : $(bin)RootOutputFileManager.o $(bin)RootFileReader.o $(bin)NavTreeList.o $(bin)RootFileWriter.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

RootIOUtilLIB :: $(RootIOUtillib) $(RootIOUtilshstamp)
	$(echo) "RootIOUtil : library ok"

$(RootIOUtillib) :: $(bin)RootOutputFileManager.o $(bin)RootFileReader.o $(bin)NavTreeList.o $(bin)RootFileWriter.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(RootIOUtillib) $(bin)RootOutputFileManager.o $(bin)RootFileReader.o $(bin)NavTreeList.o $(bin)RootFileWriter.o
	$(lib_silent) $(ranlib) $(RootIOUtillib)
	$(lib_silent) cat /dev/null >$(RootIOUtilstamp)

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

$(RootIOUtillibname).$(shlibsuffix) :: $(RootIOUtillib) requirements $(use_requirements) $(RootIOUtilstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" RootIOUtil $(RootIOUtil_shlibflags)
	$(lib_silent) cat /dev/null >$(RootIOUtilshstamp)

$(RootIOUtilshstamp) :: $(RootIOUtillibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RootIOUtillibname).$(shlibsuffix) ; then cat /dev/null >$(RootIOUtilshstamp) ; fi

RootIOUtilclean ::
	$(cleanup_echo) objects RootIOUtil
	$(cleanup_silent) /bin/rm -f $(bin)RootOutputFileManager.o $(bin)RootFileReader.o $(bin)NavTreeList.o $(bin)RootFileWriter.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)RootOutputFileManager.o $(bin)RootFileReader.o $(bin)NavTreeList.o $(bin)RootFileWriter.o) $(patsubst %.o,%.dep,$(bin)RootOutputFileManager.o $(bin)RootFileReader.o $(bin)NavTreeList.o $(bin)RootFileWriter.o) $(patsubst %.o,%.d.stamp,$(bin)RootOutputFileManager.o $(bin)RootFileReader.o $(bin)NavTreeList.o $(bin)RootFileWriter.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RootIOUtil_deps RootIOUtil_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RootIOUtilinstallname = $(library_prefix)RootIOUtil$(library_suffix).$(shlibsuffix)

RootIOUtil :: RootIOUtilinstall ;

install :: RootIOUtilinstall ;

RootIOUtilinstall :: $(install_dir)/$(RootIOUtilinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RootIOUtilinstallname) :: $(bin)$(RootIOUtilinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootIOUtilinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RootIOUtilclean :: RootIOUtiluninstall

uninstall :: RootIOUtiluninstall ;

RootIOUtiluninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootIOUtilinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),RootIOUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),RootIOUtilprototype)

$(bin)RootIOUtil_dependencies.make : $(use_requirements) $(cmt_final_setup_RootIOUtil)
	$(echo) "(RootIOUtil.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)RootOutputFileManager.cc $(src)RootFileReader.cc $(src)NavTreeList.cc $(src)RootFileWriter.cc -end_all $(includes) $(app_RootIOUtil_cppflags) $(lib_RootIOUtil_cppflags) -name=RootIOUtil $? -f=$(cmt_dependencies_in_RootIOUtil) -without_cmt

-include $(bin)RootIOUtil_dependencies.make

endif
endif
endif

RootIOUtilclean ::
	$(cleanup_silent) \rm -rf $(bin)RootIOUtil_deps $(bin)RootIOUtil_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootOutputFileManager.d

$(bin)$(binobj)RootOutputFileManager.d :

$(bin)$(binobj)RootOutputFileManager.o : $(cmt_final_setup_RootIOUtil)

$(bin)$(binobj)RootOutputFileManager.o : $(src)RootOutputFileManager.cc
	$(cpp_echo) $(src)RootOutputFileManager.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOUtil_pp_cppflags) $(lib_RootIOUtil_pp_cppflags) $(RootOutputFileManager_pp_cppflags) $(use_cppflags) $(RootIOUtil_cppflags) $(lib_RootIOUtil_cppflags) $(RootOutputFileManager_cppflags) $(RootOutputFileManager_cc_cppflags)  $(src)RootOutputFileManager.cc
endif
endif

else
$(bin)RootIOUtil_dependencies.make : $(RootOutputFileManager_cc_dependencies)

$(bin)RootIOUtil_dependencies.make : $(src)RootOutputFileManager.cc

$(bin)$(binobj)RootOutputFileManager.o : $(RootOutputFileManager_cc_dependencies)
	$(cpp_echo) $(src)RootOutputFileManager.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOUtil_pp_cppflags) $(lib_RootIOUtil_pp_cppflags) $(RootOutputFileManager_pp_cppflags) $(use_cppflags) $(RootIOUtil_cppflags) $(lib_RootIOUtil_cppflags) $(RootOutputFileManager_cppflags) $(RootOutputFileManager_cc_cppflags)  $(src)RootOutputFileManager.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootFileReader.d

$(bin)$(binobj)RootFileReader.d :

$(bin)$(binobj)RootFileReader.o : $(cmt_final_setup_RootIOUtil)

$(bin)$(binobj)RootFileReader.o : $(src)RootFileReader.cc
	$(cpp_echo) $(src)RootFileReader.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOUtil_pp_cppflags) $(lib_RootIOUtil_pp_cppflags) $(RootFileReader_pp_cppflags) $(use_cppflags) $(RootIOUtil_cppflags) $(lib_RootIOUtil_cppflags) $(RootFileReader_cppflags) $(RootFileReader_cc_cppflags)  $(src)RootFileReader.cc
endif
endif

else
$(bin)RootIOUtil_dependencies.make : $(RootFileReader_cc_dependencies)

$(bin)RootIOUtil_dependencies.make : $(src)RootFileReader.cc

$(bin)$(binobj)RootFileReader.o : $(RootFileReader_cc_dependencies)
	$(cpp_echo) $(src)RootFileReader.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOUtil_pp_cppflags) $(lib_RootIOUtil_pp_cppflags) $(RootFileReader_pp_cppflags) $(use_cppflags) $(RootIOUtil_cppflags) $(lib_RootIOUtil_cppflags) $(RootFileReader_cppflags) $(RootFileReader_cc_cppflags)  $(src)RootFileReader.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NavTreeList.d

$(bin)$(binobj)NavTreeList.d :

$(bin)$(binobj)NavTreeList.o : $(cmt_final_setup_RootIOUtil)

$(bin)$(binobj)NavTreeList.o : $(src)NavTreeList.cc
	$(cpp_echo) $(src)NavTreeList.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOUtil_pp_cppflags) $(lib_RootIOUtil_pp_cppflags) $(NavTreeList_pp_cppflags) $(use_cppflags) $(RootIOUtil_cppflags) $(lib_RootIOUtil_cppflags) $(NavTreeList_cppflags) $(NavTreeList_cc_cppflags)  $(src)NavTreeList.cc
endif
endif

else
$(bin)RootIOUtil_dependencies.make : $(NavTreeList_cc_dependencies)

$(bin)RootIOUtil_dependencies.make : $(src)NavTreeList.cc

$(bin)$(binobj)NavTreeList.o : $(NavTreeList_cc_dependencies)
	$(cpp_echo) $(src)NavTreeList.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOUtil_pp_cppflags) $(lib_RootIOUtil_pp_cppflags) $(NavTreeList_pp_cppflags) $(use_cppflags) $(RootIOUtil_cppflags) $(lib_RootIOUtil_cppflags) $(NavTreeList_cppflags) $(NavTreeList_cc_cppflags)  $(src)NavTreeList.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOUtilclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootFileWriter.d

$(bin)$(binobj)RootFileWriter.d :

$(bin)$(binobj)RootFileWriter.o : $(cmt_final_setup_RootIOUtil)

$(bin)$(binobj)RootFileWriter.o : $(src)RootFileWriter.cc
	$(cpp_echo) $(src)RootFileWriter.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOUtil_pp_cppflags) $(lib_RootIOUtil_pp_cppflags) $(RootFileWriter_pp_cppflags) $(use_cppflags) $(RootIOUtil_cppflags) $(lib_RootIOUtil_cppflags) $(RootFileWriter_cppflags) $(RootFileWriter_cc_cppflags)  $(src)RootFileWriter.cc
endif
endif

else
$(bin)RootIOUtil_dependencies.make : $(RootFileWriter_cc_dependencies)

$(bin)RootIOUtil_dependencies.make : $(src)RootFileWriter.cc

$(bin)$(binobj)RootFileWriter.o : $(RootFileWriter_cc_dependencies)
	$(cpp_echo) $(src)RootFileWriter.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOUtil_pp_cppflags) $(lib_RootIOUtil_pp_cppflags) $(RootFileWriter_pp_cppflags) $(use_cppflags) $(RootIOUtil_cppflags) $(lib_RootIOUtil_cppflags) $(RootFileWriter_cppflags) $(RootFileWriter_cc_cppflags)  $(src)RootFileWriter.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RootIOUtilclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootIOUtil.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootIOUtilclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RootIOUtil
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RootIOUtil$(library_suffix).a $(library_prefix)RootIOUtil$(library_suffix).$(shlibsuffix) RootIOUtil.stamp RootIOUtil.shstamp
#-- end of cleanup_library ---------------

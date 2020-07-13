#-- start of make_header -----------------

#====================================
#  Library RootIOTools
#
#   Generated Fri Jul 10 19:27:02 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootIOTools_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootIOTools_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootIOTools

RootIOTools_tag = $(tag)

#cmt_local_tagfile_RootIOTools = $(RootIOTools_tag)_RootIOTools.make
cmt_local_tagfile_RootIOTools = $(bin)$(RootIOTools_tag)_RootIOTools.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootIOTools_tag = $(tag)

#cmt_local_tagfile_RootIOTools = $(RootIOTools_tag).make
cmt_local_tagfile_RootIOTools = $(bin)$(RootIOTools_tag).make

endif

include $(cmt_local_tagfile_RootIOTools)
#-include $(cmt_local_tagfile_RootIOTools)

ifdef cmt_RootIOTools_has_target_tag

cmt_final_setup_RootIOTools = $(bin)setup_RootIOTools.make
cmt_dependencies_in_RootIOTools = $(bin)dependencies_RootIOTools.in
#cmt_final_setup_RootIOTools = $(bin)RootIOTools_RootIOToolssetup.make
cmt_local_RootIOTools_makefile = $(bin)RootIOTools.make

else

cmt_final_setup_RootIOTools = $(bin)setup.make
cmt_dependencies_in_RootIOTools = $(bin)dependencies.in
#cmt_final_setup_RootIOTools = $(bin)RootIOToolssetup.make
cmt_local_RootIOTools_makefile = $(bin)RootIOTools.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootIOToolssetup.make

#RootIOTools :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootIOTools'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootIOTools/
#RootIOTools::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RootIOToolslibname   = $(bin)$(library_prefix)RootIOTools$(library_suffix)
RootIOToolslib       = $(RootIOToolslibname).a
RootIOToolsstamp     = $(bin)RootIOTools.stamp
RootIOToolsshstamp   = $(bin)RootIOTools.shstamp

RootIOTools :: dirs  RootIOToolsLIB
	$(echo) "RootIOTools ok"

cmt_RootIOTools_has_prototypes = 1

#--------------------------------------

ifdef cmt_RootIOTools_has_prototypes

RootIOToolsprototype :  ;

endif

RootIOToolscompile : $(bin)UniqueIDTableMerger.o $(bin)FileMetaDataMerger.o $(bin)MergeRootFilesAlg.o $(bin)TreeLooper.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

RootIOToolsLIB :: $(RootIOToolslib) $(RootIOToolsshstamp)
	$(echo) "RootIOTools : library ok"

$(RootIOToolslib) :: $(bin)UniqueIDTableMerger.o $(bin)FileMetaDataMerger.o $(bin)MergeRootFilesAlg.o $(bin)TreeLooper.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(RootIOToolslib) $(bin)UniqueIDTableMerger.o $(bin)FileMetaDataMerger.o $(bin)MergeRootFilesAlg.o $(bin)TreeLooper.o
	$(lib_silent) $(ranlib) $(RootIOToolslib)
	$(lib_silent) cat /dev/null >$(RootIOToolsstamp)

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

$(RootIOToolslibname).$(shlibsuffix) :: $(RootIOToolslib) requirements $(use_requirements) $(RootIOToolsstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" RootIOTools $(RootIOTools_shlibflags)
	$(lib_silent) cat /dev/null >$(RootIOToolsshstamp)

$(RootIOToolsshstamp) :: $(RootIOToolslibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RootIOToolslibname).$(shlibsuffix) ; then cat /dev/null >$(RootIOToolsshstamp) ; fi

RootIOToolsclean ::
	$(cleanup_echo) objects RootIOTools
	$(cleanup_silent) /bin/rm -f $(bin)UniqueIDTableMerger.o $(bin)FileMetaDataMerger.o $(bin)MergeRootFilesAlg.o $(bin)TreeLooper.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)UniqueIDTableMerger.o $(bin)FileMetaDataMerger.o $(bin)MergeRootFilesAlg.o $(bin)TreeLooper.o) $(patsubst %.o,%.dep,$(bin)UniqueIDTableMerger.o $(bin)FileMetaDataMerger.o $(bin)MergeRootFilesAlg.o $(bin)TreeLooper.o) $(patsubst %.o,%.d.stamp,$(bin)UniqueIDTableMerger.o $(bin)FileMetaDataMerger.o $(bin)MergeRootFilesAlg.o $(bin)TreeLooper.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RootIOTools_deps RootIOTools_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RootIOToolsinstallname = $(library_prefix)RootIOTools$(library_suffix).$(shlibsuffix)

RootIOTools :: RootIOToolsinstall ;

install :: RootIOToolsinstall ;

RootIOToolsinstall :: $(install_dir)/$(RootIOToolsinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RootIOToolsinstallname) :: $(bin)$(RootIOToolsinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootIOToolsinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RootIOToolsclean :: RootIOToolsuninstall

uninstall :: RootIOToolsuninstall ;

RootIOToolsuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootIOToolsinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),RootIOToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),RootIOToolsprototype)

$(bin)RootIOTools_dependencies.make : $(use_requirements) $(cmt_final_setup_RootIOTools)
	$(echo) "(RootIOTools.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)UniqueIDTableMerger.cc $(src)FileMetaDataMerger.cc $(src)MergeRootFilesAlg.cc $(src)TreeLooper.cc -end_all $(includes) $(app_RootIOTools_cppflags) $(lib_RootIOTools_cppflags) -name=RootIOTools $? -f=$(cmt_dependencies_in_RootIOTools) -without_cmt

-include $(bin)RootIOTools_dependencies.make

endif
endif
endif

RootIOToolsclean ::
	$(cleanup_silent) \rm -rf $(bin)RootIOTools_deps $(bin)RootIOTools_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)UniqueIDTableMerger.d

$(bin)$(binobj)UniqueIDTableMerger.d :

$(bin)$(binobj)UniqueIDTableMerger.o : $(cmt_final_setup_RootIOTools)

$(bin)$(binobj)UniqueIDTableMerger.o : $(src)UniqueIDTableMerger.cc
	$(cpp_echo) $(src)UniqueIDTableMerger.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTools_pp_cppflags) $(lib_RootIOTools_pp_cppflags) $(UniqueIDTableMerger_pp_cppflags) $(use_cppflags) $(RootIOTools_cppflags) $(lib_RootIOTools_cppflags) $(UniqueIDTableMerger_cppflags) $(UniqueIDTableMerger_cc_cppflags)  $(src)UniqueIDTableMerger.cc
endif
endif

else
$(bin)RootIOTools_dependencies.make : $(UniqueIDTableMerger_cc_dependencies)

$(bin)RootIOTools_dependencies.make : $(src)UniqueIDTableMerger.cc

$(bin)$(binobj)UniqueIDTableMerger.o : $(UniqueIDTableMerger_cc_dependencies)
	$(cpp_echo) $(src)UniqueIDTableMerger.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTools_pp_cppflags) $(lib_RootIOTools_pp_cppflags) $(UniqueIDTableMerger_pp_cppflags) $(use_cppflags) $(RootIOTools_cppflags) $(lib_RootIOTools_cppflags) $(UniqueIDTableMerger_cppflags) $(UniqueIDTableMerger_cc_cppflags)  $(src)UniqueIDTableMerger.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FileMetaDataMerger.d

$(bin)$(binobj)FileMetaDataMerger.d :

$(bin)$(binobj)FileMetaDataMerger.o : $(cmt_final_setup_RootIOTools)

$(bin)$(binobj)FileMetaDataMerger.o : $(src)FileMetaDataMerger.cc
	$(cpp_echo) $(src)FileMetaDataMerger.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTools_pp_cppflags) $(lib_RootIOTools_pp_cppflags) $(FileMetaDataMerger_pp_cppflags) $(use_cppflags) $(RootIOTools_cppflags) $(lib_RootIOTools_cppflags) $(FileMetaDataMerger_cppflags) $(FileMetaDataMerger_cc_cppflags)  $(src)FileMetaDataMerger.cc
endif
endif

else
$(bin)RootIOTools_dependencies.make : $(FileMetaDataMerger_cc_dependencies)

$(bin)RootIOTools_dependencies.make : $(src)FileMetaDataMerger.cc

$(bin)$(binobj)FileMetaDataMerger.o : $(FileMetaDataMerger_cc_dependencies)
	$(cpp_echo) $(src)FileMetaDataMerger.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTools_pp_cppflags) $(lib_RootIOTools_pp_cppflags) $(FileMetaDataMerger_pp_cppflags) $(use_cppflags) $(RootIOTools_cppflags) $(lib_RootIOTools_cppflags) $(FileMetaDataMerger_cppflags) $(FileMetaDataMerger_cc_cppflags)  $(src)FileMetaDataMerger.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MergeRootFilesAlg.d

$(bin)$(binobj)MergeRootFilesAlg.d :

$(bin)$(binobj)MergeRootFilesAlg.o : $(cmt_final_setup_RootIOTools)

$(bin)$(binobj)MergeRootFilesAlg.o : $(src)MergeRootFilesAlg.cc
	$(cpp_echo) $(src)MergeRootFilesAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTools_pp_cppflags) $(lib_RootIOTools_pp_cppflags) $(MergeRootFilesAlg_pp_cppflags) $(use_cppflags) $(RootIOTools_cppflags) $(lib_RootIOTools_cppflags) $(MergeRootFilesAlg_cppflags) $(MergeRootFilesAlg_cc_cppflags)  $(src)MergeRootFilesAlg.cc
endif
endif

else
$(bin)RootIOTools_dependencies.make : $(MergeRootFilesAlg_cc_dependencies)

$(bin)RootIOTools_dependencies.make : $(src)MergeRootFilesAlg.cc

$(bin)$(binobj)MergeRootFilesAlg.o : $(MergeRootFilesAlg_cc_dependencies)
	$(cpp_echo) $(src)MergeRootFilesAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTools_pp_cppflags) $(lib_RootIOTools_pp_cppflags) $(MergeRootFilesAlg_pp_cppflags) $(use_cppflags) $(RootIOTools_cppflags) $(lib_RootIOTools_cppflags) $(MergeRootFilesAlg_cppflags) $(MergeRootFilesAlg_cc_cppflags)  $(src)MergeRootFilesAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TreeLooper.d

$(bin)$(binobj)TreeLooper.d :

$(bin)$(binobj)TreeLooper.o : $(cmt_final_setup_RootIOTools)

$(bin)$(binobj)TreeLooper.o : $(src)TreeLooper.cc
	$(cpp_echo) $(src)TreeLooper.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTools_pp_cppflags) $(lib_RootIOTools_pp_cppflags) $(TreeLooper_pp_cppflags) $(use_cppflags) $(RootIOTools_cppflags) $(lib_RootIOTools_cppflags) $(TreeLooper_cppflags) $(TreeLooper_cc_cppflags)  $(src)TreeLooper.cc
endif
endif

else
$(bin)RootIOTools_dependencies.make : $(TreeLooper_cc_dependencies)

$(bin)RootIOTools_dependencies.make : $(src)TreeLooper.cc

$(bin)$(binobj)TreeLooper.o : $(TreeLooper_cc_dependencies)
	$(cpp_echo) $(src)TreeLooper.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTools_pp_cppflags) $(lib_RootIOTools_pp_cppflags) $(TreeLooper_pp_cppflags) $(use_cppflags) $(RootIOTools_cppflags) $(lib_RootIOTools_cppflags) $(TreeLooper_cppflags) $(TreeLooper_cc_cppflags)  $(src)TreeLooper.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RootIOToolsclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootIOTools.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootIOToolsclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RootIOTools
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RootIOTools$(library_suffix).a $(library_prefix)RootIOTools$(library_suffix).$(shlibsuffix) RootIOTools.stamp RootIOTools.shstamp
#-- end of cleanup_library ---------------

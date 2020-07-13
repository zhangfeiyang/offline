#-- start of make_header -----------------

#====================================
#  Library EvtNavigator
#
#   Generated Fri Jul 10 19:17:56 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_EvtNavigator_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_EvtNavigator_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_EvtNavigator

EvtNavigator_tag = $(tag)

#cmt_local_tagfile_EvtNavigator = $(EvtNavigator_tag)_EvtNavigator.make
cmt_local_tagfile_EvtNavigator = $(bin)$(EvtNavigator_tag)_EvtNavigator.make

else

tags      = $(tag),$(CMTEXTRATAGS)

EvtNavigator_tag = $(tag)

#cmt_local_tagfile_EvtNavigator = $(EvtNavigator_tag).make
cmt_local_tagfile_EvtNavigator = $(bin)$(EvtNavigator_tag).make

endif

include $(cmt_local_tagfile_EvtNavigator)
#-include $(cmt_local_tagfile_EvtNavigator)

ifdef cmt_EvtNavigator_has_target_tag

cmt_final_setup_EvtNavigator = $(bin)setup_EvtNavigator.make
cmt_dependencies_in_EvtNavigator = $(bin)dependencies_EvtNavigator.in
#cmt_final_setup_EvtNavigator = $(bin)EvtNavigator_EvtNavigatorsetup.make
cmt_local_EvtNavigator_makefile = $(bin)EvtNavigator.make

else

cmt_final_setup_EvtNavigator = $(bin)setup.make
cmt_dependencies_in_EvtNavigator = $(bin)dependencies.in
#cmt_final_setup_EvtNavigator = $(bin)EvtNavigatorsetup.make
cmt_local_EvtNavigator_makefile = $(bin)EvtNavigator.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)EvtNavigatorsetup.make

#EvtNavigator :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'EvtNavigator'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = EvtNavigator/
#EvtNavigator::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

EvtNavigatorlibname   = $(bin)$(library_prefix)EvtNavigator$(library_suffix)
EvtNavigatorlib       = $(EvtNavigatorlibname).a
EvtNavigatorstamp     = $(bin)EvtNavigator.stamp
EvtNavigatorshstamp   = $(bin)EvtNavigator.shstamp

EvtNavigator :: dirs  EvtNavigatorLIB
	$(echo) "EvtNavigator ok"

cmt_EvtNavigator_has_prototypes = 1

#--------------------------------------

ifdef cmt_EvtNavigator_has_prototypes

EvtNavigatorprototype :  ;

endif

EvtNavigatorcompile : $(bin)EvtNavigatorDict.o $(bin)EvtNavigator.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

EvtNavigatorLIB :: $(EvtNavigatorlib) $(EvtNavigatorshstamp)
	$(echo) "EvtNavigator : library ok"

$(EvtNavigatorlib) :: $(bin)EvtNavigatorDict.o $(bin)EvtNavigator.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(EvtNavigatorlib) $(bin)EvtNavigatorDict.o $(bin)EvtNavigator.o
	$(lib_silent) $(ranlib) $(EvtNavigatorlib)
	$(lib_silent) cat /dev/null >$(EvtNavigatorstamp)

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

$(EvtNavigatorlibname).$(shlibsuffix) :: $(EvtNavigatorlib) requirements $(use_requirements) $(EvtNavigatorstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" EvtNavigator $(EvtNavigator_shlibflags)
	$(lib_silent) cat /dev/null >$(EvtNavigatorshstamp)

$(EvtNavigatorshstamp) :: $(EvtNavigatorlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(EvtNavigatorlibname).$(shlibsuffix) ; then cat /dev/null >$(EvtNavigatorshstamp) ; fi

EvtNavigatorclean ::
	$(cleanup_echo) objects EvtNavigator
	$(cleanup_silent) /bin/rm -f $(bin)EvtNavigatorDict.o $(bin)EvtNavigator.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)EvtNavigatorDict.o $(bin)EvtNavigator.o) $(patsubst %.o,%.dep,$(bin)EvtNavigatorDict.o $(bin)EvtNavigator.o) $(patsubst %.o,%.d.stamp,$(bin)EvtNavigatorDict.o $(bin)EvtNavigator.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf EvtNavigator_deps EvtNavigator_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
EvtNavigatorinstallname = $(library_prefix)EvtNavigator$(library_suffix).$(shlibsuffix)

EvtNavigator :: EvtNavigatorinstall ;

install :: EvtNavigatorinstall ;

EvtNavigatorinstall :: $(install_dir)/$(EvtNavigatorinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(EvtNavigatorinstallname) :: $(bin)$(EvtNavigatorinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(EvtNavigatorinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##EvtNavigatorclean :: EvtNavigatoruninstall

uninstall :: EvtNavigatoruninstall ;

EvtNavigatoruninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(EvtNavigatorinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),EvtNavigatorclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),EvtNavigatorprototype)

$(bin)EvtNavigator_dependencies.make : $(use_requirements) $(cmt_final_setup_EvtNavigator)
	$(echo) "(EvtNavigator.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)EvtNavigatorDict.cc $(src)EvtNavigator.cc -end_all $(includes) $(app_EvtNavigator_cppflags) $(lib_EvtNavigator_cppflags) -name=EvtNavigator $? -f=$(cmt_dependencies_in_EvtNavigator) -without_cmt

-include $(bin)EvtNavigator_dependencies.make

endif
endif
endif

EvtNavigatorclean ::
	$(cleanup_silent) \rm -rf $(bin)EvtNavigator_deps $(bin)EvtNavigator_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EvtNavigatorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EvtNavigatorDict.d

$(bin)$(binobj)EvtNavigatorDict.d :

$(bin)$(binobj)EvtNavigatorDict.o : $(cmt_final_setup_EvtNavigator)

$(bin)$(binobj)EvtNavigatorDict.o : $(src)EvtNavigatorDict.cc
	$(cpp_echo) $(src)EvtNavigatorDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EvtNavigator_pp_cppflags) $(lib_EvtNavigator_pp_cppflags) $(EvtNavigatorDict_pp_cppflags) $(use_cppflags) $(EvtNavigator_cppflags) $(lib_EvtNavigator_cppflags) $(EvtNavigatorDict_cppflags) $(EvtNavigatorDict_cc_cppflags)  $(src)EvtNavigatorDict.cc
endif
endif

else
$(bin)EvtNavigator_dependencies.make : $(EvtNavigatorDict_cc_dependencies)

$(bin)EvtNavigator_dependencies.make : $(src)EvtNavigatorDict.cc

$(bin)$(binobj)EvtNavigatorDict.o : $(EvtNavigatorDict_cc_dependencies)
	$(cpp_echo) $(src)EvtNavigatorDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EvtNavigator_pp_cppflags) $(lib_EvtNavigator_pp_cppflags) $(EvtNavigatorDict_pp_cppflags) $(use_cppflags) $(EvtNavigator_cppflags) $(lib_EvtNavigator_cppflags) $(EvtNavigatorDict_cppflags) $(EvtNavigatorDict_cc_cppflags)  $(src)EvtNavigatorDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EvtNavigatorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EvtNavigator.d

$(bin)$(binobj)EvtNavigator.d :

$(bin)$(binobj)EvtNavigator.o : $(cmt_final_setup_EvtNavigator)

$(bin)$(binobj)EvtNavigator.o : $(src)EvtNavigator.cc
	$(cpp_echo) $(src)EvtNavigator.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EvtNavigator_pp_cppflags) $(lib_EvtNavigator_pp_cppflags) $(EvtNavigator_pp_cppflags) $(use_cppflags) $(EvtNavigator_cppflags) $(lib_EvtNavigator_cppflags) $(EvtNavigator_cppflags) $(EvtNavigator_cc_cppflags)  $(src)EvtNavigator.cc
endif
endif

else
$(bin)EvtNavigator_dependencies.make : $(EvtNavigator_cc_dependencies)

$(bin)EvtNavigator_dependencies.make : $(src)EvtNavigator.cc

$(bin)$(binobj)EvtNavigator.o : $(EvtNavigator_cc_dependencies)
	$(cpp_echo) $(src)EvtNavigator.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EvtNavigator_pp_cppflags) $(lib_EvtNavigator_pp_cppflags) $(EvtNavigator_pp_cppflags) $(use_cppflags) $(EvtNavigator_cppflags) $(lib_EvtNavigator_cppflags) $(EvtNavigator_cppflags) $(EvtNavigator_cc_cppflags)  $(src)EvtNavigator.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: EvtNavigatorclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(EvtNavigator.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

EvtNavigatorclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library EvtNavigator
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)EvtNavigator$(library_suffix).a $(library_prefix)EvtNavigator$(library_suffix).$(shlibsuffix) EvtNavigator.stamp EvtNavigator.shstamp
#-- end of cleanup_library ---------------

#-- start of make_header -----------------

#====================================
#  Library PhyEvent
#
#   Generated Fri Jul 10 19:18:44 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PhyEvent_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PhyEvent_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PhyEvent

PhyEvent_tag = $(tag)

#cmt_local_tagfile_PhyEvent = $(PhyEvent_tag)_PhyEvent.make
cmt_local_tagfile_PhyEvent = $(bin)$(PhyEvent_tag)_PhyEvent.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PhyEvent_tag = $(tag)

#cmt_local_tagfile_PhyEvent = $(PhyEvent_tag).make
cmt_local_tagfile_PhyEvent = $(bin)$(PhyEvent_tag).make

endif

include $(cmt_local_tagfile_PhyEvent)
#-include $(cmt_local_tagfile_PhyEvent)

ifdef cmt_PhyEvent_has_target_tag

cmt_final_setup_PhyEvent = $(bin)setup_PhyEvent.make
cmt_dependencies_in_PhyEvent = $(bin)dependencies_PhyEvent.in
#cmt_final_setup_PhyEvent = $(bin)PhyEvent_PhyEventsetup.make
cmt_local_PhyEvent_makefile = $(bin)PhyEvent.make

else

cmt_final_setup_PhyEvent = $(bin)setup.make
cmt_dependencies_in_PhyEvent = $(bin)dependencies.in
#cmt_final_setup_PhyEvent = $(bin)PhyEventsetup.make
cmt_local_PhyEvent_makefile = $(bin)PhyEvent.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PhyEventsetup.make

#PhyEvent :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PhyEvent'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PhyEvent/
#PhyEvent::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

PhyEventlibname   = $(bin)$(library_prefix)PhyEvent$(library_suffix)
PhyEventlib       = $(PhyEventlibname).a
PhyEventstamp     = $(bin)PhyEvent.stamp
PhyEventshstamp   = $(bin)PhyEvent.shstamp

PhyEvent :: dirs  PhyEventLIB
	$(echo) "PhyEvent ok"

cmt_PhyEvent_has_prototypes = 1

#--------------------------------------

ifdef cmt_PhyEvent_has_prototypes

PhyEventprototype :  ;

endif

PhyEventcompile : $(bin)PhyHeaderDict.o $(bin)PhyEvent.o $(bin)PhyEventDict.o $(bin)PhyHeader.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

PhyEventLIB :: $(PhyEventlib) $(PhyEventshstamp)
	$(echo) "PhyEvent : library ok"

$(PhyEventlib) :: $(bin)PhyHeaderDict.o $(bin)PhyEvent.o $(bin)PhyEventDict.o $(bin)PhyHeader.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(PhyEventlib) $(bin)PhyHeaderDict.o $(bin)PhyEvent.o $(bin)PhyEventDict.o $(bin)PhyHeader.o
	$(lib_silent) $(ranlib) $(PhyEventlib)
	$(lib_silent) cat /dev/null >$(PhyEventstamp)

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

$(PhyEventlibname).$(shlibsuffix) :: $(PhyEventlib) requirements $(use_requirements) $(PhyEventstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" PhyEvent $(PhyEvent_shlibflags)
	$(lib_silent) cat /dev/null >$(PhyEventshstamp)

$(PhyEventshstamp) :: $(PhyEventlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(PhyEventlibname).$(shlibsuffix) ; then cat /dev/null >$(PhyEventshstamp) ; fi

PhyEventclean ::
	$(cleanup_echo) objects PhyEvent
	$(cleanup_silent) /bin/rm -f $(bin)PhyHeaderDict.o $(bin)PhyEvent.o $(bin)PhyEventDict.o $(bin)PhyHeader.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PhyHeaderDict.o $(bin)PhyEvent.o $(bin)PhyEventDict.o $(bin)PhyHeader.o) $(patsubst %.o,%.dep,$(bin)PhyHeaderDict.o $(bin)PhyEvent.o $(bin)PhyEventDict.o $(bin)PhyHeader.o) $(patsubst %.o,%.d.stamp,$(bin)PhyHeaderDict.o $(bin)PhyEvent.o $(bin)PhyEventDict.o $(bin)PhyHeader.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf PhyEvent_deps PhyEvent_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
PhyEventinstallname = $(library_prefix)PhyEvent$(library_suffix).$(shlibsuffix)

PhyEvent :: PhyEventinstall ;

install :: PhyEventinstall ;

PhyEventinstall :: $(install_dir)/$(PhyEventinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(PhyEventinstallname) :: $(bin)$(PhyEventinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PhyEventinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##PhyEventclean :: PhyEventuninstall

uninstall :: PhyEventuninstall ;

PhyEventuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PhyEventinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),PhyEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),PhyEventprototype)

$(bin)PhyEvent_dependencies.make : $(use_requirements) $(cmt_final_setup_PhyEvent)
	$(echo) "(PhyEvent.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)PhyHeaderDict.cc $(src)PhyEvent.cc $(src)PhyEventDict.cc $(src)PhyHeader.cc -end_all $(includes) $(app_PhyEvent_cppflags) $(lib_PhyEvent_cppflags) -name=PhyEvent $? -f=$(cmt_dependencies_in_PhyEvent) -without_cmt

-include $(bin)PhyEvent_dependencies.make

endif
endif
endif

PhyEventclean ::
	$(cleanup_silent) \rm -rf $(bin)PhyEvent_deps $(bin)PhyEvent_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PhyEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PhyHeaderDict.d

$(bin)$(binobj)PhyHeaderDict.d :

$(bin)$(binobj)PhyHeaderDict.o : $(cmt_final_setup_PhyEvent)

$(bin)$(binobj)PhyHeaderDict.o : $(src)PhyHeaderDict.cc
	$(cpp_echo) $(src)PhyHeaderDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PhyEvent_pp_cppflags) $(lib_PhyEvent_pp_cppflags) $(PhyHeaderDict_pp_cppflags) $(use_cppflags) $(PhyEvent_cppflags) $(lib_PhyEvent_cppflags) $(PhyHeaderDict_cppflags) $(PhyHeaderDict_cc_cppflags)  $(src)PhyHeaderDict.cc
endif
endif

else
$(bin)PhyEvent_dependencies.make : $(PhyHeaderDict_cc_dependencies)

$(bin)PhyEvent_dependencies.make : $(src)PhyHeaderDict.cc

$(bin)$(binobj)PhyHeaderDict.o : $(PhyHeaderDict_cc_dependencies)
	$(cpp_echo) $(src)PhyHeaderDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PhyEvent_pp_cppflags) $(lib_PhyEvent_pp_cppflags) $(PhyHeaderDict_pp_cppflags) $(use_cppflags) $(PhyEvent_cppflags) $(lib_PhyEvent_cppflags) $(PhyHeaderDict_cppflags) $(PhyHeaderDict_cc_cppflags)  $(src)PhyHeaderDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PhyEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PhyEvent.d

$(bin)$(binobj)PhyEvent.d :

$(bin)$(binobj)PhyEvent.o : $(cmt_final_setup_PhyEvent)

$(bin)$(binobj)PhyEvent.o : $(src)PhyEvent.cc
	$(cpp_echo) $(src)PhyEvent.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PhyEvent_pp_cppflags) $(lib_PhyEvent_pp_cppflags) $(PhyEvent_pp_cppflags) $(use_cppflags) $(PhyEvent_cppflags) $(lib_PhyEvent_cppflags) $(PhyEvent_cppflags) $(PhyEvent_cc_cppflags)  $(src)PhyEvent.cc
endif
endif

else
$(bin)PhyEvent_dependencies.make : $(PhyEvent_cc_dependencies)

$(bin)PhyEvent_dependencies.make : $(src)PhyEvent.cc

$(bin)$(binobj)PhyEvent.o : $(PhyEvent_cc_dependencies)
	$(cpp_echo) $(src)PhyEvent.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PhyEvent_pp_cppflags) $(lib_PhyEvent_pp_cppflags) $(PhyEvent_pp_cppflags) $(use_cppflags) $(PhyEvent_cppflags) $(lib_PhyEvent_cppflags) $(PhyEvent_cppflags) $(PhyEvent_cc_cppflags)  $(src)PhyEvent.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PhyEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PhyEventDict.d

$(bin)$(binobj)PhyEventDict.d :

$(bin)$(binobj)PhyEventDict.o : $(cmt_final_setup_PhyEvent)

$(bin)$(binobj)PhyEventDict.o : $(src)PhyEventDict.cc
	$(cpp_echo) $(src)PhyEventDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PhyEvent_pp_cppflags) $(lib_PhyEvent_pp_cppflags) $(PhyEventDict_pp_cppflags) $(use_cppflags) $(PhyEvent_cppflags) $(lib_PhyEvent_cppflags) $(PhyEventDict_cppflags) $(PhyEventDict_cc_cppflags)  $(src)PhyEventDict.cc
endif
endif

else
$(bin)PhyEvent_dependencies.make : $(PhyEventDict_cc_dependencies)

$(bin)PhyEvent_dependencies.make : $(src)PhyEventDict.cc

$(bin)$(binobj)PhyEventDict.o : $(PhyEventDict_cc_dependencies)
	$(cpp_echo) $(src)PhyEventDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PhyEvent_pp_cppflags) $(lib_PhyEvent_pp_cppflags) $(PhyEventDict_pp_cppflags) $(use_cppflags) $(PhyEvent_cppflags) $(lib_PhyEvent_cppflags) $(PhyEventDict_cppflags) $(PhyEventDict_cc_cppflags)  $(src)PhyEventDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PhyEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PhyHeader.d

$(bin)$(binobj)PhyHeader.d :

$(bin)$(binobj)PhyHeader.o : $(cmt_final_setup_PhyEvent)

$(bin)$(binobj)PhyHeader.o : $(src)PhyHeader.cc
	$(cpp_echo) $(src)PhyHeader.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PhyEvent_pp_cppflags) $(lib_PhyEvent_pp_cppflags) $(PhyHeader_pp_cppflags) $(use_cppflags) $(PhyEvent_cppflags) $(lib_PhyEvent_cppflags) $(PhyHeader_cppflags) $(PhyHeader_cc_cppflags)  $(src)PhyHeader.cc
endif
endif

else
$(bin)PhyEvent_dependencies.make : $(PhyHeader_cc_dependencies)

$(bin)PhyEvent_dependencies.make : $(src)PhyHeader.cc

$(bin)$(binobj)PhyHeader.o : $(PhyHeader_cc_dependencies)
	$(cpp_echo) $(src)PhyHeader.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PhyEvent_pp_cppflags) $(lib_PhyEvent_pp_cppflags) $(PhyHeader_pp_cppflags) $(use_cppflags) $(PhyEvent_cppflags) $(lib_PhyEvent_cppflags) $(PhyHeader_cppflags) $(PhyHeader_cc_cppflags)  $(src)PhyHeader.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: PhyEventclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PhyEvent.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PhyEventclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library PhyEvent
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)PhyEvent$(library_suffix).a $(library_prefix)PhyEvent$(library_suffix).$(shlibsuffix) PhyEvent.stamp PhyEvent.shstamp
#-- end of cleanup_library ---------------

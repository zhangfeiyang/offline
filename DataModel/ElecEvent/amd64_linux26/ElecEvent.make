#-- start of make_header -----------------

#====================================
#  Library ElecEvent
#
#   Generated Fri Jul 10 19:20:29 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_ElecEvent_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ElecEvent_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ElecEvent

ElecEvent_tag = $(tag)

#cmt_local_tagfile_ElecEvent = $(ElecEvent_tag)_ElecEvent.make
cmt_local_tagfile_ElecEvent = $(bin)$(ElecEvent_tag)_ElecEvent.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ElecEvent_tag = $(tag)

#cmt_local_tagfile_ElecEvent = $(ElecEvent_tag).make
cmt_local_tagfile_ElecEvent = $(bin)$(ElecEvent_tag).make

endif

include $(cmt_local_tagfile_ElecEvent)
#-include $(cmt_local_tagfile_ElecEvent)

ifdef cmt_ElecEvent_has_target_tag

cmt_final_setup_ElecEvent = $(bin)setup_ElecEvent.make
cmt_dependencies_in_ElecEvent = $(bin)dependencies_ElecEvent.in
#cmt_final_setup_ElecEvent = $(bin)ElecEvent_ElecEventsetup.make
cmt_local_ElecEvent_makefile = $(bin)ElecEvent.make

else

cmt_final_setup_ElecEvent = $(bin)setup.make
cmt_dependencies_in_ElecEvent = $(bin)dependencies.in
#cmt_final_setup_ElecEvent = $(bin)ElecEventsetup.make
cmt_local_ElecEvent_makefile = $(bin)ElecEvent.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ElecEventsetup.make

#ElecEvent :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ElecEvent'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ElecEvent/
#ElecEvent::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

ElecEventlibname   = $(bin)$(library_prefix)ElecEvent$(library_suffix)
ElecEventlib       = $(ElecEventlibname).a
ElecEventstamp     = $(bin)ElecEvent.stamp
ElecEventshstamp   = $(bin)ElecEvent.shstamp

ElecEvent :: dirs  ElecEventLIB
	$(echo) "ElecEvent ok"

cmt_ElecEvent_has_prototypes = 1

#--------------------------------------

ifdef cmt_ElecEvent_has_prototypes

ElecEventprototype :  ;

endif

ElecEventcompile : $(bin)ElecHeaderDict.o $(bin)SpmtElecEvent.o $(bin)ElecFeeCrateDict.o $(bin)ElecFeeChannel.o $(bin)ElecEvent.o $(bin)SpmtElecAbcBlockDict.o $(bin)ElecFeeCrate.o $(bin)ElecHeader.o $(bin)SpmtElecEventDict.o $(bin)ElecFeeChannelDict.o $(bin)ElecEventDict.o $(bin)SpmtElecAbcBlock.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

ElecEventLIB :: $(ElecEventlib) $(ElecEventshstamp)
	$(echo) "ElecEvent : library ok"

$(ElecEventlib) :: $(bin)ElecHeaderDict.o $(bin)SpmtElecEvent.o $(bin)ElecFeeCrateDict.o $(bin)ElecFeeChannel.o $(bin)ElecEvent.o $(bin)SpmtElecAbcBlockDict.o $(bin)ElecFeeCrate.o $(bin)ElecHeader.o $(bin)SpmtElecEventDict.o $(bin)ElecFeeChannelDict.o $(bin)ElecEventDict.o $(bin)SpmtElecAbcBlock.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(ElecEventlib) $(bin)ElecHeaderDict.o $(bin)SpmtElecEvent.o $(bin)ElecFeeCrateDict.o $(bin)ElecFeeChannel.o $(bin)ElecEvent.o $(bin)SpmtElecAbcBlockDict.o $(bin)ElecFeeCrate.o $(bin)ElecHeader.o $(bin)SpmtElecEventDict.o $(bin)ElecFeeChannelDict.o $(bin)ElecEventDict.o $(bin)SpmtElecAbcBlock.o
	$(lib_silent) $(ranlib) $(ElecEventlib)
	$(lib_silent) cat /dev/null >$(ElecEventstamp)

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

$(ElecEventlibname).$(shlibsuffix) :: $(ElecEventlib) requirements $(use_requirements) $(ElecEventstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" ElecEvent $(ElecEvent_shlibflags)
	$(lib_silent) cat /dev/null >$(ElecEventshstamp)

$(ElecEventshstamp) :: $(ElecEventlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(ElecEventlibname).$(shlibsuffix) ; then cat /dev/null >$(ElecEventshstamp) ; fi

ElecEventclean ::
	$(cleanup_echo) objects ElecEvent
	$(cleanup_silent) /bin/rm -f $(bin)ElecHeaderDict.o $(bin)SpmtElecEvent.o $(bin)ElecFeeCrateDict.o $(bin)ElecFeeChannel.o $(bin)ElecEvent.o $(bin)SpmtElecAbcBlockDict.o $(bin)ElecFeeCrate.o $(bin)ElecHeader.o $(bin)SpmtElecEventDict.o $(bin)ElecFeeChannelDict.o $(bin)ElecEventDict.o $(bin)SpmtElecAbcBlock.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)ElecHeaderDict.o $(bin)SpmtElecEvent.o $(bin)ElecFeeCrateDict.o $(bin)ElecFeeChannel.o $(bin)ElecEvent.o $(bin)SpmtElecAbcBlockDict.o $(bin)ElecFeeCrate.o $(bin)ElecHeader.o $(bin)SpmtElecEventDict.o $(bin)ElecFeeChannelDict.o $(bin)ElecEventDict.o $(bin)SpmtElecAbcBlock.o) $(patsubst %.o,%.dep,$(bin)ElecHeaderDict.o $(bin)SpmtElecEvent.o $(bin)ElecFeeCrateDict.o $(bin)ElecFeeChannel.o $(bin)ElecEvent.o $(bin)SpmtElecAbcBlockDict.o $(bin)ElecFeeCrate.o $(bin)ElecHeader.o $(bin)SpmtElecEventDict.o $(bin)ElecFeeChannelDict.o $(bin)ElecEventDict.o $(bin)SpmtElecAbcBlock.o) $(patsubst %.o,%.d.stamp,$(bin)ElecHeaderDict.o $(bin)SpmtElecEvent.o $(bin)ElecFeeCrateDict.o $(bin)ElecFeeChannel.o $(bin)ElecEvent.o $(bin)SpmtElecAbcBlockDict.o $(bin)ElecFeeCrate.o $(bin)ElecHeader.o $(bin)SpmtElecEventDict.o $(bin)ElecFeeChannelDict.o $(bin)ElecEventDict.o $(bin)SpmtElecAbcBlock.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf ElecEvent_deps ElecEvent_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
ElecEventinstallname = $(library_prefix)ElecEvent$(library_suffix).$(shlibsuffix)

ElecEvent :: ElecEventinstall ;

install :: ElecEventinstall ;

ElecEventinstall :: $(install_dir)/$(ElecEventinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(ElecEventinstallname) :: $(bin)$(ElecEventinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(ElecEventinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##ElecEventclean :: ElecEventuninstall

uninstall :: ElecEventuninstall ;

ElecEventuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(ElecEventinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),ElecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),ElecEventprototype)

$(bin)ElecEvent_dependencies.make : $(use_requirements) $(cmt_final_setup_ElecEvent)
	$(echo) "(ElecEvent.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)ElecHeaderDict.cc $(src)SpmtElecEvent.cc $(src)ElecFeeCrateDict.cc $(src)ElecFeeChannel.cc $(src)ElecEvent.cc $(src)SpmtElecAbcBlockDict.cc $(src)ElecFeeCrate.cc $(src)ElecHeader.cc $(src)SpmtElecEventDict.cc $(src)ElecFeeChannelDict.cc $(src)ElecEventDict.cc $(src)SpmtElecAbcBlock.cc -end_all $(includes) $(app_ElecEvent_cppflags) $(lib_ElecEvent_cppflags) -name=ElecEvent $? -f=$(cmt_dependencies_in_ElecEvent) -without_cmt

-include $(bin)ElecEvent_dependencies.make

endif
endif
endif

ElecEventclean ::
	$(cleanup_silent) \rm -rf $(bin)ElecEvent_deps $(bin)ElecEvent_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ElecHeaderDict.d

$(bin)$(binobj)ElecHeaderDict.d :

$(bin)$(binobj)ElecHeaderDict.o : $(cmt_final_setup_ElecEvent)

$(bin)$(binobj)ElecHeaderDict.o : $(src)ElecHeaderDict.cc
	$(cpp_echo) $(src)ElecHeaderDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecHeaderDict_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecHeaderDict_cppflags) $(ElecHeaderDict_cc_cppflags)  $(src)ElecHeaderDict.cc
endif
endif

else
$(bin)ElecEvent_dependencies.make : $(ElecHeaderDict_cc_dependencies)

$(bin)ElecEvent_dependencies.make : $(src)ElecHeaderDict.cc

$(bin)$(binobj)ElecHeaderDict.o : $(ElecHeaderDict_cc_dependencies)
	$(cpp_echo) $(src)ElecHeaderDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecHeaderDict_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecHeaderDict_cppflags) $(ElecHeaderDict_cc_cppflags)  $(src)ElecHeaderDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SpmtElecEvent.d

$(bin)$(binobj)SpmtElecEvent.d :

$(bin)$(binobj)SpmtElecEvent.o : $(cmt_final_setup_ElecEvent)

$(bin)$(binobj)SpmtElecEvent.o : $(src)SpmtElecEvent.cc
	$(cpp_echo) $(src)SpmtElecEvent.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(SpmtElecEvent_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(SpmtElecEvent_cppflags) $(SpmtElecEvent_cc_cppflags)  $(src)SpmtElecEvent.cc
endif
endif

else
$(bin)ElecEvent_dependencies.make : $(SpmtElecEvent_cc_dependencies)

$(bin)ElecEvent_dependencies.make : $(src)SpmtElecEvent.cc

$(bin)$(binobj)SpmtElecEvent.o : $(SpmtElecEvent_cc_dependencies)
	$(cpp_echo) $(src)SpmtElecEvent.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(SpmtElecEvent_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(SpmtElecEvent_cppflags) $(SpmtElecEvent_cc_cppflags)  $(src)SpmtElecEvent.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ElecFeeCrateDict.d

$(bin)$(binobj)ElecFeeCrateDict.d :

$(bin)$(binobj)ElecFeeCrateDict.o : $(cmt_final_setup_ElecEvent)

$(bin)$(binobj)ElecFeeCrateDict.o : $(src)ElecFeeCrateDict.cc
	$(cpp_echo) $(src)ElecFeeCrateDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecFeeCrateDict_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecFeeCrateDict_cppflags) $(ElecFeeCrateDict_cc_cppflags)  $(src)ElecFeeCrateDict.cc
endif
endif

else
$(bin)ElecEvent_dependencies.make : $(ElecFeeCrateDict_cc_dependencies)

$(bin)ElecEvent_dependencies.make : $(src)ElecFeeCrateDict.cc

$(bin)$(binobj)ElecFeeCrateDict.o : $(ElecFeeCrateDict_cc_dependencies)
	$(cpp_echo) $(src)ElecFeeCrateDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecFeeCrateDict_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecFeeCrateDict_cppflags) $(ElecFeeCrateDict_cc_cppflags)  $(src)ElecFeeCrateDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ElecFeeChannel.d

$(bin)$(binobj)ElecFeeChannel.d :

$(bin)$(binobj)ElecFeeChannel.o : $(cmt_final_setup_ElecEvent)

$(bin)$(binobj)ElecFeeChannel.o : $(src)ElecFeeChannel.cc
	$(cpp_echo) $(src)ElecFeeChannel.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecFeeChannel_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecFeeChannel_cppflags) $(ElecFeeChannel_cc_cppflags)  $(src)ElecFeeChannel.cc
endif
endif

else
$(bin)ElecEvent_dependencies.make : $(ElecFeeChannel_cc_dependencies)

$(bin)ElecEvent_dependencies.make : $(src)ElecFeeChannel.cc

$(bin)$(binobj)ElecFeeChannel.o : $(ElecFeeChannel_cc_dependencies)
	$(cpp_echo) $(src)ElecFeeChannel.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecFeeChannel_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecFeeChannel_cppflags) $(ElecFeeChannel_cc_cppflags)  $(src)ElecFeeChannel.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ElecEvent.d

$(bin)$(binobj)ElecEvent.d :

$(bin)$(binobj)ElecEvent.o : $(cmt_final_setup_ElecEvent)

$(bin)$(binobj)ElecEvent.o : $(src)ElecEvent.cc
	$(cpp_echo) $(src)ElecEvent.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecEvent_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecEvent_cppflags) $(ElecEvent_cc_cppflags)  $(src)ElecEvent.cc
endif
endif

else
$(bin)ElecEvent_dependencies.make : $(ElecEvent_cc_dependencies)

$(bin)ElecEvent_dependencies.make : $(src)ElecEvent.cc

$(bin)$(binobj)ElecEvent.o : $(ElecEvent_cc_dependencies)
	$(cpp_echo) $(src)ElecEvent.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecEvent_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecEvent_cppflags) $(ElecEvent_cc_cppflags)  $(src)ElecEvent.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SpmtElecAbcBlockDict.d

$(bin)$(binobj)SpmtElecAbcBlockDict.d :

$(bin)$(binobj)SpmtElecAbcBlockDict.o : $(cmt_final_setup_ElecEvent)

$(bin)$(binobj)SpmtElecAbcBlockDict.o : $(src)SpmtElecAbcBlockDict.cc
	$(cpp_echo) $(src)SpmtElecAbcBlockDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(SpmtElecAbcBlockDict_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(SpmtElecAbcBlockDict_cppflags) $(SpmtElecAbcBlockDict_cc_cppflags)  $(src)SpmtElecAbcBlockDict.cc
endif
endif

else
$(bin)ElecEvent_dependencies.make : $(SpmtElecAbcBlockDict_cc_dependencies)

$(bin)ElecEvent_dependencies.make : $(src)SpmtElecAbcBlockDict.cc

$(bin)$(binobj)SpmtElecAbcBlockDict.o : $(SpmtElecAbcBlockDict_cc_dependencies)
	$(cpp_echo) $(src)SpmtElecAbcBlockDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(SpmtElecAbcBlockDict_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(SpmtElecAbcBlockDict_cppflags) $(SpmtElecAbcBlockDict_cc_cppflags)  $(src)SpmtElecAbcBlockDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ElecFeeCrate.d

$(bin)$(binobj)ElecFeeCrate.d :

$(bin)$(binobj)ElecFeeCrate.o : $(cmt_final_setup_ElecEvent)

$(bin)$(binobj)ElecFeeCrate.o : $(src)ElecFeeCrate.cc
	$(cpp_echo) $(src)ElecFeeCrate.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecFeeCrate_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecFeeCrate_cppflags) $(ElecFeeCrate_cc_cppflags)  $(src)ElecFeeCrate.cc
endif
endif

else
$(bin)ElecEvent_dependencies.make : $(ElecFeeCrate_cc_dependencies)

$(bin)ElecEvent_dependencies.make : $(src)ElecFeeCrate.cc

$(bin)$(binobj)ElecFeeCrate.o : $(ElecFeeCrate_cc_dependencies)
	$(cpp_echo) $(src)ElecFeeCrate.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecFeeCrate_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecFeeCrate_cppflags) $(ElecFeeCrate_cc_cppflags)  $(src)ElecFeeCrate.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ElecHeader.d

$(bin)$(binobj)ElecHeader.d :

$(bin)$(binobj)ElecHeader.o : $(cmt_final_setup_ElecEvent)

$(bin)$(binobj)ElecHeader.o : $(src)ElecHeader.cc
	$(cpp_echo) $(src)ElecHeader.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecHeader_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecHeader_cppflags) $(ElecHeader_cc_cppflags)  $(src)ElecHeader.cc
endif
endif

else
$(bin)ElecEvent_dependencies.make : $(ElecHeader_cc_dependencies)

$(bin)ElecEvent_dependencies.make : $(src)ElecHeader.cc

$(bin)$(binobj)ElecHeader.o : $(ElecHeader_cc_dependencies)
	$(cpp_echo) $(src)ElecHeader.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecHeader_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecHeader_cppflags) $(ElecHeader_cc_cppflags)  $(src)ElecHeader.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SpmtElecEventDict.d

$(bin)$(binobj)SpmtElecEventDict.d :

$(bin)$(binobj)SpmtElecEventDict.o : $(cmt_final_setup_ElecEvent)

$(bin)$(binobj)SpmtElecEventDict.o : $(src)SpmtElecEventDict.cc
	$(cpp_echo) $(src)SpmtElecEventDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(SpmtElecEventDict_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(SpmtElecEventDict_cppflags) $(SpmtElecEventDict_cc_cppflags)  $(src)SpmtElecEventDict.cc
endif
endif

else
$(bin)ElecEvent_dependencies.make : $(SpmtElecEventDict_cc_dependencies)

$(bin)ElecEvent_dependencies.make : $(src)SpmtElecEventDict.cc

$(bin)$(binobj)SpmtElecEventDict.o : $(SpmtElecEventDict_cc_dependencies)
	$(cpp_echo) $(src)SpmtElecEventDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(SpmtElecEventDict_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(SpmtElecEventDict_cppflags) $(SpmtElecEventDict_cc_cppflags)  $(src)SpmtElecEventDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ElecFeeChannelDict.d

$(bin)$(binobj)ElecFeeChannelDict.d :

$(bin)$(binobj)ElecFeeChannelDict.o : $(cmt_final_setup_ElecEvent)

$(bin)$(binobj)ElecFeeChannelDict.o : $(src)ElecFeeChannelDict.cc
	$(cpp_echo) $(src)ElecFeeChannelDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecFeeChannelDict_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecFeeChannelDict_cppflags) $(ElecFeeChannelDict_cc_cppflags)  $(src)ElecFeeChannelDict.cc
endif
endif

else
$(bin)ElecEvent_dependencies.make : $(ElecFeeChannelDict_cc_dependencies)

$(bin)ElecEvent_dependencies.make : $(src)ElecFeeChannelDict.cc

$(bin)$(binobj)ElecFeeChannelDict.o : $(ElecFeeChannelDict_cc_dependencies)
	$(cpp_echo) $(src)ElecFeeChannelDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecFeeChannelDict_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecFeeChannelDict_cppflags) $(ElecFeeChannelDict_cc_cppflags)  $(src)ElecFeeChannelDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ElecEventDict.d

$(bin)$(binobj)ElecEventDict.d :

$(bin)$(binobj)ElecEventDict.o : $(cmt_final_setup_ElecEvent)

$(bin)$(binobj)ElecEventDict.o : $(src)ElecEventDict.cc
	$(cpp_echo) $(src)ElecEventDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecEventDict_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecEventDict_cppflags) $(ElecEventDict_cc_cppflags)  $(src)ElecEventDict.cc
endif
endif

else
$(bin)ElecEvent_dependencies.make : $(ElecEventDict_cc_dependencies)

$(bin)ElecEvent_dependencies.make : $(src)ElecEventDict.cc

$(bin)$(binobj)ElecEventDict.o : $(ElecEventDict_cc_dependencies)
	$(cpp_echo) $(src)ElecEventDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(ElecEventDict_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(ElecEventDict_cppflags) $(ElecEventDict_cc_cppflags)  $(src)ElecEventDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SpmtElecAbcBlock.d

$(bin)$(binobj)SpmtElecAbcBlock.d :

$(bin)$(binobj)SpmtElecAbcBlock.o : $(cmt_final_setup_ElecEvent)

$(bin)$(binobj)SpmtElecAbcBlock.o : $(src)SpmtElecAbcBlock.cc
	$(cpp_echo) $(src)SpmtElecAbcBlock.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(SpmtElecAbcBlock_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(SpmtElecAbcBlock_cppflags) $(SpmtElecAbcBlock_cc_cppflags)  $(src)SpmtElecAbcBlock.cc
endif
endif

else
$(bin)ElecEvent_dependencies.make : $(SpmtElecAbcBlock_cc_dependencies)

$(bin)ElecEvent_dependencies.make : $(src)SpmtElecAbcBlock.cc

$(bin)$(binobj)SpmtElecAbcBlock.o : $(SpmtElecAbcBlock_cc_dependencies)
	$(cpp_echo) $(src)SpmtElecAbcBlock.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecEvent_pp_cppflags) $(lib_ElecEvent_pp_cppflags) $(SpmtElecAbcBlock_pp_cppflags) $(use_cppflags) $(ElecEvent_cppflags) $(lib_ElecEvent_cppflags) $(SpmtElecAbcBlock_cppflags) $(SpmtElecAbcBlock_cc_cppflags)  $(src)SpmtElecAbcBlock.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: ElecEventclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ElecEvent.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ElecEventclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library ElecEvent
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)ElecEvent$(library_suffix).a $(library_prefix)ElecEvent$(library_suffix).$(shlibsuffix) ElecEvent.stamp ElecEvent.shstamp
#-- end of cleanup_library ---------------

#-- start of make_header -----------------

#====================================
#  Library CalibEvent
#
#   Generated Fri Jul 10 19:18:50 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_CalibEvent_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_CalibEvent_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_CalibEvent

CalibEvent_tag = $(tag)

#cmt_local_tagfile_CalibEvent = $(CalibEvent_tag)_CalibEvent.make
cmt_local_tagfile_CalibEvent = $(bin)$(CalibEvent_tag)_CalibEvent.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CalibEvent_tag = $(tag)

#cmt_local_tagfile_CalibEvent = $(CalibEvent_tag).make
cmt_local_tagfile_CalibEvent = $(bin)$(CalibEvent_tag).make

endif

include $(cmt_local_tagfile_CalibEvent)
#-include $(cmt_local_tagfile_CalibEvent)

ifdef cmt_CalibEvent_has_target_tag

cmt_final_setup_CalibEvent = $(bin)setup_CalibEvent.make
cmt_dependencies_in_CalibEvent = $(bin)dependencies_CalibEvent.in
#cmt_final_setup_CalibEvent = $(bin)CalibEvent_CalibEventsetup.make
cmt_local_CalibEvent_makefile = $(bin)CalibEvent.make

else

cmt_final_setup_CalibEvent = $(bin)setup.make
cmt_dependencies_in_CalibEvent = $(bin)dependencies.in
#cmt_final_setup_CalibEvent = $(bin)CalibEventsetup.make
cmt_local_CalibEvent_makefile = $(bin)CalibEvent.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CalibEventsetup.make

#CalibEvent :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'CalibEvent'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = CalibEvent/
#CalibEvent::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

CalibEventlibname   = $(bin)$(library_prefix)CalibEvent$(library_suffix)
CalibEventlib       = $(CalibEventlibname).a
CalibEventstamp     = $(bin)CalibEvent.stamp
CalibEventshstamp   = $(bin)CalibEvent.shstamp

CalibEvent :: dirs  CalibEventLIB
	$(echo) "CalibEvent ok"

cmt_CalibEvent_has_prototypes = 1

#--------------------------------------

ifdef cmt_CalibEvent_has_prototypes

CalibEventprototype :  ;

endif

CalibEventcompile : $(bin)TTCalibEventDict.o $(bin)CalibPMTChannelDict.o $(bin)CalibEventDict.o $(bin)TTCalibEvent.o $(bin)CalibTTChannelDict.o $(bin)CalibTTChannel.o $(bin)CalibHeaderDict.o $(bin)CalibPMTChannel.o $(bin)CalibEvent.o $(bin)CalibHeader.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

CalibEventLIB :: $(CalibEventlib) $(CalibEventshstamp)
	$(echo) "CalibEvent : library ok"

$(CalibEventlib) :: $(bin)TTCalibEventDict.o $(bin)CalibPMTChannelDict.o $(bin)CalibEventDict.o $(bin)TTCalibEvent.o $(bin)CalibTTChannelDict.o $(bin)CalibTTChannel.o $(bin)CalibHeaderDict.o $(bin)CalibPMTChannel.o $(bin)CalibEvent.o $(bin)CalibHeader.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(CalibEventlib) $(bin)TTCalibEventDict.o $(bin)CalibPMTChannelDict.o $(bin)CalibEventDict.o $(bin)TTCalibEvent.o $(bin)CalibTTChannelDict.o $(bin)CalibTTChannel.o $(bin)CalibHeaderDict.o $(bin)CalibPMTChannel.o $(bin)CalibEvent.o $(bin)CalibHeader.o
	$(lib_silent) $(ranlib) $(CalibEventlib)
	$(lib_silent) cat /dev/null >$(CalibEventstamp)

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

$(CalibEventlibname).$(shlibsuffix) :: $(CalibEventlib) requirements $(use_requirements) $(CalibEventstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" CalibEvent $(CalibEvent_shlibflags)
	$(lib_silent) cat /dev/null >$(CalibEventshstamp)

$(CalibEventshstamp) :: $(CalibEventlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(CalibEventlibname).$(shlibsuffix) ; then cat /dev/null >$(CalibEventshstamp) ; fi

CalibEventclean ::
	$(cleanup_echo) objects CalibEvent
	$(cleanup_silent) /bin/rm -f $(bin)TTCalibEventDict.o $(bin)CalibPMTChannelDict.o $(bin)CalibEventDict.o $(bin)TTCalibEvent.o $(bin)CalibTTChannelDict.o $(bin)CalibTTChannel.o $(bin)CalibHeaderDict.o $(bin)CalibPMTChannel.o $(bin)CalibEvent.o $(bin)CalibHeader.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)TTCalibEventDict.o $(bin)CalibPMTChannelDict.o $(bin)CalibEventDict.o $(bin)TTCalibEvent.o $(bin)CalibTTChannelDict.o $(bin)CalibTTChannel.o $(bin)CalibHeaderDict.o $(bin)CalibPMTChannel.o $(bin)CalibEvent.o $(bin)CalibHeader.o) $(patsubst %.o,%.dep,$(bin)TTCalibEventDict.o $(bin)CalibPMTChannelDict.o $(bin)CalibEventDict.o $(bin)TTCalibEvent.o $(bin)CalibTTChannelDict.o $(bin)CalibTTChannel.o $(bin)CalibHeaderDict.o $(bin)CalibPMTChannel.o $(bin)CalibEvent.o $(bin)CalibHeader.o) $(patsubst %.o,%.d.stamp,$(bin)TTCalibEventDict.o $(bin)CalibPMTChannelDict.o $(bin)CalibEventDict.o $(bin)TTCalibEvent.o $(bin)CalibTTChannelDict.o $(bin)CalibTTChannel.o $(bin)CalibHeaderDict.o $(bin)CalibPMTChannel.o $(bin)CalibEvent.o $(bin)CalibHeader.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf CalibEvent_deps CalibEvent_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
CalibEventinstallname = $(library_prefix)CalibEvent$(library_suffix).$(shlibsuffix)

CalibEvent :: CalibEventinstall ;

install :: CalibEventinstall ;

CalibEventinstall :: $(install_dir)/$(CalibEventinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(CalibEventinstallname) :: $(bin)$(CalibEventinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(CalibEventinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##CalibEventclean :: CalibEventuninstall

uninstall :: CalibEventuninstall ;

CalibEventuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(CalibEventinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),CalibEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),CalibEventprototype)

$(bin)CalibEvent_dependencies.make : $(use_requirements) $(cmt_final_setup_CalibEvent)
	$(echo) "(CalibEvent.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)TTCalibEventDict.cc $(src)CalibPMTChannelDict.cc $(src)CalibEventDict.cc $(src)TTCalibEvent.cc $(src)CalibTTChannelDict.cc $(src)CalibTTChannel.cc $(src)CalibHeaderDict.cc $(src)CalibPMTChannel.cc $(src)CalibEvent.cc $(src)CalibHeader.cc -end_all $(includes) $(app_CalibEvent_cppflags) $(lib_CalibEvent_cppflags) -name=CalibEvent $? -f=$(cmt_dependencies_in_CalibEvent) -without_cmt

-include $(bin)CalibEvent_dependencies.make

endif
endif
endif

CalibEventclean ::
	$(cleanup_silent) \rm -rf $(bin)CalibEvent_deps $(bin)CalibEvent_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CalibEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TTCalibEventDict.d

$(bin)$(binobj)TTCalibEventDict.d :

$(bin)$(binobj)TTCalibEventDict.o : $(cmt_final_setup_CalibEvent)

$(bin)$(binobj)TTCalibEventDict.o : $(src)TTCalibEventDict.cc
	$(cpp_echo) $(src)TTCalibEventDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(TTCalibEventDict_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(TTCalibEventDict_cppflags) $(TTCalibEventDict_cc_cppflags)  $(src)TTCalibEventDict.cc
endif
endif

else
$(bin)CalibEvent_dependencies.make : $(TTCalibEventDict_cc_dependencies)

$(bin)CalibEvent_dependencies.make : $(src)TTCalibEventDict.cc

$(bin)$(binobj)TTCalibEventDict.o : $(TTCalibEventDict_cc_dependencies)
	$(cpp_echo) $(src)TTCalibEventDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(TTCalibEventDict_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(TTCalibEventDict_cppflags) $(TTCalibEventDict_cc_cppflags)  $(src)TTCalibEventDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CalibEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CalibPMTChannelDict.d

$(bin)$(binobj)CalibPMTChannelDict.d :

$(bin)$(binobj)CalibPMTChannelDict.o : $(cmt_final_setup_CalibEvent)

$(bin)$(binobj)CalibPMTChannelDict.o : $(src)CalibPMTChannelDict.cc
	$(cpp_echo) $(src)CalibPMTChannelDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibPMTChannelDict_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibPMTChannelDict_cppflags) $(CalibPMTChannelDict_cc_cppflags)  $(src)CalibPMTChannelDict.cc
endif
endif

else
$(bin)CalibEvent_dependencies.make : $(CalibPMTChannelDict_cc_dependencies)

$(bin)CalibEvent_dependencies.make : $(src)CalibPMTChannelDict.cc

$(bin)$(binobj)CalibPMTChannelDict.o : $(CalibPMTChannelDict_cc_dependencies)
	$(cpp_echo) $(src)CalibPMTChannelDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibPMTChannelDict_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibPMTChannelDict_cppflags) $(CalibPMTChannelDict_cc_cppflags)  $(src)CalibPMTChannelDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CalibEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CalibEventDict.d

$(bin)$(binobj)CalibEventDict.d :

$(bin)$(binobj)CalibEventDict.o : $(cmt_final_setup_CalibEvent)

$(bin)$(binobj)CalibEventDict.o : $(src)CalibEventDict.cc
	$(cpp_echo) $(src)CalibEventDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibEventDict_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibEventDict_cppflags) $(CalibEventDict_cc_cppflags)  $(src)CalibEventDict.cc
endif
endif

else
$(bin)CalibEvent_dependencies.make : $(CalibEventDict_cc_dependencies)

$(bin)CalibEvent_dependencies.make : $(src)CalibEventDict.cc

$(bin)$(binobj)CalibEventDict.o : $(CalibEventDict_cc_dependencies)
	$(cpp_echo) $(src)CalibEventDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibEventDict_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibEventDict_cppflags) $(CalibEventDict_cc_cppflags)  $(src)CalibEventDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CalibEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TTCalibEvent.d

$(bin)$(binobj)TTCalibEvent.d :

$(bin)$(binobj)TTCalibEvent.o : $(cmt_final_setup_CalibEvent)

$(bin)$(binobj)TTCalibEvent.o : $(src)TTCalibEvent.cc
	$(cpp_echo) $(src)TTCalibEvent.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(TTCalibEvent_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(TTCalibEvent_cppflags) $(TTCalibEvent_cc_cppflags)  $(src)TTCalibEvent.cc
endif
endif

else
$(bin)CalibEvent_dependencies.make : $(TTCalibEvent_cc_dependencies)

$(bin)CalibEvent_dependencies.make : $(src)TTCalibEvent.cc

$(bin)$(binobj)TTCalibEvent.o : $(TTCalibEvent_cc_dependencies)
	$(cpp_echo) $(src)TTCalibEvent.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(TTCalibEvent_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(TTCalibEvent_cppflags) $(TTCalibEvent_cc_cppflags)  $(src)TTCalibEvent.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CalibEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CalibTTChannelDict.d

$(bin)$(binobj)CalibTTChannelDict.d :

$(bin)$(binobj)CalibTTChannelDict.o : $(cmt_final_setup_CalibEvent)

$(bin)$(binobj)CalibTTChannelDict.o : $(src)CalibTTChannelDict.cc
	$(cpp_echo) $(src)CalibTTChannelDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibTTChannelDict_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibTTChannelDict_cppflags) $(CalibTTChannelDict_cc_cppflags)  $(src)CalibTTChannelDict.cc
endif
endif

else
$(bin)CalibEvent_dependencies.make : $(CalibTTChannelDict_cc_dependencies)

$(bin)CalibEvent_dependencies.make : $(src)CalibTTChannelDict.cc

$(bin)$(binobj)CalibTTChannelDict.o : $(CalibTTChannelDict_cc_dependencies)
	$(cpp_echo) $(src)CalibTTChannelDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibTTChannelDict_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibTTChannelDict_cppflags) $(CalibTTChannelDict_cc_cppflags)  $(src)CalibTTChannelDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CalibEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CalibTTChannel.d

$(bin)$(binobj)CalibTTChannel.d :

$(bin)$(binobj)CalibTTChannel.o : $(cmt_final_setup_CalibEvent)

$(bin)$(binobj)CalibTTChannel.o : $(src)CalibTTChannel.cc
	$(cpp_echo) $(src)CalibTTChannel.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibTTChannel_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibTTChannel_cppflags) $(CalibTTChannel_cc_cppflags)  $(src)CalibTTChannel.cc
endif
endif

else
$(bin)CalibEvent_dependencies.make : $(CalibTTChannel_cc_dependencies)

$(bin)CalibEvent_dependencies.make : $(src)CalibTTChannel.cc

$(bin)$(binobj)CalibTTChannel.o : $(CalibTTChannel_cc_dependencies)
	$(cpp_echo) $(src)CalibTTChannel.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibTTChannel_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibTTChannel_cppflags) $(CalibTTChannel_cc_cppflags)  $(src)CalibTTChannel.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CalibEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CalibHeaderDict.d

$(bin)$(binobj)CalibHeaderDict.d :

$(bin)$(binobj)CalibHeaderDict.o : $(cmt_final_setup_CalibEvent)

$(bin)$(binobj)CalibHeaderDict.o : $(src)CalibHeaderDict.cc
	$(cpp_echo) $(src)CalibHeaderDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibHeaderDict_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibHeaderDict_cppflags) $(CalibHeaderDict_cc_cppflags)  $(src)CalibHeaderDict.cc
endif
endif

else
$(bin)CalibEvent_dependencies.make : $(CalibHeaderDict_cc_dependencies)

$(bin)CalibEvent_dependencies.make : $(src)CalibHeaderDict.cc

$(bin)$(binobj)CalibHeaderDict.o : $(CalibHeaderDict_cc_dependencies)
	$(cpp_echo) $(src)CalibHeaderDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibHeaderDict_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibHeaderDict_cppflags) $(CalibHeaderDict_cc_cppflags)  $(src)CalibHeaderDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CalibEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CalibPMTChannel.d

$(bin)$(binobj)CalibPMTChannel.d :

$(bin)$(binobj)CalibPMTChannel.o : $(cmt_final_setup_CalibEvent)

$(bin)$(binobj)CalibPMTChannel.o : $(src)CalibPMTChannel.cc
	$(cpp_echo) $(src)CalibPMTChannel.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibPMTChannel_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibPMTChannel_cppflags) $(CalibPMTChannel_cc_cppflags)  $(src)CalibPMTChannel.cc
endif
endif

else
$(bin)CalibEvent_dependencies.make : $(CalibPMTChannel_cc_dependencies)

$(bin)CalibEvent_dependencies.make : $(src)CalibPMTChannel.cc

$(bin)$(binobj)CalibPMTChannel.o : $(CalibPMTChannel_cc_dependencies)
	$(cpp_echo) $(src)CalibPMTChannel.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibPMTChannel_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibPMTChannel_cppflags) $(CalibPMTChannel_cc_cppflags)  $(src)CalibPMTChannel.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CalibEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CalibEvent.d

$(bin)$(binobj)CalibEvent.d :

$(bin)$(binobj)CalibEvent.o : $(cmt_final_setup_CalibEvent)

$(bin)$(binobj)CalibEvent.o : $(src)CalibEvent.cc
	$(cpp_echo) $(src)CalibEvent.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibEvent_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibEvent_cppflags) $(CalibEvent_cc_cppflags)  $(src)CalibEvent.cc
endif
endif

else
$(bin)CalibEvent_dependencies.make : $(CalibEvent_cc_dependencies)

$(bin)CalibEvent_dependencies.make : $(src)CalibEvent.cc

$(bin)$(binobj)CalibEvent.o : $(CalibEvent_cc_dependencies)
	$(cpp_echo) $(src)CalibEvent.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibEvent_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibEvent_cppflags) $(CalibEvent_cc_cppflags)  $(src)CalibEvent.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CalibEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CalibHeader.d

$(bin)$(binobj)CalibHeader.d :

$(bin)$(binobj)CalibHeader.o : $(cmt_final_setup_CalibEvent)

$(bin)$(binobj)CalibHeader.o : $(src)CalibHeader.cc
	$(cpp_echo) $(src)CalibHeader.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibHeader_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibHeader_cppflags) $(CalibHeader_cc_cppflags)  $(src)CalibHeader.cc
endif
endif

else
$(bin)CalibEvent_dependencies.make : $(CalibHeader_cc_dependencies)

$(bin)CalibEvent_dependencies.make : $(src)CalibHeader.cc

$(bin)$(binobj)CalibHeader.o : $(CalibHeader_cc_dependencies)
	$(cpp_echo) $(src)CalibHeader.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CalibEvent_pp_cppflags) $(lib_CalibEvent_pp_cppflags) $(CalibHeader_pp_cppflags) $(use_cppflags) $(CalibEvent_cppflags) $(lib_CalibEvent_cppflags) $(CalibHeader_cppflags) $(CalibHeader_cc_cppflags)  $(src)CalibHeader.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: CalibEventclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(CalibEvent.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

CalibEventclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library CalibEvent
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)CalibEvent$(library_suffix).a $(library_prefix)CalibEvent$(library_suffix).$(shlibsuffix) CalibEvent.stamp CalibEvent.shstamp
#-- end of cleanup_library ---------------

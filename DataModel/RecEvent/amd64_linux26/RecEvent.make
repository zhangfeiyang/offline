#-- start of make_header -----------------

#====================================
#  Library RecEvent
#
#   Generated Fri Jul 10 19:18:56 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RecEvent_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RecEvent_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RecEvent

RecEvent_tag = $(tag)

#cmt_local_tagfile_RecEvent = $(RecEvent_tag)_RecEvent.make
cmt_local_tagfile_RecEvent = $(bin)$(RecEvent_tag)_RecEvent.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RecEvent_tag = $(tag)

#cmt_local_tagfile_RecEvent = $(RecEvent_tag).make
cmt_local_tagfile_RecEvent = $(bin)$(RecEvent_tag).make

endif

include $(cmt_local_tagfile_RecEvent)
#-include $(cmt_local_tagfile_RecEvent)

ifdef cmt_RecEvent_has_target_tag

cmt_final_setup_RecEvent = $(bin)setup_RecEvent.make
cmt_dependencies_in_RecEvent = $(bin)dependencies_RecEvent.in
#cmt_final_setup_RecEvent = $(bin)RecEvent_RecEventsetup.make
cmt_local_RecEvent_makefile = $(bin)RecEvent.make

else

cmt_final_setup_RecEvent = $(bin)setup.make
cmt_dependencies_in_RecEvent = $(bin)dependencies.in
#cmt_final_setup_RecEvent = $(bin)RecEventsetup.make
cmt_local_RecEvent_makefile = $(bin)RecEvent.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RecEventsetup.make

#RecEvent :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RecEvent'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RecEvent/
#RecEvent::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RecEventlibname   = $(bin)$(library_prefix)RecEvent$(library_suffix)
RecEventlib       = $(RecEventlibname).a
RecEventstamp     = $(bin)RecEvent.stamp
RecEventshstamp   = $(bin)RecEvent.shstamp

RecEvent :: dirs  RecEventLIB
	$(echo) "RecEvent ok"

cmt_RecEvent_has_prototypes = 1

#--------------------------------------

ifdef cmt_RecEvent_has_prototypes

RecEventprototype :  ;

endif

RecEventcompile : $(bin)CDRecEvent.o $(bin)RecHeader.o $(bin)CDTrackRecEvent.o $(bin)CDTrackRecEventDict.o $(bin)TTRecEvent.o $(bin)RecTrack.o $(bin)WPRecEvent.o $(bin)WPRecEventDict.o $(bin)TTRecEventDict.o $(bin)CDRecEventDict.o $(bin)RecHeaderDict.o $(bin)RecTrackDict.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

RecEventLIB :: $(RecEventlib) $(RecEventshstamp)
	$(echo) "RecEvent : library ok"

$(RecEventlib) :: $(bin)CDRecEvent.o $(bin)RecHeader.o $(bin)CDTrackRecEvent.o $(bin)CDTrackRecEventDict.o $(bin)TTRecEvent.o $(bin)RecTrack.o $(bin)WPRecEvent.o $(bin)WPRecEventDict.o $(bin)TTRecEventDict.o $(bin)CDRecEventDict.o $(bin)RecHeaderDict.o $(bin)RecTrackDict.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(RecEventlib) $(bin)CDRecEvent.o $(bin)RecHeader.o $(bin)CDTrackRecEvent.o $(bin)CDTrackRecEventDict.o $(bin)TTRecEvent.o $(bin)RecTrack.o $(bin)WPRecEvent.o $(bin)WPRecEventDict.o $(bin)TTRecEventDict.o $(bin)CDRecEventDict.o $(bin)RecHeaderDict.o $(bin)RecTrackDict.o
	$(lib_silent) $(ranlib) $(RecEventlib)
	$(lib_silent) cat /dev/null >$(RecEventstamp)

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

$(RecEventlibname).$(shlibsuffix) :: $(RecEventlib) requirements $(use_requirements) $(RecEventstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" RecEvent $(RecEvent_shlibflags)
	$(lib_silent) cat /dev/null >$(RecEventshstamp)

$(RecEventshstamp) :: $(RecEventlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RecEventlibname).$(shlibsuffix) ; then cat /dev/null >$(RecEventshstamp) ; fi

RecEventclean ::
	$(cleanup_echo) objects RecEvent
	$(cleanup_silent) /bin/rm -f $(bin)CDRecEvent.o $(bin)RecHeader.o $(bin)CDTrackRecEvent.o $(bin)CDTrackRecEventDict.o $(bin)TTRecEvent.o $(bin)RecTrack.o $(bin)WPRecEvent.o $(bin)WPRecEventDict.o $(bin)TTRecEventDict.o $(bin)CDRecEventDict.o $(bin)RecHeaderDict.o $(bin)RecTrackDict.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)CDRecEvent.o $(bin)RecHeader.o $(bin)CDTrackRecEvent.o $(bin)CDTrackRecEventDict.o $(bin)TTRecEvent.o $(bin)RecTrack.o $(bin)WPRecEvent.o $(bin)WPRecEventDict.o $(bin)TTRecEventDict.o $(bin)CDRecEventDict.o $(bin)RecHeaderDict.o $(bin)RecTrackDict.o) $(patsubst %.o,%.dep,$(bin)CDRecEvent.o $(bin)RecHeader.o $(bin)CDTrackRecEvent.o $(bin)CDTrackRecEventDict.o $(bin)TTRecEvent.o $(bin)RecTrack.o $(bin)WPRecEvent.o $(bin)WPRecEventDict.o $(bin)TTRecEventDict.o $(bin)CDRecEventDict.o $(bin)RecHeaderDict.o $(bin)RecTrackDict.o) $(patsubst %.o,%.d.stamp,$(bin)CDRecEvent.o $(bin)RecHeader.o $(bin)CDTrackRecEvent.o $(bin)CDTrackRecEventDict.o $(bin)TTRecEvent.o $(bin)RecTrack.o $(bin)WPRecEvent.o $(bin)WPRecEventDict.o $(bin)TTRecEventDict.o $(bin)CDRecEventDict.o $(bin)RecHeaderDict.o $(bin)RecTrackDict.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RecEvent_deps RecEvent_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RecEventinstallname = $(library_prefix)RecEvent$(library_suffix).$(shlibsuffix)

RecEvent :: RecEventinstall ;

install :: RecEventinstall ;

RecEventinstall :: $(install_dir)/$(RecEventinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RecEventinstallname) :: $(bin)$(RecEventinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RecEventinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RecEventclean :: RecEventuninstall

uninstall :: RecEventuninstall ;

RecEventuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RecEventinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),RecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),RecEventprototype)

$(bin)RecEvent_dependencies.make : $(use_requirements) $(cmt_final_setup_RecEvent)
	$(echo) "(RecEvent.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)CDRecEvent.cc $(src)RecHeader.cc $(src)CDTrackRecEvent.cc $(src)CDTrackRecEventDict.cc $(src)TTRecEvent.cc $(src)RecTrack.cc $(src)WPRecEvent.cc $(src)WPRecEventDict.cc $(src)TTRecEventDict.cc $(src)CDRecEventDict.cc $(src)RecHeaderDict.cc $(src)RecTrackDict.cc -end_all $(includes) $(app_RecEvent_cppflags) $(lib_RecEvent_cppflags) -name=RecEvent $? -f=$(cmt_dependencies_in_RecEvent) -without_cmt

-include $(bin)RecEvent_dependencies.make

endif
endif
endif

RecEventclean ::
	$(cleanup_silent) \rm -rf $(bin)RecEvent_deps $(bin)RecEvent_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CDRecEvent.d

$(bin)$(binobj)CDRecEvent.d :

$(bin)$(binobj)CDRecEvent.o : $(cmt_final_setup_RecEvent)

$(bin)$(binobj)CDRecEvent.o : $(src)CDRecEvent.cc
	$(cpp_echo) $(src)CDRecEvent.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(CDRecEvent_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(CDRecEvent_cppflags) $(CDRecEvent_cc_cppflags)  $(src)CDRecEvent.cc
endif
endif

else
$(bin)RecEvent_dependencies.make : $(CDRecEvent_cc_dependencies)

$(bin)RecEvent_dependencies.make : $(src)CDRecEvent.cc

$(bin)$(binobj)CDRecEvent.o : $(CDRecEvent_cc_dependencies)
	$(cpp_echo) $(src)CDRecEvent.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(CDRecEvent_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(CDRecEvent_cppflags) $(CDRecEvent_cc_cppflags)  $(src)CDRecEvent.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecHeader.d

$(bin)$(binobj)RecHeader.d :

$(bin)$(binobj)RecHeader.o : $(cmt_final_setup_RecEvent)

$(bin)$(binobj)RecHeader.o : $(src)RecHeader.cc
	$(cpp_echo) $(src)RecHeader.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(RecHeader_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(RecHeader_cppflags) $(RecHeader_cc_cppflags)  $(src)RecHeader.cc
endif
endif

else
$(bin)RecEvent_dependencies.make : $(RecHeader_cc_dependencies)

$(bin)RecEvent_dependencies.make : $(src)RecHeader.cc

$(bin)$(binobj)RecHeader.o : $(RecHeader_cc_dependencies)
	$(cpp_echo) $(src)RecHeader.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(RecHeader_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(RecHeader_cppflags) $(RecHeader_cc_cppflags)  $(src)RecHeader.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CDTrackRecEvent.d

$(bin)$(binobj)CDTrackRecEvent.d :

$(bin)$(binobj)CDTrackRecEvent.o : $(cmt_final_setup_RecEvent)

$(bin)$(binobj)CDTrackRecEvent.o : $(src)CDTrackRecEvent.cc
	$(cpp_echo) $(src)CDTrackRecEvent.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(CDTrackRecEvent_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(CDTrackRecEvent_cppflags) $(CDTrackRecEvent_cc_cppflags)  $(src)CDTrackRecEvent.cc
endif
endif

else
$(bin)RecEvent_dependencies.make : $(CDTrackRecEvent_cc_dependencies)

$(bin)RecEvent_dependencies.make : $(src)CDTrackRecEvent.cc

$(bin)$(binobj)CDTrackRecEvent.o : $(CDTrackRecEvent_cc_dependencies)
	$(cpp_echo) $(src)CDTrackRecEvent.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(CDTrackRecEvent_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(CDTrackRecEvent_cppflags) $(CDTrackRecEvent_cc_cppflags)  $(src)CDTrackRecEvent.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CDTrackRecEventDict.d

$(bin)$(binobj)CDTrackRecEventDict.d :

$(bin)$(binobj)CDTrackRecEventDict.o : $(cmt_final_setup_RecEvent)

$(bin)$(binobj)CDTrackRecEventDict.o : $(src)CDTrackRecEventDict.cc
	$(cpp_echo) $(src)CDTrackRecEventDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(CDTrackRecEventDict_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(CDTrackRecEventDict_cppflags) $(CDTrackRecEventDict_cc_cppflags)  $(src)CDTrackRecEventDict.cc
endif
endif

else
$(bin)RecEvent_dependencies.make : $(CDTrackRecEventDict_cc_dependencies)

$(bin)RecEvent_dependencies.make : $(src)CDTrackRecEventDict.cc

$(bin)$(binobj)CDTrackRecEventDict.o : $(CDTrackRecEventDict_cc_dependencies)
	$(cpp_echo) $(src)CDTrackRecEventDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(CDTrackRecEventDict_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(CDTrackRecEventDict_cppflags) $(CDTrackRecEventDict_cc_cppflags)  $(src)CDTrackRecEventDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TTRecEvent.d

$(bin)$(binobj)TTRecEvent.d :

$(bin)$(binobj)TTRecEvent.o : $(cmt_final_setup_RecEvent)

$(bin)$(binobj)TTRecEvent.o : $(src)TTRecEvent.cc
	$(cpp_echo) $(src)TTRecEvent.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(TTRecEvent_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(TTRecEvent_cppflags) $(TTRecEvent_cc_cppflags)  $(src)TTRecEvent.cc
endif
endif

else
$(bin)RecEvent_dependencies.make : $(TTRecEvent_cc_dependencies)

$(bin)RecEvent_dependencies.make : $(src)TTRecEvent.cc

$(bin)$(binobj)TTRecEvent.o : $(TTRecEvent_cc_dependencies)
	$(cpp_echo) $(src)TTRecEvent.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(TTRecEvent_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(TTRecEvent_cppflags) $(TTRecEvent_cc_cppflags)  $(src)TTRecEvent.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecTrack.d

$(bin)$(binobj)RecTrack.d :

$(bin)$(binobj)RecTrack.o : $(cmt_final_setup_RecEvent)

$(bin)$(binobj)RecTrack.o : $(src)RecTrack.cc
	$(cpp_echo) $(src)RecTrack.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(RecTrack_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(RecTrack_cppflags) $(RecTrack_cc_cppflags)  $(src)RecTrack.cc
endif
endif

else
$(bin)RecEvent_dependencies.make : $(RecTrack_cc_dependencies)

$(bin)RecEvent_dependencies.make : $(src)RecTrack.cc

$(bin)$(binobj)RecTrack.o : $(RecTrack_cc_dependencies)
	$(cpp_echo) $(src)RecTrack.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(RecTrack_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(RecTrack_cppflags) $(RecTrack_cc_cppflags)  $(src)RecTrack.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)WPRecEvent.d

$(bin)$(binobj)WPRecEvent.d :

$(bin)$(binobj)WPRecEvent.o : $(cmt_final_setup_RecEvent)

$(bin)$(binobj)WPRecEvent.o : $(src)WPRecEvent.cc
	$(cpp_echo) $(src)WPRecEvent.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(WPRecEvent_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(WPRecEvent_cppflags) $(WPRecEvent_cc_cppflags)  $(src)WPRecEvent.cc
endif
endif

else
$(bin)RecEvent_dependencies.make : $(WPRecEvent_cc_dependencies)

$(bin)RecEvent_dependencies.make : $(src)WPRecEvent.cc

$(bin)$(binobj)WPRecEvent.o : $(WPRecEvent_cc_dependencies)
	$(cpp_echo) $(src)WPRecEvent.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(WPRecEvent_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(WPRecEvent_cppflags) $(WPRecEvent_cc_cppflags)  $(src)WPRecEvent.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)WPRecEventDict.d

$(bin)$(binobj)WPRecEventDict.d :

$(bin)$(binobj)WPRecEventDict.o : $(cmt_final_setup_RecEvent)

$(bin)$(binobj)WPRecEventDict.o : $(src)WPRecEventDict.cc
	$(cpp_echo) $(src)WPRecEventDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(WPRecEventDict_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(WPRecEventDict_cppflags) $(WPRecEventDict_cc_cppflags)  $(src)WPRecEventDict.cc
endif
endif

else
$(bin)RecEvent_dependencies.make : $(WPRecEventDict_cc_dependencies)

$(bin)RecEvent_dependencies.make : $(src)WPRecEventDict.cc

$(bin)$(binobj)WPRecEventDict.o : $(WPRecEventDict_cc_dependencies)
	$(cpp_echo) $(src)WPRecEventDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(WPRecEventDict_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(WPRecEventDict_cppflags) $(WPRecEventDict_cc_cppflags)  $(src)WPRecEventDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TTRecEventDict.d

$(bin)$(binobj)TTRecEventDict.d :

$(bin)$(binobj)TTRecEventDict.o : $(cmt_final_setup_RecEvent)

$(bin)$(binobj)TTRecEventDict.o : $(src)TTRecEventDict.cc
	$(cpp_echo) $(src)TTRecEventDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(TTRecEventDict_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(TTRecEventDict_cppflags) $(TTRecEventDict_cc_cppflags)  $(src)TTRecEventDict.cc
endif
endif

else
$(bin)RecEvent_dependencies.make : $(TTRecEventDict_cc_dependencies)

$(bin)RecEvent_dependencies.make : $(src)TTRecEventDict.cc

$(bin)$(binobj)TTRecEventDict.o : $(TTRecEventDict_cc_dependencies)
	$(cpp_echo) $(src)TTRecEventDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(TTRecEventDict_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(TTRecEventDict_cppflags) $(TTRecEventDict_cc_cppflags)  $(src)TTRecEventDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CDRecEventDict.d

$(bin)$(binobj)CDRecEventDict.d :

$(bin)$(binobj)CDRecEventDict.o : $(cmt_final_setup_RecEvent)

$(bin)$(binobj)CDRecEventDict.o : $(src)CDRecEventDict.cc
	$(cpp_echo) $(src)CDRecEventDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(CDRecEventDict_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(CDRecEventDict_cppflags) $(CDRecEventDict_cc_cppflags)  $(src)CDRecEventDict.cc
endif
endif

else
$(bin)RecEvent_dependencies.make : $(CDRecEventDict_cc_dependencies)

$(bin)RecEvent_dependencies.make : $(src)CDRecEventDict.cc

$(bin)$(binobj)CDRecEventDict.o : $(CDRecEventDict_cc_dependencies)
	$(cpp_echo) $(src)CDRecEventDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(CDRecEventDict_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(CDRecEventDict_cppflags) $(CDRecEventDict_cc_cppflags)  $(src)CDRecEventDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecHeaderDict.d

$(bin)$(binobj)RecHeaderDict.d :

$(bin)$(binobj)RecHeaderDict.o : $(cmt_final_setup_RecEvent)

$(bin)$(binobj)RecHeaderDict.o : $(src)RecHeaderDict.cc
	$(cpp_echo) $(src)RecHeaderDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(RecHeaderDict_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(RecHeaderDict_cppflags) $(RecHeaderDict_cc_cppflags)  $(src)RecHeaderDict.cc
endif
endif

else
$(bin)RecEvent_dependencies.make : $(RecHeaderDict_cc_dependencies)

$(bin)RecEvent_dependencies.make : $(src)RecHeaderDict.cc

$(bin)$(binobj)RecHeaderDict.o : $(RecHeaderDict_cc_dependencies)
	$(cpp_echo) $(src)RecHeaderDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(RecHeaderDict_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(RecHeaderDict_cppflags) $(RecHeaderDict_cc_cppflags)  $(src)RecHeaderDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecTrackDict.d

$(bin)$(binobj)RecTrackDict.d :

$(bin)$(binobj)RecTrackDict.o : $(cmt_final_setup_RecEvent)

$(bin)$(binobj)RecTrackDict.o : $(src)RecTrackDict.cc
	$(cpp_echo) $(src)RecTrackDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(RecTrackDict_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(RecTrackDict_cppflags) $(RecTrackDict_cc_cppflags)  $(src)RecTrackDict.cc
endif
endif

else
$(bin)RecEvent_dependencies.make : $(RecTrackDict_cc_dependencies)

$(bin)RecEvent_dependencies.make : $(src)RecTrackDict.cc

$(bin)$(binobj)RecTrackDict.o : $(RecTrackDict_cc_dependencies)
	$(cpp_echo) $(src)RecTrackDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecEvent_pp_cppflags) $(lib_RecEvent_pp_cppflags) $(RecTrackDict_pp_cppflags) $(use_cppflags) $(RecEvent_cppflags) $(lib_RecEvent_cppflags) $(RecTrackDict_cppflags) $(RecTrackDict_cc_cppflags)  $(src)RecTrackDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RecEventclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RecEvent.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RecEventclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RecEvent
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RecEvent$(library_suffix).a $(library_prefix)RecEvent$(library_suffix).$(shlibsuffix) RecEvent.stamp RecEvent.shstamp
#-- end of cleanup_library ---------------

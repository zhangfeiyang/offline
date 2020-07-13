#-- start of make_header -----------------

#====================================
#  Library SimEventV2
#
#   Generated Fri Jul 10 19:21:28 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_SimEventV2_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_SimEventV2_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_SimEventV2

SimEventV2_tag = $(tag)

#cmt_local_tagfile_SimEventV2 = $(SimEventV2_tag)_SimEventV2.make
cmt_local_tagfile_SimEventV2 = $(bin)$(SimEventV2_tag)_SimEventV2.make

else

tags      = $(tag),$(CMTEXTRATAGS)

SimEventV2_tag = $(tag)

#cmt_local_tagfile_SimEventV2 = $(SimEventV2_tag).make
cmt_local_tagfile_SimEventV2 = $(bin)$(SimEventV2_tag).make

endif

include $(cmt_local_tagfile_SimEventV2)
#-include $(cmt_local_tagfile_SimEventV2)

ifdef cmt_SimEventV2_has_target_tag

cmt_final_setup_SimEventV2 = $(bin)setup_SimEventV2.make
cmt_dependencies_in_SimEventV2 = $(bin)dependencies_SimEventV2.in
#cmt_final_setup_SimEventV2 = $(bin)SimEventV2_SimEventV2setup.make
cmt_local_SimEventV2_makefile = $(bin)SimEventV2.make

else

cmt_final_setup_SimEventV2 = $(bin)setup.make
cmt_dependencies_in_SimEventV2 = $(bin)dependencies.in
#cmt_final_setup_SimEventV2 = $(bin)SimEventV2setup.make
cmt_local_SimEventV2_makefile = $(bin)SimEventV2.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)SimEventV2setup.make

#SimEventV2 :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'SimEventV2'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = SimEventV2/
#SimEventV2::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

SimEventV2libname   = $(bin)$(library_prefix)SimEventV2$(library_suffix)
SimEventV2lib       = $(SimEventV2libname).a
SimEventV2stamp     = $(bin)SimEventV2.stamp
SimEventV2shstamp   = $(bin)SimEventV2.shstamp

SimEventV2 :: dirs  SimEventV2LIB
	$(echo) "SimEventV2 ok"

cmt_SimEventV2_has_prototypes = 1

#--------------------------------------

ifdef cmt_SimEventV2_has_prototypes

SimEventV2prototype :  ;

endif

SimEventV2compile : $(bin)SimTrackDict.o $(bin)SimTTHitDict.o $(bin)SimEventDict.o $(bin)SimHeaderDict.o $(bin)SimTrack.o $(bin)SimTTHit.o $(bin)SimHeader.o $(bin)SimPMTHitDict.o $(bin)SimPMTHit.o $(bin)SimEvent.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

SimEventV2LIB :: $(SimEventV2lib) $(SimEventV2shstamp)
	$(echo) "SimEventV2 : library ok"

$(SimEventV2lib) :: $(bin)SimTrackDict.o $(bin)SimTTHitDict.o $(bin)SimEventDict.o $(bin)SimHeaderDict.o $(bin)SimTrack.o $(bin)SimTTHit.o $(bin)SimHeader.o $(bin)SimPMTHitDict.o $(bin)SimPMTHit.o $(bin)SimEvent.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(SimEventV2lib) $(bin)SimTrackDict.o $(bin)SimTTHitDict.o $(bin)SimEventDict.o $(bin)SimHeaderDict.o $(bin)SimTrack.o $(bin)SimTTHit.o $(bin)SimHeader.o $(bin)SimPMTHitDict.o $(bin)SimPMTHit.o $(bin)SimEvent.o
	$(lib_silent) $(ranlib) $(SimEventV2lib)
	$(lib_silent) cat /dev/null >$(SimEventV2stamp)

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

$(SimEventV2libname).$(shlibsuffix) :: $(SimEventV2lib) requirements $(use_requirements) $(SimEventV2stamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" SimEventV2 $(SimEventV2_shlibflags)
	$(lib_silent) cat /dev/null >$(SimEventV2shstamp)

$(SimEventV2shstamp) :: $(SimEventV2libname).$(shlibsuffix)
	$(lib_silent) if test -f $(SimEventV2libname).$(shlibsuffix) ; then cat /dev/null >$(SimEventV2shstamp) ; fi

SimEventV2clean ::
	$(cleanup_echo) objects SimEventV2
	$(cleanup_silent) /bin/rm -f $(bin)SimTrackDict.o $(bin)SimTTHitDict.o $(bin)SimEventDict.o $(bin)SimHeaderDict.o $(bin)SimTrack.o $(bin)SimTTHit.o $(bin)SimHeader.o $(bin)SimPMTHitDict.o $(bin)SimPMTHit.o $(bin)SimEvent.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)SimTrackDict.o $(bin)SimTTHitDict.o $(bin)SimEventDict.o $(bin)SimHeaderDict.o $(bin)SimTrack.o $(bin)SimTTHit.o $(bin)SimHeader.o $(bin)SimPMTHitDict.o $(bin)SimPMTHit.o $(bin)SimEvent.o) $(patsubst %.o,%.dep,$(bin)SimTrackDict.o $(bin)SimTTHitDict.o $(bin)SimEventDict.o $(bin)SimHeaderDict.o $(bin)SimTrack.o $(bin)SimTTHit.o $(bin)SimHeader.o $(bin)SimPMTHitDict.o $(bin)SimPMTHit.o $(bin)SimEvent.o) $(patsubst %.o,%.d.stamp,$(bin)SimTrackDict.o $(bin)SimTTHitDict.o $(bin)SimEventDict.o $(bin)SimHeaderDict.o $(bin)SimTrack.o $(bin)SimTTHit.o $(bin)SimHeader.o $(bin)SimPMTHitDict.o $(bin)SimPMTHit.o $(bin)SimEvent.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf SimEventV2_deps SimEventV2_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
SimEventV2installname = $(library_prefix)SimEventV2$(library_suffix).$(shlibsuffix)

SimEventV2 :: SimEventV2install ;

install :: SimEventV2install ;

SimEventV2install :: $(install_dir)/$(SimEventV2installname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(SimEventV2installname) :: $(bin)$(SimEventV2installname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(SimEventV2installname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##SimEventV2clean :: SimEventV2uninstall

uninstall :: SimEventV2uninstall ;

SimEventV2uninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(SimEventV2installname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),SimEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),SimEventV2prototype)

$(bin)SimEventV2_dependencies.make : $(use_requirements) $(cmt_final_setup_SimEventV2)
	$(echo) "(SimEventV2.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)SimTrackDict.cc $(src)SimTTHitDict.cc $(src)SimEventDict.cc $(src)SimHeaderDict.cc $(src)SimTrack.cc $(src)SimTTHit.cc $(src)SimHeader.cc $(src)SimPMTHitDict.cc $(src)SimPMTHit.cc $(src)SimEvent.cc -end_all $(includes) $(app_SimEventV2_cppflags) $(lib_SimEventV2_cppflags) -name=SimEventV2 $? -f=$(cmt_dependencies_in_SimEventV2) -without_cmt

-include $(bin)SimEventV2_dependencies.make

endif
endif
endif

SimEventV2clean ::
	$(cleanup_silent) \rm -rf $(bin)SimEventV2_deps $(bin)SimEventV2_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),SimEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SimTrackDict.d

$(bin)$(binobj)SimTrackDict.d :

$(bin)$(binobj)SimTrackDict.o : $(cmt_final_setup_SimEventV2)

$(bin)$(binobj)SimTrackDict.o : $(src)SimTrackDict.cc
	$(cpp_echo) $(src)SimTrackDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimTrackDict_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimTrackDict_cppflags) $(SimTrackDict_cc_cppflags)  $(src)SimTrackDict.cc
endif
endif

else
$(bin)SimEventV2_dependencies.make : $(SimTrackDict_cc_dependencies)

$(bin)SimEventV2_dependencies.make : $(src)SimTrackDict.cc

$(bin)$(binobj)SimTrackDict.o : $(SimTrackDict_cc_dependencies)
	$(cpp_echo) $(src)SimTrackDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimTrackDict_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimTrackDict_cppflags) $(SimTrackDict_cc_cppflags)  $(src)SimTrackDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),SimEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SimTTHitDict.d

$(bin)$(binobj)SimTTHitDict.d :

$(bin)$(binobj)SimTTHitDict.o : $(cmt_final_setup_SimEventV2)

$(bin)$(binobj)SimTTHitDict.o : $(src)SimTTHitDict.cc
	$(cpp_echo) $(src)SimTTHitDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimTTHitDict_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimTTHitDict_cppflags) $(SimTTHitDict_cc_cppflags)  $(src)SimTTHitDict.cc
endif
endif

else
$(bin)SimEventV2_dependencies.make : $(SimTTHitDict_cc_dependencies)

$(bin)SimEventV2_dependencies.make : $(src)SimTTHitDict.cc

$(bin)$(binobj)SimTTHitDict.o : $(SimTTHitDict_cc_dependencies)
	$(cpp_echo) $(src)SimTTHitDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimTTHitDict_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimTTHitDict_cppflags) $(SimTTHitDict_cc_cppflags)  $(src)SimTTHitDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),SimEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SimEventDict.d

$(bin)$(binobj)SimEventDict.d :

$(bin)$(binobj)SimEventDict.o : $(cmt_final_setup_SimEventV2)

$(bin)$(binobj)SimEventDict.o : $(src)SimEventDict.cc
	$(cpp_echo) $(src)SimEventDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimEventDict_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimEventDict_cppflags) $(SimEventDict_cc_cppflags)  $(src)SimEventDict.cc
endif
endif

else
$(bin)SimEventV2_dependencies.make : $(SimEventDict_cc_dependencies)

$(bin)SimEventV2_dependencies.make : $(src)SimEventDict.cc

$(bin)$(binobj)SimEventDict.o : $(SimEventDict_cc_dependencies)
	$(cpp_echo) $(src)SimEventDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimEventDict_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimEventDict_cppflags) $(SimEventDict_cc_cppflags)  $(src)SimEventDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),SimEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SimHeaderDict.d

$(bin)$(binobj)SimHeaderDict.d :

$(bin)$(binobj)SimHeaderDict.o : $(cmt_final_setup_SimEventV2)

$(bin)$(binobj)SimHeaderDict.o : $(src)SimHeaderDict.cc
	$(cpp_echo) $(src)SimHeaderDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimHeaderDict_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimHeaderDict_cppflags) $(SimHeaderDict_cc_cppflags)  $(src)SimHeaderDict.cc
endif
endif

else
$(bin)SimEventV2_dependencies.make : $(SimHeaderDict_cc_dependencies)

$(bin)SimEventV2_dependencies.make : $(src)SimHeaderDict.cc

$(bin)$(binobj)SimHeaderDict.o : $(SimHeaderDict_cc_dependencies)
	$(cpp_echo) $(src)SimHeaderDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimHeaderDict_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimHeaderDict_cppflags) $(SimHeaderDict_cc_cppflags)  $(src)SimHeaderDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),SimEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SimTrack.d

$(bin)$(binobj)SimTrack.d :

$(bin)$(binobj)SimTrack.o : $(cmt_final_setup_SimEventV2)

$(bin)$(binobj)SimTrack.o : $(src)SimTrack.cc
	$(cpp_echo) $(src)SimTrack.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimTrack_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimTrack_cppflags) $(SimTrack_cc_cppflags)  $(src)SimTrack.cc
endif
endif

else
$(bin)SimEventV2_dependencies.make : $(SimTrack_cc_dependencies)

$(bin)SimEventV2_dependencies.make : $(src)SimTrack.cc

$(bin)$(binobj)SimTrack.o : $(SimTrack_cc_dependencies)
	$(cpp_echo) $(src)SimTrack.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimTrack_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimTrack_cppflags) $(SimTrack_cc_cppflags)  $(src)SimTrack.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),SimEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SimTTHit.d

$(bin)$(binobj)SimTTHit.d :

$(bin)$(binobj)SimTTHit.o : $(cmt_final_setup_SimEventV2)

$(bin)$(binobj)SimTTHit.o : $(src)SimTTHit.cc
	$(cpp_echo) $(src)SimTTHit.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimTTHit_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimTTHit_cppflags) $(SimTTHit_cc_cppflags)  $(src)SimTTHit.cc
endif
endif

else
$(bin)SimEventV2_dependencies.make : $(SimTTHit_cc_dependencies)

$(bin)SimEventV2_dependencies.make : $(src)SimTTHit.cc

$(bin)$(binobj)SimTTHit.o : $(SimTTHit_cc_dependencies)
	$(cpp_echo) $(src)SimTTHit.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimTTHit_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimTTHit_cppflags) $(SimTTHit_cc_cppflags)  $(src)SimTTHit.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),SimEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SimHeader.d

$(bin)$(binobj)SimHeader.d :

$(bin)$(binobj)SimHeader.o : $(cmt_final_setup_SimEventV2)

$(bin)$(binobj)SimHeader.o : $(src)SimHeader.cc
	$(cpp_echo) $(src)SimHeader.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimHeader_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimHeader_cppflags) $(SimHeader_cc_cppflags)  $(src)SimHeader.cc
endif
endif

else
$(bin)SimEventV2_dependencies.make : $(SimHeader_cc_dependencies)

$(bin)SimEventV2_dependencies.make : $(src)SimHeader.cc

$(bin)$(binobj)SimHeader.o : $(SimHeader_cc_dependencies)
	$(cpp_echo) $(src)SimHeader.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimHeader_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimHeader_cppflags) $(SimHeader_cc_cppflags)  $(src)SimHeader.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),SimEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SimPMTHitDict.d

$(bin)$(binobj)SimPMTHitDict.d :

$(bin)$(binobj)SimPMTHitDict.o : $(cmt_final_setup_SimEventV2)

$(bin)$(binobj)SimPMTHitDict.o : $(src)SimPMTHitDict.cc
	$(cpp_echo) $(src)SimPMTHitDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimPMTHitDict_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimPMTHitDict_cppflags) $(SimPMTHitDict_cc_cppflags)  $(src)SimPMTHitDict.cc
endif
endif

else
$(bin)SimEventV2_dependencies.make : $(SimPMTHitDict_cc_dependencies)

$(bin)SimEventV2_dependencies.make : $(src)SimPMTHitDict.cc

$(bin)$(binobj)SimPMTHitDict.o : $(SimPMTHitDict_cc_dependencies)
	$(cpp_echo) $(src)SimPMTHitDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimPMTHitDict_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimPMTHitDict_cppflags) $(SimPMTHitDict_cc_cppflags)  $(src)SimPMTHitDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),SimEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SimPMTHit.d

$(bin)$(binobj)SimPMTHit.d :

$(bin)$(binobj)SimPMTHit.o : $(cmt_final_setup_SimEventV2)

$(bin)$(binobj)SimPMTHit.o : $(src)SimPMTHit.cc
	$(cpp_echo) $(src)SimPMTHit.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimPMTHit_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimPMTHit_cppflags) $(SimPMTHit_cc_cppflags)  $(src)SimPMTHit.cc
endif
endif

else
$(bin)SimEventV2_dependencies.make : $(SimPMTHit_cc_dependencies)

$(bin)SimEventV2_dependencies.make : $(src)SimPMTHit.cc

$(bin)$(binobj)SimPMTHit.o : $(SimPMTHit_cc_dependencies)
	$(cpp_echo) $(src)SimPMTHit.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimPMTHit_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimPMTHit_cppflags) $(SimPMTHit_cc_cppflags)  $(src)SimPMTHit.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),SimEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SimEvent.d

$(bin)$(binobj)SimEvent.d :

$(bin)$(binobj)SimEvent.o : $(cmt_final_setup_SimEventV2)

$(bin)$(binobj)SimEvent.o : $(src)SimEvent.cc
	$(cpp_echo) $(src)SimEvent.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimEvent_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimEvent_cppflags) $(SimEvent_cc_cppflags)  $(src)SimEvent.cc
endif
endif

else
$(bin)SimEventV2_dependencies.make : $(SimEvent_cc_dependencies)

$(bin)SimEventV2_dependencies.make : $(src)SimEvent.cc

$(bin)$(binobj)SimEvent.o : $(SimEvent_cc_dependencies)
	$(cpp_echo) $(src)SimEvent.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SimEventV2_pp_cppflags) $(lib_SimEventV2_pp_cppflags) $(SimEvent_pp_cppflags) $(use_cppflags) $(SimEventV2_cppflags) $(lib_SimEventV2_cppflags) $(SimEvent_cppflags) $(SimEvent_cc_cppflags)  $(src)SimEvent.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: SimEventV2clean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(SimEventV2.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

SimEventV2clean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library SimEventV2
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)SimEventV2$(library_suffix).a $(library_prefix)SimEventV2$(library_suffix).$(shlibsuffix) SimEventV2.stamp SimEventV2.shstamp
#-- end of cleanup_library ---------------

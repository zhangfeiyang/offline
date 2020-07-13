#-- start of make_header -----------------

#====================================
#  Library RootIOTest
#
#   Generated Fri Jul 10 19:24:32 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootIOTest_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootIOTest_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootIOTest

RootIOTest_tag = $(tag)

#cmt_local_tagfile_RootIOTest = $(RootIOTest_tag)_RootIOTest.make
cmt_local_tagfile_RootIOTest = $(bin)$(RootIOTest_tag)_RootIOTest.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootIOTest_tag = $(tag)

#cmt_local_tagfile_RootIOTest = $(RootIOTest_tag).make
cmt_local_tagfile_RootIOTest = $(bin)$(RootIOTest_tag).make

endif

include $(cmt_local_tagfile_RootIOTest)
#-include $(cmt_local_tagfile_RootIOTest)

ifdef cmt_RootIOTest_has_target_tag

cmt_final_setup_RootIOTest = $(bin)setup_RootIOTest.make
cmt_dependencies_in_RootIOTest = $(bin)dependencies_RootIOTest.in
#cmt_final_setup_RootIOTest = $(bin)RootIOTest_RootIOTestsetup.make
cmt_local_RootIOTest_makefile = $(bin)RootIOTest.make

else

cmt_final_setup_RootIOTest = $(bin)setup.make
cmt_dependencies_in_RootIOTest = $(bin)dependencies.in
#cmt_final_setup_RootIOTest = $(bin)RootIOTestsetup.make
cmt_local_RootIOTest_makefile = $(bin)RootIOTest.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootIOTestsetup.make

#RootIOTest :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootIOTest'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootIOTest/
#RootIOTest::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RootIOTestlibname   = $(bin)$(library_prefix)RootIOTest$(library_suffix)
RootIOTestlib       = $(RootIOTestlibname).a
RootIOTeststamp     = $(bin)RootIOTest.stamp
RootIOTestshstamp   = $(bin)RootIOTest.shstamp

RootIOTest :: dirs  RootIOTestLIB
	$(echo) "RootIOTest ok"

cmt_RootIOTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_RootIOTest_has_prototypes

RootIOTestprototype :  ;

endif

RootIOTestcompile : $(bin)DummyEventDict.o $(bin)DummyTTHitDict.o $(bin)DummyEvent.o $(bin)DummyPMTHit.o $(bin)TestRecEDM.o $(bin)DummyPMTHitDict.o $(bin)DummyTrack.o $(bin)DummyHeaderDict.o $(bin)DummyHeader.o $(bin)DummyTrackDict.o $(bin)DummyTTHit.o $(bin)MakeSample.o $(bin)SelectEventData.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

RootIOTestLIB :: $(RootIOTestlib) $(RootIOTestshstamp)
	$(echo) "RootIOTest : library ok"

$(RootIOTestlib) :: $(bin)DummyEventDict.o $(bin)DummyTTHitDict.o $(bin)DummyEvent.o $(bin)DummyPMTHit.o $(bin)TestRecEDM.o $(bin)DummyPMTHitDict.o $(bin)DummyTrack.o $(bin)DummyHeaderDict.o $(bin)DummyHeader.o $(bin)DummyTrackDict.o $(bin)DummyTTHit.o $(bin)MakeSample.o $(bin)SelectEventData.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(RootIOTestlib) $(bin)DummyEventDict.o $(bin)DummyTTHitDict.o $(bin)DummyEvent.o $(bin)DummyPMTHit.o $(bin)TestRecEDM.o $(bin)DummyPMTHitDict.o $(bin)DummyTrack.o $(bin)DummyHeaderDict.o $(bin)DummyHeader.o $(bin)DummyTrackDict.o $(bin)DummyTTHit.o $(bin)MakeSample.o $(bin)SelectEventData.o
	$(lib_silent) $(ranlib) $(RootIOTestlib)
	$(lib_silent) cat /dev/null >$(RootIOTeststamp)

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

$(RootIOTestlibname).$(shlibsuffix) :: $(RootIOTestlib) requirements $(use_requirements) $(RootIOTeststamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" RootIOTest $(RootIOTest_shlibflags)
	$(lib_silent) cat /dev/null >$(RootIOTestshstamp)

$(RootIOTestshstamp) :: $(RootIOTestlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RootIOTestlibname).$(shlibsuffix) ; then cat /dev/null >$(RootIOTestshstamp) ; fi

RootIOTestclean ::
	$(cleanup_echo) objects RootIOTest
	$(cleanup_silent) /bin/rm -f $(bin)DummyEventDict.o $(bin)DummyTTHitDict.o $(bin)DummyEvent.o $(bin)DummyPMTHit.o $(bin)TestRecEDM.o $(bin)DummyPMTHitDict.o $(bin)DummyTrack.o $(bin)DummyHeaderDict.o $(bin)DummyHeader.o $(bin)DummyTrackDict.o $(bin)DummyTTHit.o $(bin)MakeSample.o $(bin)SelectEventData.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)DummyEventDict.o $(bin)DummyTTHitDict.o $(bin)DummyEvent.o $(bin)DummyPMTHit.o $(bin)TestRecEDM.o $(bin)DummyPMTHitDict.o $(bin)DummyTrack.o $(bin)DummyHeaderDict.o $(bin)DummyHeader.o $(bin)DummyTrackDict.o $(bin)DummyTTHit.o $(bin)MakeSample.o $(bin)SelectEventData.o) $(patsubst %.o,%.dep,$(bin)DummyEventDict.o $(bin)DummyTTHitDict.o $(bin)DummyEvent.o $(bin)DummyPMTHit.o $(bin)TestRecEDM.o $(bin)DummyPMTHitDict.o $(bin)DummyTrack.o $(bin)DummyHeaderDict.o $(bin)DummyHeader.o $(bin)DummyTrackDict.o $(bin)DummyTTHit.o $(bin)MakeSample.o $(bin)SelectEventData.o) $(patsubst %.o,%.d.stamp,$(bin)DummyEventDict.o $(bin)DummyTTHitDict.o $(bin)DummyEvent.o $(bin)DummyPMTHit.o $(bin)TestRecEDM.o $(bin)DummyPMTHitDict.o $(bin)DummyTrack.o $(bin)DummyHeaderDict.o $(bin)DummyHeader.o $(bin)DummyTrackDict.o $(bin)DummyTTHit.o $(bin)MakeSample.o $(bin)SelectEventData.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RootIOTest_deps RootIOTest_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RootIOTestinstallname = $(library_prefix)RootIOTest$(library_suffix).$(shlibsuffix)

RootIOTest :: RootIOTestinstall ;

install :: RootIOTestinstall ;

RootIOTestinstall :: $(install_dir)/$(RootIOTestinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RootIOTestinstallname) :: $(bin)$(RootIOTestinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootIOTestinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RootIOTestclean :: RootIOTestuninstall

uninstall :: RootIOTestuninstall ;

RootIOTestuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootIOTestinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),RootIOTestprototype)

$(bin)RootIOTest_dependencies.make : $(use_requirements) $(cmt_final_setup_RootIOTest)
	$(echo) "(RootIOTest.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)DummyEventDict.cc $(src)DummyTTHitDict.cc $(src)DummyEvent.cc $(src)DummyPMTHit.cc $(src)TestRecEDM.cc $(src)DummyPMTHitDict.cc $(src)DummyTrack.cc $(src)DummyHeaderDict.cc $(src)DummyHeader.cc $(src)DummyTrackDict.cc $(src)DummyTTHit.cc $(src)MakeSample.cc $(src)SelectEventData.cc -end_all $(includes) $(app_RootIOTest_cppflags) $(lib_RootIOTest_cppflags) -name=RootIOTest $? -f=$(cmt_dependencies_in_RootIOTest) -without_cmt

-include $(bin)RootIOTest_dependencies.make

endif
endif
endif

RootIOTestclean ::
	$(cleanup_silent) \rm -rf $(bin)RootIOTest_deps $(bin)RootIOTest_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyEventDict.d

$(bin)$(binobj)DummyEventDict.d :

$(bin)$(binobj)DummyEventDict.o : $(cmt_final_setup_RootIOTest)

$(bin)$(binobj)DummyEventDict.o : $(src)DummyEventDict.cc
	$(cpp_echo) $(src)DummyEventDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyEventDict_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyEventDict_cppflags) $(DummyEventDict_cc_cppflags)  $(src)DummyEventDict.cc
endif
endif

else
$(bin)RootIOTest_dependencies.make : $(DummyEventDict_cc_dependencies)

$(bin)RootIOTest_dependencies.make : $(src)DummyEventDict.cc

$(bin)$(binobj)DummyEventDict.o : $(DummyEventDict_cc_dependencies)
	$(cpp_echo) $(src)DummyEventDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyEventDict_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyEventDict_cppflags) $(DummyEventDict_cc_cppflags)  $(src)DummyEventDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyTTHitDict.d

$(bin)$(binobj)DummyTTHitDict.d :

$(bin)$(binobj)DummyTTHitDict.o : $(cmt_final_setup_RootIOTest)

$(bin)$(binobj)DummyTTHitDict.o : $(src)DummyTTHitDict.cc
	$(cpp_echo) $(src)DummyTTHitDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyTTHitDict_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyTTHitDict_cppflags) $(DummyTTHitDict_cc_cppflags)  $(src)DummyTTHitDict.cc
endif
endif

else
$(bin)RootIOTest_dependencies.make : $(DummyTTHitDict_cc_dependencies)

$(bin)RootIOTest_dependencies.make : $(src)DummyTTHitDict.cc

$(bin)$(binobj)DummyTTHitDict.o : $(DummyTTHitDict_cc_dependencies)
	$(cpp_echo) $(src)DummyTTHitDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyTTHitDict_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyTTHitDict_cppflags) $(DummyTTHitDict_cc_cppflags)  $(src)DummyTTHitDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyEvent.d

$(bin)$(binobj)DummyEvent.d :

$(bin)$(binobj)DummyEvent.o : $(cmt_final_setup_RootIOTest)

$(bin)$(binobj)DummyEvent.o : $(src)DummyEvent.cc
	$(cpp_echo) $(src)DummyEvent.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyEvent_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyEvent_cppflags) $(DummyEvent_cc_cppflags)  $(src)DummyEvent.cc
endif
endif

else
$(bin)RootIOTest_dependencies.make : $(DummyEvent_cc_dependencies)

$(bin)RootIOTest_dependencies.make : $(src)DummyEvent.cc

$(bin)$(binobj)DummyEvent.o : $(DummyEvent_cc_dependencies)
	$(cpp_echo) $(src)DummyEvent.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyEvent_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyEvent_cppflags) $(DummyEvent_cc_cppflags)  $(src)DummyEvent.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyPMTHit.d

$(bin)$(binobj)DummyPMTHit.d :

$(bin)$(binobj)DummyPMTHit.o : $(cmt_final_setup_RootIOTest)

$(bin)$(binobj)DummyPMTHit.o : $(src)DummyPMTHit.cc
	$(cpp_echo) $(src)DummyPMTHit.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyPMTHit_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyPMTHit_cppflags) $(DummyPMTHit_cc_cppflags)  $(src)DummyPMTHit.cc
endif
endif

else
$(bin)RootIOTest_dependencies.make : $(DummyPMTHit_cc_dependencies)

$(bin)RootIOTest_dependencies.make : $(src)DummyPMTHit.cc

$(bin)$(binobj)DummyPMTHit.o : $(DummyPMTHit_cc_dependencies)
	$(cpp_echo) $(src)DummyPMTHit.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyPMTHit_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyPMTHit_cppflags) $(DummyPMTHit_cc_cppflags)  $(src)DummyPMTHit.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TestRecEDM.d

$(bin)$(binobj)TestRecEDM.d :

$(bin)$(binobj)TestRecEDM.o : $(cmt_final_setup_RootIOTest)

$(bin)$(binobj)TestRecEDM.o : $(src)TestRecEDM.cc
	$(cpp_echo) $(src)TestRecEDM.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(TestRecEDM_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(TestRecEDM_cppflags) $(TestRecEDM_cc_cppflags)  $(src)TestRecEDM.cc
endif
endif

else
$(bin)RootIOTest_dependencies.make : $(TestRecEDM_cc_dependencies)

$(bin)RootIOTest_dependencies.make : $(src)TestRecEDM.cc

$(bin)$(binobj)TestRecEDM.o : $(TestRecEDM_cc_dependencies)
	$(cpp_echo) $(src)TestRecEDM.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(TestRecEDM_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(TestRecEDM_cppflags) $(TestRecEDM_cc_cppflags)  $(src)TestRecEDM.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyPMTHitDict.d

$(bin)$(binobj)DummyPMTHitDict.d :

$(bin)$(binobj)DummyPMTHitDict.o : $(cmt_final_setup_RootIOTest)

$(bin)$(binobj)DummyPMTHitDict.o : $(src)DummyPMTHitDict.cc
	$(cpp_echo) $(src)DummyPMTHitDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyPMTHitDict_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyPMTHitDict_cppflags) $(DummyPMTHitDict_cc_cppflags)  $(src)DummyPMTHitDict.cc
endif
endif

else
$(bin)RootIOTest_dependencies.make : $(DummyPMTHitDict_cc_dependencies)

$(bin)RootIOTest_dependencies.make : $(src)DummyPMTHitDict.cc

$(bin)$(binobj)DummyPMTHitDict.o : $(DummyPMTHitDict_cc_dependencies)
	$(cpp_echo) $(src)DummyPMTHitDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyPMTHitDict_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyPMTHitDict_cppflags) $(DummyPMTHitDict_cc_cppflags)  $(src)DummyPMTHitDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyTrack.d

$(bin)$(binobj)DummyTrack.d :

$(bin)$(binobj)DummyTrack.o : $(cmt_final_setup_RootIOTest)

$(bin)$(binobj)DummyTrack.o : $(src)DummyTrack.cc
	$(cpp_echo) $(src)DummyTrack.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyTrack_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyTrack_cppflags) $(DummyTrack_cc_cppflags)  $(src)DummyTrack.cc
endif
endif

else
$(bin)RootIOTest_dependencies.make : $(DummyTrack_cc_dependencies)

$(bin)RootIOTest_dependencies.make : $(src)DummyTrack.cc

$(bin)$(binobj)DummyTrack.o : $(DummyTrack_cc_dependencies)
	$(cpp_echo) $(src)DummyTrack.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyTrack_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyTrack_cppflags) $(DummyTrack_cc_cppflags)  $(src)DummyTrack.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyHeaderDict.d

$(bin)$(binobj)DummyHeaderDict.d :

$(bin)$(binobj)DummyHeaderDict.o : $(cmt_final_setup_RootIOTest)

$(bin)$(binobj)DummyHeaderDict.o : $(src)DummyHeaderDict.cc
	$(cpp_echo) $(src)DummyHeaderDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyHeaderDict_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyHeaderDict_cppflags) $(DummyHeaderDict_cc_cppflags)  $(src)DummyHeaderDict.cc
endif
endif

else
$(bin)RootIOTest_dependencies.make : $(DummyHeaderDict_cc_dependencies)

$(bin)RootIOTest_dependencies.make : $(src)DummyHeaderDict.cc

$(bin)$(binobj)DummyHeaderDict.o : $(DummyHeaderDict_cc_dependencies)
	$(cpp_echo) $(src)DummyHeaderDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyHeaderDict_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyHeaderDict_cppflags) $(DummyHeaderDict_cc_cppflags)  $(src)DummyHeaderDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyHeader.d

$(bin)$(binobj)DummyHeader.d :

$(bin)$(binobj)DummyHeader.o : $(cmt_final_setup_RootIOTest)

$(bin)$(binobj)DummyHeader.o : $(src)DummyHeader.cc
	$(cpp_echo) $(src)DummyHeader.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyHeader_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyHeader_cppflags) $(DummyHeader_cc_cppflags)  $(src)DummyHeader.cc
endif
endif

else
$(bin)RootIOTest_dependencies.make : $(DummyHeader_cc_dependencies)

$(bin)RootIOTest_dependencies.make : $(src)DummyHeader.cc

$(bin)$(binobj)DummyHeader.o : $(DummyHeader_cc_dependencies)
	$(cpp_echo) $(src)DummyHeader.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyHeader_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyHeader_cppflags) $(DummyHeader_cc_cppflags)  $(src)DummyHeader.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyTrackDict.d

$(bin)$(binobj)DummyTrackDict.d :

$(bin)$(binobj)DummyTrackDict.o : $(cmt_final_setup_RootIOTest)

$(bin)$(binobj)DummyTrackDict.o : $(src)DummyTrackDict.cc
	$(cpp_echo) $(src)DummyTrackDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyTrackDict_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyTrackDict_cppflags) $(DummyTrackDict_cc_cppflags)  $(src)DummyTrackDict.cc
endif
endif

else
$(bin)RootIOTest_dependencies.make : $(DummyTrackDict_cc_dependencies)

$(bin)RootIOTest_dependencies.make : $(src)DummyTrackDict.cc

$(bin)$(binobj)DummyTrackDict.o : $(DummyTrackDict_cc_dependencies)
	$(cpp_echo) $(src)DummyTrackDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyTrackDict_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyTrackDict_cppflags) $(DummyTrackDict_cc_cppflags)  $(src)DummyTrackDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyTTHit.d

$(bin)$(binobj)DummyTTHit.d :

$(bin)$(binobj)DummyTTHit.o : $(cmt_final_setup_RootIOTest)

$(bin)$(binobj)DummyTTHit.o : $(src)DummyTTHit.cc
	$(cpp_echo) $(src)DummyTTHit.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyTTHit_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyTTHit_cppflags) $(DummyTTHit_cc_cppflags)  $(src)DummyTTHit.cc
endif
endif

else
$(bin)RootIOTest_dependencies.make : $(DummyTTHit_cc_dependencies)

$(bin)RootIOTest_dependencies.make : $(src)DummyTTHit.cc

$(bin)$(binobj)DummyTTHit.o : $(DummyTTHit_cc_dependencies)
	$(cpp_echo) $(src)DummyTTHit.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(DummyTTHit_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(DummyTTHit_cppflags) $(DummyTTHit_cc_cppflags)  $(src)DummyTTHit.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MakeSample.d

$(bin)$(binobj)MakeSample.d :

$(bin)$(binobj)MakeSample.o : $(cmt_final_setup_RootIOTest)

$(bin)$(binobj)MakeSample.o : $(src)MakeSample.cc
	$(cpp_echo) $(src)MakeSample.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(MakeSample_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(MakeSample_cppflags) $(MakeSample_cc_cppflags)  $(src)MakeSample.cc
endif
endif

else
$(bin)RootIOTest_dependencies.make : $(MakeSample_cc_dependencies)

$(bin)RootIOTest_dependencies.make : $(src)MakeSample.cc

$(bin)$(binobj)MakeSample.o : $(MakeSample_cc_dependencies)
	$(cpp_echo) $(src)MakeSample.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(MakeSample_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(MakeSample_cppflags) $(MakeSample_cc_cppflags)  $(src)MakeSample.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SelectEventData.d

$(bin)$(binobj)SelectEventData.d :

$(bin)$(binobj)SelectEventData.o : $(cmt_final_setup_RootIOTest)

$(bin)$(binobj)SelectEventData.o : $(src)SelectEventData.cc
	$(cpp_echo) $(src)SelectEventData.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(SelectEventData_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(SelectEventData_cppflags) $(SelectEventData_cc_cppflags)  $(src)SelectEventData.cc
endif
endif

else
$(bin)RootIOTest_dependencies.make : $(SelectEventData_cc_dependencies)

$(bin)RootIOTest_dependencies.make : $(src)SelectEventData.cc

$(bin)$(binobj)SelectEventData.o : $(SelectEventData_cc_dependencies)
	$(cpp_echo) $(src)SelectEventData.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOTest_pp_cppflags) $(lib_RootIOTest_pp_cppflags) $(SelectEventData_pp_cppflags) $(use_cppflags) $(RootIOTest_cppflags) $(lib_RootIOTest_cppflags) $(SelectEventData_cppflags) $(SelectEventData_cc_cppflags)  $(src)SelectEventData.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RootIOTestclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootIOTest.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootIOTestclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RootIOTest
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RootIOTest$(library_suffix).a $(library_prefix)RootIOTest$(library_suffix).$(shlibsuffix) RootIOTest.stamp RootIOTest.shstamp
#-- end of cleanup_library ---------------

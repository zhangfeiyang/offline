#-- start of make_header -----------------

#====================================
#  Library GenSim
#
#   Generated Fri Jul 10 19:15:44 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GenSim_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GenSim_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GenSim

GenSim_tag = $(tag)

#cmt_local_tagfile_GenSim = $(GenSim_tag)_GenSim.make
cmt_local_tagfile_GenSim = $(bin)$(GenSim_tag)_GenSim.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GenSim_tag = $(tag)

#cmt_local_tagfile_GenSim = $(GenSim_tag).make
cmt_local_tagfile_GenSim = $(bin)$(GenSim_tag).make

endif

include $(cmt_local_tagfile_GenSim)
#-include $(cmt_local_tagfile_GenSim)

ifdef cmt_GenSim_has_target_tag

cmt_final_setup_GenSim = $(bin)setup_GenSim.make
cmt_dependencies_in_GenSim = $(bin)dependencies_GenSim.in
#cmt_final_setup_GenSim = $(bin)GenSim_GenSimsetup.make
cmt_local_GenSim_makefile = $(bin)GenSim.make

else

cmt_final_setup_GenSim = $(bin)setup.make
cmt_dependencies_in_GenSim = $(bin)dependencies.in
#cmt_final_setup_GenSim = $(bin)GenSimsetup.make
cmt_local_GenSim_makefile = $(bin)GenSim.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GenSimsetup.make

#GenSim :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GenSim'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GenSim/
#GenSim::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GenSimlibname   = $(bin)$(library_prefix)GenSim$(library_suffix)
GenSimlib       = $(GenSimlibname).a
GenSimstamp     = $(bin)GenSim.stamp
GenSimshstamp   = $(bin)GenSim.shstamp

GenSim :: dirs  GenSimLIB
	$(echo) "GenSim ok"

cmt_GenSim_has_prototypes = 1

#--------------------------------------

ifdef cmt_GenSim_has_prototypes

GenSimprototype :  ;

endif

GenSimcompile : $(bin)OpticalPhotonGunRan.o $(bin)testLocalToGlobal.o $(bin)RandomPositionTubeGen.o $(bin)RandomPositionFaceGen.o $(bin)HepEvtParser.o $(bin)PMTGlassPosGenV2.o $(bin)RandomPositionGen.o $(bin)PMTGlassPosGen.o $(bin)RandomAngleGen.o $(bin)RandomPositionBallGen.o $(bin)LocalPVTransform.o $(bin)PVPathTransformV2.o $(bin)getEnergy.o $(bin)OpticalPhotonGun.o $(bin)PMTGlassPosGenManagerV2.o $(bin)RandomPositionHollowGen.o $(bin)PMTGlassPosGenManager.o $(bin)PVPathTransform.o $(bin)RooTrackerParser.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

GenSimLIB :: $(GenSimlib) $(GenSimshstamp)
	$(echo) "GenSim : library ok"

$(GenSimlib) :: $(bin)OpticalPhotonGunRan.o $(bin)testLocalToGlobal.o $(bin)RandomPositionTubeGen.o $(bin)RandomPositionFaceGen.o $(bin)HepEvtParser.o $(bin)PMTGlassPosGenV2.o $(bin)RandomPositionGen.o $(bin)PMTGlassPosGen.o $(bin)RandomAngleGen.o $(bin)RandomPositionBallGen.o $(bin)LocalPVTransform.o $(bin)PVPathTransformV2.o $(bin)getEnergy.o $(bin)OpticalPhotonGun.o $(bin)PMTGlassPosGenManagerV2.o $(bin)RandomPositionHollowGen.o $(bin)PMTGlassPosGenManager.o $(bin)PVPathTransform.o $(bin)RooTrackerParser.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(GenSimlib) $(bin)OpticalPhotonGunRan.o $(bin)testLocalToGlobal.o $(bin)RandomPositionTubeGen.o $(bin)RandomPositionFaceGen.o $(bin)HepEvtParser.o $(bin)PMTGlassPosGenV2.o $(bin)RandomPositionGen.o $(bin)PMTGlassPosGen.o $(bin)RandomAngleGen.o $(bin)RandomPositionBallGen.o $(bin)LocalPVTransform.o $(bin)PVPathTransformV2.o $(bin)getEnergy.o $(bin)OpticalPhotonGun.o $(bin)PMTGlassPosGenManagerV2.o $(bin)RandomPositionHollowGen.o $(bin)PMTGlassPosGenManager.o $(bin)PVPathTransform.o $(bin)RooTrackerParser.o
	$(lib_silent) $(ranlib) $(GenSimlib)
	$(lib_silent) cat /dev/null >$(GenSimstamp)

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

$(GenSimlibname).$(shlibsuffix) :: $(GenSimlib) requirements $(use_requirements) $(GenSimstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" GenSim $(GenSim_shlibflags)
	$(lib_silent) cat /dev/null >$(GenSimshstamp)

$(GenSimshstamp) :: $(GenSimlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GenSimlibname).$(shlibsuffix) ; then cat /dev/null >$(GenSimshstamp) ; fi

GenSimclean ::
	$(cleanup_echo) objects GenSim
	$(cleanup_silent) /bin/rm -f $(bin)OpticalPhotonGunRan.o $(bin)testLocalToGlobal.o $(bin)RandomPositionTubeGen.o $(bin)RandomPositionFaceGen.o $(bin)HepEvtParser.o $(bin)PMTGlassPosGenV2.o $(bin)RandomPositionGen.o $(bin)PMTGlassPosGen.o $(bin)RandomAngleGen.o $(bin)RandomPositionBallGen.o $(bin)LocalPVTransform.o $(bin)PVPathTransformV2.o $(bin)getEnergy.o $(bin)OpticalPhotonGun.o $(bin)PMTGlassPosGenManagerV2.o $(bin)RandomPositionHollowGen.o $(bin)PMTGlassPosGenManager.o $(bin)PVPathTransform.o $(bin)RooTrackerParser.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)OpticalPhotonGunRan.o $(bin)testLocalToGlobal.o $(bin)RandomPositionTubeGen.o $(bin)RandomPositionFaceGen.o $(bin)HepEvtParser.o $(bin)PMTGlassPosGenV2.o $(bin)RandomPositionGen.o $(bin)PMTGlassPosGen.o $(bin)RandomAngleGen.o $(bin)RandomPositionBallGen.o $(bin)LocalPVTransform.o $(bin)PVPathTransformV2.o $(bin)getEnergy.o $(bin)OpticalPhotonGun.o $(bin)PMTGlassPosGenManagerV2.o $(bin)RandomPositionHollowGen.o $(bin)PMTGlassPosGenManager.o $(bin)PVPathTransform.o $(bin)RooTrackerParser.o) $(patsubst %.o,%.dep,$(bin)OpticalPhotonGunRan.o $(bin)testLocalToGlobal.o $(bin)RandomPositionTubeGen.o $(bin)RandomPositionFaceGen.o $(bin)HepEvtParser.o $(bin)PMTGlassPosGenV2.o $(bin)RandomPositionGen.o $(bin)PMTGlassPosGen.o $(bin)RandomAngleGen.o $(bin)RandomPositionBallGen.o $(bin)LocalPVTransform.o $(bin)PVPathTransformV2.o $(bin)getEnergy.o $(bin)OpticalPhotonGun.o $(bin)PMTGlassPosGenManagerV2.o $(bin)RandomPositionHollowGen.o $(bin)PMTGlassPosGenManager.o $(bin)PVPathTransform.o $(bin)RooTrackerParser.o) $(patsubst %.o,%.d.stamp,$(bin)OpticalPhotonGunRan.o $(bin)testLocalToGlobal.o $(bin)RandomPositionTubeGen.o $(bin)RandomPositionFaceGen.o $(bin)HepEvtParser.o $(bin)PMTGlassPosGenV2.o $(bin)RandomPositionGen.o $(bin)PMTGlassPosGen.o $(bin)RandomAngleGen.o $(bin)RandomPositionBallGen.o $(bin)LocalPVTransform.o $(bin)PVPathTransformV2.o $(bin)getEnergy.o $(bin)OpticalPhotonGun.o $(bin)PMTGlassPosGenManagerV2.o $(bin)RandomPositionHollowGen.o $(bin)PMTGlassPosGenManager.o $(bin)PVPathTransform.o $(bin)RooTrackerParser.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GenSim_deps GenSim_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GenSiminstallname = $(library_prefix)GenSim$(library_suffix).$(shlibsuffix)

GenSim :: GenSiminstall ;

install :: GenSiminstall ;

GenSiminstall :: $(install_dir)/$(GenSiminstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GenSiminstallname) :: $(bin)$(GenSiminstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GenSiminstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GenSimclean :: GenSimuninstall

uninstall :: GenSimuninstall ;

GenSimuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GenSiminstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),GenSimprototype)

$(bin)GenSim_dependencies.make : $(use_requirements) $(cmt_final_setup_GenSim)
	$(echo) "(GenSim.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)OpticalPhotonGunRan.cc $(src)testLocalToGlobal.cc $(src)RandomPositionTubeGen.cc $(src)RandomPositionFaceGen.cc $(src)HepEvtParser.cc $(src)PMTGlassPosGenV2.cc $(src)RandomPositionGen.cc $(src)PMTGlassPosGen.cc $(src)RandomAngleGen.cc $(src)RandomPositionBallGen.cc $(src)LocalPVTransform.cc $(src)PVPathTransformV2.cc $(src)getEnergy.cc $(src)OpticalPhotonGun.cc $(src)PMTGlassPosGenManagerV2.cc $(src)RandomPositionHollowGen.cc $(src)PMTGlassPosGenManager.cc $(src)PVPathTransform.cc $(src)RooTrackerParser.cc -end_all $(includes) $(app_GenSim_cppflags) $(lib_GenSim_cppflags) -name=GenSim $? -f=$(cmt_dependencies_in_GenSim) -without_cmt

-include $(bin)GenSim_dependencies.make

endif
endif
endif

GenSimclean ::
	$(cleanup_silent) \rm -rf $(bin)GenSim_deps $(bin)GenSim_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)OpticalPhotonGunRan.d

$(bin)$(binobj)OpticalPhotonGunRan.d :

$(bin)$(binobj)OpticalPhotonGunRan.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)OpticalPhotonGunRan.o : $(src)OpticalPhotonGunRan.cc
	$(cpp_echo) $(src)OpticalPhotonGunRan.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(OpticalPhotonGunRan_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(OpticalPhotonGunRan_cppflags) $(OpticalPhotonGunRan_cc_cppflags)  $(src)OpticalPhotonGunRan.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(OpticalPhotonGunRan_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)OpticalPhotonGunRan.cc

$(bin)$(binobj)OpticalPhotonGunRan.o : $(OpticalPhotonGunRan_cc_dependencies)
	$(cpp_echo) $(src)OpticalPhotonGunRan.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(OpticalPhotonGunRan_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(OpticalPhotonGunRan_cppflags) $(OpticalPhotonGunRan_cc_cppflags)  $(src)OpticalPhotonGunRan.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)testLocalToGlobal.d

$(bin)$(binobj)testLocalToGlobal.d :

$(bin)$(binobj)testLocalToGlobal.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)testLocalToGlobal.o : $(src)testLocalToGlobal.cc
	$(cpp_echo) $(src)testLocalToGlobal.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(testLocalToGlobal_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(testLocalToGlobal_cppflags) $(testLocalToGlobal_cc_cppflags)  $(src)testLocalToGlobal.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(testLocalToGlobal_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)testLocalToGlobal.cc

$(bin)$(binobj)testLocalToGlobal.o : $(testLocalToGlobal_cc_dependencies)
	$(cpp_echo) $(src)testLocalToGlobal.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(testLocalToGlobal_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(testLocalToGlobal_cppflags) $(testLocalToGlobal_cc_cppflags)  $(src)testLocalToGlobal.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RandomPositionTubeGen.d

$(bin)$(binobj)RandomPositionTubeGen.d :

$(bin)$(binobj)RandomPositionTubeGen.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)RandomPositionTubeGen.o : $(src)RandomPositionTubeGen.cc
	$(cpp_echo) $(src)RandomPositionTubeGen.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RandomPositionTubeGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RandomPositionTubeGen_cppflags) $(RandomPositionTubeGen_cc_cppflags)  $(src)RandomPositionTubeGen.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(RandomPositionTubeGen_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)RandomPositionTubeGen.cc

$(bin)$(binobj)RandomPositionTubeGen.o : $(RandomPositionTubeGen_cc_dependencies)
	$(cpp_echo) $(src)RandomPositionTubeGen.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RandomPositionTubeGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RandomPositionTubeGen_cppflags) $(RandomPositionTubeGen_cc_cppflags)  $(src)RandomPositionTubeGen.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RandomPositionFaceGen.d

$(bin)$(binobj)RandomPositionFaceGen.d :

$(bin)$(binobj)RandomPositionFaceGen.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)RandomPositionFaceGen.o : $(src)RandomPositionFaceGen.cc
	$(cpp_echo) $(src)RandomPositionFaceGen.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RandomPositionFaceGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RandomPositionFaceGen_cppflags) $(RandomPositionFaceGen_cc_cppflags)  $(src)RandomPositionFaceGen.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(RandomPositionFaceGen_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)RandomPositionFaceGen.cc

$(bin)$(binobj)RandomPositionFaceGen.o : $(RandomPositionFaceGen_cc_dependencies)
	$(cpp_echo) $(src)RandomPositionFaceGen.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RandomPositionFaceGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RandomPositionFaceGen_cppflags) $(RandomPositionFaceGen_cc_cppflags)  $(src)RandomPositionFaceGen.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HepEvtParser.d

$(bin)$(binobj)HepEvtParser.d :

$(bin)$(binobj)HepEvtParser.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)HepEvtParser.o : $(src)HepEvtParser.cc
	$(cpp_echo) $(src)HepEvtParser.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(HepEvtParser_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(HepEvtParser_cppflags) $(HepEvtParser_cc_cppflags)  $(src)HepEvtParser.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(HepEvtParser_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)HepEvtParser.cc

$(bin)$(binobj)HepEvtParser.o : $(HepEvtParser_cc_dependencies)
	$(cpp_echo) $(src)HepEvtParser.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(HepEvtParser_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(HepEvtParser_cppflags) $(HepEvtParser_cc_cppflags)  $(src)HepEvtParser.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PMTGlassPosGenV2.d

$(bin)$(binobj)PMTGlassPosGenV2.d :

$(bin)$(binobj)PMTGlassPosGenV2.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)PMTGlassPosGenV2.o : $(src)PMTGlassPosGenV2.cc
	$(cpp_echo) $(src)PMTGlassPosGenV2.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(PMTGlassPosGenV2_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(PMTGlassPosGenV2_cppflags) $(PMTGlassPosGenV2_cc_cppflags)  $(src)PMTGlassPosGenV2.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(PMTGlassPosGenV2_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)PMTGlassPosGenV2.cc

$(bin)$(binobj)PMTGlassPosGenV2.o : $(PMTGlassPosGenV2_cc_dependencies)
	$(cpp_echo) $(src)PMTGlassPosGenV2.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(PMTGlassPosGenV2_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(PMTGlassPosGenV2_cppflags) $(PMTGlassPosGenV2_cc_cppflags)  $(src)PMTGlassPosGenV2.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RandomPositionGen.d

$(bin)$(binobj)RandomPositionGen.d :

$(bin)$(binobj)RandomPositionGen.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)RandomPositionGen.o : $(src)RandomPositionGen.cc
	$(cpp_echo) $(src)RandomPositionGen.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RandomPositionGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RandomPositionGen_cppflags) $(RandomPositionGen_cc_cppflags)  $(src)RandomPositionGen.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(RandomPositionGen_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)RandomPositionGen.cc

$(bin)$(binobj)RandomPositionGen.o : $(RandomPositionGen_cc_dependencies)
	$(cpp_echo) $(src)RandomPositionGen.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RandomPositionGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RandomPositionGen_cppflags) $(RandomPositionGen_cc_cppflags)  $(src)RandomPositionGen.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PMTGlassPosGen.d

$(bin)$(binobj)PMTGlassPosGen.d :

$(bin)$(binobj)PMTGlassPosGen.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)PMTGlassPosGen.o : $(src)PMTGlassPosGen.cc
	$(cpp_echo) $(src)PMTGlassPosGen.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(PMTGlassPosGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(PMTGlassPosGen_cppflags) $(PMTGlassPosGen_cc_cppflags)  $(src)PMTGlassPosGen.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(PMTGlassPosGen_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)PMTGlassPosGen.cc

$(bin)$(binobj)PMTGlassPosGen.o : $(PMTGlassPosGen_cc_dependencies)
	$(cpp_echo) $(src)PMTGlassPosGen.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(PMTGlassPosGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(PMTGlassPosGen_cppflags) $(PMTGlassPosGen_cc_cppflags)  $(src)PMTGlassPosGen.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RandomAngleGen.d

$(bin)$(binobj)RandomAngleGen.d :

$(bin)$(binobj)RandomAngleGen.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)RandomAngleGen.o : $(src)RandomAngleGen.cc
	$(cpp_echo) $(src)RandomAngleGen.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RandomAngleGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RandomAngleGen_cppflags) $(RandomAngleGen_cc_cppflags)  $(src)RandomAngleGen.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(RandomAngleGen_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)RandomAngleGen.cc

$(bin)$(binobj)RandomAngleGen.o : $(RandomAngleGen_cc_dependencies)
	$(cpp_echo) $(src)RandomAngleGen.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RandomAngleGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RandomAngleGen_cppflags) $(RandomAngleGen_cc_cppflags)  $(src)RandomAngleGen.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RandomPositionBallGen.d

$(bin)$(binobj)RandomPositionBallGen.d :

$(bin)$(binobj)RandomPositionBallGen.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)RandomPositionBallGen.o : $(src)RandomPositionBallGen.cc
	$(cpp_echo) $(src)RandomPositionBallGen.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RandomPositionBallGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RandomPositionBallGen_cppflags) $(RandomPositionBallGen_cc_cppflags)  $(src)RandomPositionBallGen.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(RandomPositionBallGen_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)RandomPositionBallGen.cc

$(bin)$(binobj)RandomPositionBallGen.o : $(RandomPositionBallGen_cc_dependencies)
	$(cpp_echo) $(src)RandomPositionBallGen.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RandomPositionBallGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RandomPositionBallGen_cppflags) $(RandomPositionBallGen_cc_cppflags)  $(src)RandomPositionBallGen.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LocalPVTransform.d

$(bin)$(binobj)LocalPVTransform.d :

$(bin)$(binobj)LocalPVTransform.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)LocalPVTransform.o : $(src)LocalPVTransform.cc
	$(cpp_echo) $(src)LocalPVTransform.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(LocalPVTransform_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(LocalPVTransform_cppflags) $(LocalPVTransform_cc_cppflags)  $(src)LocalPVTransform.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(LocalPVTransform_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)LocalPVTransform.cc

$(bin)$(binobj)LocalPVTransform.o : $(LocalPVTransform_cc_dependencies)
	$(cpp_echo) $(src)LocalPVTransform.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(LocalPVTransform_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(LocalPVTransform_cppflags) $(LocalPVTransform_cc_cppflags)  $(src)LocalPVTransform.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PVPathTransformV2.d

$(bin)$(binobj)PVPathTransformV2.d :

$(bin)$(binobj)PVPathTransformV2.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)PVPathTransformV2.o : $(src)PVPathTransformV2.cc
	$(cpp_echo) $(src)PVPathTransformV2.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(PVPathTransformV2_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(PVPathTransformV2_cppflags) $(PVPathTransformV2_cc_cppflags)  $(src)PVPathTransformV2.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(PVPathTransformV2_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)PVPathTransformV2.cc

$(bin)$(binobj)PVPathTransformV2.o : $(PVPathTransformV2_cc_dependencies)
	$(cpp_echo) $(src)PVPathTransformV2.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(PVPathTransformV2_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(PVPathTransformV2_cppflags) $(PVPathTransformV2_cc_cppflags)  $(src)PVPathTransformV2.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)getEnergy.d

$(bin)$(binobj)getEnergy.d :

$(bin)$(binobj)getEnergy.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)getEnergy.o : $(src)getEnergy.cc
	$(cpp_echo) $(src)getEnergy.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(getEnergy_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(getEnergy_cppflags) $(getEnergy_cc_cppflags)  $(src)getEnergy.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(getEnergy_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)getEnergy.cc

$(bin)$(binobj)getEnergy.o : $(getEnergy_cc_dependencies)
	$(cpp_echo) $(src)getEnergy.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(getEnergy_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(getEnergy_cppflags) $(getEnergy_cc_cppflags)  $(src)getEnergy.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)OpticalPhotonGun.d

$(bin)$(binobj)OpticalPhotonGun.d :

$(bin)$(binobj)OpticalPhotonGun.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)OpticalPhotonGun.o : $(src)OpticalPhotonGun.cc
	$(cpp_echo) $(src)OpticalPhotonGun.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(OpticalPhotonGun_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(OpticalPhotonGun_cppflags) $(OpticalPhotonGun_cc_cppflags)  $(src)OpticalPhotonGun.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(OpticalPhotonGun_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)OpticalPhotonGun.cc

$(bin)$(binobj)OpticalPhotonGun.o : $(OpticalPhotonGun_cc_dependencies)
	$(cpp_echo) $(src)OpticalPhotonGun.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(OpticalPhotonGun_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(OpticalPhotonGun_cppflags) $(OpticalPhotonGun_cc_cppflags)  $(src)OpticalPhotonGun.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PMTGlassPosGenManagerV2.d

$(bin)$(binobj)PMTGlassPosGenManagerV2.d :

$(bin)$(binobj)PMTGlassPosGenManagerV2.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)PMTGlassPosGenManagerV2.o : $(src)PMTGlassPosGenManagerV2.cc
	$(cpp_echo) $(src)PMTGlassPosGenManagerV2.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(PMTGlassPosGenManagerV2_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(PMTGlassPosGenManagerV2_cppflags) $(PMTGlassPosGenManagerV2_cc_cppflags)  $(src)PMTGlassPosGenManagerV2.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(PMTGlassPosGenManagerV2_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)PMTGlassPosGenManagerV2.cc

$(bin)$(binobj)PMTGlassPosGenManagerV2.o : $(PMTGlassPosGenManagerV2_cc_dependencies)
	$(cpp_echo) $(src)PMTGlassPosGenManagerV2.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(PMTGlassPosGenManagerV2_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(PMTGlassPosGenManagerV2_cppflags) $(PMTGlassPosGenManagerV2_cc_cppflags)  $(src)PMTGlassPosGenManagerV2.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RandomPositionHollowGen.d

$(bin)$(binobj)RandomPositionHollowGen.d :

$(bin)$(binobj)RandomPositionHollowGen.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)RandomPositionHollowGen.o : $(src)RandomPositionHollowGen.cc
	$(cpp_echo) $(src)RandomPositionHollowGen.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RandomPositionHollowGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RandomPositionHollowGen_cppflags) $(RandomPositionHollowGen_cc_cppflags)  $(src)RandomPositionHollowGen.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(RandomPositionHollowGen_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)RandomPositionHollowGen.cc

$(bin)$(binobj)RandomPositionHollowGen.o : $(RandomPositionHollowGen_cc_dependencies)
	$(cpp_echo) $(src)RandomPositionHollowGen.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RandomPositionHollowGen_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RandomPositionHollowGen_cppflags) $(RandomPositionHollowGen_cc_cppflags)  $(src)RandomPositionHollowGen.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PMTGlassPosGenManager.d

$(bin)$(binobj)PMTGlassPosGenManager.d :

$(bin)$(binobj)PMTGlassPosGenManager.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)PMTGlassPosGenManager.o : $(src)PMTGlassPosGenManager.cc
	$(cpp_echo) $(src)PMTGlassPosGenManager.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(PMTGlassPosGenManager_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(PMTGlassPosGenManager_cppflags) $(PMTGlassPosGenManager_cc_cppflags)  $(src)PMTGlassPosGenManager.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(PMTGlassPosGenManager_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)PMTGlassPosGenManager.cc

$(bin)$(binobj)PMTGlassPosGenManager.o : $(PMTGlassPosGenManager_cc_dependencies)
	$(cpp_echo) $(src)PMTGlassPosGenManager.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(PMTGlassPosGenManager_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(PMTGlassPosGenManager_cppflags) $(PMTGlassPosGenManager_cc_cppflags)  $(src)PMTGlassPosGenManager.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PVPathTransform.d

$(bin)$(binobj)PVPathTransform.d :

$(bin)$(binobj)PVPathTransform.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)PVPathTransform.o : $(src)PVPathTransform.cc
	$(cpp_echo) $(src)PVPathTransform.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(PVPathTransform_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(PVPathTransform_cppflags) $(PVPathTransform_cc_cppflags)  $(src)PVPathTransform.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(PVPathTransform_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)PVPathTransform.cc

$(bin)$(binobj)PVPathTransform.o : $(PVPathTransform_cc_dependencies)
	$(cpp_echo) $(src)PVPathTransform.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(PVPathTransform_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(PVPathTransform_cppflags) $(PVPathTransform_cc_cppflags)  $(src)PVPathTransform.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RooTrackerParser.d

$(bin)$(binobj)RooTrackerParser.d :

$(bin)$(binobj)RooTrackerParser.o : $(cmt_final_setup_GenSim)

$(bin)$(binobj)RooTrackerParser.o : $(src)RooTrackerParser.cc
	$(cpp_echo) $(src)RooTrackerParser.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RooTrackerParser_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RooTrackerParser_cppflags) $(RooTrackerParser_cc_cppflags)  $(src)RooTrackerParser.cc
endif
endif

else
$(bin)GenSim_dependencies.make : $(RooTrackerParser_cc_dependencies)

$(bin)GenSim_dependencies.make : $(src)RooTrackerParser.cc

$(bin)$(binobj)RooTrackerParser.o : $(RooTrackerParser_cc_dependencies)
	$(cpp_echo) $(src)RooTrackerParser.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenSim_pp_cppflags) $(lib_GenSim_pp_cppflags) $(RooTrackerParser_pp_cppflags) $(use_cppflags) $(GenSim_cppflags) $(lib_GenSim_cppflags) $(RooTrackerParser_cppflags) $(RooTrackerParser_cc_cppflags)  $(src)RooTrackerParser.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GenSimclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GenSim.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GenSimclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GenSim
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GenSim$(library_suffix).a $(library_prefix)GenSim$(library_suffix).$(shlibsuffix) GenSim.stamp GenSim.shstamp
#-- end of cleanup_library ---------------

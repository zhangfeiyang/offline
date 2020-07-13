#-- start of make_header -----------------

#====================================
#  Library CentralDetector
#
#   Generated Sun Jul 12 17:26:21 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_CentralDetector_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_CentralDetector_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_CentralDetector

CentralDetector_tag = $(tag)

#cmt_local_tagfile_CentralDetector = $(CentralDetector_tag)_CentralDetector.make
cmt_local_tagfile_CentralDetector = $(bin)$(CentralDetector_tag)_CentralDetector.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CentralDetector_tag = $(tag)

#cmt_local_tagfile_CentralDetector = $(CentralDetector_tag).make
cmt_local_tagfile_CentralDetector = $(bin)$(CentralDetector_tag).make

endif

include $(cmt_local_tagfile_CentralDetector)
#-include $(cmt_local_tagfile_CentralDetector)

ifdef cmt_CentralDetector_has_target_tag

cmt_final_setup_CentralDetector = $(bin)setup_CentralDetector.make
cmt_dependencies_in_CentralDetector = $(bin)dependencies_CentralDetector.in
#cmt_final_setup_CentralDetector = $(bin)CentralDetector_CentralDetectorsetup.make
cmt_local_CentralDetector_makefile = $(bin)CentralDetector.make

else

cmt_final_setup_CentralDetector = $(bin)setup.make
cmt_dependencies_in_CentralDetector = $(bin)dependencies.in
#cmt_final_setup_CentralDetector = $(bin)CentralDetectorsetup.make
cmt_local_CentralDetector_makefile = $(bin)CentralDetector.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CentralDetectorsetup.make

#CentralDetector :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'CentralDetector'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = CentralDetector/
#CentralDetector::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

CentralDetectorlibname   = $(bin)$(library_prefix)CentralDetector$(library_suffix)
CentralDetectorlib       = $(CentralDetectorlibname).a
CentralDetectorstamp     = $(bin)CentralDetector.stamp
CentralDetectorshstamp   = $(bin)CentralDetector.shstamp

CentralDetector :: dirs  CentralDetectorLIB
	$(echo) "CentralDetector ok"

cmt_CentralDetector_has_prototypes = 1

#--------------------------------------

ifdef cmt_CentralDetector_has_prototypes

CentralDetectorprototype :  ;

endif

CentralDetectorcompile : $(bin)OnePMTPlacement.o $(bin)PrototypeConstruction.o $(bin)FastenerAcrylicConstruction.o $(bin)HBeamConstruction.o $(bin)RoundBottomFlaskSolidMaker.o $(bin)DetSim1Construction.o $(bin)DetSim0Construction.o $(bin)PrototypeOnePMTConstruction.o $(bin)DetSim2Construction.o $(bin)StrutAcrylicConstruction.o $(bin)dyb2NylonFilmOpticalModel.o $(bin)StrutBalloonConstruction.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

CentralDetectorLIB :: $(CentralDetectorlib) $(CentralDetectorshstamp)
	$(echo) "CentralDetector : library ok"

$(CentralDetectorlib) :: $(bin)OnePMTPlacement.o $(bin)PrototypeConstruction.o $(bin)FastenerAcrylicConstruction.o $(bin)HBeamConstruction.o $(bin)RoundBottomFlaskSolidMaker.o $(bin)DetSim1Construction.o $(bin)DetSim0Construction.o $(bin)PrototypeOnePMTConstruction.o $(bin)DetSim2Construction.o $(bin)StrutAcrylicConstruction.o $(bin)dyb2NylonFilmOpticalModel.o $(bin)StrutBalloonConstruction.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(CentralDetectorlib) $(bin)OnePMTPlacement.o $(bin)PrototypeConstruction.o $(bin)FastenerAcrylicConstruction.o $(bin)HBeamConstruction.o $(bin)RoundBottomFlaskSolidMaker.o $(bin)DetSim1Construction.o $(bin)DetSim0Construction.o $(bin)PrototypeOnePMTConstruction.o $(bin)DetSim2Construction.o $(bin)StrutAcrylicConstruction.o $(bin)dyb2NylonFilmOpticalModel.o $(bin)StrutBalloonConstruction.o
	$(lib_silent) $(ranlib) $(CentralDetectorlib)
	$(lib_silent) cat /dev/null >$(CentralDetectorstamp)

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

$(CentralDetectorlibname).$(shlibsuffix) :: $(CentralDetectorlib) requirements $(use_requirements) $(CentralDetectorstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" CentralDetector $(CentralDetector_shlibflags)
	$(lib_silent) cat /dev/null >$(CentralDetectorshstamp)

$(CentralDetectorshstamp) :: $(CentralDetectorlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(CentralDetectorlibname).$(shlibsuffix) ; then cat /dev/null >$(CentralDetectorshstamp) ; fi

CentralDetectorclean ::
	$(cleanup_echo) objects CentralDetector
	$(cleanup_silent) /bin/rm -f $(bin)OnePMTPlacement.o $(bin)PrototypeConstruction.o $(bin)FastenerAcrylicConstruction.o $(bin)HBeamConstruction.o $(bin)RoundBottomFlaskSolidMaker.o $(bin)DetSim1Construction.o $(bin)DetSim0Construction.o $(bin)PrototypeOnePMTConstruction.o $(bin)DetSim2Construction.o $(bin)StrutAcrylicConstruction.o $(bin)dyb2NylonFilmOpticalModel.o $(bin)StrutBalloonConstruction.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)OnePMTPlacement.o $(bin)PrototypeConstruction.o $(bin)FastenerAcrylicConstruction.o $(bin)HBeamConstruction.o $(bin)RoundBottomFlaskSolidMaker.o $(bin)DetSim1Construction.o $(bin)DetSim0Construction.o $(bin)PrototypeOnePMTConstruction.o $(bin)DetSim2Construction.o $(bin)StrutAcrylicConstruction.o $(bin)dyb2NylonFilmOpticalModel.o $(bin)StrutBalloonConstruction.o) $(patsubst %.o,%.dep,$(bin)OnePMTPlacement.o $(bin)PrototypeConstruction.o $(bin)FastenerAcrylicConstruction.o $(bin)HBeamConstruction.o $(bin)RoundBottomFlaskSolidMaker.o $(bin)DetSim1Construction.o $(bin)DetSim0Construction.o $(bin)PrototypeOnePMTConstruction.o $(bin)DetSim2Construction.o $(bin)StrutAcrylicConstruction.o $(bin)dyb2NylonFilmOpticalModel.o $(bin)StrutBalloonConstruction.o) $(patsubst %.o,%.d.stamp,$(bin)OnePMTPlacement.o $(bin)PrototypeConstruction.o $(bin)FastenerAcrylicConstruction.o $(bin)HBeamConstruction.o $(bin)RoundBottomFlaskSolidMaker.o $(bin)DetSim1Construction.o $(bin)DetSim0Construction.o $(bin)PrototypeOnePMTConstruction.o $(bin)DetSim2Construction.o $(bin)StrutAcrylicConstruction.o $(bin)dyb2NylonFilmOpticalModel.o $(bin)StrutBalloonConstruction.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf CentralDetector_deps CentralDetector_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
CentralDetectorinstallname = $(library_prefix)CentralDetector$(library_suffix).$(shlibsuffix)

CentralDetector :: CentralDetectorinstall ;

install :: CentralDetectorinstall ;

CentralDetectorinstall :: $(install_dir)/$(CentralDetectorinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(CentralDetectorinstallname) :: $(bin)$(CentralDetectorinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(CentralDetectorinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##CentralDetectorclean :: CentralDetectoruninstall

uninstall :: CentralDetectoruninstall ;

CentralDetectoruninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(CentralDetectorinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),CentralDetectorclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),CentralDetectorprototype)

$(bin)CentralDetector_dependencies.make : $(use_requirements) $(cmt_final_setup_CentralDetector)
	$(echo) "(CentralDetector.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)OnePMTPlacement.cc $(src)PrototypeConstruction.cc $(src)FastenerAcrylicConstruction.cc $(src)HBeamConstruction.cc $(src)RoundBottomFlaskSolidMaker.cc $(src)DetSim1Construction.cc $(src)DetSim0Construction.cc $(src)PrototypeOnePMTConstruction.cc $(src)DetSim2Construction.cc $(src)StrutAcrylicConstruction.cc $(src)dyb2NylonFilmOpticalModel.cc $(src)StrutBalloonConstruction.cc -end_all $(includes) $(app_CentralDetector_cppflags) $(lib_CentralDetector_cppflags) -name=CentralDetector $? -f=$(cmt_dependencies_in_CentralDetector) -without_cmt

-include $(bin)CentralDetector_dependencies.make

endif
endif
endif

CentralDetectorclean ::
	$(cleanup_silent) \rm -rf $(bin)CentralDetector_deps $(bin)CentralDetector_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CentralDetectorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)OnePMTPlacement.d

$(bin)$(binobj)OnePMTPlacement.d :

$(bin)$(binobj)OnePMTPlacement.o : $(cmt_final_setup_CentralDetector)

$(bin)$(binobj)OnePMTPlacement.o : $(src)OnePMTPlacement.cc
	$(cpp_echo) $(src)OnePMTPlacement.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(OnePMTPlacement_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(OnePMTPlacement_cppflags) $(OnePMTPlacement_cc_cppflags)  $(src)OnePMTPlacement.cc
endif
endif

else
$(bin)CentralDetector_dependencies.make : $(OnePMTPlacement_cc_dependencies)

$(bin)CentralDetector_dependencies.make : $(src)OnePMTPlacement.cc

$(bin)$(binobj)OnePMTPlacement.o : $(OnePMTPlacement_cc_dependencies)
	$(cpp_echo) $(src)OnePMTPlacement.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(OnePMTPlacement_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(OnePMTPlacement_cppflags) $(OnePMTPlacement_cc_cppflags)  $(src)OnePMTPlacement.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CentralDetectorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PrototypeConstruction.d

$(bin)$(binobj)PrototypeConstruction.d :

$(bin)$(binobj)PrototypeConstruction.o : $(cmt_final_setup_CentralDetector)

$(bin)$(binobj)PrototypeConstruction.o : $(src)PrototypeConstruction.cc
	$(cpp_echo) $(src)PrototypeConstruction.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(PrototypeConstruction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(PrototypeConstruction_cppflags) $(PrototypeConstruction_cc_cppflags)  $(src)PrototypeConstruction.cc
endif
endif

else
$(bin)CentralDetector_dependencies.make : $(PrototypeConstruction_cc_dependencies)

$(bin)CentralDetector_dependencies.make : $(src)PrototypeConstruction.cc

$(bin)$(binobj)PrototypeConstruction.o : $(PrototypeConstruction_cc_dependencies)
	$(cpp_echo) $(src)PrototypeConstruction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(PrototypeConstruction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(PrototypeConstruction_cppflags) $(PrototypeConstruction_cc_cppflags)  $(src)PrototypeConstruction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CentralDetectorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FastenerAcrylicConstruction.d

$(bin)$(binobj)FastenerAcrylicConstruction.d :

$(bin)$(binobj)FastenerAcrylicConstruction.o : $(cmt_final_setup_CentralDetector)

$(bin)$(binobj)FastenerAcrylicConstruction.o : $(src)FastenerAcrylicConstruction.cc
	$(cpp_echo) $(src)FastenerAcrylicConstruction.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(FastenerAcrylicConstruction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(FastenerAcrylicConstruction_cppflags) $(FastenerAcrylicConstruction_cc_cppflags)  $(src)FastenerAcrylicConstruction.cc
endif
endif

else
$(bin)CentralDetector_dependencies.make : $(FastenerAcrylicConstruction_cc_dependencies)

$(bin)CentralDetector_dependencies.make : $(src)FastenerAcrylicConstruction.cc

$(bin)$(binobj)FastenerAcrylicConstruction.o : $(FastenerAcrylicConstruction_cc_dependencies)
	$(cpp_echo) $(src)FastenerAcrylicConstruction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(FastenerAcrylicConstruction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(FastenerAcrylicConstruction_cppflags) $(FastenerAcrylicConstruction_cc_cppflags)  $(src)FastenerAcrylicConstruction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CentralDetectorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HBeamConstruction.d

$(bin)$(binobj)HBeamConstruction.d :

$(bin)$(binobj)HBeamConstruction.o : $(cmt_final_setup_CentralDetector)

$(bin)$(binobj)HBeamConstruction.o : $(src)HBeamConstruction.cc
	$(cpp_echo) $(src)HBeamConstruction.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(HBeamConstruction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(HBeamConstruction_cppflags) $(HBeamConstruction_cc_cppflags)  $(src)HBeamConstruction.cc
endif
endif

else
$(bin)CentralDetector_dependencies.make : $(HBeamConstruction_cc_dependencies)

$(bin)CentralDetector_dependencies.make : $(src)HBeamConstruction.cc

$(bin)$(binobj)HBeamConstruction.o : $(HBeamConstruction_cc_dependencies)
	$(cpp_echo) $(src)HBeamConstruction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(HBeamConstruction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(HBeamConstruction_cppflags) $(HBeamConstruction_cc_cppflags)  $(src)HBeamConstruction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CentralDetectorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RoundBottomFlaskSolidMaker.d

$(bin)$(binobj)RoundBottomFlaskSolidMaker.d :

$(bin)$(binobj)RoundBottomFlaskSolidMaker.o : $(cmt_final_setup_CentralDetector)

$(bin)$(binobj)RoundBottomFlaskSolidMaker.o : $(src)RoundBottomFlaskSolidMaker.cc
	$(cpp_echo) $(src)RoundBottomFlaskSolidMaker.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(RoundBottomFlaskSolidMaker_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(RoundBottomFlaskSolidMaker_cppflags) $(RoundBottomFlaskSolidMaker_cc_cppflags)  $(src)RoundBottomFlaskSolidMaker.cc
endif
endif

else
$(bin)CentralDetector_dependencies.make : $(RoundBottomFlaskSolidMaker_cc_dependencies)

$(bin)CentralDetector_dependencies.make : $(src)RoundBottomFlaskSolidMaker.cc

$(bin)$(binobj)RoundBottomFlaskSolidMaker.o : $(RoundBottomFlaskSolidMaker_cc_dependencies)
	$(cpp_echo) $(src)RoundBottomFlaskSolidMaker.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(RoundBottomFlaskSolidMaker_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(RoundBottomFlaskSolidMaker_cppflags) $(RoundBottomFlaskSolidMaker_cc_cppflags)  $(src)RoundBottomFlaskSolidMaker.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CentralDetectorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DetSim1Construction.d

$(bin)$(binobj)DetSim1Construction.d :

$(bin)$(binobj)DetSim1Construction.o : $(cmt_final_setup_CentralDetector)

$(bin)$(binobj)DetSim1Construction.o : $(src)DetSim1Construction.cc
	$(cpp_echo) $(src)DetSim1Construction.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(DetSim1Construction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(DetSim1Construction_cppflags) $(DetSim1Construction_cc_cppflags)  $(src)DetSim1Construction.cc
endif
endif

else
$(bin)CentralDetector_dependencies.make : $(DetSim1Construction_cc_dependencies)

$(bin)CentralDetector_dependencies.make : $(src)DetSim1Construction.cc

$(bin)$(binobj)DetSim1Construction.o : $(DetSim1Construction_cc_dependencies)
	$(cpp_echo) $(src)DetSim1Construction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(DetSim1Construction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(DetSim1Construction_cppflags) $(DetSim1Construction_cc_cppflags)  $(src)DetSim1Construction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CentralDetectorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DetSim0Construction.d

$(bin)$(binobj)DetSim0Construction.d :

$(bin)$(binobj)DetSim0Construction.o : $(cmt_final_setup_CentralDetector)

$(bin)$(binobj)DetSim0Construction.o : $(src)DetSim0Construction.cc
	$(cpp_echo) $(src)DetSim0Construction.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(DetSim0Construction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(DetSim0Construction_cppflags) $(DetSim0Construction_cc_cppflags)  $(src)DetSim0Construction.cc
endif
endif

else
$(bin)CentralDetector_dependencies.make : $(DetSim0Construction_cc_dependencies)

$(bin)CentralDetector_dependencies.make : $(src)DetSim0Construction.cc

$(bin)$(binobj)DetSim0Construction.o : $(DetSim0Construction_cc_dependencies)
	$(cpp_echo) $(src)DetSim0Construction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(DetSim0Construction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(DetSim0Construction_cppflags) $(DetSim0Construction_cc_cppflags)  $(src)DetSim0Construction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CentralDetectorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PrototypeOnePMTConstruction.d

$(bin)$(binobj)PrototypeOnePMTConstruction.d :

$(bin)$(binobj)PrototypeOnePMTConstruction.o : $(cmt_final_setup_CentralDetector)

$(bin)$(binobj)PrototypeOnePMTConstruction.o : $(src)PrototypeOnePMTConstruction.cc
	$(cpp_echo) $(src)PrototypeOnePMTConstruction.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(PrototypeOnePMTConstruction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(PrototypeOnePMTConstruction_cppflags) $(PrototypeOnePMTConstruction_cc_cppflags)  $(src)PrototypeOnePMTConstruction.cc
endif
endif

else
$(bin)CentralDetector_dependencies.make : $(PrototypeOnePMTConstruction_cc_dependencies)

$(bin)CentralDetector_dependencies.make : $(src)PrototypeOnePMTConstruction.cc

$(bin)$(binobj)PrototypeOnePMTConstruction.o : $(PrototypeOnePMTConstruction_cc_dependencies)
	$(cpp_echo) $(src)PrototypeOnePMTConstruction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(PrototypeOnePMTConstruction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(PrototypeOnePMTConstruction_cppflags) $(PrototypeOnePMTConstruction_cc_cppflags)  $(src)PrototypeOnePMTConstruction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CentralDetectorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DetSim2Construction.d

$(bin)$(binobj)DetSim2Construction.d :

$(bin)$(binobj)DetSim2Construction.o : $(cmt_final_setup_CentralDetector)

$(bin)$(binobj)DetSim2Construction.o : $(src)DetSim2Construction.cc
	$(cpp_echo) $(src)DetSim2Construction.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(DetSim2Construction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(DetSim2Construction_cppflags) $(DetSim2Construction_cc_cppflags)  $(src)DetSim2Construction.cc
endif
endif

else
$(bin)CentralDetector_dependencies.make : $(DetSim2Construction_cc_dependencies)

$(bin)CentralDetector_dependencies.make : $(src)DetSim2Construction.cc

$(bin)$(binobj)DetSim2Construction.o : $(DetSim2Construction_cc_dependencies)
	$(cpp_echo) $(src)DetSim2Construction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(DetSim2Construction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(DetSim2Construction_cppflags) $(DetSim2Construction_cc_cppflags)  $(src)DetSim2Construction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CentralDetectorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StrutAcrylicConstruction.d

$(bin)$(binobj)StrutAcrylicConstruction.d :

$(bin)$(binobj)StrutAcrylicConstruction.o : $(cmt_final_setup_CentralDetector)

$(bin)$(binobj)StrutAcrylicConstruction.o : $(src)StrutAcrylicConstruction.cc
	$(cpp_echo) $(src)StrutAcrylicConstruction.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(StrutAcrylicConstruction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(StrutAcrylicConstruction_cppflags) $(StrutAcrylicConstruction_cc_cppflags)  $(src)StrutAcrylicConstruction.cc
endif
endif

else
$(bin)CentralDetector_dependencies.make : $(StrutAcrylicConstruction_cc_dependencies)

$(bin)CentralDetector_dependencies.make : $(src)StrutAcrylicConstruction.cc

$(bin)$(binobj)StrutAcrylicConstruction.o : $(StrutAcrylicConstruction_cc_dependencies)
	$(cpp_echo) $(src)StrutAcrylicConstruction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(StrutAcrylicConstruction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(StrutAcrylicConstruction_cppflags) $(StrutAcrylicConstruction_cc_cppflags)  $(src)StrutAcrylicConstruction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CentralDetectorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)dyb2NylonFilmOpticalModel.d

$(bin)$(binobj)dyb2NylonFilmOpticalModel.d :

$(bin)$(binobj)dyb2NylonFilmOpticalModel.o : $(cmt_final_setup_CentralDetector)

$(bin)$(binobj)dyb2NylonFilmOpticalModel.o : $(src)dyb2NylonFilmOpticalModel.cc
	$(cpp_echo) $(src)dyb2NylonFilmOpticalModel.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(dyb2NylonFilmOpticalModel_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(dyb2NylonFilmOpticalModel_cppflags) $(dyb2NylonFilmOpticalModel_cc_cppflags)  $(src)dyb2NylonFilmOpticalModel.cc
endif
endif

else
$(bin)CentralDetector_dependencies.make : $(dyb2NylonFilmOpticalModel_cc_dependencies)

$(bin)CentralDetector_dependencies.make : $(src)dyb2NylonFilmOpticalModel.cc

$(bin)$(binobj)dyb2NylonFilmOpticalModel.o : $(dyb2NylonFilmOpticalModel_cc_dependencies)
	$(cpp_echo) $(src)dyb2NylonFilmOpticalModel.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(dyb2NylonFilmOpticalModel_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(dyb2NylonFilmOpticalModel_cppflags) $(dyb2NylonFilmOpticalModel_cc_cppflags)  $(src)dyb2NylonFilmOpticalModel.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CentralDetectorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StrutBalloonConstruction.d

$(bin)$(binobj)StrutBalloonConstruction.d :

$(bin)$(binobj)StrutBalloonConstruction.o : $(cmt_final_setup_CentralDetector)

$(bin)$(binobj)StrutBalloonConstruction.o : $(src)StrutBalloonConstruction.cc
	$(cpp_echo) $(src)StrutBalloonConstruction.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(StrutBalloonConstruction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(StrutBalloonConstruction_cppflags) $(StrutBalloonConstruction_cc_cppflags)  $(src)StrutBalloonConstruction.cc
endif
endif

else
$(bin)CentralDetector_dependencies.make : $(StrutBalloonConstruction_cc_dependencies)

$(bin)CentralDetector_dependencies.make : $(src)StrutBalloonConstruction.cc

$(bin)$(binobj)StrutBalloonConstruction.o : $(StrutBalloonConstruction_cc_dependencies)
	$(cpp_echo) $(src)StrutBalloonConstruction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CentralDetector_pp_cppflags) $(lib_CentralDetector_pp_cppflags) $(StrutBalloonConstruction_pp_cppflags) $(use_cppflags) $(CentralDetector_cppflags) $(lib_CentralDetector_cppflags) $(StrutBalloonConstruction_cppflags) $(StrutBalloonConstruction_cc_cppflags)  $(src)StrutBalloonConstruction.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: CentralDetectorclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(CentralDetector.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

CentralDetectorclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library CentralDetector
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)CentralDetector$(library_suffix).a $(library_prefix)CentralDetector$(library_suffix).$(shlibsuffix) CentralDetector.stamp CentralDetector.shstamp
#-- end of cleanup_library ---------------

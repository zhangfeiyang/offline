#-- start of make_header -----------------

#====================================
#  Library GenTools
#
#   Generated Fri Jul 10 19:24:52 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GenTools_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GenTools_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GenTools

GenTools_tag = $(tag)

#cmt_local_tagfile_GenTools = $(GenTools_tag)_GenTools.make
cmt_local_tagfile_GenTools = $(bin)$(GenTools_tag)_GenTools.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GenTools_tag = $(tag)

#cmt_local_tagfile_GenTools = $(GenTools_tag).make
cmt_local_tagfile_GenTools = $(bin)$(GenTools_tag).make

endif

include $(cmt_local_tagfile_GenTools)
#-include $(cmt_local_tagfile_GenTools)

ifdef cmt_GenTools_has_target_tag

cmt_final_setup_GenTools = $(bin)setup_GenTools.make
cmt_dependencies_in_GenTools = $(bin)dependencies_GenTools.in
#cmt_final_setup_GenTools = $(bin)GenTools_GenToolssetup.make
cmt_local_GenTools_makefile = $(bin)GenTools.make

else

cmt_final_setup_GenTools = $(bin)setup.make
cmt_dependencies_in_GenTools = $(bin)dependencies.in
#cmt_final_setup_GenTools = $(bin)GenToolssetup.make
cmt_local_GenTools_makefile = $(bin)GenTools.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GenToolssetup.make

#GenTools :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GenTools'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GenTools/
#GenTools::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GenToolslibname   = $(bin)$(library_prefix)GenTools$(library_suffix)
GenToolslib       = $(GenToolslibname).a
GenToolsstamp     = $(bin)GenTools.stamp
GenToolsshstamp   = $(bin)GenTools.shstamp

GenTools :: dirs  GenToolsLIB
	$(echo) "GenTools ok"

cmt_GenTools_has_prototypes = 1

#--------------------------------------

ifdef cmt_GenTools_has_prototypes

GenToolsprototype :  ;

endif

GenToolscompile : $(bin)PostGenTools.o $(bin)GtTimeOffsetTool.o $(bin)GtPelletronBeamerTool.o $(bin)GtPositionerTool.o $(bin)GenTools.o $(bin)binding.o $(bin)GtSNTool.o $(bin)GtGstTool.o $(bin)GtHepEvtGenTool.o $(bin)GtGunGenTool.o $(bin)GenEventBuffer.o $(bin)GtOPLoaderTool.o $(bin)IGenTool.o $(bin)HepEvt2HepMC.o $(bin)GtHepMCDumper.o $(bin)GtOpScintTool.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

GenToolsLIB :: $(GenToolslib) $(GenToolsshstamp)
	$(echo) "GenTools : library ok"

$(GenToolslib) :: $(bin)PostGenTools.o $(bin)GtTimeOffsetTool.o $(bin)GtPelletronBeamerTool.o $(bin)GtPositionerTool.o $(bin)GenTools.o $(bin)binding.o $(bin)GtSNTool.o $(bin)GtGstTool.o $(bin)GtHepEvtGenTool.o $(bin)GtGunGenTool.o $(bin)GenEventBuffer.o $(bin)GtOPLoaderTool.o $(bin)IGenTool.o $(bin)HepEvt2HepMC.o $(bin)GtHepMCDumper.o $(bin)GtOpScintTool.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(GenToolslib) $(bin)PostGenTools.o $(bin)GtTimeOffsetTool.o $(bin)GtPelletronBeamerTool.o $(bin)GtPositionerTool.o $(bin)GenTools.o $(bin)binding.o $(bin)GtSNTool.o $(bin)GtGstTool.o $(bin)GtHepEvtGenTool.o $(bin)GtGunGenTool.o $(bin)GenEventBuffer.o $(bin)GtOPLoaderTool.o $(bin)IGenTool.o $(bin)HepEvt2HepMC.o $(bin)GtHepMCDumper.o $(bin)GtOpScintTool.o
	$(lib_silent) $(ranlib) $(GenToolslib)
	$(lib_silent) cat /dev/null >$(GenToolsstamp)

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

$(GenToolslibname).$(shlibsuffix) :: $(GenToolslib) requirements $(use_requirements) $(GenToolsstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" GenTools $(GenTools_shlibflags)
	$(lib_silent) cat /dev/null >$(GenToolsshstamp)

$(GenToolsshstamp) :: $(GenToolslibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GenToolslibname).$(shlibsuffix) ; then cat /dev/null >$(GenToolsshstamp) ; fi

GenToolsclean ::
	$(cleanup_echo) objects GenTools
	$(cleanup_silent) /bin/rm -f $(bin)PostGenTools.o $(bin)GtTimeOffsetTool.o $(bin)GtPelletronBeamerTool.o $(bin)GtPositionerTool.o $(bin)GenTools.o $(bin)binding.o $(bin)GtSNTool.o $(bin)GtGstTool.o $(bin)GtHepEvtGenTool.o $(bin)GtGunGenTool.o $(bin)GenEventBuffer.o $(bin)GtOPLoaderTool.o $(bin)IGenTool.o $(bin)HepEvt2HepMC.o $(bin)GtHepMCDumper.o $(bin)GtOpScintTool.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PostGenTools.o $(bin)GtTimeOffsetTool.o $(bin)GtPelletronBeamerTool.o $(bin)GtPositionerTool.o $(bin)GenTools.o $(bin)binding.o $(bin)GtSNTool.o $(bin)GtGstTool.o $(bin)GtHepEvtGenTool.o $(bin)GtGunGenTool.o $(bin)GenEventBuffer.o $(bin)GtOPLoaderTool.o $(bin)IGenTool.o $(bin)HepEvt2HepMC.o $(bin)GtHepMCDumper.o $(bin)GtOpScintTool.o) $(patsubst %.o,%.dep,$(bin)PostGenTools.o $(bin)GtTimeOffsetTool.o $(bin)GtPelletronBeamerTool.o $(bin)GtPositionerTool.o $(bin)GenTools.o $(bin)binding.o $(bin)GtSNTool.o $(bin)GtGstTool.o $(bin)GtHepEvtGenTool.o $(bin)GtGunGenTool.o $(bin)GenEventBuffer.o $(bin)GtOPLoaderTool.o $(bin)IGenTool.o $(bin)HepEvt2HepMC.o $(bin)GtHepMCDumper.o $(bin)GtOpScintTool.o) $(patsubst %.o,%.d.stamp,$(bin)PostGenTools.o $(bin)GtTimeOffsetTool.o $(bin)GtPelletronBeamerTool.o $(bin)GtPositionerTool.o $(bin)GenTools.o $(bin)binding.o $(bin)GtSNTool.o $(bin)GtGstTool.o $(bin)GtHepEvtGenTool.o $(bin)GtGunGenTool.o $(bin)GenEventBuffer.o $(bin)GtOPLoaderTool.o $(bin)IGenTool.o $(bin)HepEvt2HepMC.o $(bin)GtHepMCDumper.o $(bin)GtOpScintTool.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GenTools_deps GenTools_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GenToolsinstallname = $(library_prefix)GenTools$(library_suffix).$(shlibsuffix)

GenTools :: GenToolsinstall ;

install :: GenToolsinstall ;

GenToolsinstall :: $(install_dir)/$(GenToolsinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GenToolsinstallname) :: $(bin)$(GenToolsinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GenToolsinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GenToolsclean :: GenToolsuninstall

uninstall :: GenToolsuninstall ;

GenToolsuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GenToolsinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),GenToolsprototype)

$(bin)GenTools_dependencies.make : $(use_requirements) $(cmt_final_setup_GenTools)
	$(echo) "(GenTools.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)PostGenTools.cc $(src)GtTimeOffsetTool.cc $(src)GtPelletronBeamerTool.cc $(src)GtPositionerTool.cc $(src)GenTools.cc $(src)binding.cc $(src)GtSNTool.cc $(src)GtGstTool.cc $(src)GtHepEvtGenTool.cc $(src)GtGunGenTool.cc $(src)GenEventBuffer.cc $(src)GtOPLoaderTool.cc $(src)IGenTool.cc $(src)HepEvt2HepMC.cc $(src)GtHepMCDumper.cc $(src)GtOpScintTool.cc -end_all $(includes) $(app_GenTools_cppflags) $(lib_GenTools_cppflags) -name=GenTools $? -f=$(cmt_dependencies_in_GenTools) -without_cmt

-include $(bin)GenTools_dependencies.make

endif
endif
endif

GenToolsclean ::
	$(cleanup_silent) \rm -rf $(bin)GenTools_deps $(bin)GenTools_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PostGenTools.d

$(bin)$(binobj)PostGenTools.d :

$(bin)$(binobj)PostGenTools.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)PostGenTools.o : $(src)PostGenTools.cc
	$(cpp_echo) $(src)PostGenTools.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(PostGenTools_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(PostGenTools_cppflags) $(PostGenTools_cc_cppflags)  $(src)PostGenTools.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(PostGenTools_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)PostGenTools.cc

$(bin)$(binobj)PostGenTools.o : $(PostGenTools_cc_dependencies)
	$(cpp_echo) $(src)PostGenTools.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(PostGenTools_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(PostGenTools_cppflags) $(PostGenTools_cc_cppflags)  $(src)PostGenTools.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GtTimeOffsetTool.d

$(bin)$(binobj)GtTimeOffsetTool.d :

$(bin)$(binobj)GtTimeOffsetTool.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)GtTimeOffsetTool.o : $(src)GtTimeOffsetTool.cc
	$(cpp_echo) $(src)GtTimeOffsetTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtTimeOffsetTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtTimeOffsetTool_cppflags) $(GtTimeOffsetTool_cc_cppflags)  $(src)GtTimeOffsetTool.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(GtTimeOffsetTool_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)GtTimeOffsetTool.cc

$(bin)$(binobj)GtTimeOffsetTool.o : $(GtTimeOffsetTool_cc_dependencies)
	$(cpp_echo) $(src)GtTimeOffsetTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtTimeOffsetTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtTimeOffsetTool_cppflags) $(GtTimeOffsetTool_cc_cppflags)  $(src)GtTimeOffsetTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GtPelletronBeamerTool.d

$(bin)$(binobj)GtPelletronBeamerTool.d :

$(bin)$(binobj)GtPelletronBeamerTool.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)GtPelletronBeamerTool.o : $(src)GtPelletronBeamerTool.cc
	$(cpp_echo) $(src)GtPelletronBeamerTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtPelletronBeamerTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtPelletronBeamerTool_cppflags) $(GtPelletronBeamerTool_cc_cppflags)  $(src)GtPelletronBeamerTool.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(GtPelletronBeamerTool_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)GtPelletronBeamerTool.cc

$(bin)$(binobj)GtPelletronBeamerTool.o : $(GtPelletronBeamerTool_cc_dependencies)
	$(cpp_echo) $(src)GtPelletronBeamerTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtPelletronBeamerTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtPelletronBeamerTool_cppflags) $(GtPelletronBeamerTool_cc_cppflags)  $(src)GtPelletronBeamerTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GtPositionerTool.d

$(bin)$(binobj)GtPositionerTool.d :

$(bin)$(binobj)GtPositionerTool.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)GtPositionerTool.o : $(src)GtPositionerTool.cc
	$(cpp_echo) $(src)GtPositionerTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtPositionerTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtPositionerTool_cppflags) $(GtPositionerTool_cc_cppflags)  $(src)GtPositionerTool.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(GtPositionerTool_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)GtPositionerTool.cc

$(bin)$(binobj)GtPositionerTool.o : $(GtPositionerTool_cc_dependencies)
	$(cpp_echo) $(src)GtPositionerTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtPositionerTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtPositionerTool_cppflags) $(GtPositionerTool_cc_cppflags)  $(src)GtPositionerTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GenTools.d

$(bin)$(binobj)GenTools.d :

$(bin)$(binobj)GenTools.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)GenTools.o : $(src)GenTools.cc
	$(cpp_echo) $(src)GenTools.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GenTools_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GenTools_cppflags) $(GenTools_cc_cppflags)  $(src)GenTools.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(GenTools_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)GenTools.cc

$(bin)$(binobj)GenTools.o : $(GenTools_cc_dependencies)
	$(cpp_echo) $(src)GenTools.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GenTools_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GenTools_cppflags) $(GenTools_cc_cppflags)  $(src)GenTools.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)binding.d

$(bin)$(binobj)binding.d :

$(bin)$(binobj)binding.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)binding.o : $(src)binding.cc
	$(cpp_echo) $(src)binding.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(binding_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(binding_cppflags) $(binding_cc_cppflags)  $(src)binding.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(binding_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)binding.cc

$(bin)$(binobj)binding.o : $(binding_cc_dependencies)
	$(cpp_echo) $(src)binding.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(binding_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(binding_cppflags) $(binding_cc_cppflags)  $(src)binding.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GtSNTool.d

$(bin)$(binobj)GtSNTool.d :

$(bin)$(binobj)GtSNTool.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)GtSNTool.o : $(src)GtSNTool.cc
	$(cpp_echo) $(src)GtSNTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtSNTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtSNTool_cppflags) $(GtSNTool_cc_cppflags)  $(src)GtSNTool.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(GtSNTool_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)GtSNTool.cc

$(bin)$(binobj)GtSNTool.o : $(GtSNTool_cc_dependencies)
	$(cpp_echo) $(src)GtSNTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtSNTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtSNTool_cppflags) $(GtSNTool_cc_cppflags)  $(src)GtSNTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GtGstTool.d

$(bin)$(binobj)GtGstTool.d :

$(bin)$(binobj)GtGstTool.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)GtGstTool.o : $(src)GtGstTool.cc
	$(cpp_echo) $(src)GtGstTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtGstTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtGstTool_cppflags) $(GtGstTool_cc_cppflags)  $(src)GtGstTool.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(GtGstTool_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)GtGstTool.cc

$(bin)$(binobj)GtGstTool.o : $(GtGstTool_cc_dependencies)
	$(cpp_echo) $(src)GtGstTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtGstTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtGstTool_cppflags) $(GtGstTool_cc_cppflags)  $(src)GtGstTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GtHepEvtGenTool.d

$(bin)$(binobj)GtHepEvtGenTool.d :

$(bin)$(binobj)GtHepEvtGenTool.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)GtHepEvtGenTool.o : $(src)GtHepEvtGenTool.cc
	$(cpp_echo) $(src)GtHepEvtGenTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtHepEvtGenTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtHepEvtGenTool_cppflags) $(GtHepEvtGenTool_cc_cppflags)  $(src)GtHepEvtGenTool.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(GtHepEvtGenTool_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)GtHepEvtGenTool.cc

$(bin)$(binobj)GtHepEvtGenTool.o : $(GtHepEvtGenTool_cc_dependencies)
	$(cpp_echo) $(src)GtHepEvtGenTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtHepEvtGenTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtHepEvtGenTool_cppflags) $(GtHepEvtGenTool_cc_cppflags)  $(src)GtHepEvtGenTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GtGunGenTool.d

$(bin)$(binobj)GtGunGenTool.d :

$(bin)$(binobj)GtGunGenTool.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)GtGunGenTool.o : $(src)GtGunGenTool.cc
	$(cpp_echo) $(src)GtGunGenTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtGunGenTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtGunGenTool_cppflags) $(GtGunGenTool_cc_cppflags)  $(src)GtGunGenTool.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(GtGunGenTool_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)GtGunGenTool.cc

$(bin)$(binobj)GtGunGenTool.o : $(GtGunGenTool_cc_dependencies)
	$(cpp_echo) $(src)GtGunGenTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtGunGenTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtGunGenTool_cppflags) $(GtGunGenTool_cc_cppflags)  $(src)GtGunGenTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GenEventBuffer.d

$(bin)$(binobj)GenEventBuffer.d :

$(bin)$(binobj)GenEventBuffer.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)GenEventBuffer.o : $(src)GenEventBuffer.cc
	$(cpp_echo) $(src)GenEventBuffer.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GenEventBuffer_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GenEventBuffer_cppflags) $(GenEventBuffer_cc_cppflags)  $(src)GenEventBuffer.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(GenEventBuffer_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)GenEventBuffer.cc

$(bin)$(binobj)GenEventBuffer.o : $(GenEventBuffer_cc_dependencies)
	$(cpp_echo) $(src)GenEventBuffer.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GenEventBuffer_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GenEventBuffer_cppflags) $(GenEventBuffer_cc_cppflags)  $(src)GenEventBuffer.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GtOPLoaderTool.d

$(bin)$(binobj)GtOPLoaderTool.d :

$(bin)$(binobj)GtOPLoaderTool.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)GtOPLoaderTool.o : $(src)GtOPLoaderTool.cc
	$(cpp_echo) $(src)GtOPLoaderTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtOPLoaderTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtOPLoaderTool_cppflags) $(GtOPLoaderTool_cc_cppflags)  $(src)GtOPLoaderTool.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(GtOPLoaderTool_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)GtOPLoaderTool.cc

$(bin)$(binobj)GtOPLoaderTool.o : $(GtOPLoaderTool_cc_dependencies)
	$(cpp_echo) $(src)GtOPLoaderTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtOPLoaderTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtOPLoaderTool_cppflags) $(GtOPLoaderTool_cc_cppflags)  $(src)GtOPLoaderTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IGenTool.d

$(bin)$(binobj)IGenTool.d :

$(bin)$(binobj)IGenTool.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)IGenTool.o : $(src)IGenTool.cc
	$(cpp_echo) $(src)IGenTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(IGenTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(IGenTool_cppflags) $(IGenTool_cc_cppflags)  $(src)IGenTool.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(IGenTool_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)IGenTool.cc

$(bin)$(binobj)IGenTool.o : $(IGenTool_cc_dependencies)
	$(cpp_echo) $(src)IGenTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(IGenTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(IGenTool_cppflags) $(IGenTool_cc_cppflags)  $(src)IGenTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HepEvt2HepMC.d

$(bin)$(binobj)HepEvt2HepMC.d :

$(bin)$(binobj)HepEvt2HepMC.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)HepEvt2HepMC.o : $(src)HepEvt2HepMC.cc
	$(cpp_echo) $(src)HepEvt2HepMC.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(HepEvt2HepMC_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(HepEvt2HepMC_cppflags) $(HepEvt2HepMC_cc_cppflags)  $(src)HepEvt2HepMC.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(HepEvt2HepMC_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)HepEvt2HepMC.cc

$(bin)$(binobj)HepEvt2HepMC.o : $(HepEvt2HepMC_cc_dependencies)
	$(cpp_echo) $(src)HepEvt2HepMC.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(HepEvt2HepMC_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(HepEvt2HepMC_cppflags) $(HepEvt2HepMC_cc_cppflags)  $(src)HepEvt2HepMC.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GtHepMCDumper.d

$(bin)$(binobj)GtHepMCDumper.d :

$(bin)$(binobj)GtHepMCDumper.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)GtHepMCDumper.o : $(src)GtHepMCDumper.cc
	$(cpp_echo) $(src)GtHepMCDumper.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtHepMCDumper_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtHepMCDumper_cppflags) $(GtHepMCDumper_cc_cppflags)  $(src)GtHepMCDumper.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(GtHepMCDumper_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)GtHepMCDumper.cc

$(bin)$(binobj)GtHepMCDumper.o : $(GtHepMCDumper_cc_dependencies)
	$(cpp_echo) $(src)GtHepMCDumper.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtHepMCDumper_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtHepMCDumper_cppflags) $(GtHepMCDumper_cc_cppflags)  $(src)GtHepMCDumper.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenToolsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GtOpScintTool.d

$(bin)$(binobj)GtOpScintTool.d :

$(bin)$(binobj)GtOpScintTool.o : $(cmt_final_setup_GenTools)

$(bin)$(binobj)GtOpScintTool.o : $(src)GtOpScintTool.cc
	$(cpp_echo) $(src)GtOpScintTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtOpScintTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtOpScintTool_cppflags) $(GtOpScintTool_cc_cppflags)  $(src)GtOpScintTool.cc
endif
endif

else
$(bin)GenTools_dependencies.make : $(GtOpScintTool_cc_dependencies)

$(bin)GenTools_dependencies.make : $(src)GtOpScintTool.cc

$(bin)$(binobj)GtOpScintTool.o : $(GtOpScintTool_cc_dependencies)
	$(cpp_echo) $(src)GtOpScintTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenTools_pp_cppflags) $(lib_GenTools_pp_cppflags) $(GtOpScintTool_pp_cppflags) $(use_cppflags) $(GenTools_cppflags) $(lib_GenTools_cppflags) $(GtOpScintTool_cppflags) $(GtOpScintTool_cc_cppflags)  $(src)GtOpScintTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GenToolsclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GenTools.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GenToolsclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GenTools
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GenTools$(library_suffix).a $(library_prefix)GenTools$(library_suffix).$(shlibsuffix) GenTools.stamp GenTools.shstamp
#-- end of cleanup_library ---------------

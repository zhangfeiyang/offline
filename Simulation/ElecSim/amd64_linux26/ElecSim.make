#-- start of make_header -----------------

#====================================
#  Library ElecSim
#
#   Generated Fri Jul 10 19:24:18 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_ElecSim_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ElecSim_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ElecSim

ElecSim_tag = $(tag)

#cmt_local_tagfile_ElecSim = $(ElecSim_tag)_ElecSim.make
cmt_local_tagfile_ElecSim = $(bin)$(ElecSim_tag)_ElecSim.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ElecSim_tag = $(tag)

#cmt_local_tagfile_ElecSim = $(ElecSim_tag).make
cmt_local_tagfile_ElecSim = $(bin)$(ElecSim_tag).make

endif

include $(cmt_local_tagfile_ElecSim)
#-include $(cmt_local_tagfile_ElecSim)

ifdef cmt_ElecSim_has_target_tag

cmt_final_setup_ElecSim = $(bin)setup_ElecSim.make
cmt_dependencies_in_ElecSim = $(bin)dependencies_ElecSim.in
#cmt_final_setup_ElecSim = $(bin)ElecSim_ElecSimsetup.make
cmt_local_ElecSim_makefile = $(bin)ElecSim.make

else

cmt_final_setup_ElecSim = $(bin)setup.make
cmt_dependencies_in_ElecSim = $(bin)dependencies.in
#cmt_final_setup_ElecSim = $(bin)ElecSimsetup.make
cmt_local_ElecSim_makefile = $(bin)ElecSim.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ElecSimsetup.make

#ElecSim :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ElecSim'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ElecSim/
#ElecSim::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

ElecSimlibname   = $(bin)$(library_prefix)ElecSim$(library_suffix)
ElecSimlib       = $(ElecSimlibname).a
ElecSimstamp     = $(bin)ElecSim.stamp
ElecSimshstamp   = $(bin)ElecSim.shstamp

ElecSim :: dirs  ElecSimLIB
	$(echo) "ElecSim ok"

cmt_ElecSim_has_prototypes = 1

#--------------------------------------

ifdef cmt_ElecSim_has_prototypes

ElecSimprototype :  ;

endif

ElecSimcompile : $(bin)UnpackHitsAlg.o $(bin)ElecSimClass.o $(bin)ElecSim.o $(bin)Gen_Signal.o $(bin)Gen_Pulse.o $(bin)TestBuffDataAlg.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

ElecSimLIB :: $(ElecSimlib) $(ElecSimshstamp)
	$(echo) "ElecSim : library ok"

$(ElecSimlib) :: $(bin)UnpackHitsAlg.o $(bin)ElecSimClass.o $(bin)ElecSim.o $(bin)Gen_Signal.o $(bin)Gen_Pulse.o $(bin)TestBuffDataAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(ElecSimlib) $(bin)UnpackHitsAlg.o $(bin)ElecSimClass.o $(bin)ElecSim.o $(bin)Gen_Signal.o $(bin)Gen_Pulse.o $(bin)TestBuffDataAlg.o
	$(lib_silent) $(ranlib) $(ElecSimlib)
	$(lib_silent) cat /dev/null >$(ElecSimstamp)

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

$(ElecSimlibname).$(shlibsuffix) :: $(ElecSimlib) requirements $(use_requirements) $(ElecSimstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" ElecSim $(ElecSim_shlibflags)
	$(lib_silent) cat /dev/null >$(ElecSimshstamp)

$(ElecSimshstamp) :: $(ElecSimlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(ElecSimlibname).$(shlibsuffix) ; then cat /dev/null >$(ElecSimshstamp) ; fi

ElecSimclean ::
	$(cleanup_echo) objects ElecSim
	$(cleanup_silent) /bin/rm -f $(bin)UnpackHitsAlg.o $(bin)ElecSimClass.o $(bin)ElecSim.o $(bin)Gen_Signal.o $(bin)Gen_Pulse.o $(bin)TestBuffDataAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)UnpackHitsAlg.o $(bin)ElecSimClass.o $(bin)ElecSim.o $(bin)Gen_Signal.o $(bin)Gen_Pulse.o $(bin)TestBuffDataAlg.o) $(patsubst %.o,%.dep,$(bin)UnpackHitsAlg.o $(bin)ElecSimClass.o $(bin)ElecSim.o $(bin)Gen_Signal.o $(bin)Gen_Pulse.o $(bin)TestBuffDataAlg.o) $(patsubst %.o,%.d.stamp,$(bin)UnpackHitsAlg.o $(bin)ElecSimClass.o $(bin)ElecSim.o $(bin)Gen_Signal.o $(bin)Gen_Pulse.o $(bin)TestBuffDataAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf ElecSim_deps ElecSim_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
ElecSiminstallname = $(library_prefix)ElecSim$(library_suffix).$(shlibsuffix)

ElecSim :: ElecSiminstall ;

install :: ElecSiminstall ;

ElecSiminstall :: $(install_dir)/$(ElecSiminstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(ElecSiminstallname) :: $(bin)$(ElecSiminstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(ElecSiminstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##ElecSimclean :: ElecSimuninstall

uninstall :: ElecSimuninstall ;

ElecSimuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(ElecSiminstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),ElecSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),ElecSimprototype)

$(bin)ElecSim_dependencies.make : $(use_requirements) $(cmt_final_setup_ElecSim)
	$(echo) "(ElecSim.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)UnpackHitsAlg.cc $(src)ElecSimClass.cc $(src)ElecSim.cc $(src)Gen_Signal.cc $(src)Gen_Pulse.cc $(src)TestBuffDataAlg.cc -end_all $(includes) $(app_ElecSim_cppflags) $(lib_ElecSim_cppflags) -name=ElecSim $? -f=$(cmt_dependencies_in_ElecSim) -without_cmt

-include $(bin)ElecSim_dependencies.make

endif
endif
endif

ElecSimclean ::
	$(cleanup_silent) \rm -rf $(bin)ElecSim_deps $(bin)ElecSim_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)UnpackHitsAlg.d

$(bin)$(binobj)UnpackHitsAlg.d :

$(bin)$(binobj)UnpackHitsAlg.o : $(cmt_final_setup_ElecSim)

$(bin)$(binobj)UnpackHitsAlg.o : $(src)UnpackHitsAlg.cc
	$(cpp_echo) $(src)UnpackHitsAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecSim_pp_cppflags) $(lib_ElecSim_pp_cppflags) $(UnpackHitsAlg_pp_cppflags) $(use_cppflags) $(ElecSim_cppflags) $(lib_ElecSim_cppflags) $(UnpackHitsAlg_cppflags) $(UnpackHitsAlg_cc_cppflags)  $(src)UnpackHitsAlg.cc
endif
endif

else
$(bin)ElecSim_dependencies.make : $(UnpackHitsAlg_cc_dependencies)

$(bin)ElecSim_dependencies.make : $(src)UnpackHitsAlg.cc

$(bin)$(binobj)UnpackHitsAlg.o : $(UnpackHitsAlg_cc_dependencies)
	$(cpp_echo) $(src)UnpackHitsAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecSim_pp_cppflags) $(lib_ElecSim_pp_cppflags) $(UnpackHitsAlg_pp_cppflags) $(use_cppflags) $(ElecSim_cppflags) $(lib_ElecSim_cppflags) $(UnpackHitsAlg_cppflags) $(UnpackHitsAlg_cc_cppflags)  $(src)UnpackHitsAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ElecSimClass.d

$(bin)$(binobj)ElecSimClass.d :

$(bin)$(binobj)ElecSimClass.o : $(cmt_final_setup_ElecSim)

$(bin)$(binobj)ElecSimClass.o : $(src)ElecSimClass.cc
	$(cpp_echo) $(src)ElecSimClass.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecSim_pp_cppflags) $(lib_ElecSim_pp_cppflags) $(ElecSimClass_pp_cppflags) $(use_cppflags) $(ElecSim_cppflags) $(lib_ElecSim_cppflags) $(ElecSimClass_cppflags) $(ElecSimClass_cc_cppflags)  $(src)ElecSimClass.cc
endif
endif

else
$(bin)ElecSim_dependencies.make : $(ElecSimClass_cc_dependencies)

$(bin)ElecSim_dependencies.make : $(src)ElecSimClass.cc

$(bin)$(binobj)ElecSimClass.o : $(ElecSimClass_cc_dependencies)
	$(cpp_echo) $(src)ElecSimClass.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecSim_pp_cppflags) $(lib_ElecSim_pp_cppflags) $(ElecSimClass_pp_cppflags) $(use_cppflags) $(ElecSim_cppflags) $(lib_ElecSim_cppflags) $(ElecSimClass_cppflags) $(ElecSimClass_cc_cppflags)  $(src)ElecSimClass.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ElecSim.d

$(bin)$(binobj)ElecSim.d :

$(bin)$(binobj)ElecSim.o : $(cmt_final_setup_ElecSim)

$(bin)$(binobj)ElecSim.o : $(src)ElecSim.cc
	$(cpp_echo) $(src)ElecSim.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecSim_pp_cppflags) $(lib_ElecSim_pp_cppflags) $(ElecSim_pp_cppflags) $(use_cppflags) $(ElecSim_cppflags) $(lib_ElecSim_cppflags) $(ElecSim_cppflags) $(ElecSim_cc_cppflags)  $(src)ElecSim.cc
endif
endif

else
$(bin)ElecSim_dependencies.make : $(ElecSim_cc_dependencies)

$(bin)ElecSim_dependencies.make : $(src)ElecSim.cc

$(bin)$(binobj)ElecSim.o : $(ElecSim_cc_dependencies)
	$(cpp_echo) $(src)ElecSim.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecSim_pp_cppflags) $(lib_ElecSim_pp_cppflags) $(ElecSim_pp_cppflags) $(use_cppflags) $(ElecSim_cppflags) $(lib_ElecSim_cppflags) $(ElecSim_cppflags) $(ElecSim_cc_cppflags)  $(src)ElecSim.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Gen_Signal.d

$(bin)$(binobj)Gen_Signal.d :

$(bin)$(binobj)Gen_Signal.o : $(cmt_final_setup_ElecSim)

$(bin)$(binobj)Gen_Signal.o : $(src)Gen_Signal.cc
	$(cpp_echo) $(src)Gen_Signal.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecSim_pp_cppflags) $(lib_ElecSim_pp_cppflags) $(Gen_Signal_pp_cppflags) $(use_cppflags) $(ElecSim_cppflags) $(lib_ElecSim_cppflags) $(Gen_Signal_cppflags) $(Gen_Signal_cc_cppflags)  $(src)Gen_Signal.cc
endif
endif

else
$(bin)ElecSim_dependencies.make : $(Gen_Signal_cc_dependencies)

$(bin)ElecSim_dependencies.make : $(src)Gen_Signal.cc

$(bin)$(binobj)Gen_Signal.o : $(Gen_Signal_cc_dependencies)
	$(cpp_echo) $(src)Gen_Signal.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecSim_pp_cppflags) $(lib_ElecSim_pp_cppflags) $(Gen_Signal_pp_cppflags) $(use_cppflags) $(ElecSim_cppflags) $(lib_ElecSim_cppflags) $(Gen_Signal_cppflags) $(Gen_Signal_cc_cppflags)  $(src)Gen_Signal.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Gen_Pulse.d

$(bin)$(binobj)Gen_Pulse.d :

$(bin)$(binobj)Gen_Pulse.o : $(cmt_final_setup_ElecSim)

$(bin)$(binobj)Gen_Pulse.o : $(src)Gen_Pulse.cc
	$(cpp_echo) $(src)Gen_Pulse.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecSim_pp_cppflags) $(lib_ElecSim_pp_cppflags) $(Gen_Pulse_pp_cppflags) $(use_cppflags) $(ElecSim_cppflags) $(lib_ElecSim_cppflags) $(Gen_Pulse_cppflags) $(Gen_Pulse_cc_cppflags)  $(src)Gen_Pulse.cc
endif
endif

else
$(bin)ElecSim_dependencies.make : $(Gen_Pulse_cc_dependencies)

$(bin)ElecSim_dependencies.make : $(src)Gen_Pulse.cc

$(bin)$(binobj)Gen_Pulse.o : $(Gen_Pulse_cc_dependencies)
	$(cpp_echo) $(src)Gen_Pulse.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecSim_pp_cppflags) $(lib_ElecSim_pp_cppflags) $(Gen_Pulse_pp_cppflags) $(use_cppflags) $(ElecSim_cppflags) $(lib_ElecSim_cppflags) $(Gen_Pulse_cppflags) $(Gen_Pulse_cc_cppflags)  $(src)Gen_Pulse.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TestBuffDataAlg.d

$(bin)$(binobj)TestBuffDataAlg.d :

$(bin)$(binobj)TestBuffDataAlg.o : $(cmt_final_setup_ElecSim)

$(bin)$(binobj)TestBuffDataAlg.o : $(src)TestBuffDataAlg.cc
	$(cpp_echo) $(src)TestBuffDataAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecSim_pp_cppflags) $(lib_ElecSim_pp_cppflags) $(TestBuffDataAlg_pp_cppflags) $(use_cppflags) $(ElecSim_cppflags) $(lib_ElecSim_cppflags) $(TestBuffDataAlg_cppflags) $(TestBuffDataAlg_cc_cppflags)  $(src)TestBuffDataAlg.cc
endif
endif

else
$(bin)ElecSim_dependencies.make : $(TestBuffDataAlg_cc_dependencies)

$(bin)ElecSim_dependencies.make : $(src)TestBuffDataAlg.cc

$(bin)$(binobj)TestBuffDataAlg.o : $(TestBuffDataAlg_cc_dependencies)
	$(cpp_echo) $(src)TestBuffDataAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecSim_pp_cppflags) $(lib_ElecSim_pp_cppflags) $(TestBuffDataAlg_pp_cppflags) $(use_cppflags) $(ElecSim_cppflags) $(lib_ElecSim_cppflags) $(TestBuffDataAlg_cppflags) $(TestBuffDataAlg_cc_cppflags)  $(src)TestBuffDataAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: ElecSimclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ElecSim.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ElecSimclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library ElecSim
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)ElecSim$(library_suffix).a $(library_prefix)ElecSim$(library_suffix).$(shlibsuffix) ElecSim.stamp ElecSim.shstamp
#-- end of cleanup_library ---------------

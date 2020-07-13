#-- start of make_header -----------------

#====================================
#  Library WaveFit
#
#   Generated Fri Jul 10 19:21:14 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_WaveFit_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_WaveFit_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_WaveFit

WaveFitAlg_tag = $(tag)

#cmt_local_tagfile_WaveFit = $(WaveFitAlg_tag)_WaveFit.make
cmt_local_tagfile_WaveFit = $(bin)$(WaveFitAlg_tag)_WaveFit.make

else

tags      = $(tag),$(CMTEXTRATAGS)

WaveFitAlg_tag = $(tag)

#cmt_local_tagfile_WaveFit = $(WaveFitAlg_tag).make
cmt_local_tagfile_WaveFit = $(bin)$(WaveFitAlg_tag).make

endif

include $(cmt_local_tagfile_WaveFit)
#-include $(cmt_local_tagfile_WaveFit)

ifdef cmt_WaveFit_has_target_tag

cmt_final_setup_WaveFit = $(bin)setup_WaveFit.make
cmt_dependencies_in_WaveFit = $(bin)dependencies_WaveFit.in
#cmt_final_setup_WaveFit = $(bin)WaveFitAlg_WaveFitsetup.make
cmt_local_WaveFit_makefile = $(bin)WaveFit.make

else

cmt_final_setup_WaveFit = $(bin)setup.make
cmt_dependencies_in_WaveFit = $(bin)dependencies.in
#cmt_final_setup_WaveFit = $(bin)WaveFitAlgsetup.make
cmt_local_WaveFit_makefile = $(bin)WaveFit.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)WaveFitAlgsetup.make

#WaveFit :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'WaveFit'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = WaveFit/
#WaveFit::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

WaveFitlibname   = $(bin)$(library_prefix)WaveFit$(library_suffix)
WaveFitlib       = $(WaveFitlibname).a
WaveFitstamp     = $(bin)WaveFit.stamp
WaveFitshstamp   = $(bin)WaveFit.shstamp

WaveFit :: dirs  WaveFitLIB
	$(echo) "WaveFit ok"

cmt_WaveFit_has_prototypes = 1

#--------------------------------------

ifdef cmt_WaveFit_has_prototypes

WaveFitprototype :  ;

endif

WaveFitcompile : $(bin)WaveFit.o $(bin)FadcReadout.o $(bin)FadcFit.o $(bin)AnalysisTool.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

WaveFitLIB :: $(WaveFitlib) $(WaveFitshstamp)
	$(echo) "WaveFit : library ok"

$(WaveFitlib) :: $(bin)WaveFit.o $(bin)FadcReadout.o $(bin)FadcFit.o $(bin)AnalysisTool.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(WaveFitlib) $(bin)WaveFit.o $(bin)FadcReadout.o $(bin)FadcFit.o $(bin)AnalysisTool.o
	$(lib_silent) $(ranlib) $(WaveFitlib)
	$(lib_silent) cat /dev/null >$(WaveFitstamp)

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

$(WaveFitlibname).$(shlibsuffix) :: $(WaveFitlib) requirements $(use_requirements) $(WaveFitstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" WaveFit $(WaveFit_shlibflags)
	$(lib_silent) cat /dev/null >$(WaveFitshstamp)

$(WaveFitshstamp) :: $(WaveFitlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(WaveFitlibname).$(shlibsuffix) ; then cat /dev/null >$(WaveFitshstamp) ; fi

WaveFitclean ::
	$(cleanup_echo) objects WaveFit
	$(cleanup_silent) /bin/rm -f $(bin)WaveFit.o $(bin)FadcReadout.o $(bin)FadcFit.o $(bin)AnalysisTool.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)WaveFit.o $(bin)FadcReadout.o $(bin)FadcFit.o $(bin)AnalysisTool.o) $(patsubst %.o,%.dep,$(bin)WaveFit.o $(bin)FadcReadout.o $(bin)FadcFit.o $(bin)AnalysisTool.o) $(patsubst %.o,%.d.stamp,$(bin)WaveFit.o $(bin)FadcReadout.o $(bin)FadcFit.o $(bin)AnalysisTool.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf WaveFit_deps WaveFit_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
WaveFitinstallname = $(library_prefix)WaveFit$(library_suffix).$(shlibsuffix)

WaveFit :: WaveFitinstall ;

install :: WaveFitinstall ;

WaveFitinstall :: $(install_dir)/$(WaveFitinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(WaveFitinstallname) :: $(bin)$(WaveFitinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(WaveFitinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##WaveFitclean :: WaveFituninstall

uninstall :: WaveFituninstall ;

WaveFituninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(WaveFitinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),WaveFitclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),WaveFitprototype)

$(bin)WaveFit_dependencies.make : $(use_requirements) $(cmt_final_setup_WaveFit)
	$(echo) "(WaveFit.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)WaveFit.cc $(src)FadcReadout.cxx $(src)FadcFit.cxx $(src)AnalysisTool.cxx -end_all $(includes) $(app_WaveFit_cppflags) $(lib_WaveFit_cppflags) -name=WaveFit $? -f=$(cmt_dependencies_in_WaveFit) -without_cmt

-include $(bin)WaveFit_dependencies.make

endif
endif
endif

WaveFitclean ::
	$(cleanup_silent) \rm -rf $(bin)WaveFit_deps $(bin)WaveFit_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),WaveFitclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)WaveFit.d

$(bin)$(binobj)WaveFit.d :

$(bin)$(binobj)WaveFit.o : $(cmt_final_setup_WaveFit)

$(bin)$(binobj)WaveFit.o : $(src)WaveFit.cc
	$(cpp_echo) $(src)WaveFit.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(WaveFit_pp_cppflags) $(lib_WaveFit_pp_cppflags) $(WaveFit_pp_cppflags) $(use_cppflags) $(WaveFit_cppflags) $(lib_WaveFit_cppflags) $(WaveFit_cppflags) $(WaveFit_cc_cppflags)  $(src)WaveFit.cc
endif
endif

else
$(bin)WaveFit_dependencies.make : $(WaveFit_cc_dependencies)

$(bin)WaveFit_dependencies.make : $(src)WaveFit.cc

$(bin)$(binobj)WaveFit.o : $(WaveFit_cc_dependencies)
	$(cpp_echo) $(src)WaveFit.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(WaveFit_pp_cppflags) $(lib_WaveFit_pp_cppflags) $(WaveFit_pp_cppflags) $(use_cppflags) $(WaveFit_cppflags) $(lib_WaveFit_cppflags) $(WaveFit_cppflags) $(WaveFit_cc_cppflags)  $(src)WaveFit.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),WaveFitclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FadcReadout.d

$(bin)$(binobj)FadcReadout.d :

$(bin)$(binobj)FadcReadout.o : $(cmt_final_setup_WaveFit)

$(bin)$(binobj)FadcReadout.o : $(src)FadcReadout.cxx
	$(cpp_echo) $(src)FadcReadout.cxx
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(WaveFit_pp_cppflags) $(lib_WaveFit_pp_cppflags) $(FadcReadout_pp_cppflags) $(use_cppflags) $(WaveFit_cppflags) $(lib_WaveFit_cppflags) $(FadcReadout_cppflags) $(FadcReadout_cxx_cppflags)  $(src)FadcReadout.cxx
endif
endif

else
$(bin)WaveFit_dependencies.make : $(FadcReadout_cxx_dependencies)

$(bin)WaveFit_dependencies.make : $(src)FadcReadout.cxx

$(bin)$(binobj)FadcReadout.o : $(FadcReadout_cxx_dependencies)
	$(cpp_echo) $(src)FadcReadout.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(WaveFit_pp_cppflags) $(lib_WaveFit_pp_cppflags) $(FadcReadout_pp_cppflags) $(use_cppflags) $(WaveFit_cppflags) $(lib_WaveFit_cppflags) $(FadcReadout_cppflags) $(FadcReadout_cxx_cppflags)  $(src)FadcReadout.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),WaveFitclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FadcFit.d

$(bin)$(binobj)FadcFit.d :

$(bin)$(binobj)FadcFit.o : $(cmt_final_setup_WaveFit)

$(bin)$(binobj)FadcFit.o : $(src)FadcFit.cxx
	$(cpp_echo) $(src)FadcFit.cxx
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(WaveFit_pp_cppflags) $(lib_WaveFit_pp_cppflags) $(FadcFit_pp_cppflags) $(use_cppflags) $(WaveFit_cppflags) $(lib_WaveFit_cppflags) $(FadcFit_cppflags) $(FadcFit_cxx_cppflags)  $(src)FadcFit.cxx
endif
endif

else
$(bin)WaveFit_dependencies.make : $(FadcFit_cxx_dependencies)

$(bin)WaveFit_dependencies.make : $(src)FadcFit.cxx

$(bin)$(binobj)FadcFit.o : $(FadcFit_cxx_dependencies)
	$(cpp_echo) $(src)FadcFit.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(WaveFit_pp_cppflags) $(lib_WaveFit_pp_cppflags) $(FadcFit_pp_cppflags) $(use_cppflags) $(WaveFit_cppflags) $(lib_WaveFit_cppflags) $(FadcFit_cppflags) $(FadcFit_cxx_cppflags)  $(src)FadcFit.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),WaveFitclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AnalysisTool.d

$(bin)$(binobj)AnalysisTool.d :

$(bin)$(binobj)AnalysisTool.o : $(cmt_final_setup_WaveFit)

$(bin)$(binobj)AnalysisTool.o : $(src)AnalysisTool.cxx
	$(cpp_echo) $(src)AnalysisTool.cxx
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(WaveFit_pp_cppflags) $(lib_WaveFit_pp_cppflags) $(AnalysisTool_pp_cppflags) $(use_cppflags) $(WaveFit_cppflags) $(lib_WaveFit_cppflags) $(AnalysisTool_cppflags) $(AnalysisTool_cxx_cppflags)  $(src)AnalysisTool.cxx
endif
endif

else
$(bin)WaveFit_dependencies.make : $(AnalysisTool_cxx_dependencies)

$(bin)WaveFit_dependencies.make : $(src)AnalysisTool.cxx

$(bin)$(binobj)AnalysisTool.o : $(AnalysisTool_cxx_dependencies)
	$(cpp_echo) $(src)AnalysisTool.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(WaveFit_pp_cppflags) $(lib_WaveFit_pp_cppflags) $(AnalysisTool_pp_cppflags) $(use_cppflags) $(WaveFit_cppflags) $(lib_WaveFit_cppflags) $(AnalysisTool_cppflags) $(AnalysisTool_cxx_cppflags)  $(src)AnalysisTool.cxx

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: WaveFitclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(WaveFit.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

WaveFitclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library WaveFit
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)WaveFit$(library_suffix).a $(library_prefix)WaveFit$(library_suffix).$(shlibsuffix) WaveFit.stamp WaveFit.shstamp
#-- end of cleanup_library ---------------

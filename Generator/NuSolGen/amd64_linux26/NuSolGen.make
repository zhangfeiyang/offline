#-- start of make_header -----------------

#====================================
#  Library NuSolGen
#
#   Generated Fri Jul 10 19:26:49 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_NuSolGen_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_NuSolGen_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_NuSolGen

NuSolGen_tag = $(tag)

#cmt_local_tagfile_NuSolGen = $(NuSolGen_tag)_NuSolGen.make
cmt_local_tagfile_NuSolGen = $(bin)$(NuSolGen_tag)_NuSolGen.make

else

tags      = $(tag),$(CMTEXTRATAGS)

NuSolGen_tag = $(tag)

#cmt_local_tagfile_NuSolGen = $(NuSolGen_tag).make
cmt_local_tagfile_NuSolGen = $(bin)$(NuSolGen_tag).make

endif

include $(cmt_local_tagfile_NuSolGen)
#-include $(cmt_local_tagfile_NuSolGen)

ifdef cmt_NuSolGen_has_target_tag

cmt_final_setup_NuSolGen = $(bin)setup_NuSolGen.make
cmt_dependencies_in_NuSolGen = $(bin)dependencies_NuSolGen.in
#cmt_final_setup_NuSolGen = $(bin)NuSolGen_NuSolGensetup.make
cmt_local_NuSolGen_makefile = $(bin)NuSolGen.make

else

cmt_final_setup_NuSolGen = $(bin)setup.make
cmt_dependencies_in_NuSolGen = $(bin)dependencies.in
#cmt_final_setup_NuSolGen = $(bin)NuSolGensetup.make
cmt_local_NuSolGen_makefile = $(bin)NuSolGen.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)NuSolGensetup.make

#NuSolGen :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'NuSolGen'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = NuSolGen/
#NuSolGen::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

NuSolGenlibname   = $(bin)$(library_prefix)NuSolGen$(library_suffix)
NuSolGenlib       = $(NuSolGenlibname).a
NuSolGenstamp     = $(bin)NuSolGen.stamp
NuSolGenshstamp   = $(bin)NuSolGen.shstamp

NuSolGen :: dirs  NuSolGenLIB
	$(echo) "NuSolGen ok"

cmt_NuSolGen_has_prototypes = 1

#--------------------------------------

ifdef cmt_NuSolGen_has_prototypes

NuSolGenprototype :  ;

endif

NuSolGencompile : $(bin)SolarNeutrinoSpectrum.o $(bin)GtNuSolTool.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

NuSolGenLIB :: $(NuSolGenlib) $(NuSolGenshstamp)
	$(echo) "NuSolGen : library ok"

$(NuSolGenlib) :: $(bin)SolarNeutrinoSpectrum.o $(bin)GtNuSolTool.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(NuSolGenlib) $(bin)SolarNeutrinoSpectrum.o $(bin)GtNuSolTool.o
	$(lib_silent) $(ranlib) $(NuSolGenlib)
	$(lib_silent) cat /dev/null >$(NuSolGenstamp)

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

$(NuSolGenlibname).$(shlibsuffix) :: $(NuSolGenlib) requirements $(use_requirements) $(NuSolGenstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" NuSolGen $(NuSolGen_shlibflags)
	$(lib_silent) cat /dev/null >$(NuSolGenshstamp)

$(NuSolGenshstamp) :: $(NuSolGenlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(NuSolGenlibname).$(shlibsuffix) ; then cat /dev/null >$(NuSolGenshstamp) ; fi

NuSolGenclean ::
	$(cleanup_echo) objects NuSolGen
	$(cleanup_silent) /bin/rm -f $(bin)SolarNeutrinoSpectrum.o $(bin)GtNuSolTool.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)SolarNeutrinoSpectrum.o $(bin)GtNuSolTool.o) $(patsubst %.o,%.dep,$(bin)SolarNeutrinoSpectrum.o $(bin)GtNuSolTool.o) $(patsubst %.o,%.d.stamp,$(bin)SolarNeutrinoSpectrum.o $(bin)GtNuSolTool.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf NuSolGen_deps NuSolGen_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
NuSolGeninstallname = $(library_prefix)NuSolGen$(library_suffix).$(shlibsuffix)

NuSolGen :: NuSolGeninstall ;

install :: NuSolGeninstall ;

NuSolGeninstall :: $(install_dir)/$(NuSolGeninstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(NuSolGeninstallname) :: $(bin)$(NuSolGeninstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(NuSolGeninstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##NuSolGenclean :: NuSolGenuninstall

uninstall :: NuSolGenuninstall ;

NuSolGenuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(NuSolGeninstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),NuSolGenclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),NuSolGenprototype)

$(bin)NuSolGen_dependencies.make : $(use_requirements) $(cmt_final_setup_NuSolGen)
	$(echo) "(NuSolGen.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)SolarNeutrinoSpectrum.cc $(src)GtNuSolTool.cc -end_all $(includes) $(app_NuSolGen_cppflags) $(lib_NuSolGen_cppflags) -name=NuSolGen $? -f=$(cmt_dependencies_in_NuSolGen) -without_cmt

-include $(bin)NuSolGen_dependencies.make

endif
endif
endif

NuSolGenclean ::
	$(cleanup_silent) \rm -rf $(bin)NuSolGen_deps $(bin)NuSolGen_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),NuSolGenclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SolarNeutrinoSpectrum.d

$(bin)$(binobj)SolarNeutrinoSpectrum.d :

$(bin)$(binobj)SolarNeutrinoSpectrum.o : $(cmt_final_setup_NuSolGen)

$(bin)$(binobj)SolarNeutrinoSpectrum.o : $(src)SolarNeutrinoSpectrum.cc
	$(cpp_echo) $(src)SolarNeutrinoSpectrum.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(NuSolGen_pp_cppflags) $(lib_NuSolGen_pp_cppflags) $(SolarNeutrinoSpectrum_pp_cppflags) $(use_cppflags) $(NuSolGen_cppflags) $(lib_NuSolGen_cppflags) $(SolarNeutrinoSpectrum_cppflags) $(SolarNeutrinoSpectrum_cc_cppflags)  $(src)SolarNeutrinoSpectrum.cc
endif
endif

else
$(bin)NuSolGen_dependencies.make : $(SolarNeutrinoSpectrum_cc_dependencies)

$(bin)NuSolGen_dependencies.make : $(src)SolarNeutrinoSpectrum.cc

$(bin)$(binobj)SolarNeutrinoSpectrum.o : $(SolarNeutrinoSpectrum_cc_dependencies)
	$(cpp_echo) $(src)SolarNeutrinoSpectrum.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(NuSolGen_pp_cppflags) $(lib_NuSolGen_pp_cppflags) $(SolarNeutrinoSpectrum_pp_cppflags) $(use_cppflags) $(NuSolGen_cppflags) $(lib_NuSolGen_cppflags) $(SolarNeutrinoSpectrum_cppflags) $(SolarNeutrinoSpectrum_cc_cppflags)  $(src)SolarNeutrinoSpectrum.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),NuSolGenclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GtNuSolTool.d

$(bin)$(binobj)GtNuSolTool.d :

$(bin)$(binobj)GtNuSolTool.o : $(cmt_final_setup_NuSolGen)

$(bin)$(binobj)GtNuSolTool.o : $(src)GtNuSolTool.cc
	$(cpp_echo) $(src)GtNuSolTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(NuSolGen_pp_cppflags) $(lib_NuSolGen_pp_cppflags) $(GtNuSolTool_pp_cppflags) $(use_cppflags) $(NuSolGen_cppflags) $(lib_NuSolGen_cppflags) $(GtNuSolTool_cppflags) $(GtNuSolTool_cc_cppflags)  $(src)GtNuSolTool.cc
endif
endif

else
$(bin)NuSolGen_dependencies.make : $(GtNuSolTool_cc_dependencies)

$(bin)NuSolGen_dependencies.make : $(src)GtNuSolTool.cc

$(bin)$(binobj)GtNuSolTool.o : $(GtNuSolTool_cc_dependencies)
	$(cpp_echo) $(src)GtNuSolTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(NuSolGen_pp_cppflags) $(lib_NuSolGen_pp_cppflags) $(GtNuSolTool_pp_cppflags) $(use_cppflags) $(NuSolGen_cppflags) $(lib_NuSolGen_cppflags) $(GtNuSolTool_cppflags) $(GtNuSolTool_cc_cppflags)  $(src)GtNuSolTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: NuSolGenclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(NuSolGen.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

NuSolGenclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library NuSolGen
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)NuSolGen$(library_suffix).a $(library_prefix)NuSolGen$(library_suffix).$(shlibsuffix) NuSolGen.stamp NuSolGen.shstamp
#-- end of cleanup_library ---------------

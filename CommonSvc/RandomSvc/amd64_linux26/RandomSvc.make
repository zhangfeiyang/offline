#-- start of make_header -----------------

#====================================
#  Library RandomSvc
#
#   Generated Fri Jul 10 19:17:20 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RandomSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RandomSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RandomSvc

RandomSvc_tag = $(tag)

#cmt_local_tagfile_RandomSvc = $(RandomSvc_tag)_RandomSvc.make
cmt_local_tagfile_RandomSvc = $(bin)$(RandomSvc_tag)_RandomSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RandomSvc_tag = $(tag)

#cmt_local_tagfile_RandomSvc = $(RandomSvc_tag).make
cmt_local_tagfile_RandomSvc = $(bin)$(RandomSvc_tag).make

endif

include $(cmt_local_tagfile_RandomSvc)
#-include $(cmt_local_tagfile_RandomSvc)

ifdef cmt_RandomSvc_has_target_tag

cmt_final_setup_RandomSvc = $(bin)setup_RandomSvc.make
cmt_dependencies_in_RandomSvc = $(bin)dependencies_RandomSvc.in
#cmt_final_setup_RandomSvc = $(bin)RandomSvc_RandomSvcsetup.make
cmt_local_RandomSvc_makefile = $(bin)RandomSvc.make

else

cmt_final_setup_RandomSvc = $(bin)setup.make
cmt_dependencies_in_RandomSvc = $(bin)dependencies.in
#cmt_final_setup_RandomSvc = $(bin)RandomSvcsetup.make
cmt_local_RandomSvc_makefile = $(bin)RandomSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RandomSvcsetup.make

#RandomSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RandomSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RandomSvc/
#RandomSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RandomSvclibname   = $(bin)$(library_prefix)RandomSvc$(library_suffix)
RandomSvclib       = $(RandomSvclibname).a
RandomSvcstamp     = $(bin)RandomSvc.stamp
RandomSvcshstamp   = $(bin)RandomSvc.shstamp

RandomSvc :: dirs  RandomSvcLIB
	$(echo) "RandomSvc ok"

cmt_RandomSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_RandomSvc_has_prototypes

RandomSvcprototype :  ;

endif

RandomSvccompile : $(bin)RandomSeedRecorder.o $(bin)IRandomSvc.o $(bin)RandomSvc.o $(bin)RandomSvcBinding.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

RandomSvcLIB :: $(RandomSvclib) $(RandomSvcshstamp)
	$(echo) "RandomSvc : library ok"

$(RandomSvclib) :: $(bin)RandomSeedRecorder.o $(bin)IRandomSvc.o $(bin)RandomSvc.o $(bin)RandomSvcBinding.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(RandomSvclib) $(bin)RandomSeedRecorder.o $(bin)IRandomSvc.o $(bin)RandomSvc.o $(bin)RandomSvcBinding.o
	$(lib_silent) $(ranlib) $(RandomSvclib)
	$(lib_silent) cat /dev/null >$(RandomSvcstamp)

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

$(RandomSvclibname).$(shlibsuffix) :: $(RandomSvclib) requirements $(use_requirements) $(RandomSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" RandomSvc $(RandomSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(RandomSvcshstamp)

$(RandomSvcshstamp) :: $(RandomSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RandomSvclibname).$(shlibsuffix) ; then cat /dev/null >$(RandomSvcshstamp) ; fi

RandomSvcclean ::
	$(cleanup_echo) objects RandomSvc
	$(cleanup_silent) /bin/rm -f $(bin)RandomSeedRecorder.o $(bin)IRandomSvc.o $(bin)RandomSvc.o $(bin)RandomSvcBinding.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)RandomSeedRecorder.o $(bin)IRandomSvc.o $(bin)RandomSvc.o $(bin)RandomSvcBinding.o) $(patsubst %.o,%.dep,$(bin)RandomSeedRecorder.o $(bin)IRandomSvc.o $(bin)RandomSvc.o $(bin)RandomSvcBinding.o) $(patsubst %.o,%.d.stamp,$(bin)RandomSeedRecorder.o $(bin)IRandomSvc.o $(bin)RandomSvc.o $(bin)RandomSvcBinding.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RandomSvc_deps RandomSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RandomSvcinstallname = $(library_prefix)RandomSvc$(library_suffix).$(shlibsuffix)

RandomSvc :: RandomSvcinstall ;

install :: RandomSvcinstall ;

RandomSvcinstall :: $(install_dir)/$(RandomSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RandomSvcinstallname) :: $(bin)$(RandomSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RandomSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RandomSvcclean :: RandomSvcuninstall

uninstall :: RandomSvcuninstall ;

RandomSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RandomSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),RandomSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),RandomSvcprototype)

$(bin)RandomSvc_dependencies.make : $(use_requirements) $(cmt_final_setup_RandomSvc)
	$(echo) "(RandomSvc.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)RandomSeedRecorder.cc $(src)IRandomSvc.cc $(src)RandomSvc.cc ../binding/RandomSvcBinding.cc -end_all $(includes) $(app_RandomSvc_cppflags) $(lib_RandomSvc_cppflags) -name=RandomSvc $? -f=$(cmt_dependencies_in_RandomSvc) -without_cmt

-include $(bin)RandomSvc_dependencies.make

endif
endif
endif

RandomSvcclean ::
	$(cleanup_silent) \rm -rf $(bin)RandomSvc_deps $(bin)RandomSvc_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RandomSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RandomSeedRecorder.d

$(bin)$(binobj)RandomSeedRecorder.d :

$(bin)$(binobj)RandomSeedRecorder.o : $(cmt_final_setup_RandomSvc)

$(bin)$(binobj)RandomSeedRecorder.o : $(src)RandomSeedRecorder.cc
	$(cpp_echo) $(src)RandomSeedRecorder.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RandomSvc_pp_cppflags) $(lib_RandomSvc_pp_cppflags) $(RandomSeedRecorder_pp_cppflags) $(use_cppflags) $(RandomSvc_cppflags) $(lib_RandomSvc_cppflags) $(RandomSeedRecorder_cppflags) $(RandomSeedRecorder_cc_cppflags)  $(src)RandomSeedRecorder.cc
endif
endif

else
$(bin)RandomSvc_dependencies.make : $(RandomSeedRecorder_cc_dependencies)

$(bin)RandomSvc_dependencies.make : $(src)RandomSeedRecorder.cc

$(bin)$(binobj)RandomSeedRecorder.o : $(RandomSeedRecorder_cc_dependencies)
	$(cpp_echo) $(src)RandomSeedRecorder.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RandomSvc_pp_cppflags) $(lib_RandomSvc_pp_cppflags) $(RandomSeedRecorder_pp_cppflags) $(use_cppflags) $(RandomSvc_cppflags) $(lib_RandomSvc_cppflags) $(RandomSeedRecorder_cppflags) $(RandomSeedRecorder_cc_cppflags)  $(src)RandomSeedRecorder.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RandomSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IRandomSvc.d

$(bin)$(binobj)IRandomSvc.d :

$(bin)$(binobj)IRandomSvc.o : $(cmt_final_setup_RandomSvc)

$(bin)$(binobj)IRandomSvc.o : $(src)IRandomSvc.cc
	$(cpp_echo) $(src)IRandomSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RandomSvc_pp_cppflags) $(lib_RandomSvc_pp_cppflags) $(IRandomSvc_pp_cppflags) $(use_cppflags) $(RandomSvc_cppflags) $(lib_RandomSvc_cppflags) $(IRandomSvc_cppflags) $(IRandomSvc_cc_cppflags)  $(src)IRandomSvc.cc
endif
endif

else
$(bin)RandomSvc_dependencies.make : $(IRandomSvc_cc_dependencies)

$(bin)RandomSvc_dependencies.make : $(src)IRandomSvc.cc

$(bin)$(binobj)IRandomSvc.o : $(IRandomSvc_cc_dependencies)
	$(cpp_echo) $(src)IRandomSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RandomSvc_pp_cppflags) $(lib_RandomSvc_pp_cppflags) $(IRandomSvc_pp_cppflags) $(use_cppflags) $(RandomSvc_cppflags) $(lib_RandomSvc_cppflags) $(IRandomSvc_cppflags) $(IRandomSvc_cc_cppflags)  $(src)IRandomSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RandomSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RandomSvc.d

$(bin)$(binobj)RandomSvc.d :

$(bin)$(binobj)RandomSvc.o : $(cmt_final_setup_RandomSvc)

$(bin)$(binobj)RandomSvc.o : $(src)RandomSvc.cc
	$(cpp_echo) $(src)RandomSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RandomSvc_pp_cppflags) $(lib_RandomSvc_pp_cppflags) $(RandomSvc_pp_cppflags) $(use_cppflags) $(RandomSvc_cppflags) $(lib_RandomSvc_cppflags) $(RandomSvc_cppflags) $(RandomSvc_cc_cppflags)  $(src)RandomSvc.cc
endif
endif

else
$(bin)RandomSvc_dependencies.make : $(RandomSvc_cc_dependencies)

$(bin)RandomSvc_dependencies.make : $(src)RandomSvc.cc

$(bin)$(binobj)RandomSvc.o : $(RandomSvc_cc_dependencies)
	$(cpp_echo) $(src)RandomSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RandomSvc_pp_cppflags) $(lib_RandomSvc_pp_cppflags) $(RandomSvc_pp_cppflags) $(use_cppflags) $(RandomSvc_cppflags) $(lib_RandomSvc_cppflags) $(RandomSvc_cppflags) $(RandomSvc_cc_cppflags)  $(src)RandomSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RandomSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RandomSvcBinding.d

$(bin)$(binobj)RandomSvcBinding.d :

$(bin)$(binobj)RandomSvcBinding.o : $(cmt_final_setup_RandomSvc)

$(bin)$(binobj)RandomSvcBinding.o : ../binding/RandomSvcBinding.cc
	$(cpp_echo) ../binding/RandomSvcBinding.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RandomSvc_pp_cppflags) $(lib_RandomSvc_pp_cppflags) $(RandomSvcBinding_pp_cppflags) $(use_cppflags) $(RandomSvc_cppflags) $(lib_RandomSvc_cppflags) $(RandomSvcBinding_cppflags) $(RandomSvcBinding_cc_cppflags) -I../binding ../binding/RandomSvcBinding.cc
endif
endif

else
$(bin)RandomSvc_dependencies.make : $(RandomSvcBinding_cc_dependencies)

$(bin)RandomSvc_dependencies.make : ../binding/RandomSvcBinding.cc

$(bin)$(binobj)RandomSvcBinding.o : $(RandomSvcBinding_cc_dependencies)
	$(cpp_echo) ../binding/RandomSvcBinding.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RandomSvc_pp_cppflags) $(lib_RandomSvc_pp_cppflags) $(RandomSvcBinding_pp_cppflags) $(use_cppflags) $(RandomSvc_cppflags) $(lib_RandomSvc_cppflags) $(RandomSvcBinding_cppflags) $(RandomSvcBinding_cc_cppflags) -I../binding ../binding/RandomSvcBinding.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RandomSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RandomSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RandomSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RandomSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RandomSvc$(library_suffix).a $(library_prefix)RandomSvc$(library_suffix).$(shlibsuffix) RandomSvc.stamp RandomSvc.shstamp
#-- end of cleanup_library ---------------

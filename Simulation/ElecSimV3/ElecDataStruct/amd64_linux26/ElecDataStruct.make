#-- start of make_header -----------------

#====================================
#  Library ElecDataStruct
#
#   Generated Fri Jul 10 19:22:54 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_ElecDataStruct_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ElecDataStruct_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ElecDataStruct

ElecDataStruct_tag = $(tag)

#cmt_local_tagfile_ElecDataStruct = $(ElecDataStruct_tag)_ElecDataStruct.make
cmt_local_tagfile_ElecDataStruct = $(bin)$(ElecDataStruct_tag)_ElecDataStruct.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ElecDataStruct_tag = $(tag)

#cmt_local_tagfile_ElecDataStruct = $(ElecDataStruct_tag).make
cmt_local_tagfile_ElecDataStruct = $(bin)$(ElecDataStruct_tag).make

endif

include $(cmt_local_tagfile_ElecDataStruct)
#-include $(cmt_local_tagfile_ElecDataStruct)

ifdef cmt_ElecDataStruct_has_target_tag

cmt_final_setup_ElecDataStruct = $(bin)setup_ElecDataStruct.make
cmt_dependencies_in_ElecDataStruct = $(bin)dependencies_ElecDataStruct.in
#cmt_final_setup_ElecDataStruct = $(bin)ElecDataStruct_ElecDataStructsetup.make
cmt_local_ElecDataStruct_makefile = $(bin)ElecDataStruct.make

else

cmt_final_setup_ElecDataStruct = $(bin)setup.make
cmt_dependencies_in_ElecDataStruct = $(bin)dependencies.in
#cmt_final_setup_ElecDataStruct = $(bin)ElecDataStructsetup.make
cmt_local_ElecDataStruct_makefile = $(bin)ElecDataStruct.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ElecDataStructsetup.make

#ElecDataStruct :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ElecDataStruct'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ElecDataStruct/
#ElecDataStruct::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

ElecDataStructlibname   = $(bin)$(library_prefix)ElecDataStruct$(library_suffix)
ElecDataStructlib       = $(ElecDataStructlibname).a
ElecDataStructstamp     = $(bin)ElecDataStruct.stamp
ElecDataStructshstamp   = $(bin)ElecDataStruct.shstamp

ElecDataStruct :: dirs  ElecDataStructLIB
	$(echo) "ElecDataStruct ok"

cmt_ElecDataStruct_has_prototypes = 1

#--------------------------------------

ifdef cmt_ElecDataStruct_has_prototypes

ElecDataStructprototype :  ;

endif

ElecDataStructcompile : $(bin)Hit.o $(bin)EventKeeper.o $(bin)Event.o $(bin)Pulse.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

ElecDataStructLIB :: $(ElecDataStructlib) $(ElecDataStructshstamp)
	$(echo) "ElecDataStruct : library ok"

$(ElecDataStructlib) :: $(bin)Hit.o $(bin)EventKeeper.o $(bin)Event.o $(bin)Pulse.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(ElecDataStructlib) $(bin)Hit.o $(bin)EventKeeper.o $(bin)Event.o $(bin)Pulse.o
	$(lib_silent) $(ranlib) $(ElecDataStructlib)
	$(lib_silent) cat /dev/null >$(ElecDataStructstamp)

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

$(ElecDataStructlibname).$(shlibsuffix) :: $(ElecDataStructlib) requirements $(use_requirements) $(ElecDataStructstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" ElecDataStruct $(ElecDataStruct_shlibflags)
	$(lib_silent) cat /dev/null >$(ElecDataStructshstamp)

$(ElecDataStructshstamp) :: $(ElecDataStructlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(ElecDataStructlibname).$(shlibsuffix) ; then cat /dev/null >$(ElecDataStructshstamp) ; fi

ElecDataStructclean ::
	$(cleanup_echo) objects ElecDataStruct
	$(cleanup_silent) /bin/rm -f $(bin)Hit.o $(bin)EventKeeper.o $(bin)Event.o $(bin)Pulse.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)Hit.o $(bin)EventKeeper.o $(bin)Event.o $(bin)Pulse.o) $(patsubst %.o,%.dep,$(bin)Hit.o $(bin)EventKeeper.o $(bin)Event.o $(bin)Pulse.o) $(patsubst %.o,%.d.stamp,$(bin)Hit.o $(bin)EventKeeper.o $(bin)Event.o $(bin)Pulse.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf ElecDataStruct_deps ElecDataStruct_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
ElecDataStructinstallname = $(library_prefix)ElecDataStruct$(library_suffix).$(shlibsuffix)

ElecDataStruct :: ElecDataStructinstall ;

install :: ElecDataStructinstall ;

ElecDataStructinstall :: $(install_dir)/$(ElecDataStructinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(ElecDataStructinstallname) :: $(bin)$(ElecDataStructinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(ElecDataStructinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##ElecDataStructclean :: ElecDataStructuninstall

uninstall :: ElecDataStructuninstall ;

ElecDataStructuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(ElecDataStructinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),ElecDataStructclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),ElecDataStructprototype)

$(bin)ElecDataStruct_dependencies.make : $(use_requirements) $(cmt_final_setup_ElecDataStruct)
	$(echo) "(ElecDataStruct.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)Hit.cc $(src)EventKeeper.cc $(src)Event.cc $(src)Pulse.cc -end_all $(includes) $(app_ElecDataStruct_cppflags) $(lib_ElecDataStruct_cppflags) -name=ElecDataStruct $? -f=$(cmt_dependencies_in_ElecDataStruct) -without_cmt

-include $(bin)ElecDataStruct_dependencies.make

endif
endif
endif

ElecDataStructclean ::
	$(cleanup_silent) \rm -rf $(bin)ElecDataStruct_deps $(bin)ElecDataStruct_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecDataStructclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Hit.d

$(bin)$(binobj)Hit.d :

$(bin)$(binobj)Hit.o : $(cmt_final_setup_ElecDataStruct)

$(bin)$(binobj)Hit.o : $(src)Hit.cc
	$(cpp_echo) $(src)Hit.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecDataStruct_pp_cppflags) $(lib_ElecDataStruct_pp_cppflags) $(Hit_pp_cppflags) $(use_cppflags) $(ElecDataStruct_cppflags) $(lib_ElecDataStruct_cppflags) $(Hit_cppflags) $(Hit_cc_cppflags)  $(src)Hit.cc
endif
endif

else
$(bin)ElecDataStruct_dependencies.make : $(Hit_cc_dependencies)

$(bin)ElecDataStruct_dependencies.make : $(src)Hit.cc

$(bin)$(binobj)Hit.o : $(Hit_cc_dependencies)
	$(cpp_echo) $(src)Hit.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecDataStruct_pp_cppflags) $(lib_ElecDataStruct_pp_cppflags) $(Hit_pp_cppflags) $(use_cppflags) $(ElecDataStruct_cppflags) $(lib_ElecDataStruct_cppflags) $(Hit_cppflags) $(Hit_cc_cppflags)  $(src)Hit.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecDataStructclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EventKeeper.d

$(bin)$(binobj)EventKeeper.d :

$(bin)$(binobj)EventKeeper.o : $(cmt_final_setup_ElecDataStruct)

$(bin)$(binobj)EventKeeper.o : $(src)EventKeeper.cc
	$(cpp_echo) $(src)EventKeeper.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecDataStruct_pp_cppflags) $(lib_ElecDataStruct_pp_cppflags) $(EventKeeper_pp_cppflags) $(use_cppflags) $(ElecDataStruct_cppflags) $(lib_ElecDataStruct_cppflags) $(EventKeeper_cppflags) $(EventKeeper_cc_cppflags)  $(src)EventKeeper.cc
endif
endif

else
$(bin)ElecDataStruct_dependencies.make : $(EventKeeper_cc_dependencies)

$(bin)ElecDataStruct_dependencies.make : $(src)EventKeeper.cc

$(bin)$(binobj)EventKeeper.o : $(EventKeeper_cc_dependencies)
	$(cpp_echo) $(src)EventKeeper.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecDataStruct_pp_cppflags) $(lib_ElecDataStruct_pp_cppflags) $(EventKeeper_pp_cppflags) $(use_cppflags) $(ElecDataStruct_cppflags) $(lib_ElecDataStruct_cppflags) $(EventKeeper_cppflags) $(EventKeeper_cc_cppflags)  $(src)EventKeeper.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecDataStructclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Event.d

$(bin)$(binobj)Event.d :

$(bin)$(binobj)Event.o : $(cmt_final_setup_ElecDataStruct)

$(bin)$(binobj)Event.o : $(src)Event.cc
	$(cpp_echo) $(src)Event.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecDataStruct_pp_cppflags) $(lib_ElecDataStruct_pp_cppflags) $(Event_pp_cppflags) $(use_cppflags) $(ElecDataStruct_cppflags) $(lib_ElecDataStruct_cppflags) $(Event_cppflags) $(Event_cc_cppflags)  $(src)Event.cc
endif
endif

else
$(bin)ElecDataStruct_dependencies.make : $(Event_cc_dependencies)

$(bin)ElecDataStruct_dependencies.make : $(src)Event.cc

$(bin)$(binobj)Event.o : $(Event_cc_dependencies)
	$(cpp_echo) $(src)Event.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecDataStruct_pp_cppflags) $(lib_ElecDataStruct_pp_cppflags) $(Event_pp_cppflags) $(use_cppflags) $(ElecDataStruct_cppflags) $(lib_ElecDataStruct_cppflags) $(Event_cppflags) $(Event_cc_cppflags)  $(src)Event.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecDataStructclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Pulse.d

$(bin)$(binobj)Pulse.d :

$(bin)$(binobj)Pulse.o : $(cmt_final_setup_ElecDataStruct)

$(bin)$(binobj)Pulse.o : $(src)Pulse.cc
	$(cpp_echo) $(src)Pulse.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecDataStruct_pp_cppflags) $(lib_ElecDataStruct_pp_cppflags) $(Pulse_pp_cppflags) $(use_cppflags) $(ElecDataStruct_cppflags) $(lib_ElecDataStruct_cppflags) $(Pulse_cppflags) $(Pulse_cc_cppflags)  $(src)Pulse.cc
endif
endif

else
$(bin)ElecDataStruct_dependencies.make : $(Pulse_cc_dependencies)

$(bin)ElecDataStruct_dependencies.make : $(src)Pulse.cc

$(bin)$(binobj)Pulse.o : $(Pulse_cc_dependencies)
	$(cpp_echo) $(src)Pulse.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecDataStruct_pp_cppflags) $(lib_ElecDataStruct_pp_cppflags) $(Pulse_pp_cppflags) $(use_cppflags) $(ElecDataStruct_cppflags) $(lib_ElecDataStruct_cppflags) $(Pulse_cppflags) $(Pulse_cc_cppflags)  $(src)Pulse.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: ElecDataStructclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ElecDataStruct.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ElecDataStructclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library ElecDataStruct
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)ElecDataStruct$(library_suffix).a $(library_prefix)ElecDataStruct$(library_suffix).$(shlibsuffix) ElecDataStruct.stamp ElecDataStruct.shstamp
#-- end of cleanup_library ---------------

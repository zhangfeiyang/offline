#-- start of make_header -----------------

#====================================
#  Library JunoTimer
#
#   Generated Fri Jul 10 19:15:35 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_JunoTimer_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_JunoTimer_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_JunoTimer

JunoTimer_tag = $(tag)

#cmt_local_tagfile_JunoTimer = $(JunoTimer_tag)_JunoTimer.make
cmt_local_tagfile_JunoTimer = $(bin)$(JunoTimer_tag)_JunoTimer.make

else

tags      = $(tag),$(CMTEXTRATAGS)

JunoTimer_tag = $(tag)

#cmt_local_tagfile_JunoTimer = $(JunoTimer_tag).make
cmt_local_tagfile_JunoTimer = $(bin)$(JunoTimer_tag).make

endif

include $(cmt_local_tagfile_JunoTimer)
#-include $(cmt_local_tagfile_JunoTimer)

ifdef cmt_JunoTimer_has_target_tag

cmt_final_setup_JunoTimer = $(bin)setup_JunoTimer.make
cmt_dependencies_in_JunoTimer = $(bin)dependencies_JunoTimer.in
#cmt_final_setup_JunoTimer = $(bin)JunoTimer_JunoTimersetup.make
cmt_local_JunoTimer_makefile = $(bin)JunoTimer.make

else

cmt_final_setup_JunoTimer = $(bin)setup.make
cmt_dependencies_in_JunoTimer = $(bin)dependencies.in
#cmt_final_setup_JunoTimer = $(bin)JunoTimersetup.make
cmt_local_JunoTimer_makefile = $(bin)JunoTimer.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)JunoTimersetup.make

#JunoTimer :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'JunoTimer'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = JunoTimer/
#JunoTimer::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

JunoTimerlibname   = $(bin)$(library_prefix)JunoTimer$(library_suffix)
JunoTimerlib       = $(JunoTimerlibname).a
JunoTimerstamp     = $(bin)JunoTimer.stamp
JunoTimershstamp   = $(bin)JunoTimer.shstamp

JunoTimer :: dirs  JunoTimerLIB
	$(echo) "JunoTimer ok"

cmt_JunoTimer_has_prototypes = 1

#--------------------------------------

ifdef cmt_JunoTimer_has_prototypes

JunoTimerprototype :  ;

endif

JunoTimercompile : $(bin)JunoTimerSvc.o $(bin)JunoTimer.o $(bin)JunoTimerBinding.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

JunoTimerLIB :: $(JunoTimerlib) $(JunoTimershstamp)
	$(echo) "JunoTimer : library ok"

$(JunoTimerlib) :: $(bin)JunoTimerSvc.o $(bin)JunoTimer.o $(bin)JunoTimerBinding.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(JunoTimerlib) $(bin)JunoTimerSvc.o $(bin)JunoTimer.o $(bin)JunoTimerBinding.o
	$(lib_silent) $(ranlib) $(JunoTimerlib)
	$(lib_silent) cat /dev/null >$(JunoTimerstamp)

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

$(JunoTimerlibname).$(shlibsuffix) :: $(JunoTimerlib) requirements $(use_requirements) $(JunoTimerstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" JunoTimer $(JunoTimer_shlibflags)
	$(lib_silent) cat /dev/null >$(JunoTimershstamp)

$(JunoTimershstamp) :: $(JunoTimerlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(JunoTimerlibname).$(shlibsuffix) ; then cat /dev/null >$(JunoTimershstamp) ; fi

JunoTimerclean ::
	$(cleanup_echo) objects JunoTimer
	$(cleanup_silent) /bin/rm -f $(bin)JunoTimerSvc.o $(bin)JunoTimer.o $(bin)JunoTimerBinding.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)JunoTimerSvc.o $(bin)JunoTimer.o $(bin)JunoTimerBinding.o) $(patsubst %.o,%.dep,$(bin)JunoTimerSvc.o $(bin)JunoTimer.o $(bin)JunoTimerBinding.o) $(patsubst %.o,%.d.stamp,$(bin)JunoTimerSvc.o $(bin)JunoTimer.o $(bin)JunoTimerBinding.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf JunoTimer_deps JunoTimer_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
JunoTimerinstallname = $(library_prefix)JunoTimer$(library_suffix).$(shlibsuffix)

JunoTimer :: JunoTimerinstall ;

install :: JunoTimerinstall ;

JunoTimerinstall :: $(install_dir)/$(JunoTimerinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(JunoTimerinstallname) :: $(bin)$(JunoTimerinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(JunoTimerinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##JunoTimerclean :: JunoTimeruninstall

uninstall :: JunoTimeruninstall ;

JunoTimeruninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(JunoTimerinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),JunoTimerclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),JunoTimerprototype)

$(bin)JunoTimer_dependencies.make : $(use_requirements) $(cmt_final_setup_JunoTimer)
	$(echo) "(JunoTimer.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)JunoTimerSvc.cc $(src)JunoTimer.cc ../binding/JunoTimerBinding.cc -end_all $(includes) $(app_JunoTimer_cppflags) $(lib_JunoTimer_cppflags) -name=JunoTimer $? -f=$(cmt_dependencies_in_JunoTimer) -without_cmt

-include $(bin)JunoTimer_dependencies.make

endif
endif
endif

JunoTimerclean ::
	$(cleanup_silent) \rm -rf $(bin)JunoTimer_deps $(bin)JunoTimer_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),JunoTimerclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JunoTimerSvc.d

$(bin)$(binobj)JunoTimerSvc.d :

$(bin)$(binobj)JunoTimerSvc.o : $(cmt_final_setup_JunoTimer)

$(bin)$(binobj)JunoTimerSvc.o : $(src)JunoTimerSvc.cc
	$(cpp_echo) $(src)JunoTimerSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(JunoTimer_pp_cppflags) $(lib_JunoTimer_pp_cppflags) $(JunoTimerSvc_pp_cppflags) $(use_cppflags) $(JunoTimer_cppflags) $(lib_JunoTimer_cppflags) $(JunoTimerSvc_cppflags) $(JunoTimerSvc_cc_cppflags)  $(src)JunoTimerSvc.cc
endif
endif

else
$(bin)JunoTimer_dependencies.make : $(JunoTimerSvc_cc_dependencies)

$(bin)JunoTimer_dependencies.make : $(src)JunoTimerSvc.cc

$(bin)$(binobj)JunoTimerSvc.o : $(JunoTimerSvc_cc_dependencies)
	$(cpp_echo) $(src)JunoTimerSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(JunoTimer_pp_cppflags) $(lib_JunoTimer_pp_cppflags) $(JunoTimerSvc_pp_cppflags) $(use_cppflags) $(JunoTimer_cppflags) $(lib_JunoTimer_cppflags) $(JunoTimerSvc_cppflags) $(JunoTimerSvc_cc_cppflags)  $(src)JunoTimerSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),JunoTimerclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JunoTimer.d

$(bin)$(binobj)JunoTimer.d :

$(bin)$(binobj)JunoTimer.o : $(cmt_final_setup_JunoTimer)

$(bin)$(binobj)JunoTimer.o : $(src)JunoTimer.cc
	$(cpp_echo) $(src)JunoTimer.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(JunoTimer_pp_cppflags) $(lib_JunoTimer_pp_cppflags) $(JunoTimer_pp_cppflags) $(use_cppflags) $(JunoTimer_cppflags) $(lib_JunoTimer_cppflags) $(JunoTimer_cppflags) $(JunoTimer_cc_cppflags)  $(src)JunoTimer.cc
endif
endif

else
$(bin)JunoTimer_dependencies.make : $(JunoTimer_cc_dependencies)

$(bin)JunoTimer_dependencies.make : $(src)JunoTimer.cc

$(bin)$(binobj)JunoTimer.o : $(JunoTimer_cc_dependencies)
	$(cpp_echo) $(src)JunoTimer.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(JunoTimer_pp_cppflags) $(lib_JunoTimer_pp_cppflags) $(JunoTimer_pp_cppflags) $(use_cppflags) $(JunoTimer_cppflags) $(lib_JunoTimer_cppflags) $(JunoTimer_cppflags) $(JunoTimer_cc_cppflags)  $(src)JunoTimer.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),JunoTimerclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JunoTimerBinding.d

$(bin)$(binobj)JunoTimerBinding.d :

$(bin)$(binobj)JunoTimerBinding.o : $(cmt_final_setup_JunoTimer)

$(bin)$(binobj)JunoTimerBinding.o : ../binding/JunoTimerBinding.cc
	$(cpp_echo) ../binding/JunoTimerBinding.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(JunoTimer_pp_cppflags) $(lib_JunoTimer_pp_cppflags) $(JunoTimerBinding_pp_cppflags) $(use_cppflags) $(JunoTimer_cppflags) $(lib_JunoTimer_cppflags) $(JunoTimerBinding_cppflags) $(JunoTimerBinding_cc_cppflags) -I../binding ../binding/JunoTimerBinding.cc
endif
endif

else
$(bin)JunoTimer_dependencies.make : $(JunoTimerBinding_cc_dependencies)

$(bin)JunoTimer_dependencies.make : ../binding/JunoTimerBinding.cc

$(bin)$(binobj)JunoTimerBinding.o : $(JunoTimerBinding_cc_dependencies)
	$(cpp_echo) ../binding/JunoTimerBinding.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(JunoTimer_pp_cppflags) $(lib_JunoTimer_pp_cppflags) $(JunoTimerBinding_pp_cppflags) $(use_cppflags) $(JunoTimer_cppflags) $(lib_JunoTimer_cppflags) $(JunoTimerBinding_cppflags) $(JunoTimerBinding_cc_cppflags) -I../binding ../binding/JunoTimerBinding.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: JunoTimerclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(JunoTimer.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

JunoTimerclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library JunoTimer
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)JunoTimer$(library_suffix).a $(library_prefix)JunoTimer$(library_suffix).$(shlibsuffix) JunoTimer.stamp JunoTimer.shstamp
#-- end of cleanup_library ---------------

#-- start of make_header -----------------

#====================================
#  Library JobInfoSvc
#
#   Generated Fri Jul 10 19:18:16 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_JobInfoSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_JobInfoSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_JobInfoSvc

JobInfoSvc_tag = $(tag)

#cmt_local_tagfile_JobInfoSvc = $(JobInfoSvc_tag)_JobInfoSvc.make
cmt_local_tagfile_JobInfoSvc = $(bin)$(JobInfoSvc_tag)_JobInfoSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

JobInfoSvc_tag = $(tag)

#cmt_local_tagfile_JobInfoSvc = $(JobInfoSvc_tag).make
cmt_local_tagfile_JobInfoSvc = $(bin)$(JobInfoSvc_tag).make

endif

include $(cmt_local_tagfile_JobInfoSvc)
#-include $(cmt_local_tagfile_JobInfoSvc)

ifdef cmt_JobInfoSvc_has_target_tag

cmt_final_setup_JobInfoSvc = $(bin)setup_JobInfoSvc.make
cmt_dependencies_in_JobInfoSvc = $(bin)dependencies_JobInfoSvc.in
#cmt_final_setup_JobInfoSvc = $(bin)JobInfoSvc_JobInfoSvcsetup.make
cmt_local_JobInfoSvc_makefile = $(bin)JobInfoSvc.make

else

cmt_final_setup_JobInfoSvc = $(bin)setup.make
cmt_dependencies_in_JobInfoSvc = $(bin)dependencies.in
#cmt_final_setup_JobInfoSvc = $(bin)JobInfoSvcsetup.make
cmt_local_JobInfoSvc_makefile = $(bin)JobInfoSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)JobInfoSvcsetup.make

#JobInfoSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'JobInfoSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = JobInfoSvc/
#JobInfoSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

JobInfoSvclibname   = $(bin)$(library_prefix)JobInfoSvc$(library_suffix)
JobInfoSvclib       = $(JobInfoSvclibname).a
JobInfoSvcstamp     = $(bin)JobInfoSvc.stamp
JobInfoSvcshstamp   = $(bin)JobInfoSvc.shstamp

JobInfoSvc :: dirs  JobInfoSvcLIB
	$(echo) "JobInfoSvc ok"

cmt_JobInfoSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_JobInfoSvc_has_prototypes

JobInfoSvcprototype :  ;

endif

JobInfoSvccompile : $(bin)JobInfoSvc.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

JobInfoSvcLIB :: $(JobInfoSvclib) $(JobInfoSvcshstamp)
	$(echo) "JobInfoSvc : library ok"

$(JobInfoSvclib) :: $(bin)JobInfoSvc.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(JobInfoSvclib) $(bin)JobInfoSvc.o
	$(lib_silent) $(ranlib) $(JobInfoSvclib)
	$(lib_silent) cat /dev/null >$(JobInfoSvcstamp)

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

$(JobInfoSvclibname).$(shlibsuffix) :: $(JobInfoSvclib) requirements $(use_requirements) $(JobInfoSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" JobInfoSvc $(JobInfoSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(JobInfoSvcshstamp)

$(JobInfoSvcshstamp) :: $(JobInfoSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(JobInfoSvclibname).$(shlibsuffix) ; then cat /dev/null >$(JobInfoSvcshstamp) ; fi

JobInfoSvcclean ::
	$(cleanup_echo) objects JobInfoSvc
	$(cleanup_silent) /bin/rm -f $(bin)JobInfoSvc.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)JobInfoSvc.o) $(patsubst %.o,%.dep,$(bin)JobInfoSvc.o) $(patsubst %.o,%.d.stamp,$(bin)JobInfoSvc.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf JobInfoSvc_deps JobInfoSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
JobInfoSvcinstallname = $(library_prefix)JobInfoSvc$(library_suffix).$(shlibsuffix)

JobInfoSvc :: JobInfoSvcinstall ;

install :: JobInfoSvcinstall ;

JobInfoSvcinstall :: $(install_dir)/$(JobInfoSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(JobInfoSvcinstallname) :: $(bin)$(JobInfoSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(JobInfoSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##JobInfoSvcclean :: JobInfoSvcuninstall

uninstall :: JobInfoSvcuninstall ;

JobInfoSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(JobInfoSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),JobInfoSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),JobInfoSvcprototype)

$(bin)JobInfoSvc_dependencies.make : $(use_requirements) $(cmt_final_setup_JobInfoSvc)
	$(echo) "(JobInfoSvc.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)JobInfoSvc.cc -end_all $(includes) $(app_JobInfoSvc_cppflags) $(lib_JobInfoSvc_cppflags) -name=JobInfoSvc $? -f=$(cmt_dependencies_in_JobInfoSvc) -without_cmt

-include $(bin)JobInfoSvc_dependencies.make

endif
endif
endif

JobInfoSvcclean ::
	$(cleanup_silent) \rm -rf $(bin)JobInfoSvc_deps $(bin)JobInfoSvc_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),JobInfoSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JobInfoSvc.d

$(bin)$(binobj)JobInfoSvc.d :

$(bin)$(binobj)JobInfoSvc.o : $(cmt_final_setup_JobInfoSvc)

$(bin)$(binobj)JobInfoSvc.o : $(src)JobInfoSvc.cc
	$(cpp_echo) $(src)JobInfoSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(JobInfoSvc_pp_cppflags) $(lib_JobInfoSvc_pp_cppflags) $(JobInfoSvc_pp_cppflags) $(use_cppflags) $(JobInfoSvc_cppflags) $(lib_JobInfoSvc_cppflags) $(JobInfoSvc_cppflags) $(JobInfoSvc_cc_cppflags)  $(src)JobInfoSvc.cc
endif
endif

else
$(bin)JobInfoSvc_dependencies.make : $(JobInfoSvc_cc_dependencies)

$(bin)JobInfoSvc_dependencies.make : $(src)JobInfoSvc.cc

$(bin)$(binobj)JobInfoSvc.o : $(JobInfoSvc_cc_dependencies)
	$(cpp_echo) $(src)JobInfoSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(JobInfoSvc_pp_cppflags) $(lib_JobInfoSvc_pp_cppflags) $(JobInfoSvc_pp_cppflags) $(use_cppflags) $(JobInfoSvc_cppflags) $(lib_JobInfoSvc_cppflags) $(JobInfoSvc_cppflags) $(JobInfoSvc_cc_cppflags)  $(src)JobInfoSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: JobInfoSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(JobInfoSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

JobInfoSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library JobInfoSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)JobInfoSvc$(library_suffix).a $(library_prefix)JobInfoSvc$(library_suffix).$(shlibsuffix) JobInfoSvc.stamp JobInfoSvc.shstamp
#-- end of cleanup_library ---------------

#-- start of make_header -----------------

#====================================
#  Library ElecBufferMgrSvc
#
#   Generated Fri Jul 10 19:23:12 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_ElecBufferMgrSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ElecBufferMgrSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ElecBufferMgrSvc

ElecBufferMgrSvc_tag = $(tag)

#cmt_local_tagfile_ElecBufferMgrSvc = $(ElecBufferMgrSvc_tag)_ElecBufferMgrSvc.make
cmt_local_tagfile_ElecBufferMgrSvc = $(bin)$(ElecBufferMgrSvc_tag)_ElecBufferMgrSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ElecBufferMgrSvc_tag = $(tag)

#cmt_local_tagfile_ElecBufferMgrSvc = $(ElecBufferMgrSvc_tag).make
cmt_local_tagfile_ElecBufferMgrSvc = $(bin)$(ElecBufferMgrSvc_tag).make

endif

include $(cmt_local_tagfile_ElecBufferMgrSvc)
#-include $(cmt_local_tagfile_ElecBufferMgrSvc)

ifdef cmt_ElecBufferMgrSvc_has_target_tag

cmt_final_setup_ElecBufferMgrSvc = $(bin)setup_ElecBufferMgrSvc.make
cmt_dependencies_in_ElecBufferMgrSvc = $(bin)dependencies_ElecBufferMgrSvc.in
#cmt_final_setup_ElecBufferMgrSvc = $(bin)ElecBufferMgrSvc_ElecBufferMgrSvcsetup.make
cmt_local_ElecBufferMgrSvc_makefile = $(bin)ElecBufferMgrSvc.make

else

cmt_final_setup_ElecBufferMgrSvc = $(bin)setup.make
cmt_dependencies_in_ElecBufferMgrSvc = $(bin)dependencies.in
#cmt_final_setup_ElecBufferMgrSvc = $(bin)ElecBufferMgrSvcsetup.make
cmt_local_ElecBufferMgrSvc_makefile = $(bin)ElecBufferMgrSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ElecBufferMgrSvcsetup.make

#ElecBufferMgrSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ElecBufferMgrSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ElecBufferMgrSvc/
#ElecBufferMgrSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

ElecBufferMgrSvclibname   = $(bin)$(library_prefix)ElecBufferMgrSvc$(library_suffix)
ElecBufferMgrSvclib       = $(ElecBufferMgrSvclibname).a
ElecBufferMgrSvcstamp     = $(bin)ElecBufferMgrSvc.stamp
ElecBufferMgrSvcshstamp   = $(bin)ElecBufferMgrSvc.shstamp

ElecBufferMgrSvc :: dirs  ElecBufferMgrSvcLIB
	$(echo) "ElecBufferMgrSvc ok"

cmt_ElecBufferMgrSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_ElecBufferMgrSvc_has_prototypes

ElecBufferMgrSvcprototype :  ;

endif

ElecBufferMgrSvccompile : $(bin)IElecBufferMgrSvc.o $(bin)ElecBufferMgrSvc.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

ElecBufferMgrSvcLIB :: $(ElecBufferMgrSvclib) $(ElecBufferMgrSvcshstamp)
	$(echo) "ElecBufferMgrSvc : library ok"

$(ElecBufferMgrSvclib) :: $(bin)IElecBufferMgrSvc.o $(bin)ElecBufferMgrSvc.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(ElecBufferMgrSvclib) $(bin)IElecBufferMgrSvc.o $(bin)ElecBufferMgrSvc.o
	$(lib_silent) $(ranlib) $(ElecBufferMgrSvclib)
	$(lib_silent) cat /dev/null >$(ElecBufferMgrSvcstamp)

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

$(ElecBufferMgrSvclibname).$(shlibsuffix) :: $(ElecBufferMgrSvclib) requirements $(use_requirements) $(ElecBufferMgrSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" ElecBufferMgrSvc $(ElecBufferMgrSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(ElecBufferMgrSvcshstamp)

$(ElecBufferMgrSvcshstamp) :: $(ElecBufferMgrSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(ElecBufferMgrSvclibname).$(shlibsuffix) ; then cat /dev/null >$(ElecBufferMgrSvcshstamp) ; fi

ElecBufferMgrSvcclean ::
	$(cleanup_echo) objects ElecBufferMgrSvc
	$(cleanup_silent) /bin/rm -f $(bin)IElecBufferMgrSvc.o $(bin)ElecBufferMgrSvc.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)IElecBufferMgrSvc.o $(bin)ElecBufferMgrSvc.o) $(patsubst %.o,%.dep,$(bin)IElecBufferMgrSvc.o $(bin)ElecBufferMgrSvc.o) $(patsubst %.o,%.d.stamp,$(bin)IElecBufferMgrSvc.o $(bin)ElecBufferMgrSvc.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf ElecBufferMgrSvc_deps ElecBufferMgrSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
ElecBufferMgrSvcinstallname = $(library_prefix)ElecBufferMgrSvc$(library_suffix).$(shlibsuffix)

ElecBufferMgrSvc :: ElecBufferMgrSvcinstall ;

install :: ElecBufferMgrSvcinstall ;

ElecBufferMgrSvcinstall :: $(install_dir)/$(ElecBufferMgrSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(ElecBufferMgrSvcinstallname) :: $(bin)$(ElecBufferMgrSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(ElecBufferMgrSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##ElecBufferMgrSvcclean :: ElecBufferMgrSvcuninstall

uninstall :: ElecBufferMgrSvcuninstall ;

ElecBufferMgrSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(ElecBufferMgrSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),ElecBufferMgrSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),ElecBufferMgrSvcprototype)

$(bin)ElecBufferMgrSvc_dependencies.make : $(use_requirements) $(cmt_final_setup_ElecBufferMgrSvc)
	$(echo) "(ElecBufferMgrSvc.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)IElecBufferMgrSvc.cc $(src)ElecBufferMgrSvc.cc -end_all $(includes) $(app_ElecBufferMgrSvc_cppflags) $(lib_ElecBufferMgrSvc_cppflags) -name=ElecBufferMgrSvc $? -f=$(cmt_dependencies_in_ElecBufferMgrSvc) -without_cmt

-include $(bin)ElecBufferMgrSvc_dependencies.make

endif
endif
endif

ElecBufferMgrSvcclean ::
	$(cleanup_silent) \rm -rf $(bin)ElecBufferMgrSvc_deps $(bin)ElecBufferMgrSvc_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecBufferMgrSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IElecBufferMgrSvc.d

$(bin)$(binobj)IElecBufferMgrSvc.d :

$(bin)$(binobj)IElecBufferMgrSvc.o : $(cmt_final_setup_ElecBufferMgrSvc)

$(bin)$(binobj)IElecBufferMgrSvc.o : $(src)IElecBufferMgrSvc.cc
	$(cpp_echo) $(src)IElecBufferMgrSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecBufferMgrSvc_pp_cppflags) $(lib_ElecBufferMgrSvc_pp_cppflags) $(IElecBufferMgrSvc_pp_cppflags) $(use_cppflags) $(ElecBufferMgrSvc_cppflags) $(lib_ElecBufferMgrSvc_cppflags) $(IElecBufferMgrSvc_cppflags) $(IElecBufferMgrSvc_cc_cppflags)  $(src)IElecBufferMgrSvc.cc
endif
endif

else
$(bin)ElecBufferMgrSvc_dependencies.make : $(IElecBufferMgrSvc_cc_dependencies)

$(bin)ElecBufferMgrSvc_dependencies.make : $(src)IElecBufferMgrSvc.cc

$(bin)$(binobj)IElecBufferMgrSvc.o : $(IElecBufferMgrSvc_cc_dependencies)
	$(cpp_echo) $(src)IElecBufferMgrSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecBufferMgrSvc_pp_cppflags) $(lib_ElecBufferMgrSvc_pp_cppflags) $(IElecBufferMgrSvc_pp_cppflags) $(use_cppflags) $(ElecBufferMgrSvc_cppflags) $(lib_ElecBufferMgrSvc_cppflags) $(IElecBufferMgrSvc_cppflags) $(IElecBufferMgrSvc_cc_cppflags)  $(src)IElecBufferMgrSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ElecBufferMgrSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ElecBufferMgrSvc.d

$(bin)$(binobj)ElecBufferMgrSvc.d :

$(bin)$(binobj)ElecBufferMgrSvc.o : $(cmt_final_setup_ElecBufferMgrSvc)

$(bin)$(binobj)ElecBufferMgrSvc.o : $(src)ElecBufferMgrSvc.cc
	$(cpp_echo) $(src)ElecBufferMgrSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ElecBufferMgrSvc_pp_cppflags) $(lib_ElecBufferMgrSvc_pp_cppflags) $(ElecBufferMgrSvc_pp_cppflags) $(use_cppflags) $(ElecBufferMgrSvc_cppflags) $(lib_ElecBufferMgrSvc_cppflags) $(ElecBufferMgrSvc_cppflags) $(ElecBufferMgrSvc_cc_cppflags)  $(src)ElecBufferMgrSvc.cc
endif
endif

else
$(bin)ElecBufferMgrSvc_dependencies.make : $(ElecBufferMgrSvc_cc_dependencies)

$(bin)ElecBufferMgrSvc_dependencies.make : $(src)ElecBufferMgrSvc.cc

$(bin)$(binobj)ElecBufferMgrSvc.o : $(ElecBufferMgrSvc_cc_dependencies)
	$(cpp_echo) $(src)ElecBufferMgrSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ElecBufferMgrSvc_pp_cppflags) $(lib_ElecBufferMgrSvc_pp_cppflags) $(ElecBufferMgrSvc_pp_cppflags) $(use_cppflags) $(ElecBufferMgrSvc_cppflags) $(lib_ElecBufferMgrSvc_cppflags) $(ElecBufferMgrSvc_cppflags) $(ElecBufferMgrSvc_cc_cppflags)  $(src)ElecBufferMgrSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: ElecBufferMgrSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ElecBufferMgrSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ElecBufferMgrSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library ElecBufferMgrSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)ElecBufferMgrSvc$(library_suffix).a $(library_prefix)ElecBufferMgrSvc$(library_suffix).$(shlibsuffix) ElecBufferMgrSvc.stamp ElecBufferMgrSvc.shstamp
#-- end of cleanup_library ---------------

#-- start of make_header -----------------

#====================================
#  Library RootRandomSvc
#
#   Generated Fri Jul 10 19:15:18 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootRandomSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootRandomSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootRandomSvc

RootRandomSvc_tag = $(tag)

#cmt_local_tagfile_RootRandomSvc = $(RootRandomSvc_tag)_RootRandomSvc.make
cmt_local_tagfile_RootRandomSvc = $(bin)$(RootRandomSvc_tag)_RootRandomSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootRandomSvc_tag = $(tag)

#cmt_local_tagfile_RootRandomSvc = $(RootRandomSvc_tag).make
cmt_local_tagfile_RootRandomSvc = $(bin)$(RootRandomSvc_tag).make

endif

include $(cmt_local_tagfile_RootRandomSvc)
#-include $(cmt_local_tagfile_RootRandomSvc)

ifdef cmt_RootRandomSvc_has_target_tag

cmt_final_setup_RootRandomSvc = $(bin)setup_RootRandomSvc.make
cmt_dependencies_in_RootRandomSvc = $(bin)dependencies_RootRandomSvc.in
#cmt_final_setup_RootRandomSvc = $(bin)RootRandomSvc_RootRandomSvcsetup.make
cmt_local_RootRandomSvc_makefile = $(bin)RootRandomSvc.make

else

cmt_final_setup_RootRandomSvc = $(bin)setup.make
cmt_dependencies_in_RootRandomSvc = $(bin)dependencies.in
#cmt_final_setup_RootRandomSvc = $(bin)RootRandomSvcsetup.make
cmt_local_RootRandomSvc_makefile = $(bin)RootRandomSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootRandomSvcsetup.make

#RootRandomSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootRandomSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootRandomSvc/
#RootRandomSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RootRandomSvclibname   = $(bin)$(library_prefix)RootRandomSvc$(library_suffix)
RootRandomSvclib       = $(RootRandomSvclibname).a
RootRandomSvcstamp     = $(bin)RootRandomSvc.stamp
RootRandomSvcshstamp   = $(bin)RootRandomSvc.shstamp

RootRandomSvc :: dirs  RootRandomSvcLIB
	$(echo) "RootRandomSvc ok"

cmt_RootRandomSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_RootRandomSvc_has_prototypes

RootRandomSvcprototype :  ;

endif

RootRandomSvccompile : $(bin)RootRandomSvc.o $(bin)IRootRandomSvc.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

RootRandomSvcLIB :: $(RootRandomSvclib) $(RootRandomSvcshstamp)
	$(echo) "RootRandomSvc : library ok"

$(RootRandomSvclib) :: $(bin)RootRandomSvc.o $(bin)IRootRandomSvc.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(RootRandomSvclib) $(bin)RootRandomSvc.o $(bin)IRootRandomSvc.o
	$(lib_silent) $(ranlib) $(RootRandomSvclib)
	$(lib_silent) cat /dev/null >$(RootRandomSvcstamp)

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

$(RootRandomSvclibname).$(shlibsuffix) :: $(RootRandomSvclib) requirements $(use_requirements) $(RootRandomSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" RootRandomSvc $(RootRandomSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(RootRandomSvcshstamp)

$(RootRandomSvcshstamp) :: $(RootRandomSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RootRandomSvclibname).$(shlibsuffix) ; then cat /dev/null >$(RootRandomSvcshstamp) ; fi

RootRandomSvcclean ::
	$(cleanup_echo) objects RootRandomSvc
	$(cleanup_silent) /bin/rm -f $(bin)RootRandomSvc.o $(bin)IRootRandomSvc.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)RootRandomSvc.o $(bin)IRootRandomSvc.o) $(patsubst %.o,%.dep,$(bin)RootRandomSvc.o $(bin)IRootRandomSvc.o) $(patsubst %.o,%.d.stamp,$(bin)RootRandomSvc.o $(bin)IRootRandomSvc.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RootRandomSvc_deps RootRandomSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RootRandomSvcinstallname = $(library_prefix)RootRandomSvc$(library_suffix).$(shlibsuffix)

RootRandomSvc :: RootRandomSvcinstall ;

install :: RootRandomSvcinstall ;

RootRandomSvcinstall :: $(install_dir)/$(RootRandomSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RootRandomSvcinstallname) :: $(bin)$(RootRandomSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootRandomSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RootRandomSvcclean :: RootRandomSvcuninstall

uninstall :: RootRandomSvcuninstall ;

RootRandomSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootRandomSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),RootRandomSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),RootRandomSvcprototype)

$(bin)RootRandomSvc_dependencies.make : $(use_requirements) $(cmt_final_setup_RootRandomSvc)
	$(echo) "(RootRandomSvc.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)RootRandomSvc.cc $(src)IRootRandomSvc.cc -end_all $(includes) $(app_RootRandomSvc_cppflags) $(lib_RootRandomSvc_cppflags) -name=RootRandomSvc $? -f=$(cmt_dependencies_in_RootRandomSvc) -without_cmt

-include $(bin)RootRandomSvc_dependencies.make

endif
endif
endif

RootRandomSvcclean ::
	$(cleanup_silent) \rm -rf $(bin)RootRandomSvc_deps $(bin)RootRandomSvc_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootRandomSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootRandomSvc.d

$(bin)$(binobj)RootRandomSvc.d :

$(bin)$(binobj)RootRandomSvc.o : $(cmt_final_setup_RootRandomSvc)

$(bin)$(binobj)RootRandomSvc.o : $(src)RootRandomSvc.cc
	$(cpp_echo) $(src)RootRandomSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootRandomSvc_pp_cppflags) $(lib_RootRandomSvc_pp_cppflags) $(RootRandomSvc_pp_cppflags) $(use_cppflags) $(RootRandomSvc_cppflags) $(lib_RootRandomSvc_cppflags) $(RootRandomSvc_cppflags) $(RootRandomSvc_cc_cppflags)  $(src)RootRandomSvc.cc
endif
endif

else
$(bin)RootRandomSvc_dependencies.make : $(RootRandomSvc_cc_dependencies)

$(bin)RootRandomSvc_dependencies.make : $(src)RootRandomSvc.cc

$(bin)$(binobj)RootRandomSvc.o : $(RootRandomSvc_cc_dependencies)
	$(cpp_echo) $(src)RootRandomSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootRandomSvc_pp_cppflags) $(lib_RootRandomSvc_pp_cppflags) $(RootRandomSvc_pp_cppflags) $(use_cppflags) $(RootRandomSvc_cppflags) $(lib_RootRandomSvc_cppflags) $(RootRandomSvc_cppflags) $(RootRandomSvc_cc_cppflags)  $(src)RootRandomSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootRandomSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IRootRandomSvc.d

$(bin)$(binobj)IRootRandomSvc.d :

$(bin)$(binobj)IRootRandomSvc.o : $(cmt_final_setup_RootRandomSvc)

$(bin)$(binobj)IRootRandomSvc.o : $(src)IRootRandomSvc.cc
	$(cpp_echo) $(src)IRootRandomSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootRandomSvc_pp_cppflags) $(lib_RootRandomSvc_pp_cppflags) $(IRootRandomSvc_pp_cppflags) $(use_cppflags) $(RootRandomSvc_cppflags) $(lib_RootRandomSvc_cppflags) $(IRootRandomSvc_cppflags) $(IRootRandomSvc_cc_cppflags)  $(src)IRootRandomSvc.cc
endif
endif

else
$(bin)RootRandomSvc_dependencies.make : $(IRootRandomSvc_cc_dependencies)

$(bin)RootRandomSvc_dependencies.make : $(src)IRootRandomSvc.cc

$(bin)$(binobj)IRootRandomSvc.o : $(IRootRandomSvc_cc_dependencies)
	$(cpp_echo) $(src)IRootRandomSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootRandomSvc_pp_cppflags) $(lib_RootRandomSvc_pp_cppflags) $(IRootRandomSvc_pp_cppflags) $(use_cppflags) $(RootRandomSvc_cppflags) $(lib_RootRandomSvc_cppflags) $(IRootRandomSvc_cppflags) $(IRootRandomSvc_cc_cppflags)  $(src)IRootRandomSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RootRandomSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootRandomSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootRandomSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RootRandomSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RootRandomSvc$(library_suffix).a $(library_prefix)RootRandomSvc$(library_suffix).$(shlibsuffix) RootRandomSvc.stamp RootRandomSvc.shstamp
#-- end of cleanup_library ---------------

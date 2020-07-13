#-- start of make_header -----------------

#====================================
#  Library GlobalTimeSvc
#
#   Generated Fri Jul 10 19:15:14 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GlobalTimeSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GlobalTimeSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GlobalTimeSvc

GlobalTimeSvc_tag = $(tag)

#cmt_local_tagfile_GlobalTimeSvc = $(GlobalTimeSvc_tag)_GlobalTimeSvc.make
cmt_local_tagfile_GlobalTimeSvc = $(bin)$(GlobalTimeSvc_tag)_GlobalTimeSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GlobalTimeSvc_tag = $(tag)

#cmt_local_tagfile_GlobalTimeSvc = $(GlobalTimeSvc_tag).make
cmt_local_tagfile_GlobalTimeSvc = $(bin)$(GlobalTimeSvc_tag).make

endif

include $(cmt_local_tagfile_GlobalTimeSvc)
#-include $(cmt_local_tagfile_GlobalTimeSvc)

ifdef cmt_GlobalTimeSvc_has_target_tag

cmt_final_setup_GlobalTimeSvc = $(bin)setup_GlobalTimeSvc.make
cmt_dependencies_in_GlobalTimeSvc = $(bin)dependencies_GlobalTimeSvc.in
#cmt_final_setup_GlobalTimeSvc = $(bin)GlobalTimeSvc_GlobalTimeSvcsetup.make
cmt_local_GlobalTimeSvc_makefile = $(bin)GlobalTimeSvc.make

else

cmt_final_setup_GlobalTimeSvc = $(bin)setup.make
cmt_dependencies_in_GlobalTimeSvc = $(bin)dependencies.in
#cmt_final_setup_GlobalTimeSvc = $(bin)GlobalTimeSvcsetup.make
cmt_local_GlobalTimeSvc_makefile = $(bin)GlobalTimeSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GlobalTimeSvcsetup.make

#GlobalTimeSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GlobalTimeSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GlobalTimeSvc/
#GlobalTimeSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GlobalTimeSvclibname   = $(bin)$(library_prefix)GlobalTimeSvc$(library_suffix)
GlobalTimeSvclib       = $(GlobalTimeSvclibname).a
GlobalTimeSvcstamp     = $(bin)GlobalTimeSvc.stamp
GlobalTimeSvcshstamp   = $(bin)GlobalTimeSvc.shstamp

GlobalTimeSvc :: dirs  GlobalTimeSvcLIB
	$(echo) "GlobalTimeSvc ok"

cmt_GlobalTimeSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_GlobalTimeSvc_has_prototypes

GlobalTimeSvcprototype :  ;

endif

GlobalTimeSvccompile : $(bin)IGlobalTimeSvc.o $(bin)GlobalTimeSvc.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

GlobalTimeSvcLIB :: $(GlobalTimeSvclib) $(GlobalTimeSvcshstamp)
	$(echo) "GlobalTimeSvc : library ok"

$(GlobalTimeSvclib) :: $(bin)IGlobalTimeSvc.o $(bin)GlobalTimeSvc.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(GlobalTimeSvclib) $(bin)IGlobalTimeSvc.o $(bin)GlobalTimeSvc.o
	$(lib_silent) $(ranlib) $(GlobalTimeSvclib)
	$(lib_silent) cat /dev/null >$(GlobalTimeSvcstamp)

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

$(GlobalTimeSvclibname).$(shlibsuffix) :: $(GlobalTimeSvclib) requirements $(use_requirements) $(GlobalTimeSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" GlobalTimeSvc $(GlobalTimeSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(GlobalTimeSvcshstamp)

$(GlobalTimeSvcshstamp) :: $(GlobalTimeSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GlobalTimeSvclibname).$(shlibsuffix) ; then cat /dev/null >$(GlobalTimeSvcshstamp) ; fi

GlobalTimeSvcclean ::
	$(cleanup_echo) objects GlobalTimeSvc
	$(cleanup_silent) /bin/rm -f $(bin)IGlobalTimeSvc.o $(bin)GlobalTimeSvc.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)IGlobalTimeSvc.o $(bin)GlobalTimeSvc.o) $(patsubst %.o,%.dep,$(bin)IGlobalTimeSvc.o $(bin)GlobalTimeSvc.o) $(patsubst %.o,%.d.stamp,$(bin)IGlobalTimeSvc.o $(bin)GlobalTimeSvc.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GlobalTimeSvc_deps GlobalTimeSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GlobalTimeSvcinstallname = $(library_prefix)GlobalTimeSvc$(library_suffix).$(shlibsuffix)

GlobalTimeSvc :: GlobalTimeSvcinstall ;

install :: GlobalTimeSvcinstall ;

GlobalTimeSvcinstall :: $(install_dir)/$(GlobalTimeSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GlobalTimeSvcinstallname) :: $(bin)$(GlobalTimeSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GlobalTimeSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GlobalTimeSvcclean :: GlobalTimeSvcuninstall

uninstall :: GlobalTimeSvcuninstall ;

GlobalTimeSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GlobalTimeSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),GlobalTimeSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),GlobalTimeSvcprototype)

$(bin)GlobalTimeSvc_dependencies.make : $(use_requirements) $(cmt_final_setup_GlobalTimeSvc)
	$(echo) "(GlobalTimeSvc.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)IGlobalTimeSvc.cc $(src)GlobalTimeSvc.cc -end_all $(includes) $(app_GlobalTimeSvc_cppflags) $(lib_GlobalTimeSvc_cppflags) -name=GlobalTimeSvc $? -f=$(cmt_dependencies_in_GlobalTimeSvc) -without_cmt

-include $(bin)GlobalTimeSvc_dependencies.make

endif
endif
endif

GlobalTimeSvcclean ::
	$(cleanup_silent) \rm -rf $(bin)GlobalTimeSvc_deps $(bin)GlobalTimeSvc_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GlobalTimeSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IGlobalTimeSvc.d

$(bin)$(binobj)IGlobalTimeSvc.d :

$(bin)$(binobj)IGlobalTimeSvc.o : $(cmt_final_setup_GlobalTimeSvc)

$(bin)$(binobj)IGlobalTimeSvc.o : $(src)IGlobalTimeSvc.cc
	$(cpp_echo) $(src)IGlobalTimeSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GlobalTimeSvc_pp_cppflags) $(lib_GlobalTimeSvc_pp_cppflags) $(IGlobalTimeSvc_pp_cppflags) $(use_cppflags) $(GlobalTimeSvc_cppflags) $(lib_GlobalTimeSvc_cppflags) $(IGlobalTimeSvc_cppflags) $(IGlobalTimeSvc_cc_cppflags)  $(src)IGlobalTimeSvc.cc
endif
endif

else
$(bin)GlobalTimeSvc_dependencies.make : $(IGlobalTimeSvc_cc_dependencies)

$(bin)GlobalTimeSvc_dependencies.make : $(src)IGlobalTimeSvc.cc

$(bin)$(binobj)IGlobalTimeSvc.o : $(IGlobalTimeSvc_cc_dependencies)
	$(cpp_echo) $(src)IGlobalTimeSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GlobalTimeSvc_pp_cppflags) $(lib_GlobalTimeSvc_pp_cppflags) $(IGlobalTimeSvc_pp_cppflags) $(use_cppflags) $(GlobalTimeSvc_cppflags) $(lib_GlobalTimeSvc_cppflags) $(IGlobalTimeSvc_cppflags) $(IGlobalTimeSvc_cc_cppflags)  $(src)IGlobalTimeSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GlobalTimeSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GlobalTimeSvc.d

$(bin)$(binobj)GlobalTimeSvc.d :

$(bin)$(binobj)GlobalTimeSvc.o : $(cmt_final_setup_GlobalTimeSvc)

$(bin)$(binobj)GlobalTimeSvc.o : $(src)GlobalTimeSvc.cc
	$(cpp_echo) $(src)GlobalTimeSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GlobalTimeSvc_pp_cppflags) $(lib_GlobalTimeSvc_pp_cppflags) $(GlobalTimeSvc_pp_cppflags) $(use_cppflags) $(GlobalTimeSvc_cppflags) $(lib_GlobalTimeSvc_cppflags) $(GlobalTimeSvc_cppflags) $(GlobalTimeSvc_cc_cppflags)  $(src)GlobalTimeSvc.cc
endif
endif

else
$(bin)GlobalTimeSvc_dependencies.make : $(GlobalTimeSvc_cc_dependencies)

$(bin)GlobalTimeSvc_dependencies.make : $(src)GlobalTimeSvc.cc

$(bin)$(binobj)GlobalTimeSvc.o : $(GlobalTimeSvc_cc_dependencies)
	$(cpp_echo) $(src)GlobalTimeSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GlobalTimeSvc_pp_cppflags) $(lib_GlobalTimeSvc_pp_cppflags) $(GlobalTimeSvc_pp_cppflags) $(use_cppflags) $(GlobalTimeSvc_cppflags) $(lib_GlobalTimeSvc_cppflags) $(GlobalTimeSvc_cppflags) $(GlobalTimeSvc_cc_cppflags)  $(src)GlobalTimeSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GlobalTimeSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GlobalTimeSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GlobalTimeSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GlobalTimeSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GlobalTimeSvc$(library_suffix).a $(library_prefix)GlobalTimeSvc$(library_suffix).$(shlibsuffix) GlobalTimeSvc.stamp GlobalTimeSvc.shstamp
#-- end of cleanup_library ---------------

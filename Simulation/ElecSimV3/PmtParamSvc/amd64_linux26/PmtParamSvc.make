#-- start of make_header -----------------

#====================================
#  Library PmtParamSvc
#
#   Generated Fri Jul 10 19:15:10 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PmtParamSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PmtParamSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PmtParamSvc

PmtParamSvc_tag = $(tag)

#cmt_local_tagfile_PmtParamSvc = $(PmtParamSvc_tag)_PmtParamSvc.make
cmt_local_tagfile_PmtParamSvc = $(bin)$(PmtParamSvc_tag)_PmtParamSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PmtParamSvc_tag = $(tag)

#cmt_local_tagfile_PmtParamSvc = $(PmtParamSvc_tag).make
cmt_local_tagfile_PmtParamSvc = $(bin)$(PmtParamSvc_tag).make

endif

include $(cmt_local_tagfile_PmtParamSvc)
#-include $(cmt_local_tagfile_PmtParamSvc)

ifdef cmt_PmtParamSvc_has_target_tag

cmt_final_setup_PmtParamSvc = $(bin)setup_PmtParamSvc.make
cmt_dependencies_in_PmtParamSvc = $(bin)dependencies_PmtParamSvc.in
#cmt_final_setup_PmtParamSvc = $(bin)PmtParamSvc_PmtParamSvcsetup.make
cmt_local_PmtParamSvc_makefile = $(bin)PmtParamSvc.make

else

cmt_final_setup_PmtParamSvc = $(bin)setup.make
cmt_dependencies_in_PmtParamSvc = $(bin)dependencies.in
#cmt_final_setup_PmtParamSvc = $(bin)PmtParamSvcsetup.make
cmt_local_PmtParamSvc_makefile = $(bin)PmtParamSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PmtParamSvcsetup.make

#PmtParamSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PmtParamSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PmtParamSvc/
#PmtParamSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

PmtParamSvclibname   = $(bin)$(library_prefix)PmtParamSvc$(library_suffix)
PmtParamSvclib       = $(PmtParamSvclibname).a
PmtParamSvcstamp     = $(bin)PmtParamSvc.stamp
PmtParamSvcshstamp   = $(bin)PmtParamSvc.shstamp

PmtParamSvc :: dirs  PmtParamSvcLIB
	$(echo) "PmtParamSvc ok"

cmt_PmtParamSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_PmtParamSvc_has_prototypes

PmtParamSvcprototype :  ;

endif

PmtParamSvccompile : $(bin)PmtParamSvc.o $(bin)IPmtParamSvc.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

PmtParamSvcLIB :: $(PmtParamSvclib) $(PmtParamSvcshstamp)
	$(echo) "PmtParamSvc : library ok"

$(PmtParamSvclib) :: $(bin)PmtParamSvc.o $(bin)IPmtParamSvc.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(PmtParamSvclib) $(bin)PmtParamSvc.o $(bin)IPmtParamSvc.o
	$(lib_silent) $(ranlib) $(PmtParamSvclib)
	$(lib_silent) cat /dev/null >$(PmtParamSvcstamp)

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

$(PmtParamSvclibname).$(shlibsuffix) :: $(PmtParamSvclib) requirements $(use_requirements) $(PmtParamSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" PmtParamSvc $(PmtParamSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(PmtParamSvcshstamp)

$(PmtParamSvcshstamp) :: $(PmtParamSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(PmtParamSvclibname).$(shlibsuffix) ; then cat /dev/null >$(PmtParamSvcshstamp) ; fi

PmtParamSvcclean ::
	$(cleanup_echo) objects PmtParamSvc
	$(cleanup_silent) /bin/rm -f $(bin)PmtParamSvc.o $(bin)IPmtParamSvc.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PmtParamSvc.o $(bin)IPmtParamSvc.o) $(patsubst %.o,%.dep,$(bin)PmtParamSvc.o $(bin)IPmtParamSvc.o) $(patsubst %.o,%.d.stamp,$(bin)PmtParamSvc.o $(bin)IPmtParamSvc.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf PmtParamSvc_deps PmtParamSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
PmtParamSvcinstallname = $(library_prefix)PmtParamSvc$(library_suffix).$(shlibsuffix)

PmtParamSvc :: PmtParamSvcinstall ;

install :: PmtParamSvcinstall ;

PmtParamSvcinstall :: $(install_dir)/$(PmtParamSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(PmtParamSvcinstallname) :: $(bin)$(PmtParamSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PmtParamSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##PmtParamSvcclean :: PmtParamSvcuninstall

uninstall :: PmtParamSvcuninstall ;

PmtParamSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PmtParamSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),PmtParamSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),PmtParamSvcprototype)

$(bin)PmtParamSvc_dependencies.make : $(use_requirements) $(cmt_final_setup_PmtParamSvc)
	$(echo) "(PmtParamSvc.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)PmtParamSvc.cc $(src)IPmtParamSvc.cc -end_all $(includes) $(app_PmtParamSvc_cppflags) $(lib_PmtParamSvc_cppflags) -name=PmtParamSvc $? -f=$(cmt_dependencies_in_PmtParamSvc) -without_cmt

-include $(bin)PmtParamSvc_dependencies.make

endif
endif
endif

PmtParamSvcclean ::
	$(cleanup_silent) \rm -rf $(bin)PmtParamSvc_deps $(bin)PmtParamSvc_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PmtParamSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PmtParamSvc.d

$(bin)$(binobj)PmtParamSvc.d :

$(bin)$(binobj)PmtParamSvc.o : $(cmt_final_setup_PmtParamSvc)

$(bin)$(binobj)PmtParamSvc.o : $(src)PmtParamSvc.cc
	$(cpp_echo) $(src)PmtParamSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PmtParamSvc_pp_cppflags) $(lib_PmtParamSvc_pp_cppflags) $(PmtParamSvc_pp_cppflags) $(use_cppflags) $(PmtParamSvc_cppflags) $(lib_PmtParamSvc_cppflags) $(PmtParamSvc_cppflags) $(PmtParamSvc_cc_cppflags)  $(src)PmtParamSvc.cc
endif
endif

else
$(bin)PmtParamSvc_dependencies.make : $(PmtParamSvc_cc_dependencies)

$(bin)PmtParamSvc_dependencies.make : $(src)PmtParamSvc.cc

$(bin)$(binobj)PmtParamSvc.o : $(PmtParamSvc_cc_dependencies)
	$(cpp_echo) $(src)PmtParamSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PmtParamSvc_pp_cppflags) $(lib_PmtParamSvc_pp_cppflags) $(PmtParamSvc_pp_cppflags) $(use_cppflags) $(PmtParamSvc_cppflags) $(lib_PmtParamSvc_cppflags) $(PmtParamSvc_cppflags) $(PmtParamSvc_cc_cppflags)  $(src)PmtParamSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PmtParamSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IPmtParamSvc.d

$(bin)$(binobj)IPmtParamSvc.d :

$(bin)$(binobj)IPmtParamSvc.o : $(cmt_final_setup_PmtParamSvc)

$(bin)$(binobj)IPmtParamSvc.o : $(src)IPmtParamSvc.cc
	$(cpp_echo) $(src)IPmtParamSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PmtParamSvc_pp_cppflags) $(lib_PmtParamSvc_pp_cppflags) $(IPmtParamSvc_pp_cppflags) $(use_cppflags) $(PmtParamSvc_cppflags) $(lib_PmtParamSvc_cppflags) $(IPmtParamSvc_cppflags) $(IPmtParamSvc_cc_cppflags)  $(src)IPmtParamSvc.cc
endif
endif

else
$(bin)PmtParamSvc_dependencies.make : $(IPmtParamSvc_cc_dependencies)

$(bin)PmtParamSvc_dependencies.make : $(src)IPmtParamSvc.cc

$(bin)$(binobj)IPmtParamSvc.o : $(IPmtParamSvc_cc_dependencies)
	$(cpp_echo) $(src)IPmtParamSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PmtParamSvc_pp_cppflags) $(lib_PmtParamSvc_pp_cppflags) $(IPmtParamSvc_pp_cppflags) $(use_cppflags) $(PmtParamSvc_cppflags) $(lib_PmtParamSvc_cppflags) $(IPmtParamSvc_cppflags) $(IPmtParamSvc_cc_cppflags)  $(src)IPmtParamSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: PmtParamSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PmtParamSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PmtParamSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library PmtParamSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)PmtParamSvc$(library_suffix).a $(library_prefix)PmtParamSvc$(library_suffix).$(shlibsuffix) PmtParamSvc.stamp PmtParamSvc.shstamp
#-- end of cleanup_library ---------------

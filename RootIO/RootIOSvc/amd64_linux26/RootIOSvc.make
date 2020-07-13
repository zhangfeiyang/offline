#-- start of make_header -----------------

#====================================
#  Library RootIOSvc
#
#   Generated Fri Jul 10 19:18:05 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootIOSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootIOSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootIOSvc

RootIOSvc_tag = $(tag)

#cmt_local_tagfile_RootIOSvc = $(RootIOSvc_tag)_RootIOSvc.make
cmt_local_tagfile_RootIOSvc = $(bin)$(RootIOSvc_tag)_RootIOSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootIOSvc_tag = $(tag)

#cmt_local_tagfile_RootIOSvc = $(RootIOSvc_tag).make
cmt_local_tagfile_RootIOSvc = $(bin)$(RootIOSvc_tag).make

endif

include $(cmt_local_tagfile_RootIOSvc)
#-include $(cmt_local_tagfile_RootIOSvc)

ifdef cmt_RootIOSvc_has_target_tag

cmt_final_setup_RootIOSvc = $(bin)setup_RootIOSvc.make
cmt_dependencies_in_RootIOSvc = $(bin)dependencies_RootIOSvc.in
#cmt_final_setup_RootIOSvc = $(bin)RootIOSvc_RootIOSvcsetup.make
cmt_local_RootIOSvc_makefile = $(bin)RootIOSvc.make

else

cmt_final_setup_RootIOSvc = $(bin)setup.make
cmt_dependencies_in_RootIOSvc = $(bin)dependencies.in
#cmt_final_setup_RootIOSvc = $(bin)RootIOSvcsetup.make
cmt_local_RootIOSvc_makefile = $(bin)RootIOSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootIOSvcsetup.make

#RootIOSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootIOSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootIOSvc/
#RootIOSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RootIOSvclibname   = $(bin)$(library_prefix)RootIOSvc$(library_suffix)
RootIOSvclib       = $(RootIOSvclibname).a
RootIOSvcstamp     = $(bin)RootIOSvc.stamp
RootIOSvcshstamp   = $(bin)RootIOSvc.shstamp

RootIOSvc :: dirs  RootIOSvcLIB
	$(echo) "RootIOSvc ok"

cmt_RootIOSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_RootIOSvc_has_prototypes

RootIOSvcprototype :  ;

endif

RootIOSvccompile : $(bin)RootOutputSvc.o $(bin)RootOutputStream.o $(bin)NavInputStream.o $(bin)RootInputSvc.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

RootIOSvcLIB :: $(RootIOSvclib) $(RootIOSvcshstamp)
	$(echo) "RootIOSvc : library ok"

$(RootIOSvclib) :: $(bin)RootOutputSvc.o $(bin)RootOutputStream.o $(bin)NavInputStream.o $(bin)RootInputSvc.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(RootIOSvclib) $(bin)RootOutputSvc.o $(bin)RootOutputStream.o $(bin)NavInputStream.o $(bin)RootInputSvc.o
	$(lib_silent) $(ranlib) $(RootIOSvclib)
	$(lib_silent) cat /dev/null >$(RootIOSvcstamp)

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

$(RootIOSvclibname).$(shlibsuffix) :: $(RootIOSvclib) requirements $(use_requirements) $(RootIOSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" RootIOSvc $(RootIOSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(RootIOSvcshstamp)

$(RootIOSvcshstamp) :: $(RootIOSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RootIOSvclibname).$(shlibsuffix) ; then cat /dev/null >$(RootIOSvcshstamp) ; fi

RootIOSvcclean ::
	$(cleanup_echo) objects RootIOSvc
	$(cleanup_silent) /bin/rm -f $(bin)RootOutputSvc.o $(bin)RootOutputStream.o $(bin)NavInputStream.o $(bin)RootInputSvc.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)RootOutputSvc.o $(bin)RootOutputStream.o $(bin)NavInputStream.o $(bin)RootInputSvc.o) $(patsubst %.o,%.dep,$(bin)RootOutputSvc.o $(bin)RootOutputStream.o $(bin)NavInputStream.o $(bin)RootInputSvc.o) $(patsubst %.o,%.d.stamp,$(bin)RootOutputSvc.o $(bin)RootOutputStream.o $(bin)NavInputStream.o $(bin)RootInputSvc.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RootIOSvc_deps RootIOSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RootIOSvcinstallname = $(library_prefix)RootIOSvc$(library_suffix).$(shlibsuffix)

RootIOSvc :: RootIOSvcinstall ;

install :: RootIOSvcinstall ;

RootIOSvcinstall :: $(install_dir)/$(RootIOSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RootIOSvcinstallname) :: $(bin)$(RootIOSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootIOSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RootIOSvcclean :: RootIOSvcuninstall

uninstall :: RootIOSvcuninstall ;

RootIOSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootIOSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),RootIOSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),RootIOSvcprototype)

$(bin)RootIOSvc_dependencies.make : $(use_requirements) $(cmt_final_setup_RootIOSvc)
	$(echo) "(RootIOSvc.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)RootOutputSvc.cc $(src)RootOutputStream.cc $(src)NavInputStream.cc $(src)RootInputSvc.cc -end_all $(includes) $(app_RootIOSvc_cppflags) $(lib_RootIOSvc_cppflags) -name=RootIOSvc $? -f=$(cmt_dependencies_in_RootIOSvc) -without_cmt

-include $(bin)RootIOSvc_dependencies.make

endif
endif
endif

RootIOSvcclean ::
	$(cleanup_silent) \rm -rf $(bin)RootIOSvc_deps $(bin)RootIOSvc_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootOutputSvc.d

$(bin)$(binobj)RootOutputSvc.d :

$(bin)$(binobj)RootOutputSvc.o : $(cmt_final_setup_RootIOSvc)

$(bin)$(binobj)RootOutputSvc.o : $(src)RootOutputSvc.cc
	$(cpp_echo) $(src)RootOutputSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOSvc_pp_cppflags) $(lib_RootIOSvc_pp_cppflags) $(RootOutputSvc_pp_cppflags) $(use_cppflags) $(RootIOSvc_cppflags) $(lib_RootIOSvc_cppflags) $(RootOutputSvc_cppflags) $(RootOutputSvc_cc_cppflags)  $(src)RootOutputSvc.cc
endif
endif

else
$(bin)RootIOSvc_dependencies.make : $(RootOutputSvc_cc_dependencies)

$(bin)RootIOSvc_dependencies.make : $(src)RootOutputSvc.cc

$(bin)$(binobj)RootOutputSvc.o : $(RootOutputSvc_cc_dependencies)
	$(cpp_echo) $(src)RootOutputSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOSvc_pp_cppflags) $(lib_RootIOSvc_pp_cppflags) $(RootOutputSvc_pp_cppflags) $(use_cppflags) $(RootIOSvc_cppflags) $(lib_RootIOSvc_cppflags) $(RootOutputSvc_cppflags) $(RootOutputSvc_cc_cppflags)  $(src)RootOutputSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootOutputStream.d

$(bin)$(binobj)RootOutputStream.d :

$(bin)$(binobj)RootOutputStream.o : $(cmt_final_setup_RootIOSvc)

$(bin)$(binobj)RootOutputStream.o : $(src)RootOutputStream.cc
	$(cpp_echo) $(src)RootOutputStream.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOSvc_pp_cppflags) $(lib_RootIOSvc_pp_cppflags) $(RootOutputStream_pp_cppflags) $(use_cppflags) $(RootIOSvc_cppflags) $(lib_RootIOSvc_cppflags) $(RootOutputStream_cppflags) $(RootOutputStream_cc_cppflags)  $(src)RootOutputStream.cc
endif
endif

else
$(bin)RootIOSvc_dependencies.make : $(RootOutputStream_cc_dependencies)

$(bin)RootIOSvc_dependencies.make : $(src)RootOutputStream.cc

$(bin)$(binobj)RootOutputStream.o : $(RootOutputStream_cc_dependencies)
	$(cpp_echo) $(src)RootOutputStream.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOSvc_pp_cppflags) $(lib_RootIOSvc_pp_cppflags) $(RootOutputStream_pp_cppflags) $(use_cppflags) $(RootIOSvc_cppflags) $(lib_RootIOSvc_cppflags) $(RootOutputStream_cppflags) $(RootOutputStream_cc_cppflags)  $(src)RootOutputStream.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NavInputStream.d

$(bin)$(binobj)NavInputStream.d :

$(bin)$(binobj)NavInputStream.o : $(cmt_final_setup_RootIOSvc)

$(bin)$(binobj)NavInputStream.o : $(src)NavInputStream.cc
	$(cpp_echo) $(src)NavInputStream.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOSvc_pp_cppflags) $(lib_RootIOSvc_pp_cppflags) $(NavInputStream_pp_cppflags) $(use_cppflags) $(RootIOSvc_cppflags) $(lib_RootIOSvc_cppflags) $(NavInputStream_cppflags) $(NavInputStream_cc_cppflags)  $(src)NavInputStream.cc
endif
endif

else
$(bin)RootIOSvc_dependencies.make : $(NavInputStream_cc_dependencies)

$(bin)RootIOSvc_dependencies.make : $(src)NavInputStream.cc

$(bin)$(binobj)NavInputStream.o : $(NavInputStream_cc_dependencies)
	$(cpp_echo) $(src)NavInputStream.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOSvc_pp_cppflags) $(lib_RootIOSvc_pp_cppflags) $(NavInputStream_pp_cppflags) $(use_cppflags) $(RootIOSvc_cppflags) $(lib_RootIOSvc_cppflags) $(NavInputStream_cppflags) $(NavInputStream_cc_cppflags)  $(src)NavInputStream.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RootIOSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootInputSvc.d

$(bin)$(binobj)RootInputSvc.d :

$(bin)$(binobj)RootInputSvc.o : $(cmt_final_setup_RootIOSvc)

$(bin)$(binobj)RootInputSvc.o : $(src)RootInputSvc.cc
	$(cpp_echo) $(src)RootInputSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RootIOSvc_pp_cppflags) $(lib_RootIOSvc_pp_cppflags) $(RootInputSvc_pp_cppflags) $(use_cppflags) $(RootIOSvc_cppflags) $(lib_RootIOSvc_cppflags) $(RootInputSvc_cppflags) $(RootInputSvc_cc_cppflags)  $(src)RootInputSvc.cc
endif
endif

else
$(bin)RootIOSvc_dependencies.make : $(RootInputSvc_cc_dependencies)

$(bin)RootIOSvc_dependencies.make : $(src)RootInputSvc.cc

$(bin)$(binobj)RootInputSvc.o : $(RootInputSvc_cc_dependencies)
	$(cpp_echo) $(src)RootInputSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootIOSvc_pp_cppflags) $(lib_RootIOSvc_pp_cppflags) $(RootInputSvc_pp_cppflags) $(use_cppflags) $(RootIOSvc_cppflags) $(lib_RootIOSvc_cppflags) $(RootInputSvc_cppflags) $(RootInputSvc_cc_cppflags)  $(src)RootInputSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RootIOSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootIOSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootIOSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RootIOSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RootIOSvc$(library_suffix).a $(library_prefix)RootIOSvc$(library_suffix).$(shlibsuffix) RootIOSvc.stamp RootIOSvc.shstamp
#-- end of cleanup_library ---------------

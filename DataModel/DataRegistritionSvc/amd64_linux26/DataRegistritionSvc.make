#-- start of make_header -----------------

#====================================
#  Library DataRegistritionSvc
#
#   Generated Fri Jul 10 19:17:47 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_DataRegistritionSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_DataRegistritionSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_DataRegistritionSvc

DataRegistritionSvc_tag = $(tag)

#cmt_local_tagfile_DataRegistritionSvc = $(DataRegistritionSvc_tag)_DataRegistritionSvc.make
cmt_local_tagfile_DataRegistritionSvc = $(bin)$(DataRegistritionSvc_tag)_DataRegistritionSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

DataRegistritionSvc_tag = $(tag)

#cmt_local_tagfile_DataRegistritionSvc = $(DataRegistritionSvc_tag).make
cmt_local_tagfile_DataRegistritionSvc = $(bin)$(DataRegistritionSvc_tag).make

endif

include $(cmt_local_tagfile_DataRegistritionSvc)
#-include $(cmt_local_tagfile_DataRegistritionSvc)

ifdef cmt_DataRegistritionSvc_has_target_tag

cmt_final_setup_DataRegistritionSvc = $(bin)setup_DataRegistritionSvc.make
cmt_dependencies_in_DataRegistritionSvc = $(bin)dependencies_DataRegistritionSvc.in
#cmt_final_setup_DataRegistritionSvc = $(bin)DataRegistritionSvc_DataRegistritionSvcsetup.make
cmt_local_DataRegistritionSvc_makefile = $(bin)DataRegistritionSvc.make

else

cmt_final_setup_DataRegistritionSvc = $(bin)setup.make
cmt_dependencies_in_DataRegistritionSvc = $(bin)dependencies.in
#cmt_final_setup_DataRegistritionSvc = $(bin)DataRegistritionSvcsetup.make
cmt_local_DataRegistritionSvc_makefile = $(bin)DataRegistritionSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)DataRegistritionSvcsetup.make

#DataRegistritionSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'DataRegistritionSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = DataRegistritionSvc/
#DataRegistritionSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

DataRegistritionSvclibname   = $(bin)$(library_prefix)DataRegistritionSvc$(library_suffix)
DataRegistritionSvclib       = $(DataRegistritionSvclibname).a
DataRegistritionSvcstamp     = $(bin)DataRegistritionSvc.stamp
DataRegistritionSvcshstamp   = $(bin)DataRegistritionSvc.shstamp

DataRegistritionSvc :: dirs  DataRegistritionSvcLIB
	$(echo) "DataRegistritionSvc ok"

cmt_DataRegistritionSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_DataRegistritionSvc_has_prototypes

DataRegistritionSvcprototype :  ;

endif

DataRegistritionSvccompile : $(bin)DataRegistritionSvc.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

DataRegistritionSvcLIB :: $(DataRegistritionSvclib) $(DataRegistritionSvcshstamp)
	$(echo) "DataRegistritionSvc : library ok"

$(DataRegistritionSvclib) :: $(bin)DataRegistritionSvc.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(DataRegistritionSvclib) $(bin)DataRegistritionSvc.o
	$(lib_silent) $(ranlib) $(DataRegistritionSvclib)
	$(lib_silent) cat /dev/null >$(DataRegistritionSvcstamp)

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

$(DataRegistritionSvclibname).$(shlibsuffix) :: $(DataRegistritionSvclib) requirements $(use_requirements) $(DataRegistritionSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" DataRegistritionSvc $(DataRegistritionSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(DataRegistritionSvcshstamp)

$(DataRegistritionSvcshstamp) :: $(DataRegistritionSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(DataRegistritionSvclibname).$(shlibsuffix) ; then cat /dev/null >$(DataRegistritionSvcshstamp) ; fi

DataRegistritionSvcclean ::
	$(cleanup_echo) objects DataRegistritionSvc
	$(cleanup_silent) /bin/rm -f $(bin)DataRegistritionSvc.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)DataRegistritionSvc.o) $(patsubst %.o,%.dep,$(bin)DataRegistritionSvc.o) $(patsubst %.o,%.d.stamp,$(bin)DataRegistritionSvc.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf DataRegistritionSvc_deps DataRegistritionSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
DataRegistritionSvcinstallname = $(library_prefix)DataRegistritionSvc$(library_suffix).$(shlibsuffix)

DataRegistritionSvc :: DataRegistritionSvcinstall ;

install :: DataRegistritionSvcinstall ;

DataRegistritionSvcinstall :: $(install_dir)/$(DataRegistritionSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(DataRegistritionSvcinstallname) :: $(bin)$(DataRegistritionSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(DataRegistritionSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##DataRegistritionSvcclean :: DataRegistritionSvcuninstall

uninstall :: DataRegistritionSvcuninstall ;

DataRegistritionSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(DataRegistritionSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),DataRegistritionSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),DataRegistritionSvcprototype)

$(bin)DataRegistritionSvc_dependencies.make : $(use_requirements) $(cmt_final_setup_DataRegistritionSvc)
	$(echo) "(DataRegistritionSvc.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)DataRegistritionSvc.cc -end_all $(includes) $(app_DataRegistritionSvc_cppflags) $(lib_DataRegistritionSvc_cppflags) -name=DataRegistritionSvc $? -f=$(cmt_dependencies_in_DataRegistritionSvc) -without_cmt

-include $(bin)DataRegistritionSvc_dependencies.make

endif
endif
endif

DataRegistritionSvcclean ::
	$(cleanup_silent) \rm -rf $(bin)DataRegistritionSvc_deps $(bin)DataRegistritionSvc_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),DataRegistritionSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataRegistritionSvc.d

$(bin)$(binobj)DataRegistritionSvc.d :

$(bin)$(binobj)DataRegistritionSvc.o : $(cmt_final_setup_DataRegistritionSvc)

$(bin)$(binobj)DataRegistritionSvc.o : $(src)DataRegistritionSvc.cc
	$(cpp_echo) $(src)DataRegistritionSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(DataRegistritionSvc_pp_cppflags) $(lib_DataRegistritionSvc_pp_cppflags) $(DataRegistritionSvc_pp_cppflags) $(use_cppflags) $(DataRegistritionSvc_cppflags) $(lib_DataRegistritionSvc_cppflags) $(DataRegistritionSvc_cppflags) $(DataRegistritionSvc_cc_cppflags)  $(src)DataRegistritionSvc.cc
endif
endif

else
$(bin)DataRegistritionSvc_dependencies.make : $(DataRegistritionSvc_cc_dependencies)

$(bin)DataRegistritionSvc_dependencies.make : $(src)DataRegistritionSvc.cc

$(bin)$(binobj)DataRegistritionSvc.o : $(DataRegistritionSvc_cc_dependencies)
	$(cpp_echo) $(src)DataRegistritionSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(DataRegistritionSvc_pp_cppflags) $(lib_DataRegistritionSvc_pp_cppflags) $(DataRegistritionSvc_pp_cppflags) $(use_cppflags) $(DataRegistritionSvc_cppflags) $(lib_DataRegistritionSvc_cppflags) $(DataRegistritionSvc_cppflags) $(DataRegistritionSvc_cc_cppflags)  $(src)DataRegistritionSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: DataRegistritionSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(DataRegistritionSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

DataRegistritionSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library DataRegistritionSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)DataRegistritionSvc$(library_suffix).a $(library_prefix)DataRegistritionSvc$(library_suffix).$(shlibsuffix) DataRegistritionSvc.stamp DataRegistritionSvc.shstamp
#-- end of cleanup_library ---------------

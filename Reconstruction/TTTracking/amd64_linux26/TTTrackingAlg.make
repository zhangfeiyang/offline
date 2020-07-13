#-- start of make_header -----------------

#====================================
#  Library TTTrackingAlg
#
#   Generated Fri Jul 10 19:21:57 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_TTTrackingAlg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TTTrackingAlg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_TTTrackingAlg

TTTracking_tag = $(tag)

#cmt_local_tagfile_TTTrackingAlg = $(TTTracking_tag)_TTTrackingAlg.make
cmt_local_tagfile_TTTrackingAlg = $(bin)$(TTTracking_tag)_TTTrackingAlg.make

else

tags      = $(tag),$(CMTEXTRATAGS)

TTTracking_tag = $(tag)

#cmt_local_tagfile_TTTrackingAlg = $(TTTracking_tag).make
cmt_local_tagfile_TTTrackingAlg = $(bin)$(TTTracking_tag).make

endif

include $(cmt_local_tagfile_TTTrackingAlg)
#-include $(cmt_local_tagfile_TTTrackingAlg)

ifdef cmt_TTTrackingAlg_has_target_tag

cmt_final_setup_TTTrackingAlg = $(bin)setup_TTTrackingAlg.make
cmt_dependencies_in_TTTrackingAlg = $(bin)dependencies_TTTrackingAlg.in
#cmt_final_setup_TTTrackingAlg = $(bin)TTTracking_TTTrackingAlgsetup.make
cmt_local_TTTrackingAlg_makefile = $(bin)TTTrackingAlg.make

else

cmt_final_setup_TTTrackingAlg = $(bin)setup.make
cmt_dependencies_in_TTTrackingAlg = $(bin)dependencies.in
#cmt_final_setup_TTTrackingAlg = $(bin)TTTrackingsetup.make
cmt_local_TTTrackingAlg_makefile = $(bin)TTTrackingAlg.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)TTTrackingsetup.make

#TTTrackingAlg :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'TTTrackingAlg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = TTTrackingAlg/
#TTTrackingAlg::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

TTTrackingAlglibname   = $(bin)$(library_prefix)TTTrackingAlg$(library_suffix)
TTTrackingAlglib       = $(TTTrackingAlglibname).a
TTTrackingAlgstamp     = $(bin)TTTrackingAlg.stamp
TTTrackingAlgshstamp   = $(bin)TTTrackingAlg.shstamp

TTTrackingAlg :: dirs  TTTrackingAlgLIB
	$(echo) "TTTrackingAlg ok"

cmt_TTTrackingAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_TTTrackingAlg_has_prototypes

TTTrackingAlgprototype :  ;

endif

TTTrackingAlgcompile : $(bin)TTTrackingAlg.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

TTTrackingAlgLIB :: $(TTTrackingAlglib) $(TTTrackingAlgshstamp)
	$(echo) "TTTrackingAlg : library ok"

$(TTTrackingAlglib) :: $(bin)TTTrackingAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(TTTrackingAlglib) $(bin)TTTrackingAlg.o
	$(lib_silent) $(ranlib) $(TTTrackingAlglib)
	$(lib_silent) cat /dev/null >$(TTTrackingAlgstamp)

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

$(TTTrackingAlglibname).$(shlibsuffix) :: $(TTTrackingAlglib) requirements $(use_requirements) $(TTTrackingAlgstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" TTTrackingAlg $(TTTrackingAlg_shlibflags)
	$(lib_silent) cat /dev/null >$(TTTrackingAlgshstamp)

$(TTTrackingAlgshstamp) :: $(TTTrackingAlglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(TTTrackingAlglibname).$(shlibsuffix) ; then cat /dev/null >$(TTTrackingAlgshstamp) ; fi

TTTrackingAlgclean ::
	$(cleanup_echo) objects TTTrackingAlg
	$(cleanup_silent) /bin/rm -f $(bin)TTTrackingAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)TTTrackingAlg.o) $(patsubst %.o,%.dep,$(bin)TTTrackingAlg.o) $(patsubst %.o,%.d.stamp,$(bin)TTTrackingAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf TTTrackingAlg_deps TTTrackingAlg_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
TTTrackingAlginstallname = $(library_prefix)TTTrackingAlg$(library_suffix).$(shlibsuffix)

TTTrackingAlg :: TTTrackingAlginstall ;

install :: TTTrackingAlginstall ;

TTTrackingAlginstall :: $(install_dir)/$(TTTrackingAlginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(TTTrackingAlginstallname) :: $(bin)$(TTTrackingAlginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(TTTrackingAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##TTTrackingAlgclean :: TTTrackingAlguninstall

uninstall :: TTTrackingAlguninstall ;

TTTrackingAlguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(TTTrackingAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),TTTrackingAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),TTTrackingAlgprototype)

$(bin)TTTrackingAlg_dependencies.make : $(use_requirements) $(cmt_final_setup_TTTrackingAlg)
	$(echo) "(TTTrackingAlg.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)TTTrackingAlg.cc -end_all $(includes) $(app_TTTrackingAlg_cppflags) $(lib_TTTrackingAlg_cppflags) -name=TTTrackingAlg $? -f=$(cmt_dependencies_in_TTTrackingAlg) -without_cmt

-include $(bin)TTTrackingAlg_dependencies.make

endif
endif
endif

TTTrackingAlgclean ::
	$(cleanup_silent) \rm -rf $(bin)TTTrackingAlg_deps $(bin)TTTrackingAlg_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),TTTrackingAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TTTrackingAlg.d

$(bin)$(binobj)TTTrackingAlg.d :

$(bin)$(binobj)TTTrackingAlg.o : $(cmt_final_setup_TTTrackingAlg)

$(bin)$(binobj)TTTrackingAlg.o : $(src)TTTrackingAlg.cc
	$(cpp_echo) $(src)TTTrackingAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(TTTrackingAlg_pp_cppflags) $(lib_TTTrackingAlg_pp_cppflags) $(TTTrackingAlg_pp_cppflags) $(use_cppflags) $(TTTrackingAlg_cppflags) $(lib_TTTrackingAlg_cppflags) $(TTTrackingAlg_cppflags) $(TTTrackingAlg_cc_cppflags)  $(src)TTTrackingAlg.cc
endif
endif

else
$(bin)TTTrackingAlg_dependencies.make : $(TTTrackingAlg_cc_dependencies)

$(bin)TTTrackingAlg_dependencies.make : $(src)TTTrackingAlg.cc

$(bin)$(binobj)TTTrackingAlg.o : $(TTTrackingAlg_cc_dependencies)
	$(cpp_echo) $(src)TTTrackingAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TTTrackingAlg_pp_cppflags) $(lib_TTTrackingAlg_pp_cppflags) $(TTTrackingAlg_pp_cppflags) $(use_cppflags) $(TTTrackingAlg_cppflags) $(lib_TTTrackingAlg_cppflags) $(TTTrackingAlg_cppflags) $(TTTrackingAlg_cc_cppflags)  $(src)TTTrackingAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: TTTrackingAlgclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(TTTrackingAlg.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

TTTrackingAlgclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library TTTrackingAlg
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)TTTrackingAlg$(library_suffix).a $(library_prefix)TTTrackingAlg$(library_suffix).$(shlibsuffix) TTTrackingAlg.stamp TTTrackingAlg.shstamp
#-- end of cleanup_library ---------------

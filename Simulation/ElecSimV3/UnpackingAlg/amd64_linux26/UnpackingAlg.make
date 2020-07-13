#-- start of make_header -----------------

#====================================
#  Library UnpackingAlg
#
#   Generated Fri Jul 10 19:23:22 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_UnpackingAlg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_UnpackingAlg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_UnpackingAlg

UnpackingAlg_tag = $(tag)

#cmt_local_tagfile_UnpackingAlg = $(UnpackingAlg_tag)_UnpackingAlg.make
cmt_local_tagfile_UnpackingAlg = $(bin)$(UnpackingAlg_tag)_UnpackingAlg.make

else

tags      = $(tag),$(CMTEXTRATAGS)

UnpackingAlg_tag = $(tag)

#cmt_local_tagfile_UnpackingAlg = $(UnpackingAlg_tag).make
cmt_local_tagfile_UnpackingAlg = $(bin)$(UnpackingAlg_tag).make

endif

include $(cmt_local_tagfile_UnpackingAlg)
#-include $(cmt_local_tagfile_UnpackingAlg)

ifdef cmt_UnpackingAlg_has_target_tag

cmt_final_setup_UnpackingAlg = $(bin)setup_UnpackingAlg.make
cmt_dependencies_in_UnpackingAlg = $(bin)dependencies_UnpackingAlg.in
#cmt_final_setup_UnpackingAlg = $(bin)UnpackingAlg_UnpackingAlgsetup.make
cmt_local_UnpackingAlg_makefile = $(bin)UnpackingAlg.make

else

cmt_final_setup_UnpackingAlg = $(bin)setup.make
cmt_dependencies_in_UnpackingAlg = $(bin)dependencies.in
#cmt_final_setup_UnpackingAlg = $(bin)UnpackingAlgsetup.make
cmt_local_UnpackingAlg_makefile = $(bin)UnpackingAlg.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)UnpackingAlgsetup.make

#UnpackingAlg :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'UnpackingAlg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = UnpackingAlg/
#UnpackingAlg::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

UnpackingAlglibname   = $(bin)$(library_prefix)UnpackingAlg$(library_suffix)
UnpackingAlglib       = $(UnpackingAlglibname).a
UnpackingAlgstamp     = $(bin)UnpackingAlg.stamp
UnpackingAlgshstamp   = $(bin)UnpackingAlg.shstamp

UnpackingAlg :: dirs  UnpackingAlgLIB
	$(echo) "UnpackingAlg ok"

cmt_UnpackingAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_UnpackingAlg_has_prototypes

UnpackingAlgprototype :  ;

endif

UnpackingAlgcompile : $(bin)UnpackingAlg.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

UnpackingAlgLIB :: $(UnpackingAlglib) $(UnpackingAlgshstamp)
	$(echo) "UnpackingAlg : library ok"

$(UnpackingAlglib) :: $(bin)UnpackingAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(UnpackingAlglib) $(bin)UnpackingAlg.o
	$(lib_silent) $(ranlib) $(UnpackingAlglib)
	$(lib_silent) cat /dev/null >$(UnpackingAlgstamp)

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

$(UnpackingAlglibname).$(shlibsuffix) :: $(UnpackingAlglib) requirements $(use_requirements) $(UnpackingAlgstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" UnpackingAlg $(UnpackingAlg_shlibflags)
	$(lib_silent) cat /dev/null >$(UnpackingAlgshstamp)

$(UnpackingAlgshstamp) :: $(UnpackingAlglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(UnpackingAlglibname).$(shlibsuffix) ; then cat /dev/null >$(UnpackingAlgshstamp) ; fi

UnpackingAlgclean ::
	$(cleanup_echo) objects UnpackingAlg
	$(cleanup_silent) /bin/rm -f $(bin)UnpackingAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)UnpackingAlg.o) $(patsubst %.o,%.dep,$(bin)UnpackingAlg.o) $(patsubst %.o,%.d.stamp,$(bin)UnpackingAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf UnpackingAlg_deps UnpackingAlg_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
UnpackingAlginstallname = $(library_prefix)UnpackingAlg$(library_suffix).$(shlibsuffix)

UnpackingAlg :: UnpackingAlginstall ;

install :: UnpackingAlginstall ;

UnpackingAlginstall :: $(install_dir)/$(UnpackingAlginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(UnpackingAlginstallname) :: $(bin)$(UnpackingAlginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(UnpackingAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##UnpackingAlgclean :: UnpackingAlguninstall

uninstall :: UnpackingAlguninstall ;

UnpackingAlguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(UnpackingAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),UnpackingAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),UnpackingAlgprototype)

$(bin)UnpackingAlg_dependencies.make : $(use_requirements) $(cmt_final_setup_UnpackingAlg)
	$(echo) "(UnpackingAlg.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)UnpackingAlg.cc -end_all $(includes) $(app_UnpackingAlg_cppflags) $(lib_UnpackingAlg_cppflags) -name=UnpackingAlg $? -f=$(cmt_dependencies_in_UnpackingAlg) -without_cmt

-include $(bin)UnpackingAlg_dependencies.make

endif
endif
endif

UnpackingAlgclean ::
	$(cleanup_silent) \rm -rf $(bin)UnpackingAlg_deps $(bin)UnpackingAlg_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),UnpackingAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)UnpackingAlg.d

$(bin)$(binobj)UnpackingAlg.d :

$(bin)$(binobj)UnpackingAlg.o : $(cmt_final_setup_UnpackingAlg)

$(bin)$(binobj)UnpackingAlg.o : $(src)UnpackingAlg.cc
	$(cpp_echo) $(src)UnpackingAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(UnpackingAlg_pp_cppflags) $(lib_UnpackingAlg_pp_cppflags) $(UnpackingAlg_pp_cppflags) $(use_cppflags) $(UnpackingAlg_cppflags) $(lib_UnpackingAlg_cppflags) $(UnpackingAlg_cppflags) $(UnpackingAlg_cc_cppflags)  $(src)UnpackingAlg.cc
endif
endif

else
$(bin)UnpackingAlg_dependencies.make : $(UnpackingAlg_cc_dependencies)

$(bin)UnpackingAlg_dependencies.make : $(src)UnpackingAlg.cc

$(bin)$(binobj)UnpackingAlg.o : $(UnpackingAlg_cc_dependencies)
	$(cpp_echo) $(src)UnpackingAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(UnpackingAlg_pp_cppflags) $(lib_UnpackingAlg_pp_cppflags) $(UnpackingAlg_pp_cppflags) $(use_cppflags) $(UnpackingAlg_cppflags) $(lib_UnpackingAlg_cppflags) $(UnpackingAlg_cppflags) $(UnpackingAlg_cc_cppflags)  $(src)UnpackingAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: UnpackingAlgclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(UnpackingAlg.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

UnpackingAlgclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library UnpackingAlg
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)UnpackingAlg$(library_suffix).a $(library_prefix)UnpackingAlg$(library_suffix).$(shlibsuffix) UnpackingAlg.stamp UnpackingAlg.shstamp
#-- end of cleanup_library ---------------

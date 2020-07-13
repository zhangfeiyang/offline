#-- start of make_header -----------------

#====================================
#  Library EvtMixingAlg
#
#   Generated Fri Jul 10 19:23:01 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_EvtMixingAlg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_EvtMixingAlg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_EvtMixingAlg

EvtMixingAlg_tag = $(tag)

#cmt_local_tagfile_EvtMixingAlg = $(EvtMixingAlg_tag)_EvtMixingAlg.make
cmt_local_tagfile_EvtMixingAlg = $(bin)$(EvtMixingAlg_tag)_EvtMixingAlg.make

else

tags      = $(tag),$(CMTEXTRATAGS)

EvtMixingAlg_tag = $(tag)

#cmt_local_tagfile_EvtMixingAlg = $(EvtMixingAlg_tag).make
cmt_local_tagfile_EvtMixingAlg = $(bin)$(EvtMixingAlg_tag).make

endif

include $(cmt_local_tagfile_EvtMixingAlg)
#-include $(cmt_local_tagfile_EvtMixingAlg)

ifdef cmt_EvtMixingAlg_has_target_tag

cmt_final_setup_EvtMixingAlg = $(bin)setup_EvtMixingAlg.make
cmt_dependencies_in_EvtMixingAlg = $(bin)dependencies_EvtMixingAlg.in
#cmt_final_setup_EvtMixingAlg = $(bin)EvtMixingAlg_EvtMixingAlgsetup.make
cmt_local_EvtMixingAlg_makefile = $(bin)EvtMixingAlg.make

else

cmt_final_setup_EvtMixingAlg = $(bin)setup.make
cmt_dependencies_in_EvtMixingAlg = $(bin)dependencies.in
#cmt_final_setup_EvtMixingAlg = $(bin)EvtMixingAlgsetup.make
cmt_local_EvtMixingAlg_makefile = $(bin)EvtMixingAlg.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)EvtMixingAlgsetup.make

#EvtMixingAlg :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'EvtMixingAlg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = EvtMixingAlg/
#EvtMixingAlg::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

EvtMixingAlglibname   = $(bin)$(library_prefix)EvtMixingAlg$(library_suffix)
EvtMixingAlglib       = $(EvtMixingAlglibname).a
EvtMixingAlgstamp     = $(bin)EvtMixingAlg.stamp
EvtMixingAlgshstamp   = $(bin)EvtMixingAlg.shstamp

EvtMixingAlg :: dirs  EvtMixingAlgLIB
	$(echo) "EvtMixingAlg ok"

cmt_EvtMixingAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_EvtMixingAlg_has_prototypes

EvtMixingAlgprototype :  ;

endif

EvtMixingAlgcompile : $(bin)EvtMixingAlg.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

EvtMixingAlgLIB :: $(EvtMixingAlglib) $(EvtMixingAlgshstamp)
	$(echo) "EvtMixingAlg : library ok"

$(EvtMixingAlglib) :: $(bin)EvtMixingAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(EvtMixingAlglib) $(bin)EvtMixingAlg.o
	$(lib_silent) $(ranlib) $(EvtMixingAlglib)
	$(lib_silent) cat /dev/null >$(EvtMixingAlgstamp)

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

$(EvtMixingAlglibname).$(shlibsuffix) :: $(EvtMixingAlglib) requirements $(use_requirements) $(EvtMixingAlgstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" EvtMixingAlg $(EvtMixingAlg_shlibflags)
	$(lib_silent) cat /dev/null >$(EvtMixingAlgshstamp)

$(EvtMixingAlgshstamp) :: $(EvtMixingAlglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(EvtMixingAlglibname).$(shlibsuffix) ; then cat /dev/null >$(EvtMixingAlgshstamp) ; fi

EvtMixingAlgclean ::
	$(cleanup_echo) objects EvtMixingAlg
	$(cleanup_silent) /bin/rm -f $(bin)EvtMixingAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)EvtMixingAlg.o) $(patsubst %.o,%.dep,$(bin)EvtMixingAlg.o) $(patsubst %.o,%.d.stamp,$(bin)EvtMixingAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf EvtMixingAlg_deps EvtMixingAlg_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
EvtMixingAlginstallname = $(library_prefix)EvtMixingAlg$(library_suffix).$(shlibsuffix)

EvtMixingAlg :: EvtMixingAlginstall ;

install :: EvtMixingAlginstall ;

EvtMixingAlginstall :: $(install_dir)/$(EvtMixingAlginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(EvtMixingAlginstallname) :: $(bin)$(EvtMixingAlginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(EvtMixingAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##EvtMixingAlgclean :: EvtMixingAlguninstall

uninstall :: EvtMixingAlguninstall ;

EvtMixingAlguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(EvtMixingAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),EvtMixingAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),EvtMixingAlgprototype)

$(bin)EvtMixingAlg_dependencies.make : $(use_requirements) $(cmt_final_setup_EvtMixingAlg)
	$(echo) "(EvtMixingAlg.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)EvtMixingAlg.cc -end_all $(includes) $(app_EvtMixingAlg_cppflags) $(lib_EvtMixingAlg_cppflags) -name=EvtMixingAlg $? -f=$(cmt_dependencies_in_EvtMixingAlg) -without_cmt

-include $(bin)EvtMixingAlg_dependencies.make

endif
endif
endif

EvtMixingAlgclean ::
	$(cleanup_silent) \rm -rf $(bin)EvtMixingAlg_deps $(bin)EvtMixingAlg_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),EvtMixingAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EvtMixingAlg.d

$(bin)$(binobj)EvtMixingAlg.d :

$(bin)$(binobj)EvtMixingAlg.o : $(cmt_final_setup_EvtMixingAlg)

$(bin)$(binobj)EvtMixingAlg.o : $(src)EvtMixingAlg.cc
	$(cpp_echo) $(src)EvtMixingAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EvtMixingAlg_pp_cppflags) $(lib_EvtMixingAlg_pp_cppflags) $(EvtMixingAlg_pp_cppflags) $(use_cppflags) $(EvtMixingAlg_cppflags) $(lib_EvtMixingAlg_cppflags) $(EvtMixingAlg_cppflags) $(EvtMixingAlg_cc_cppflags)  $(src)EvtMixingAlg.cc
endif
endif

else
$(bin)EvtMixingAlg_dependencies.make : $(EvtMixingAlg_cc_dependencies)

$(bin)EvtMixingAlg_dependencies.make : $(src)EvtMixingAlg.cc

$(bin)$(binobj)EvtMixingAlg.o : $(EvtMixingAlg_cc_dependencies)
	$(cpp_echo) $(src)EvtMixingAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EvtMixingAlg_pp_cppflags) $(lib_EvtMixingAlg_pp_cppflags) $(EvtMixingAlg_pp_cppflags) $(use_cppflags) $(EvtMixingAlg_cppflags) $(lib_EvtMixingAlg_cppflags) $(EvtMixingAlg_cppflags) $(EvtMixingAlg_cc_cppflags)  $(src)EvtMixingAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: EvtMixingAlgclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(EvtMixingAlg.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

EvtMixingAlgclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library EvtMixingAlg
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)EvtMixingAlg$(library_suffix).a $(library_prefix)EvtMixingAlg$(library_suffix).$(shlibsuffix) EvtMixingAlg.stamp EvtMixingAlg.shstamp
#-- end of cleanup_library ---------------

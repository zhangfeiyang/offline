#-- start of make_header -----------------

#====================================
#  Library PMTSimAlg
#
#   Generated Fri Jul 10 19:23:32 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PMTSimAlg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PMTSimAlg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PMTSimAlg

PMTSimAlg_tag = $(tag)

#cmt_local_tagfile_PMTSimAlg = $(PMTSimAlg_tag)_PMTSimAlg.make
cmt_local_tagfile_PMTSimAlg = $(bin)$(PMTSimAlg_tag)_PMTSimAlg.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PMTSimAlg_tag = $(tag)

#cmt_local_tagfile_PMTSimAlg = $(PMTSimAlg_tag).make
cmt_local_tagfile_PMTSimAlg = $(bin)$(PMTSimAlg_tag).make

endif

include $(cmt_local_tagfile_PMTSimAlg)
#-include $(cmt_local_tagfile_PMTSimAlg)

ifdef cmt_PMTSimAlg_has_target_tag

cmt_final_setup_PMTSimAlg = $(bin)setup_PMTSimAlg.make
cmt_dependencies_in_PMTSimAlg = $(bin)dependencies_PMTSimAlg.in
#cmt_final_setup_PMTSimAlg = $(bin)PMTSimAlg_PMTSimAlgsetup.make
cmt_local_PMTSimAlg_makefile = $(bin)PMTSimAlg.make

else

cmt_final_setup_PMTSimAlg = $(bin)setup.make
cmt_dependencies_in_PMTSimAlg = $(bin)dependencies.in
#cmt_final_setup_PMTSimAlg = $(bin)PMTSimAlgsetup.make
cmt_local_PMTSimAlg_makefile = $(bin)PMTSimAlg.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PMTSimAlgsetup.make

#PMTSimAlg :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PMTSimAlg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PMTSimAlg/
#PMTSimAlg::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

PMTSimAlglibname   = $(bin)$(library_prefix)PMTSimAlg$(library_suffix)
PMTSimAlglib       = $(PMTSimAlglibname).a
PMTSimAlgstamp     = $(bin)PMTSimAlg.stamp
PMTSimAlgshstamp   = $(bin)PMTSimAlg.shstamp

PMTSimAlg :: dirs  PMTSimAlgLIB
	$(echo) "PMTSimAlg ok"

cmt_PMTSimAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_PMTSimAlg_has_prototypes

PMTSimAlgprototype :  ;

endif

PMTSimAlgcompile : $(bin)PMTSimAlg.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

PMTSimAlgLIB :: $(PMTSimAlglib) $(PMTSimAlgshstamp)
	$(echo) "PMTSimAlg : library ok"

$(PMTSimAlglib) :: $(bin)PMTSimAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(PMTSimAlglib) $(bin)PMTSimAlg.o
	$(lib_silent) $(ranlib) $(PMTSimAlglib)
	$(lib_silent) cat /dev/null >$(PMTSimAlgstamp)

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

$(PMTSimAlglibname).$(shlibsuffix) :: $(PMTSimAlglib) requirements $(use_requirements) $(PMTSimAlgstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" PMTSimAlg $(PMTSimAlg_shlibflags)
	$(lib_silent) cat /dev/null >$(PMTSimAlgshstamp)

$(PMTSimAlgshstamp) :: $(PMTSimAlglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(PMTSimAlglibname).$(shlibsuffix) ; then cat /dev/null >$(PMTSimAlgshstamp) ; fi

PMTSimAlgclean ::
	$(cleanup_echo) objects PMTSimAlg
	$(cleanup_silent) /bin/rm -f $(bin)PMTSimAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PMTSimAlg.o) $(patsubst %.o,%.dep,$(bin)PMTSimAlg.o) $(patsubst %.o,%.d.stamp,$(bin)PMTSimAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf PMTSimAlg_deps PMTSimAlg_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
PMTSimAlginstallname = $(library_prefix)PMTSimAlg$(library_suffix).$(shlibsuffix)

PMTSimAlg :: PMTSimAlginstall ;

install :: PMTSimAlginstall ;

PMTSimAlginstall :: $(install_dir)/$(PMTSimAlginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(PMTSimAlginstallname) :: $(bin)$(PMTSimAlginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PMTSimAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##PMTSimAlgclean :: PMTSimAlguninstall

uninstall :: PMTSimAlguninstall ;

PMTSimAlguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PMTSimAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),PMTSimAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),PMTSimAlgprototype)

$(bin)PMTSimAlg_dependencies.make : $(use_requirements) $(cmt_final_setup_PMTSimAlg)
	$(echo) "(PMTSimAlg.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)PMTSimAlg.cc -end_all $(includes) $(app_PMTSimAlg_cppflags) $(lib_PMTSimAlg_cppflags) -name=PMTSimAlg $? -f=$(cmt_dependencies_in_PMTSimAlg) -without_cmt

-include $(bin)PMTSimAlg_dependencies.make

endif
endif
endif

PMTSimAlgclean ::
	$(cleanup_silent) \rm -rf $(bin)PMTSimAlg_deps $(bin)PMTSimAlg_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PMTSimAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PMTSimAlg.d

$(bin)$(binobj)PMTSimAlg.d :

$(bin)$(binobj)PMTSimAlg.o : $(cmt_final_setup_PMTSimAlg)

$(bin)$(binobj)PMTSimAlg.o : $(src)PMTSimAlg.cc
	$(cpp_echo) $(src)PMTSimAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PMTSimAlg_pp_cppflags) $(lib_PMTSimAlg_pp_cppflags) $(PMTSimAlg_pp_cppflags) $(use_cppflags) $(PMTSimAlg_cppflags) $(lib_PMTSimAlg_cppflags) $(PMTSimAlg_cppflags) $(PMTSimAlg_cc_cppflags)  $(src)PMTSimAlg.cc
endif
endif

else
$(bin)PMTSimAlg_dependencies.make : $(PMTSimAlg_cc_dependencies)

$(bin)PMTSimAlg_dependencies.make : $(src)PMTSimAlg.cc

$(bin)$(binobj)PMTSimAlg.o : $(PMTSimAlg_cc_dependencies)
	$(cpp_echo) $(src)PMTSimAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PMTSimAlg_pp_cppflags) $(lib_PMTSimAlg_pp_cppflags) $(PMTSimAlg_pp_cppflags) $(use_cppflags) $(PMTSimAlg_cppflags) $(lib_PMTSimAlg_cppflags) $(PMTSimAlg_cppflags) $(PMTSimAlg_cc_cppflags)  $(src)PMTSimAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: PMTSimAlgclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PMTSimAlg.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PMTSimAlgclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library PMTSimAlg
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)PMTSimAlg$(library_suffix).a $(library_prefix)PMTSimAlg$(library_suffix).$(shlibsuffix) PMTSimAlg.stamp PMTSimAlg.shstamp
#-- end of cleanup_library ---------------

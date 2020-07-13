#-- start of make_header -----------------

#====================================
#  Library PreTrgAlg
#
#   Generated Fri Jul 10 19:23:55 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PreTrgAlg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PreTrgAlg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PreTrgAlg

PreTrgAlg_tag = $(tag)

#cmt_local_tagfile_PreTrgAlg = $(PreTrgAlg_tag)_PreTrgAlg.make
cmt_local_tagfile_PreTrgAlg = $(bin)$(PreTrgAlg_tag)_PreTrgAlg.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PreTrgAlg_tag = $(tag)

#cmt_local_tagfile_PreTrgAlg = $(PreTrgAlg_tag).make
cmt_local_tagfile_PreTrgAlg = $(bin)$(PreTrgAlg_tag).make

endif

include $(cmt_local_tagfile_PreTrgAlg)
#-include $(cmt_local_tagfile_PreTrgAlg)

ifdef cmt_PreTrgAlg_has_target_tag

cmt_final_setup_PreTrgAlg = $(bin)setup_PreTrgAlg.make
cmt_dependencies_in_PreTrgAlg = $(bin)dependencies_PreTrgAlg.in
#cmt_final_setup_PreTrgAlg = $(bin)PreTrgAlg_PreTrgAlgsetup.make
cmt_local_PreTrgAlg_makefile = $(bin)PreTrgAlg.make

else

cmt_final_setup_PreTrgAlg = $(bin)setup.make
cmt_dependencies_in_PreTrgAlg = $(bin)dependencies.in
#cmt_final_setup_PreTrgAlg = $(bin)PreTrgAlgsetup.make
cmt_local_PreTrgAlg_makefile = $(bin)PreTrgAlg.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PreTrgAlgsetup.make

#PreTrgAlg :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PreTrgAlg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PreTrgAlg/
#PreTrgAlg::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

PreTrgAlglibname   = $(bin)$(library_prefix)PreTrgAlg$(library_suffix)
PreTrgAlglib       = $(PreTrgAlglibname).a
PreTrgAlgstamp     = $(bin)PreTrgAlg.stamp
PreTrgAlgshstamp   = $(bin)PreTrgAlg.shstamp

PreTrgAlg :: dirs  PreTrgAlgLIB
	$(echo) "PreTrgAlg ok"

cmt_PreTrgAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_PreTrgAlg_has_prototypes

PreTrgAlgprototype :  ;

endif

PreTrgAlgcompile : $(bin)PreTrgAlg.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

PreTrgAlgLIB :: $(PreTrgAlglib) $(PreTrgAlgshstamp)
	$(echo) "PreTrgAlg : library ok"

$(PreTrgAlglib) :: $(bin)PreTrgAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(PreTrgAlglib) $(bin)PreTrgAlg.o
	$(lib_silent) $(ranlib) $(PreTrgAlglib)
	$(lib_silent) cat /dev/null >$(PreTrgAlgstamp)

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

$(PreTrgAlglibname).$(shlibsuffix) :: $(PreTrgAlglib) requirements $(use_requirements) $(PreTrgAlgstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" PreTrgAlg $(PreTrgAlg_shlibflags)
	$(lib_silent) cat /dev/null >$(PreTrgAlgshstamp)

$(PreTrgAlgshstamp) :: $(PreTrgAlglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(PreTrgAlglibname).$(shlibsuffix) ; then cat /dev/null >$(PreTrgAlgshstamp) ; fi

PreTrgAlgclean ::
	$(cleanup_echo) objects PreTrgAlg
	$(cleanup_silent) /bin/rm -f $(bin)PreTrgAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PreTrgAlg.o) $(patsubst %.o,%.dep,$(bin)PreTrgAlg.o) $(patsubst %.o,%.d.stamp,$(bin)PreTrgAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf PreTrgAlg_deps PreTrgAlg_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
PreTrgAlginstallname = $(library_prefix)PreTrgAlg$(library_suffix).$(shlibsuffix)

PreTrgAlg :: PreTrgAlginstall ;

install :: PreTrgAlginstall ;

PreTrgAlginstall :: $(install_dir)/$(PreTrgAlginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(PreTrgAlginstallname) :: $(bin)$(PreTrgAlginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PreTrgAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##PreTrgAlgclean :: PreTrgAlguninstall

uninstall :: PreTrgAlguninstall ;

PreTrgAlguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PreTrgAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),PreTrgAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),PreTrgAlgprototype)

$(bin)PreTrgAlg_dependencies.make : $(use_requirements) $(cmt_final_setup_PreTrgAlg)
	$(echo) "(PreTrgAlg.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)PreTrgAlg.cc -end_all $(includes) $(app_PreTrgAlg_cppflags) $(lib_PreTrgAlg_cppflags) -name=PreTrgAlg $? -f=$(cmt_dependencies_in_PreTrgAlg) -without_cmt

-include $(bin)PreTrgAlg_dependencies.make

endif
endif
endif

PreTrgAlgclean ::
	$(cleanup_silent) \rm -rf $(bin)PreTrgAlg_deps $(bin)PreTrgAlg_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PreTrgAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PreTrgAlg.d

$(bin)$(binobj)PreTrgAlg.d :

$(bin)$(binobj)PreTrgAlg.o : $(cmt_final_setup_PreTrgAlg)

$(bin)$(binobj)PreTrgAlg.o : $(src)PreTrgAlg.cc
	$(cpp_echo) $(src)PreTrgAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PreTrgAlg_pp_cppflags) $(lib_PreTrgAlg_pp_cppflags) $(PreTrgAlg_pp_cppflags) $(use_cppflags) $(PreTrgAlg_cppflags) $(lib_PreTrgAlg_cppflags) $(PreTrgAlg_cppflags) $(PreTrgAlg_cc_cppflags)  $(src)PreTrgAlg.cc
endif
endif

else
$(bin)PreTrgAlg_dependencies.make : $(PreTrgAlg_cc_dependencies)

$(bin)PreTrgAlg_dependencies.make : $(src)PreTrgAlg.cc

$(bin)$(binobj)PreTrgAlg.o : $(PreTrgAlg_cc_dependencies)
	$(cpp_echo) $(src)PreTrgAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PreTrgAlg_pp_cppflags) $(lib_PreTrgAlg_pp_cppflags) $(PreTrgAlg_pp_cppflags) $(use_cppflags) $(PreTrgAlg_cppflags) $(lib_PreTrgAlg_cppflags) $(PreTrgAlg_cppflags) $(PreTrgAlg_cc_cppflags)  $(src)PreTrgAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: PreTrgAlgclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PreTrgAlg.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PreTrgAlgclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library PreTrgAlg
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)PreTrgAlg$(library_suffix).a $(library_prefix)PreTrgAlg$(library_suffix).$(shlibsuffix) PreTrgAlg.stamp PreTrgAlg.shstamp
#-- end of cleanup_library ---------------

#-- start of make_header -----------------

#====================================
#  Library RecTimeLikeAlg
#
#   Generated Fri Jul 10 19:20:16 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RecTimeLikeAlg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RecTimeLikeAlg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RecTimeLikeAlg

RecTimeLikeAlg_tag = $(tag)

#cmt_local_tagfile_RecTimeLikeAlg = $(RecTimeLikeAlg_tag)_RecTimeLikeAlg.make
cmt_local_tagfile_RecTimeLikeAlg = $(bin)$(RecTimeLikeAlg_tag)_RecTimeLikeAlg.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RecTimeLikeAlg_tag = $(tag)

#cmt_local_tagfile_RecTimeLikeAlg = $(RecTimeLikeAlg_tag).make
cmt_local_tagfile_RecTimeLikeAlg = $(bin)$(RecTimeLikeAlg_tag).make

endif

include $(cmt_local_tagfile_RecTimeLikeAlg)
#-include $(cmt_local_tagfile_RecTimeLikeAlg)

ifdef cmt_RecTimeLikeAlg_has_target_tag

cmt_final_setup_RecTimeLikeAlg = $(bin)setup_RecTimeLikeAlg.make
cmt_dependencies_in_RecTimeLikeAlg = $(bin)dependencies_RecTimeLikeAlg.in
#cmt_final_setup_RecTimeLikeAlg = $(bin)RecTimeLikeAlg_RecTimeLikeAlgsetup.make
cmt_local_RecTimeLikeAlg_makefile = $(bin)RecTimeLikeAlg.make

else

cmt_final_setup_RecTimeLikeAlg = $(bin)setup.make
cmt_dependencies_in_RecTimeLikeAlg = $(bin)dependencies.in
#cmt_final_setup_RecTimeLikeAlg = $(bin)RecTimeLikeAlgsetup.make
cmt_local_RecTimeLikeAlg_makefile = $(bin)RecTimeLikeAlg.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RecTimeLikeAlgsetup.make

#RecTimeLikeAlg :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RecTimeLikeAlg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RecTimeLikeAlg/
#RecTimeLikeAlg::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RecTimeLikeAlglibname   = $(bin)$(library_prefix)RecTimeLikeAlg$(library_suffix)
RecTimeLikeAlglib       = $(RecTimeLikeAlglibname).a
RecTimeLikeAlgstamp     = $(bin)RecTimeLikeAlg.stamp
RecTimeLikeAlgshstamp   = $(bin)RecTimeLikeAlg.shstamp

RecTimeLikeAlg :: dirs  RecTimeLikeAlgLIB
	$(echo) "RecTimeLikeAlg ok"

cmt_RecTimeLikeAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_RecTimeLikeAlg_has_prototypes

RecTimeLikeAlgprototype :  ;

endif

RecTimeLikeAlgcompile : $(bin)RecTimeLikeAlg.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

RecTimeLikeAlgLIB :: $(RecTimeLikeAlglib) $(RecTimeLikeAlgshstamp)
	$(echo) "RecTimeLikeAlg : library ok"

$(RecTimeLikeAlglib) :: $(bin)RecTimeLikeAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(RecTimeLikeAlglib) $(bin)RecTimeLikeAlg.o
	$(lib_silent) $(ranlib) $(RecTimeLikeAlglib)
	$(lib_silent) cat /dev/null >$(RecTimeLikeAlgstamp)

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

$(RecTimeLikeAlglibname).$(shlibsuffix) :: $(RecTimeLikeAlglib) requirements $(use_requirements) $(RecTimeLikeAlgstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" RecTimeLikeAlg $(RecTimeLikeAlg_shlibflags)
	$(lib_silent) cat /dev/null >$(RecTimeLikeAlgshstamp)

$(RecTimeLikeAlgshstamp) :: $(RecTimeLikeAlglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RecTimeLikeAlglibname).$(shlibsuffix) ; then cat /dev/null >$(RecTimeLikeAlgshstamp) ; fi

RecTimeLikeAlgclean ::
	$(cleanup_echo) objects RecTimeLikeAlg
	$(cleanup_silent) /bin/rm -f $(bin)RecTimeLikeAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)RecTimeLikeAlg.o) $(patsubst %.o,%.dep,$(bin)RecTimeLikeAlg.o) $(patsubst %.o,%.d.stamp,$(bin)RecTimeLikeAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RecTimeLikeAlg_deps RecTimeLikeAlg_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RecTimeLikeAlginstallname = $(library_prefix)RecTimeLikeAlg$(library_suffix).$(shlibsuffix)

RecTimeLikeAlg :: RecTimeLikeAlginstall ;

install :: RecTimeLikeAlginstall ;

RecTimeLikeAlginstall :: $(install_dir)/$(RecTimeLikeAlginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RecTimeLikeAlginstallname) :: $(bin)$(RecTimeLikeAlginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RecTimeLikeAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RecTimeLikeAlgclean :: RecTimeLikeAlguninstall

uninstall :: RecTimeLikeAlguninstall ;

RecTimeLikeAlguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RecTimeLikeAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),RecTimeLikeAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),RecTimeLikeAlgprototype)

$(bin)RecTimeLikeAlg_dependencies.make : $(use_requirements) $(cmt_final_setup_RecTimeLikeAlg)
	$(echo) "(RecTimeLikeAlg.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)RecTimeLikeAlg.cc -end_all $(includes) $(app_RecTimeLikeAlg_cppflags) $(lib_RecTimeLikeAlg_cppflags) -name=RecTimeLikeAlg $? -f=$(cmt_dependencies_in_RecTimeLikeAlg) -without_cmt

-include $(bin)RecTimeLikeAlg_dependencies.make

endif
endif
endif

RecTimeLikeAlgclean ::
	$(cleanup_silent) \rm -rf $(bin)RecTimeLikeAlg_deps $(bin)RecTimeLikeAlg_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecTimeLikeAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecTimeLikeAlg.d

$(bin)$(binobj)RecTimeLikeAlg.d :

$(bin)$(binobj)RecTimeLikeAlg.o : $(cmt_final_setup_RecTimeLikeAlg)

$(bin)$(binobj)RecTimeLikeAlg.o : $(src)RecTimeLikeAlg.cc
	$(cpp_echo) $(src)RecTimeLikeAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecTimeLikeAlg_pp_cppflags) $(lib_RecTimeLikeAlg_pp_cppflags) $(RecTimeLikeAlg_pp_cppflags) $(use_cppflags) $(RecTimeLikeAlg_cppflags) $(lib_RecTimeLikeAlg_cppflags) $(RecTimeLikeAlg_cppflags) $(RecTimeLikeAlg_cc_cppflags)  $(src)RecTimeLikeAlg.cc
endif
endif

else
$(bin)RecTimeLikeAlg_dependencies.make : $(RecTimeLikeAlg_cc_dependencies)

$(bin)RecTimeLikeAlg_dependencies.make : $(src)RecTimeLikeAlg.cc

$(bin)$(binobj)RecTimeLikeAlg.o : $(RecTimeLikeAlg_cc_dependencies)
	$(cpp_echo) $(src)RecTimeLikeAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecTimeLikeAlg_pp_cppflags) $(lib_RecTimeLikeAlg_pp_cppflags) $(RecTimeLikeAlg_pp_cppflags) $(use_cppflags) $(RecTimeLikeAlg_cppflags) $(lib_RecTimeLikeAlg_cppflags) $(RecTimeLikeAlg_cppflags) $(RecTimeLikeAlg_cc_cppflags)  $(src)RecTimeLikeAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RecTimeLikeAlgclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RecTimeLikeAlg.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RecTimeLikeAlgclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RecTimeLikeAlg
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RecTimeLikeAlg$(library_suffix).a $(library_prefix)RecTimeLikeAlg$(library_suffix).$(shlibsuffix) RecTimeLikeAlg.stamp RecTimeLikeAlg.shstamp
#-- end of cleanup_library ---------------

#-- start of make_header -----------------

#====================================
#  Library RecWpMuonAlg
#
#   Generated Fri Jul 10 19:19:01 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RecWpMuonAlg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RecWpMuonAlg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RecWpMuonAlg

RecWpMuonAlg_tag = $(tag)

#cmt_local_tagfile_RecWpMuonAlg = $(RecWpMuonAlg_tag)_RecWpMuonAlg.make
cmt_local_tagfile_RecWpMuonAlg = $(bin)$(RecWpMuonAlg_tag)_RecWpMuonAlg.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RecWpMuonAlg_tag = $(tag)

#cmt_local_tagfile_RecWpMuonAlg = $(RecWpMuonAlg_tag).make
cmt_local_tagfile_RecWpMuonAlg = $(bin)$(RecWpMuonAlg_tag).make

endif

include $(cmt_local_tagfile_RecWpMuonAlg)
#-include $(cmt_local_tagfile_RecWpMuonAlg)

ifdef cmt_RecWpMuonAlg_has_target_tag

cmt_final_setup_RecWpMuonAlg = $(bin)setup_RecWpMuonAlg.make
cmt_dependencies_in_RecWpMuonAlg = $(bin)dependencies_RecWpMuonAlg.in
#cmt_final_setup_RecWpMuonAlg = $(bin)RecWpMuonAlg_RecWpMuonAlgsetup.make
cmt_local_RecWpMuonAlg_makefile = $(bin)RecWpMuonAlg.make

else

cmt_final_setup_RecWpMuonAlg = $(bin)setup.make
cmt_dependencies_in_RecWpMuonAlg = $(bin)dependencies.in
#cmt_final_setup_RecWpMuonAlg = $(bin)RecWpMuonAlgsetup.make
cmt_local_RecWpMuonAlg_makefile = $(bin)RecWpMuonAlg.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RecWpMuonAlgsetup.make

#RecWpMuonAlg :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RecWpMuonAlg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RecWpMuonAlg/
#RecWpMuonAlg::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RecWpMuonAlglibname   = $(bin)$(library_prefix)RecWpMuonAlg$(library_suffix)
RecWpMuonAlglib       = $(RecWpMuonAlglibname).a
RecWpMuonAlgstamp     = $(bin)RecWpMuonAlg.stamp
RecWpMuonAlgshstamp   = $(bin)RecWpMuonAlg.shstamp

RecWpMuonAlg :: dirs  RecWpMuonAlgLIB
	$(echo) "RecWpMuonAlg ok"

cmt_RecWpMuonAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_RecWpMuonAlg_has_prototypes

RecWpMuonAlgprototype :  ;

endif

RecWpMuonAlgcompile : $(bin)Params.o $(bin)RecDummyWpTool.o $(bin)RecWpMuonAlg.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

RecWpMuonAlgLIB :: $(RecWpMuonAlglib) $(RecWpMuonAlgshstamp)
	$(echo) "RecWpMuonAlg : library ok"

$(RecWpMuonAlglib) :: $(bin)Params.o $(bin)RecDummyWpTool.o $(bin)RecWpMuonAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(RecWpMuonAlglib) $(bin)Params.o $(bin)RecDummyWpTool.o $(bin)RecWpMuonAlg.o
	$(lib_silent) $(ranlib) $(RecWpMuonAlglib)
	$(lib_silent) cat /dev/null >$(RecWpMuonAlgstamp)

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

$(RecWpMuonAlglibname).$(shlibsuffix) :: $(RecWpMuonAlglib) requirements $(use_requirements) $(RecWpMuonAlgstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" RecWpMuonAlg $(RecWpMuonAlg_shlibflags)
	$(lib_silent) cat /dev/null >$(RecWpMuonAlgshstamp)

$(RecWpMuonAlgshstamp) :: $(RecWpMuonAlglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RecWpMuonAlglibname).$(shlibsuffix) ; then cat /dev/null >$(RecWpMuonAlgshstamp) ; fi

RecWpMuonAlgclean ::
	$(cleanup_echo) objects RecWpMuonAlg
	$(cleanup_silent) /bin/rm -f $(bin)Params.o $(bin)RecDummyWpTool.o $(bin)RecWpMuonAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)Params.o $(bin)RecDummyWpTool.o $(bin)RecWpMuonAlg.o) $(patsubst %.o,%.dep,$(bin)Params.o $(bin)RecDummyWpTool.o $(bin)RecWpMuonAlg.o) $(patsubst %.o,%.d.stamp,$(bin)Params.o $(bin)RecDummyWpTool.o $(bin)RecWpMuonAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RecWpMuonAlg_deps RecWpMuonAlg_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RecWpMuonAlginstallname = $(library_prefix)RecWpMuonAlg$(library_suffix).$(shlibsuffix)

RecWpMuonAlg :: RecWpMuonAlginstall ;

install :: RecWpMuonAlginstall ;

RecWpMuonAlginstall :: $(install_dir)/$(RecWpMuonAlginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RecWpMuonAlginstallname) :: $(bin)$(RecWpMuonAlginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RecWpMuonAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RecWpMuonAlgclean :: RecWpMuonAlguninstall

uninstall :: RecWpMuonAlguninstall ;

RecWpMuonAlguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RecWpMuonAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),RecWpMuonAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),RecWpMuonAlgprototype)

$(bin)RecWpMuonAlg_dependencies.make : $(use_requirements) $(cmt_final_setup_RecWpMuonAlg)
	$(echo) "(RecWpMuonAlg.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)Params.cc $(src)RecDummyWpTool.cc $(src)RecWpMuonAlg.cc -end_all $(includes) $(app_RecWpMuonAlg_cppflags) $(lib_RecWpMuonAlg_cppflags) -name=RecWpMuonAlg $? -f=$(cmt_dependencies_in_RecWpMuonAlg) -without_cmt

-include $(bin)RecWpMuonAlg_dependencies.make

endif
endif
endif

RecWpMuonAlgclean ::
	$(cleanup_silent) \rm -rf $(bin)RecWpMuonAlg_deps $(bin)RecWpMuonAlg_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecWpMuonAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Params.d

$(bin)$(binobj)Params.d :

$(bin)$(binobj)Params.o : $(cmt_final_setup_RecWpMuonAlg)

$(bin)$(binobj)Params.o : $(src)Params.cc
	$(cpp_echo) $(src)Params.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecWpMuonAlg_pp_cppflags) $(lib_RecWpMuonAlg_pp_cppflags) $(Params_pp_cppflags) $(use_cppflags) $(RecWpMuonAlg_cppflags) $(lib_RecWpMuonAlg_cppflags) $(Params_cppflags) $(Params_cc_cppflags)  $(src)Params.cc
endif
endif

else
$(bin)RecWpMuonAlg_dependencies.make : $(Params_cc_dependencies)

$(bin)RecWpMuonAlg_dependencies.make : $(src)Params.cc

$(bin)$(binobj)Params.o : $(Params_cc_dependencies)
	$(cpp_echo) $(src)Params.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecWpMuonAlg_pp_cppflags) $(lib_RecWpMuonAlg_pp_cppflags) $(Params_pp_cppflags) $(use_cppflags) $(RecWpMuonAlg_cppflags) $(lib_RecWpMuonAlg_cppflags) $(Params_cppflags) $(Params_cc_cppflags)  $(src)Params.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecWpMuonAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecDummyWpTool.d

$(bin)$(binobj)RecDummyWpTool.d :

$(bin)$(binobj)RecDummyWpTool.o : $(cmt_final_setup_RecWpMuonAlg)

$(bin)$(binobj)RecDummyWpTool.o : $(src)RecDummyWpTool.cc
	$(cpp_echo) $(src)RecDummyWpTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecWpMuonAlg_pp_cppflags) $(lib_RecWpMuonAlg_pp_cppflags) $(RecDummyWpTool_pp_cppflags) $(use_cppflags) $(RecWpMuonAlg_cppflags) $(lib_RecWpMuonAlg_cppflags) $(RecDummyWpTool_cppflags) $(RecDummyWpTool_cc_cppflags)  $(src)RecDummyWpTool.cc
endif
endif

else
$(bin)RecWpMuonAlg_dependencies.make : $(RecDummyWpTool_cc_dependencies)

$(bin)RecWpMuonAlg_dependencies.make : $(src)RecDummyWpTool.cc

$(bin)$(binobj)RecDummyWpTool.o : $(RecDummyWpTool_cc_dependencies)
	$(cpp_echo) $(src)RecDummyWpTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecWpMuonAlg_pp_cppflags) $(lib_RecWpMuonAlg_pp_cppflags) $(RecDummyWpTool_pp_cppflags) $(use_cppflags) $(RecWpMuonAlg_cppflags) $(lib_RecWpMuonAlg_cppflags) $(RecDummyWpTool_cppflags) $(RecDummyWpTool_cc_cppflags)  $(src)RecDummyWpTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecWpMuonAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecWpMuonAlg.d

$(bin)$(binobj)RecWpMuonAlg.d :

$(bin)$(binobj)RecWpMuonAlg.o : $(cmt_final_setup_RecWpMuonAlg)

$(bin)$(binobj)RecWpMuonAlg.o : $(src)RecWpMuonAlg.cc
	$(cpp_echo) $(src)RecWpMuonAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecWpMuonAlg_pp_cppflags) $(lib_RecWpMuonAlg_pp_cppflags) $(RecWpMuonAlg_pp_cppflags) $(use_cppflags) $(RecWpMuonAlg_cppflags) $(lib_RecWpMuonAlg_cppflags) $(RecWpMuonAlg_cppflags) $(RecWpMuonAlg_cc_cppflags)  $(src)RecWpMuonAlg.cc
endif
endif

else
$(bin)RecWpMuonAlg_dependencies.make : $(RecWpMuonAlg_cc_dependencies)

$(bin)RecWpMuonAlg_dependencies.make : $(src)RecWpMuonAlg.cc

$(bin)$(binobj)RecWpMuonAlg.o : $(RecWpMuonAlg_cc_dependencies)
	$(cpp_echo) $(src)RecWpMuonAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecWpMuonAlg_pp_cppflags) $(lib_RecWpMuonAlg_pp_cppflags) $(RecWpMuonAlg_pp_cppflags) $(use_cppflags) $(RecWpMuonAlg_cppflags) $(lib_RecWpMuonAlg_cppflags) $(RecWpMuonAlg_cppflags) $(RecWpMuonAlg_cc_cppflags)  $(src)RecWpMuonAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RecWpMuonAlgclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RecWpMuonAlg.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RecWpMuonAlgclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RecWpMuonAlg
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RecWpMuonAlg$(library_suffix).a $(library_prefix)RecWpMuonAlg$(library_suffix).$(shlibsuffix) RecWpMuonAlg.stamp RecWpMuonAlg.shstamp
#-- end of cleanup_library ---------------

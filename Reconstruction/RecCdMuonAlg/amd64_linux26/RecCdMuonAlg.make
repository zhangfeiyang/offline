#-- start of make_header -----------------

#====================================
#  Library RecCdMuonAlg
#
#   Generated Fri Jul 10 19:19:25 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RecCdMuonAlg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RecCdMuonAlg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RecCdMuonAlg

RecCdMuonAlg_tag = $(tag)

#cmt_local_tagfile_RecCdMuonAlg = $(RecCdMuonAlg_tag)_RecCdMuonAlg.make
cmt_local_tagfile_RecCdMuonAlg = $(bin)$(RecCdMuonAlg_tag)_RecCdMuonAlg.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RecCdMuonAlg_tag = $(tag)

#cmt_local_tagfile_RecCdMuonAlg = $(RecCdMuonAlg_tag).make
cmt_local_tagfile_RecCdMuonAlg = $(bin)$(RecCdMuonAlg_tag).make

endif

include $(cmt_local_tagfile_RecCdMuonAlg)
#-include $(cmt_local_tagfile_RecCdMuonAlg)

ifdef cmt_RecCdMuonAlg_has_target_tag

cmt_final_setup_RecCdMuonAlg = $(bin)setup_RecCdMuonAlg.make
cmt_dependencies_in_RecCdMuonAlg = $(bin)dependencies_RecCdMuonAlg.in
#cmt_final_setup_RecCdMuonAlg = $(bin)RecCdMuonAlg_RecCdMuonAlgsetup.make
cmt_local_RecCdMuonAlg_makefile = $(bin)RecCdMuonAlg.make

else

cmt_final_setup_RecCdMuonAlg = $(bin)setup.make
cmt_dependencies_in_RecCdMuonAlg = $(bin)dependencies.in
#cmt_final_setup_RecCdMuonAlg = $(bin)RecCdMuonAlgsetup.make
cmt_local_RecCdMuonAlg_makefile = $(bin)RecCdMuonAlg.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RecCdMuonAlgsetup.make

#RecCdMuonAlg :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RecCdMuonAlg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RecCdMuonAlg/
#RecCdMuonAlg::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RecCdMuonAlglibname   = $(bin)$(library_prefix)RecCdMuonAlg$(library_suffix)
RecCdMuonAlglib       = $(RecCdMuonAlglibname).a
RecCdMuonAlgstamp     = $(bin)RecCdMuonAlg.stamp
RecCdMuonAlgshstamp   = $(bin)RecCdMuonAlg.shstamp

RecCdMuonAlg :: dirs  RecCdMuonAlgLIB
	$(echo) "RecCdMuonAlg ok"

cmt_RecCdMuonAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_RecCdMuonAlg_has_prototypes

RecCdMuonAlgprototype :  ;

endif

RecCdMuonAlgcompile : $(bin)RecCdMuonAlg.o $(bin)Params.o $(bin)RecDummyTool.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

RecCdMuonAlgLIB :: $(RecCdMuonAlglib) $(RecCdMuonAlgshstamp)
	$(echo) "RecCdMuonAlg : library ok"

$(RecCdMuonAlglib) :: $(bin)RecCdMuonAlg.o $(bin)Params.o $(bin)RecDummyTool.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(RecCdMuonAlglib) $(bin)RecCdMuonAlg.o $(bin)Params.o $(bin)RecDummyTool.o
	$(lib_silent) $(ranlib) $(RecCdMuonAlglib)
	$(lib_silent) cat /dev/null >$(RecCdMuonAlgstamp)

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

$(RecCdMuonAlglibname).$(shlibsuffix) :: $(RecCdMuonAlglib) requirements $(use_requirements) $(RecCdMuonAlgstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" RecCdMuonAlg $(RecCdMuonAlg_shlibflags)
	$(lib_silent) cat /dev/null >$(RecCdMuonAlgshstamp)

$(RecCdMuonAlgshstamp) :: $(RecCdMuonAlglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RecCdMuonAlglibname).$(shlibsuffix) ; then cat /dev/null >$(RecCdMuonAlgshstamp) ; fi

RecCdMuonAlgclean ::
	$(cleanup_echo) objects RecCdMuonAlg
	$(cleanup_silent) /bin/rm -f $(bin)RecCdMuonAlg.o $(bin)Params.o $(bin)RecDummyTool.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)RecCdMuonAlg.o $(bin)Params.o $(bin)RecDummyTool.o) $(patsubst %.o,%.dep,$(bin)RecCdMuonAlg.o $(bin)Params.o $(bin)RecDummyTool.o) $(patsubst %.o,%.d.stamp,$(bin)RecCdMuonAlg.o $(bin)Params.o $(bin)RecDummyTool.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RecCdMuonAlg_deps RecCdMuonAlg_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RecCdMuonAlginstallname = $(library_prefix)RecCdMuonAlg$(library_suffix).$(shlibsuffix)

RecCdMuonAlg :: RecCdMuonAlginstall ;

install :: RecCdMuonAlginstall ;

RecCdMuonAlginstall :: $(install_dir)/$(RecCdMuonAlginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RecCdMuonAlginstallname) :: $(bin)$(RecCdMuonAlginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RecCdMuonAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RecCdMuonAlgclean :: RecCdMuonAlguninstall

uninstall :: RecCdMuonAlguninstall ;

RecCdMuonAlguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RecCdMuonAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),RecCdMuonAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),RecCdMuonAlgprototype)

$(bin)RecCdMuonAlg_dependencies.make : $(use_requirements) $(cmt_final_setup_RecCdMuonAlg)
	$(echo) "(RecCdMuonAlg.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)RecCdMuonAlg.cc $(src)Params.cc $(src)RecDummyTool.cc -end_all $(includes) $(app_RecCdMuonAlg_cppflags) $(lib_RecCdMuonAlg_cppflags) -name=RecCdMuonAlg $? -f=$(cmt_dependencies_in_RecCdMuonAlg) -without_cmt

-include $(bin)RecCdMuonAlg_dependencies.make

endif
endif
endif

RecCdMuonAlgclean ::
	$(cleanup_silent) \rm -rf $(bin)RecCdMuonAlg_deps $(bin)RecCdMuonAlg_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecCdMuonAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecCdMuonAlg.d

$(bin)$(binobj)RecCdMuonAlg.d :

$(bin)$(binobj)RecCdMuonAlg.o : $(cmt_final_setup_RecCdMuonAlg)

$(bin)$(binobj)RecCdMuonAlg.o : $(src)RecCdMuonAlg.cc
	$(cpp_echo) $(src)RecCdMuonAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecCdMuonAlg_pp_cppflags) $(lib_RecCdMuonAlg_pp_cppflags) $(RecCdMuonAlg_pp_cppflags) $(use_cppflags) $(RecCdMuonAlg_cppflags) $(lib_RecCdMuonAlg_cppflags) $(RecCdMuonAlg_cppflags) $(RecCdMuonAlg_cc_cppflags)  $(src)RecCdMuonAlg.cc
endif
endif

else
$(bin)RecCdMuonAlg_dependencies.make : $(RecCdMuonAlg_cc_dependencies)

$(bin)RecCdMuonAlg_dependencies.make : $(src)RecCdMuonAlg.cc

$(bin)$(binobj)RecCdMuonAlg.o : $(RecCdMuonAlg_cc_dependencies)
	$(cpp_echo) $(src)RecCdMuonAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecCdMuonAlg_pp_cppflags) $(lib_RecCdMuonAlg_pp_cppflags) $(RecCdMuonAlg_pp_cppflags) $(use_cppflags) $(RecCdMuonAlg_cppflags) $(lib_RecCdMuonAlg_cppflags) $(RecCdMuonAlg_cppflags) $(RecCdMuonAlg_cc_cppflags)  $(src)RecCdMuonAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecCdMuonAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Params.d

$(bin)$(binobj)Params.d :

$(bin)$(binobj)Params.o : $(cmt_final_setup_RecCdMuonAlg)

$(bin)$(binobj)Params.o : $(src)Params.cc
	$(cpp_echo) $(src)Params.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecCdMuonAlg_pp_cppflags) $(lib_RecCdMuonAlg_pp_cppflags) $(Params_pp_cppflags) $(use_cppflags) $(RecCdMuonAlg_cppflags) $(lib_RecCdMuonAlg_cppflags) $(Params_cppflags) $(Params_cc_cppflags)  $(src)Params.cc
endif
endif

else
$(bin)RecCdMuonAlg_dependencies.make : $(Params_cc_dependencies)

$(bin)RecCdMuonAlg_dependencies.make : $(src)Params.cc

$(bin)$(binobj)Params.o : $(Params_cc_dependencies)
	$(cpp_echo) $(src)Params.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecCdMuonAlg_pp_cppflags) $(lib_RecCdMuonAlg_pp_cppflags) $(Params_pp_cppflags) $(use_cppflags) $(RecCdMuonAlg_cppflags) $(lib_RecCdMuonAlg_cppflags) $(Params_cppflags) $(Params_cc_cppflags)  $(src)Params.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),RecCdMuonAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecDummyTool.d

$(bin)$(binobj)RecDummyTool.d :

$(bin)$(binobj)RecDummyTool.o : $(cmt_final_setup_RecCdMuonAlg)

$(bin)$(binobj)RecDummyTool.o : $(src)RecDummyTool.cc
	$(cpp_echo) $(src)RecDummyTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(RecCdMuonAlg_pp_cppflags) $(lib_RecCdMuonAlg_pp_cppflags) $(RecDummyTool_pp_cppflags) $(use_cppflags) $(RecCdMuonAlg_cppflags) $(lib_RecCdMuonAlg_cppflags) $(RecDummyTool_cppflags) $(RecDummyTool_cc_cppflags)  $(src)RecDummyTool.cc
endif
endif

else
$(bin)RecCdMuonAlg_dependencies.make : $(RecDummyTool_cc_dependencies)

$(bin)RecCdMuonAlg_dependencies.make : $(src)RecDummyTool.cc

$(bin)$(binobj)RecDummyTool.o : $(RecDummyTool_cc_dependencies)
	$(cpp_echo) $(src)RecDummyTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RecCdMuonAlg_pp_cppflags) $(lib_RecCdMuonAlg_pp_cppflags) $(RecDummyTool_pp_cppflags) $(use_cppflags) $(RecCdMuonAlg_cppflags) $(lib_RecCdMuonAlg_cppflags) $(RecDummyTool_cppflags) $(RecDummyTool_cc_cppflags)  $(src)RecDummyTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RecCdMuonAlgclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RecCdMuonAlg.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RecCdMuonAlgclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RecCdMuonAlg
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RecCdMuonAlg$(library_suffix).a $(library_prefix)RecCdMuonAlg$(library_suffix).$(shlibsuffix) RecCdMuonAlg.stamp RecCdMuonAlg.shstamp
#-- end of cleanup_library ---------------

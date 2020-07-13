#-- start of make_header -----------------

#====================================
#  Library ConeMuonRecTool
#
#   Generated Fri Jul 10 19:22:20 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_ConeMuonRecTool_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ConeMuonRecTool_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ConeMuonRecTool

ConeMuonRecTool_tag = $(tag)

#cmt_local_tagfile_ConeMuonRecTool = $(ConeMuonRecTool_tag)_ConeMuonRecTool.make
cmt_local_tagfile_ConeMuonRecTool = $(bin)$(ConeMuonRecTool_tag)_ConeMuonRecTool.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ConeMuonRecTool_tag = $(tag)

#cmt_local_tagfile_ConeMuonRecTool = $(ConeMuonRecTool_tag).make
cmt_local_tagfile_ConeMuonRecTool = $(bin)$(ConeMuonRecTool_tag).make

endif

include $(cmt_local_tagfile_ConeMuonRecTool)
#-include $(cmt_local_tagfile_ConeMuonRecTool)

ifdef cmt_ConeMuonRecTool_has_target_tag

cmt_final_setup_ConeMuonRecTool = $(bin)setup_ConeMuonRecTool.make
cmt_dependencies_in_ConeMuonRecTool = $(bin)dependencies_ConeMuonRecTool.in
#cmt_final_setup_ConeMuonRecTool = $(bin)ConeMuonRecTool_ConeMuonRecToolsetup.make
cmt_local_ConeMuonRecTool_makefile = $(bin)ConeMuonRecTool.make

else

cmt_final_setup_ConeMuonRecTool = $(bin)setup.make
cmt_dependencies_in_ConeMuonRecTool = $(bin)dependencies.in
#cmt_final_setup_ConeMuonRecTool = $(bin)ConeMuonRecToolsetup.make
cmt_local_ConeMuonRecTool_makefile = $(bin)ConeMuonRecTool.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ConeMuonRecToolsetup.make

#ConeMuonRecTool :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ConeMuonRecTool'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ConeMuonRecTool/
#ConeMuonRecTool::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

ConeMuonRecToollibname   = $(bin)$(library_prefix)ConeMuonRecTool$(library_suffix)
ConeMuonRecToollib       = $(ConeMuonRecToollibname).a
ConeMuonRecToolstamp     = $(bin)ConeMuonRecTool.stamp
ConeMuonRecToolshstamp   = $(bin)ConeMuonRecTool.shstamp

ConeMuonRecTool :: dirs  ConeMuonRecToolLIB
	$(echo) "ConeMuonRecTool ok"

cmt_ConeMuonRecTool_has_prototypes = 1

#--------------------------------------

ifdef cmt_ConeMuonRecTool_has_prototypes

ConeMuonRecToolprototype :  ;

endif

ConeMuonRecToolcompile : $(bin)llhCone.o $(bin)ConeMuonRecTool.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

ConeMuonRecToolLIB :: $(ConeMuonRecToollib) $(ConeMuonRecToolshstamp)
	$(echo) "ConeMuonRecTool : library ok"

$(ConeMuonRecToollib) :: $(bin)llhCone.o $(bin)ConeMuonRecTool.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(ConeMuonRecToollib) $(bin)llhCone.o $(bin)ConeMuonRecTool.o
	$(lib_silent) $(ranlib) $(ConeMuonRecToollib)
	$(lib_silent) cat /dev/null >$(ConeMuonRecToolstamp)

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

$(ConeMuonRecToollibname).$(shlibsuffix) :: $(ConeMuonRecToollib) requirements $(use_requirements) $(ConeMuonRecToolstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" ConeMuonRecTool $(ConeMuonRecTool_shlibflags)
	$(lib_silent) cat /dev/null >$(ConeMuonRecToolshstamp)

$(ConeMuonRecToolshstamp) :: $(ConeMuonRecToollibname).$(shlibsuffix)
	$(lib_silent) if test -f $(ConeMuonRecToollibname).$(shlibsuffix) ; then cat /dev/null >$(ConeMuonRecToolshstamp) ; fi

ConeMuonRecToolclean ::
	$(cleanup_echo) objects ConeMuonRecTool
	$(cleanup_silent) /bin/rm -f $(bin)llhCone.o $(bin)ConeMuonRecTool.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)llhCone.o $(bin)ConeMuonRecTool.o) $(patsubst %.o,%.dep,$(bin)llhCone.o $(bin)ConeMuonRecTool.o) $(patsubst %.o,%.d.stamp,$(bin)llhCone.o $(bin)ConeMuonRecTool.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf ConeMuonRecTool_deps ConeMuonRecTool_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
ConeMuonRecToolinstallname = $(library_prefix)ConeMuonRecTool$(library_suffix).$(shlibsuffix)

ConeMuonRecTool :: ConeMuonRecToolinstall ;

install :: ConeMuonRecToolinstall ;

ConeMuonRecToolinstall :: $(install_dir)/$(ConeMuonRecToolinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(ConeMuonRecToolinstallname) :: $(bin)$(ConeMuonRecToolinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(ConeMuonRecToolinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##ConeMuonRecToolclean :: ConeMuonRecTooluninstall

uninstall :: ConeMuonRecTooluninstall ;

ConeMuonRecTooluninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(ConeMuonRecToolinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),ConeMuonRecToolclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),ConeMuonRecToolprototype)

$(bin)ConeMuonRecTool_dependencies.make : $(use_requirements) $(cmt_final_setup_ConeMuonRecTool)
	$(echo) "(ConeMuonRecTool.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)llhCone.cc $(src)ConeMuonRecTool.cc -end_all $(includes) $(app_ConeMuonRecTool_cppflags) $(lib_ConeMuonRecTool_cppflags) -name=ConeMuonRecTool $? -f=$(cmt_dependencies_in_ConeMuonRecTool) -without_cmt

-include $(bin)ConeMuonRecTool_dependencies.make

endif
endif
endif

ConeMuonRecToolclean ::
	$(cleanup_silent) \rm -rf $(bin)ConeMuonRecTool_deps $(bin)ConeMuonRecTool_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ConeMuonRecToolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)llhCone.d

$(bin)$(binobj)llhCone.d :

$(bin)$(binobj)llhCone.o : $(cmt_final_setup_ConeMuonRecTool)

$(bin)$(binobj)llhCone.o : $(src)llhCone.cc
	$(cpp_echo) $(src)llhCone.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ConeMuonRecTool_pp_cppflags) $(lib_ConeMuonRecTool_pp_cppflags) $(llhCone_pp_cppflags) $(use_cppflags) $(ConeMuonRecTool_cppflags) $(lib_ConeMuonRecTool_cppflags) $(llhCone_cppflags) $(llhCone_cc_cppflags)  $(src)llhCone.cc
endif
endif

else
$(bin)ConeMuonRecTool_dependencies.make : $(llhCone_cc_dependencies)

$(bin)ConeMuonRecTool_dependencies.make : $(src)llhCone.cc

$(bin)$(binobj)llhCone.o : $(llhCone_cc_dependencies)
	$(cpp_echo) $(src)llhCone.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ConeMuonRecTool_pp_cppflags) $(lib_ConeMuonRecTool_pp_cppflags) $(llhCone_pp_cppflags) $(use_cppflags) $(ConeMuonRecTool_cppflags) $(lib_ConeMuonRecTool_cppflags) $(llhCone_cppflags) $(llhCone_cc_cppflags)  $(src)llhCone.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ConeMuonRecToolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConeMuonRecTool.d

$(bin)$(binobj)ConeMuonRecTool.d :

$(bin)$(binobj)ConeMuonRecTool.o : $(cmt_final_setup_ConeMuonRecTool)

$(bin)$(binobj)ConeMuonRecTool.o : $(src)ConeMuonRecTool.cc
	$(cpp_echo) $(src)ConeMuonRecTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ConeMuonRecTool_pp_cppflags) $(lib_ConeMuonRecTool_pp_cppflags) $(ConeMuonRecTool_pp_cppflags) $(use_cppflags) $(ConeMuonRecTool_cppflags) $(lib_ConeMuonRecTool_cppflags) $(ConeMuonRecTool_cppflags) $(ConeMuonRecTool_cc_cppflags)  $(src)ConeMuonRecTool.cc
endif
endif

else
$(bin)ConeMuonRecTool_dependencies.make : $(ConeMuonRecTool_cc_dependencies)

$(bin)ConeMuonRecTool_dependencies.make : $(src)ConeMuonRecTool.cc

$(bin)$(binobj)ConeMuonRecTool.o : $(ConeMuonRecTool_cc_dependencies)
	$(cpp_echo) $(src)ConeMuonRecTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ConeMuonRecTool_pp_cppflags) $(lib_ConeMuonRecTool_pp_cppflags) $(ConeMuonRecTool_pp_cppflags) $(use_cppflags) $(ConeMuonRecTool_cppflags) $(lib_ConeMuonRecTool_cppflags) $(ConeMuonRecTool_cppflags) $(ConeMuonRecTool_cc_cppflags)  $(src)ConeMuonRecTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: ConeMuonRecToolclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ConeMuonRecTool.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ConeMuonRecToolclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library ConeMuonRecTool
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)ConeMuonRecTool$(library_suffix).a $(library_prefix)ConeMuonRecTool$(library_suffix).$(shlibsuffix) ConeMuonRecTool.stamp ConeMuonRecTool.shstamp
#-- end of cleanup_library ---------------

#-- start of make_header -----------------

#====================================
#  Library PoolMuonRecTool
#
#   Generated Fri Jul 10 19:19:15 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PoolMuonRecTool_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PoolMuonRecTool_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PoolMuonRecTool

PoolMuonRecTool_tag = $(tag)

#cmt_local_tagfile_PoolMuonRecTool = $(PoolMuonRecTool_tag)_PoolMuonRecTool.make
cmt_local_tagfile_PoolMuonRecTool = $(bin)$(PoolMuonRecTool_tag)_PoolMuonRecTool.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PoolMuonRecTool_tag = $(tag)

#cmt_local_tagfile_PoolMuonRecTool = $(PoolMuonRecTool_tag).make
cmt_local_tagfile_PoolMuonRecTool = $(bin)$(PoolMuonRecTool_tag).make

endif

include $(cmt_local_tagfile_PoolMuonRecTool)
#-include $(cmt_local_tagfile_PoolMuonRecTool)

ifdef cmt_PoolMuonRecTool_has_target_tag

cmt_final_setup_PoolMuonRecTool = $(bin)setup_PoolMuonRecTool.make
cmt_dependencies_in_PoolMuonRecTool = $(bin)dependencies_PoolMuonRecTool.in
#cmt_final_setup_PoolMuonRecTool = $(bin)PoolMuonRecTool_PoolMuonRecToolsetup.make
cmt_local_PoolMuonRecTool_makefile = $(bin)PoolMuonRecTool.make

else

cmt_final_setup_PoolMuonRecTool = $(bin)setup.make
cmt_dependencies_in_PoolMuonRecTool = $(bin)dependencies.in
#cmt_final_setup_PoolMuonRecTool = $(bin)PoolMuonRecToolsetup.make
cmt_local_PoolMuonRecTool_makefile = $(bin)PoolMuonRecTool.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PoolMuonRecToolsetup.make

#PoolMuonRecTool :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PoolMuonRecTool'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PoolMuonRecTool/
#PoolMuonRecTool::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

PoolMuonRecToollibname   = $(bin)$(library_prefix)PoolMuonRecTool$(library_suffix)
PoolMuonRecToollib       = $(PoolMuonRecToollibname).a
PoolMuonRecToolstamp     = $(bin)PoolMuonRecTool.stamp
PoolMuonRecToolshstamp   = $(bin)PoolMuonRecTool.shstamp

PoolMuonRecTool :: dirs  PoolMuonRecToolLIB
	$(echo) "PoolMuonRecTool ok"

cmt_PoolMuonRecTool_has_prototypes = 1

#--------------------------------------

ifdef cmt_PoolMuonRecTool_has_prototypes

PoolMuonRecToolprototype :  ;

endif

PoolMuonRecToolcompile : $(bin)PoolMuonRecTool.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

PoolMuonRecToolLIB :: $(PoolMuonRecToollib) $(PoolMuonRecToolshstamp)
	$(echo) "PoolMuonRecTool : library ok"

$(PoolMuonRecToollib) :: $(bin)PoolMuonRecTool.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(PoolMuonRecToollib) $(bin)PoolMuonRecTool.o
	$(lib_silent) $(ranlib) $(PoolMuonRecToollib)
	$(lib_silent) cat /dev/null >$(PoolMuonRecToolstamp)

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

$(PoolMuonRecToollibname).$(shlibsuffix) :: $(PoolMuonRecToollib) requirements $(use_requirements) $(PoolMuonRecToolstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" PoolMuonRecTool $(PoolMuonRecTool_shlibflags)
	$(lib_silent) cat /dev/null >$(PoolMuonRecToolshstamp)

$(PoolMuonRecToolshstamp) :: $(PoolMuonRecToollibname).$(shlibsuffix)
	$(lib_silent) if test -f $(PoolMuonRecToollibname).$(shlibsuffix) ; then cat /dev/null >$(PoolMuonRecToolshstamp) ; fi

PoolMuonRecToolclean ::
	$(cleanup_echo) objects PoolMuonRecTool
	$(cleanup_silent) /bin/rm -f $(bin)PoolMuonRecTool.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PoolMuonRecTool.o) $(patsubst %.o,%.dep,$(bin)PoolMuonRecTool.o) $(patsubst %.o,%.d.stamp,$(bin)PoolMuonRecTool.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf PoolMuonRecTool_deps PoolMuonRecTool_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
PoolMuonRecToolinstallname = $(library_prefix)PoolMuonRecTool$(library_suffix).$(shlibsuffix)

PoolMuonRecTool :: PoolMuonRecToolinstall ;

install :: PoolMuonRecToolinstall ;

PoolMuonRecToolinstall :: $(install_dir)/$(PoolMuonRecToolinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(PoolMuonRecToolinstallname) :: $(bin)$(PoolMuonRecToolinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PoolMuonRecToolinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##PoolMuonRecToolclean :: PoolMuonRecTooluninstall

uninstall :: PoolMuonRecTooluninstall ;

PoolMuonRecTooluninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PoolMuonRecToolinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),PoolMuonRecToolclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),PoolMuonRecToolprototype)

$(bin)PoolMuonRecTool_dependencies.make : $(use_requirements) $(cmt_final_setup_PoolMuonRecTool)
	$(echo) "(PoolMuonRecTool.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)PoolMuonRecTool.cc -end_all $(includes) $(app_PoolMuonRecTool_cppflags) $(lib_PoolMuonRecTool_cppflags) -name=PoolMuonRecTool $? -f=$(cmt_dependencies_in_PoolMuonRecTool) -without_cmt

-include $(bin)PoolMuonRecTool_dependencies.make

endif
endif
endif

PoolMuonRecToolclean ::
	$(cleanup_silent) \rm -rf $(bin)PoolMuonRecTool_deps $(bin)PoolMuonRecTool_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PoolMuonRecToolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PoolMuonRecTool.d

$(bin)$(binobj)PoolMuonRecTool.d :

$(bin)$(binobj)PoolMuonRecTool.o : $(cmt_final_setup_PoolMuonRecTool)

$(bin)$(binobj)PoolMuonRecTool.o : $(src)PoolMuonRecTool.cc
	$(cpp_echo) $(src)PoolMuonRecTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PoolMuonRecTool_pp_cppflags) $(lib_PoolMuonRecTool_pp_cppflags) $(PoolMuonRecTool_pp_cppflags) $(use_cppflags) $(PoolMuonRecTool_cppflags) $(lib_PoolMuonRecTool_cppflags) $(PoolMuonRecTool_cppflags) $(PoolMuonRecTool_cc_cppflags)  $(src)PoolMuonRecTool.cc
endif
endif

else
$(bin)PoolMuonRecTool_dependencies.make : $(PoolMuonRecTool_cc_dependencies)

$(bin)PoolMuonRecTool_dependencies.make : $(src)PoolMuonRecTool.cc

$(bin)$(binobj)PoolMuonRecTool.o : $(PoolMuonRecTool_cc_dependencies)
	$(cpp_echo) $(src)PoolMuonRecTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PoolMuonRecTool_pp_cppflags) $(lib_PoolMuonRecTool_pp_cppflags) $(PoolMuonRecTool_pp_cppflags) $(use_cppflags) $(PoolMuonRecTool_cppflags) $(lib_PoolMuonRecTool_cppflags) $(PoolMuonRecTool_cppflags) $(PoolMuonRecTool_cc_cppflags)  $(src)PoolMuonRecTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: PoolMuonRecToolclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PoolMuonRecTool.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PoolMuonRecToolclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library PoolMuonRecTool
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)PoolMuonRecTool$(library_suffix).a $(library_prefix)PoolMuonRecTool$(library_suffix).$(shlibsuffix) PoolMuonRecTool.stamp PoolMuonRecTool.shstamp
#-- end of cleanup_library ---------------

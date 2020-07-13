#-- start of make_header -----------------

#====================================
#  Library SpmtMuonRecTool
#
#   Generated Fri Jul 10 19:19:38 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_SpmtMuonRecTool_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_SpmtMuonRecTool_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_SpmtMuonRecTool

SpmtMuonRecTool_tag = $(tag)

#cmt_local_tagfile_SpmtMuonRecTool = $(SpmtMuonRecTool_tag)_SpmtMuonRecTool.make
cmt_local_tagfile_SpmtMuonRecTool = $(bin)$(SpmtMuonRecTool_tag)_SpmtMuonRecTool.make

else

tags      = $(tag),$(CMTEXTRATAGS)

SpmtMuonRecTool_tag = $(tag)

#cmt_local_tagfile_SpmtMuonRecTool = $(SpmtMuonRecTool_tag).make
cmt_local_tagfile_SpmtMuonRecTool = $(bin)$(SpmtMuonRecTool_tag).make

endif

include $(cmt_local_tagfile_SpmtMuonRecTool)
#-include $(cmt_local_tagfile_SpmtMuonRecTool)

ifdef cmt_SpmtMuonRecTool_has_target_tag

cmt_final_setup_SpmtMuonRecTool = $(bin)setup_SpmtMuonRecTool.make
cmt_dependencies_in_SpmtMuonRecTool = $(bin)dependencies_SpmtMuonRecTool.in
#cmt_final_setup_SpmtMuonRecTool = $(bin)SpmtMuonRecTool_SpmtMuonRecToolsetup.make
cmt_local_SpmtMuonRecTool_makefile = $(bin)SpmtMuonRecTool.make

else

cmt_final_setup_SpmtMuonRecTool = $(bin)setup.make
cmt_dependencies_in_SpmtMuonRecTool = $(bin)dependencies.in
#cmt_final_setup_SpmtMuonRecTool = $(bin)SpmtMuonRecToolsetup.make
cmt_local_SpmtMuonRecTool_makefile = $(bin)SpmtMuonRecTool.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)SpmtMuonRecToolsetup.make

#SpmtMuonRecTool :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'SpmtMuonRecTool'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = SpmtMuonRecTool/
#SpmtMuonRecTool::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

SpmtMuonRecToollibname   = $(bin)$(library_prefix)SpmtMuonRecTool$(library_suffix)
SpmtMuonRecToollib       = $(SpmtMuonRecToollibname).a
SpmtMuonRecToolstamp     = $(bin)SpmtMuonRecTool.stamp
SpmtMuonRecToolshstamp   = $(bin)SpmtMuonRecTool.shstamp

SpmtMuonRecTool :: dirs  SpmtMuonRecToolLIB
	$(echo) "SpmtMuonRecTool ok"

cmt_SpmtMuonRecTool_has_prototypes = 1

#--------------------------------------

ifdef cmt_SpmtMuonRecTool_has_prototypes

SpmtMuonRecToolprototype :  ;

endif

SpmtMuonRecToolcompile : $(bin)SpmtMuonRecTool.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

SpmtMuonRecToolLIB :: $(SpmtMuonRecToollib) $(SpmtMuonRecToolshstamp)
	$(echo) "SpmtMuonRecTool : library ok"

$(SpmtMuonRecToollib) :: $(bin)SpmtMuonRecTool.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(SpmtMuonRecToollib) $(bin)SpmtMuonRecTool.o
	$(lib_silent) $(ranlib) $(SpmtMuonRecToollib)
	$(lib_silent) cat /dev/null >$(SpmtMuonRecToolstamp)

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

$(SpmtMuonRecToollibname).$(shlibsuffix) :: $(SpmtMuonRecToollib) requirements $(use_requirements) $(SpmtMuonRecToolstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" SpmtMuonRecTool $(SpmtMuonRecTool_shlibflags)
	$(lib_silent) cat /dev/null >$(SpmtMuonRecToolshstamp)

$(SpmtMuonRecToolshstamp) :: $(SpmtMuonRecToollibname).$(shlibsuffix)
	$(lib_silent) if test -f $(SpmtMuonRecToollibname).$(shlibsuffix) ; then cat /dev/null >$(SpmtMuonRecToolshstamp) ; fi

SpmtMuonRecToolclean ::
	$(cleanup_echo) objects SpmtMuonRecTool
	$(cleanup_silent) /bin/rm -f $(bin)SpmtMuonRecTool.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)SpmtMuonRecTool.o) $(patsubst %.o,%.dep,$(bin)SpmtMuonRecTool.o) $(patsubst %.o,%.d.stamp,$(bin)SpmtMuonRecTool.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf SpmtMuonRecTool_deps SpmtMuonRecTool_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
SpmtMuonRecToolinstallname = $(library_prefix)SpmtMuonRecTool$(library_suffix).$(shlibsuffix)

SpmtMuonRecTool :: SpmtMuonRecToolinstall ;

install :: SpmtMuonRecToolinstall ;

SpmtMuonRecToolinstall :: $(install_dir)/$(SpmtMuonRecToolinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(SpmtMuonRecToolinstallname) :: $(bin)$(SpmtMuonRecToolinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(SpmtMuonRecToolinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##SpmtMuonRecToolclean :: SpmtMuonRecTooluninstall

uninstall :: SpmtMuonRecTooluninstall ;

SpmtMuonRecTooluninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(SpmtMuonRecToolinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),SpmtMuonRecToolclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),SpmtMuonRecToolprototype)

$(bin)SpmtMuonRecTool_dependencies.make : $(use_requirements) $(cmt_final_setup_SpmtMuonRecTool)
	$(echo) "(SpmtMuonRecTool.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)SpmtMuonRecTool.cc -end_all $(includes) $(app_SpmtMuonRecTool_cppflags) $(lib_SpmtMuonRecTool_cppflags) -name=SpmtMuonRecTool $? -f=$(cmt_dependencies_in_SpmtMuonRecTool) -without_cmt

-include $(bin)SpmtMuonRecTool_dependencies.make

endif
endif
endif

SpmtMuonRecToolclean ::
	$(cleanup_silent) \rm -rf $(bin)SpmtMuonRecTool_deps $(bin)SpmtMuonRecTool_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),SpmtMuonRecToolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SpmtMuonRecTool.d

$(bin)$(binobj)SpmtMuonRecTool.d :

$(bin)$(binobj)SpmtMuonRecTool.o : $(cmt_final_setup_SpmtMuonRecTool)

$(bin)$(binobj)SpmtMuonRecTool.o : $(src)SpmtMuonRecTool.cc
	$(cpp_echo) $(src)SpmtMuonRecTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SpmtMuonRecTool_pp_cppflags) $(lib_SpmtMuonRecTool_pp_cppflags) $(SpmtMuonRecTool_pp_cppflags) $(use_cppflags) $(SpmtMuonRecTool_cppflags) $(lib_SpmtMuonRecTool_cppflags) $(SpmtMuonRecTool_cppflags) $(SpmtMuonRecTool_cc_cppflags)  $(src)SpmtMuonRecTool.cc
endif
endif

else
$(bin)SpmtMuonRecTool_dependencies.make : $(SpmtMuonRecTool_cc_dependencies)

$(bin)SpmtMuonRecTool_dependencies.make : $(src)SpmtMuonRecTool.cc

$(bin)$(binobj)SpmtMuonRecTool.o : $(SpmtMuonRecTool_cc_dependencies)
	$(cpp_echo) $(src)SpmtMuonRecTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SpmtMuonRecTool_pp_cppflags) $(lib_SpmtMuonRecTool_pp_cppflags) $(SpmtMuonRecTool_pp_cppflags) $(use_cppflags) $(SpmtMuonRecTool_cppflags) $(lib_SpmtMuonRecTool_cppflags) $(SpmtMuonRecTool_cppflags) $(SpmtMuonRecTool_cc_cppflags)  $(src)SpmtMuonRecTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: SpmtMuonRecToolclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(SpmtMuonRecTool.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

SpmtMuonRecToolclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library SpmtMuonRecTool
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)SpmtMuonRecTool$(library_suffix).a $(library_prefix)SpmtMuonRecTool$(library_suffix).$(shlibsuffix) SpmtMuonRecTool.stamp SpmtMuonRecTool.shstamp
#-- end of cleanup_library ---------------

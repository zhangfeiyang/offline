#-- start of make_header -----------------

#====================================
#  Library LsqMuonRecTool
#
#   Generated Fri Jul 10 19:19:52 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_LsqMuonRecTool_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_LsqMuonRecTool_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_LsqMuonRecTool

LsqMuonRecTool_tag = $(tag)

#cmt_local_tagfile_LsqMuonRecTool = $(LsqMuonRecTool_tag)_LsqMuonRecTool.make
cmt_local_tagfile_LsqMuonRecTool = $(bin)$(LsqMuonRecTool_tag)_LsqMuonRecTool.make

else

tags      = $(tag),$(CMTEXTRATAGS)

LsqMuonRecTool_tag = $(tag)

#cmt_local_tagfile_LsqMuonRecTool = $(LsqMuonRecTool_tag).make
cmt_local_tagfile_LsqMuonRecTool = $(bin)$(LsqMuonRecTool_tag).make

endif

include $(cmt_local_tagfile_LsqMuonRecTool)
#-include $(cmt_local_tagfile_LsqMuonRecTool)

ifdef cmt_LsqMuonRecTool_has_target_tag

cmt_final_setup_LsqMuonRecTool = $(bin)setup_LsqMuonRecTool.make
cmt_dependencies_in_LsqMuonRecTool = $(bin)dependencies_LsqMuonRecTool.in
#cmt_final_setup_LsqMuonRecTool = $(bin)LsqMuonRecTool_LsqMuonRecToolsetup.make
cmt_local_LsqMuonRecTool_makefile = $(bin)LsqMuonRecTool.make

else

cmt_final_setup_LsqMuonRecTool = $(bin)setup.make
cmt_dependencies_in_LsqMuonRecTool = $(bin)dependencies.in
#cmt_final_setup_LsqMuonRecTool = $(bin)LsqMuonRecToolsetup.make
cmt_local_LsqMuonRecTool_makefile = $(bin)LsqMuonRecTool.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)LsqMuonRecToolsetup.make

#LsqMuonRecTool :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'LsqMuonRecTool'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = LsqMuonRecTool/
#LsqMuonRecTool::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

LsqMuonRecToollibname   = $(bin)$(library_prefix)LsqMuonRecTool$(library_suffix)
LsqMuonRecToollib       = $(LsqMuonRecToollibname).a
LsqMuonRecToolstamp     = $(bin)LsqMuonRecTool.stamp
LsqMuonRecToolshstamp   = $(bin)LsqMuonRecTool.shstamp

LsqMuonRecTool :: dirs  LsqMuonRecToolLIB
	$(echo) "LsqMuonRecTool ok"

cmt_LsqMuonRecTool_has_prototypes = 1

#--------------------------------------

ifdef cmt_LsqMuonRecTool_has_prototypes

LsqMuonRecToolprototype :  ;

endif

LsqMuonRecToolcompile : $(bin)ChiSquareTime.o $(bin)LsqMuonRecTool.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

LsqMuonRecToolLIB :: $(LsqMuonRecToollib) $(LsqMuonRecToolshstamp)
	$(echo) "LsqMuonRecTool : library ok"

$(LsqMuonRecToollib) :: $(bin)ChiSquareTime.o $(bin)LsqMuonRecTool.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(LsqMuonRecToollib) $(bin)ChiSquareTime.o $(bin)LsqMuonRecTool.o
	$(lib_silent) $(ranlib) $(LsqMuonRecToollib)
	$(lib_silent) cat /dev/null >$(LsqMuonRecToolstamp)

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

$(LsqMuonRecToollibname).$(shlibsuffix) :: $(LsqMuonRecToollib) requirements $(use_requirements) $(LsqMuonRecToolstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" LsqMuonRecTool $(LsqMuonRecTool_shlibflags)
	$(lib_silent) cat /dev/null >$(LsqMuonRecToolshstamp)

$(LsqMuonRecToolshstamp) :: $(LsqMuonRecToollibname).$(shlibsuffix)
	$(lib_silent) if test -f $(LsqMuonRecToollibname).$(shlibsuffix) ; then cat /dev/null >$(LsqMuonRecToolshstamp) ; fi

LsqMuonRecToolclean ::
	$(cleanup_echo) objects LsqMuonRecTool
	$(cleanup_silent) /bin/rm -f $(bin)ChiSquareTime.o $(bin)LsqMuonRecTool.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)ChiSquareTime.o $(bin)LsqMuonRecTool.o) $(patsubst %.o,%.dep,$(bin)ChiSquareTime.o $(bin)LsqMuonRecTool.o) $(patsubst %.o,%.d.stamp,$(bin)ChiSquareTime.o $(bin)LsqMuonRecTool.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf LsqMuonRecTool_deps LsqMuonRecTool_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
LsqMuonRecToolinstallname = $(library_prefix)LsqMuonRecTool$(library_suffix).$(shlibsuffix)

LsqMuonRecTool :: LsqMuonRecToolinstall ;

install :: LsqMuonRecToolinstall ;

LsqMuonRecToolinstall :: $(install_dir)/$(LsqMuonRecToolinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(LsqMuonRecToolinstallname) :: $(bin)$(LsqMuonRecToolinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(LsqMuonRecToolinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##LsqMuonRecToolclean :: LsqMuonRecTooluninstall

uninstall :: LsqMuonRecTooluninstall ;

LsqMuonRecTooluninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(LsqMuonRecToolinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),LsqMuonRecToolclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),LsqMuonRecToolprototype)

$(bin)LsqMuonRecTool_dependencies.make : $(use_requirements) $(cmt_final_setup_LsqMuonRecTool)
	$(echo) "(LsqMuonRecTool.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)ChiSquareTime.cc $(src)LsqMuonRecTool.cc -end_all $(includes) $(app_LsqMuonRecTool_cppflags) $(lib_LsqMuonRecTool_cppflags) -name=LsqMuonRecTool $? -f=$(cmt_dependencies_in_LsqMuonRecTool) -without_cmt

-include $(bin)LsqMuonRecTool_dependencies.make

endif
endif
endif

LsqMuonRecToolclean ::
	$(cleanup_silent) \rm -rf $(bin)LsqMuonRecTool_deps $(bin)LsqMuonRecTool_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),LsqMuonRecToolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ChiSquareTime.d

$(bin)$(binobj)ChiSquareTime.d :

$(bin)$(binobj)ChiSquareTime.o : $(cmt_final_setup_LsqMuonRecTool)

$(bin)$(binobj)ChiSquareTime.o : $(src)ChiSquareTime.cc
	$(cpp_echo) $(src)ChiSquareTime.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(LsqMuonRecTool_pp_cppflags) $(lib_LsqMuonRecTool_pp_cppflags) $(ChiSquareTime_pp_cppflags) $(use_cppflags) $(LsqMuonRecTool_cppflags) $(lib_LsqMuonRecTool_cppflags) $(ChiSquareTime_cppflags) $(ChiSquareTime_cc_cppflags)  $(src)ChiSquareTime.cc
endif
endif

else
$(bin)LsqMuonRecTool_dependencies.make : $(ChiSquareTime_cc_dependencies)

$(bin)LsqMuonRecTool_dependencies.make : $(src)ChiSquareTime.cc

$(bin)$(binobj)ChiSquareTime.o : $(ChiSquareTime_cc_dependencies)
	$(cpp_echo) $(src)ChiSquareTime.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LsqMuonRecTool_pp_cppflags) $(lib_LsqMuonRecTool_pp_cppflags) $(ChiSquareTime_pp_cppflags) $(use_cppflags) $(LsqMuonRecTool_cppflags) $(lib_LsqMuonRecTool_cppflags) $(ChiSquareTime_cppflags) $(ChiSquareTime_cc_cppflags)  $(src)ChiSquareTime.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),LsqMuonRecToolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LsqMuonRecTool.d

$(bin)$(binobj)LsqMuonRecTool.d :

$(bin)$(binobj)LsqMuonRecTool.o : $(cmt_final_setup_LsqMuonRecTool)

$(bin)$(binobj)LsqMuonRecTool.o : $(src)LsqMuonRecTool.cc
	$(cpp_echo) $(src)LsqMuonRecTool.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(LsqMuonRecTool_pp_cppflags) $(lib_LsqMuonRecTool_pp_cppflags) $(LsqMuonRecTool_pp_cppflags) $(use_cppflags) $(LsqMuonRecTool_cppflags) $(lib_LsqMuonRecTool_cppflags) $(LsqMuonRecTool_cppflags) $(LsqMuonRecTool_cc_cppflags)  $(src)LsqMuonRecTool.cc
endif
endif

else
$(bin)LsqMuonRecTool_dependencies.make : $(LsqMuonRecTool_cc_dependencies)

$(bin)LsqMuonRecTool_dependencies.make : $(src)LsqMuonRecTool.cc

$(bin)$(binobj)LsqMuonRecTool.o : $(LsqMuonRecTool_cc_dependencies)
	$(cpp_echo) $(src)LsqMuonRecTool.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LsqMuonRecTool_pp_cppflags) $(lib_LsqMuonRecTool_pp_cppflags) $(LsqMuonRecTool_pp_cppflags) $(use_cppflags) $(LsqMuonRecTool_cppflags) $(lib_LsqMuonRecTool_cppflags) $(LsqMuonRecTool_cppflags) $(LsqMuonRecTool_cc_cppflags)  $(src)LsqMuonRecTool.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: LsqMuonRecToolclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(LsqMuonRecTool.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

LsqMuonRecToolclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library LsqMuonRecTool
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)LsqMuonRecTool$(library_suffix).a $(library_prefix)LsqMuonRecTool$(library_suffix).$(shlibsuffix) LsqMuonRecTool.stamp LsqMuonRecTool.shstamp
#-- end of cleanup_library ---------------

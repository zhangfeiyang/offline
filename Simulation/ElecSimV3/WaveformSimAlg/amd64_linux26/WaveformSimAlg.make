#-- start of make_header -----------------

#====================================
#  Library WaveformSimAlg
#
#   Generated Fri Jul 10 19:23:43 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_WaveformSimAlg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_WaveformSimAlg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_WaveformSimAlg

WaveformSimAlg_tag = $(tag)

#cmt_local_tagfile_WaveformSimAlg = $(WaveformSimAlg_tag)_WaveformSimAlg.make
cmt_local_tagfile_WaveformSimAlg = $(bin)$(WaveformSimAlg_tag)_WaveformSimAlg.make

else

tags      = $(tag),$(CMTEXTRATAGS)

WaveformSimAlg_tag = $(tag)

#cmt_local_tagfile_WaveformSimAlg = $(WaveformSimAlg_tag).make
cmt_local_tagfile_WaveformSimAlg = $(bin)$(WaveformSimAlg_tag).make

endif

include $(cmt_local_tagfile_WaveformSimAlg)
#-include $(cmt_local_tagfile_WaveformSimAlg)

ifdef cmt_WaveformSimAlg_has_target_tag

cmt_final_setup_WaveformSimAlg = $(bin)setup_WaveformSimAlg.make
cmt_dependencies_in_WaveformSimAlg = $(bin)dependencies_WaveformSimAlg.in
#cmt_final_setup_WaveformSimAlg = $(bin)WaveformSimAlg_WaveformSimAlgsetup.make
cmt_local_WaveformSimAlg_makefile = $(bin)WaveformSimAlg.make

else

cmt_final_setup_WaveformSimAlg = $(bin)setup.make
cmt_dependencies_in_WaveformSimAlg = $(bin)dependencies.in
#cmt_final_setup_WaveformSimAlg = $(bin)WaveformSimAlgsetup.make
cmt_local_WaveformSimAlg_makefile = $(bin)WaveformSimAlg.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)WaveformSimAlgsetup.make

#WaveformSimAlg :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'WaveformSimAlg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = WaveformSimAlg/
#WaveformSimAlg::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

WaveformSimAlglibname   = $(bin)$(library_prefix)WaveformSimAlg$(library_suffix)
WaveformSimAlglib       = $(WaveformSimAlglibname).a
WaveformSimAlgstamp     = $(bin)WaveformSimAlg.stamp
WaveformSimAlgshstamp   = $(bin)WaveformSimAlg.shstamp

WaveformSimAlg :: dirs  WaveformSimAlgLIB
	$(echo) "WaveformSimAlg ok"

cmt_WaveformSimAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_WaveformSimAlg_has_prototypes

WaveformSimAlgprototype :  ;

endif

WaveformSimAlgcompile : $(bin)WaveformSimAlg.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

WaveformSimAlgLIB :: $(WaveformSimAlglib) $(WaveformSimAlgshstamp)
	$(echo) "WaveformSimAlg : library ok"

$(WaveformSimAlglib) :: $(bin)WaveformSimAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(WaveformSimAlglib) $(bin)WaveformSimAlg.o
	$(lib_silent) $(ranlib) $(WaveformSimAlglib)
	$(lib_silent) cat /dev/null >$(WaveformSimAlgstamp)

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

$(WaveformSimAlglibname).$(shlibsuffix) :: $(WaveformSimAlglib) requirements $(use_requirements) $(WaveformSimAlgstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" WaveformSimAlg $(WaveformSimAlg_shlibflags)
	$(lib_silent) cat /dev/null >$(WaveformSimAlgshstamp)

$(WaveformSimAlgshstamp) :: $(WaveformSimAlglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(WaveformSimAlglibname).$(shlibsuffix) ; then cat /dev/null >$(WaveformSimAlgshstamp) ; fi

WaveformSimAlgclean ::
	$(cleanup_echo) objects WaveformSimAlg
	$(cleanup_silent) /bin/rm -f $(bin)WaveformSimAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)WaveformSimAlg.o) $(patsubst %.o,%.dep,$(bin)WaveformSimAlg.o) $(patsubst %.o,%.d.stamp,$(bin)WaveformSimAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf WaveformSimAlg_deps WaveformSimAlg_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
WaveformSimAlginstallname = $(library_prefix)WaveformSimAlg$(library_suffix).$(shlibsuffix)

WaveformSimAlg :: WaveformSimAlginstall ;

install :: WaveformSimAlginstall ;

WaveformSimAlginstall :: $(install_dir)/$(WaveformSimAlginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(WaveformSimAlginstallname) :: $(bin)$(WaveformSimAlginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(WaveformSimAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##WaveformSimAlgclean :: WaveformSimAlguninstall

uninstall :: WaveformSimAlguninstall ;

WaveformSimAlguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(WaveformSimAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),WaveformSimAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),WaveformSimAlgprototype)

$(bin)WaveformSimAlg_dependencies.make : $(use_requirements) $(cmt_final_setup_WaveformSimAlg)
	$(echo) "(WaveformSimAlg.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)WaveformSimAlg.cc -end_all $(includes) $(app_WaveformSimAlg_cppflags) $(lib_WaveformSimAlg_cppflags) -name=WaveformSimAlg $? -f=$(cmt_dependencies_in_WaveformSimAlg) -without_cmt

-include $(bin)WaveformSimAlg_dependencies.make

endif
endif
endif

WaveformSimAlgclean ::
	$(cleanup_silent) \rm -rf $(bin)WaveformSimAlg_deps $(bin)WaveformSimAlg_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),WaveformSimAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)WaveformSimAlg.d

$(bin)$(binobj)WaveformSimAlg.d :

$(bin)$(binobj)WaveformSimAlg.o : $(cmt_final_setup_WaveformSimAlg)

$(bin)$(binobj)WaveformSimAlg.o : $(src)WaveformSimAlg.cc
	$(cpp_echo) $(src)WaveformSimAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(WaveformSimAlg_pp_cppflags) $(lib_WaveformSimAlg_pp_cppflags) $(WaveformSimAlg_pp_cppflags) $(use_cppflags) $(WaveformSimAlg_cppflags) $(lib_WaveformSimAlg_cppflags) $(WaveformSimAlg_cppflags) $(WaveformSimAlg_cc_cppflags)  $(src)WaveformSimAlg.cc
endif
endif

else
$(bin)WaveformSimAlg_dependencies.make : $(WaveformSimAlg_cc_dependencies)

$(bin)WaveformSimAlg_dependencies.make : $(src)WaveformSimAlg.cc

$(bin)$(binobj)WaveformSimAlg.o : $(WaveformSimAlg_cc_dependencies)
	$(cpp_echo) $(src)WaveformSimAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(WaveformSimAlg_pp_cppflags) $(lib_WaveformSimAlg_pp_cppflags) $(WaveformSimAlg_pp_cppflags) $(use_cppflags) $(WaveformSimAlg_cppflags) $(lib_WaveformSimAlg_cppflags) $(WaveformSimAlg_cppflags) $(WaveformSimAlg_cc_cppflags)  $(src)WaveformSimAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: WaveformSimAlgclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(WaveformSimAlg.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

WaveformSimAlgclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library WaveformSimAlg
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)WaveformSimAlg$(library_suffix).a $(library_prefix)WaveformSimAlg$(library_suffix).$(shlibsuffix) WaveformSimAlg.stamp WaveformSimAlg.shstamp
#-- end of cleanup_library ---------------

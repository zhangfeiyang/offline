#-- start of make_header -----------------

#====================================
#  Library TTCalibAlg
#
#   Generated Fri Jul 10 19:22:08 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_TTCalibAlg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TTCalibAlg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_TTCalibAlg

TTCalib_tag = $(tag)

#cmt_local_tagfile_TTCalibAlg = $(TTCalib_tag)_TTCalibAlg.make
cmt_local_tagfile_TTCalibAlg = $(bin)$(TTCalib_tag)_TTCalibAlg.make

else

tags      = $(tag),$(CMTEXTRATAGS)

TTCalib_tag = $(tag)

#cmt_local_tagfile_TTCalibAlg = $(TTCalib_tag).make
cmt_local_tagfile_TTCalibAlg = $(bin)$(TTCalib_tag).make

endif

include $(cmt_local_tagfile_TTCalibAlg)
#-include $(cmt_local_tagfile_TTCalibAlg)

ifdef cmt_TTCalibAlg_has_target_tag

cmt_final_setup_TTCalibAlg = $(bin)setup_TTCalibAlg.make
cmt_dependencies_in_TTCalibAlg = $(bin)dependencies_TTCalibAlg.in
#cmt_final_setup_TTCalibAlg = $(bin)TTCalib_TTCalibAlgsetup.make
cmt_local_TTCalibAlg_makefile = $(bin)TTCalibAlg.make

else

cmt_final_setup_TTCalibAlg = $(bin)setup.make
cmt_dependencies_in_TTCalibAlg = $(bin)dependencies.in
#cmt_final_setup_TTCalibAlg = $(bin)TTCalibsetup.make
cmt_local_TTCalibAlg_makefile = $(bin)TTCalibAlg.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)TTCalibsetup.make

#TTCalibAlg :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'TTCalibAlg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = TTCalibAlg/
#TTCalibAlg::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

TTCalibAlglibname   = $(bin)$(library_prefix)TTCalibAlg$(library_suffix)
TTCalibAlglib       = $(TTCalibAlglibname).a
TTCalibAlgstamp     = $(bin)TTCalibAlg.stamp
TTCalibAlgshstamp   = $(bin)TTCalibAlg.shstamp

TTCalibAlg :: dirs  TTCalibAlgLIB
	$(echo) "TTCalibAlg ok"

cmt_TTCalibAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_TTCalibAlg_has_prototypes

TTCalibAlgprototype :  ;

endif

TTCalibAlgcompile : $(bin)TTCalibAlg.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

TTCalibAlgLIB :: $(TTCalibAlglib) $(TTCalibAlgshstamp)
	$(echo) "TTCalibAlg : library ok"

$(TTCalibAlglib) :: $(bin)TTCalibAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(TTCalibAlglib) $(bin)TTCalibAlg.o
	$(lib_silent) $(ranlib) $(TTCalibAlglib)
	$(lib_silent) cat /dev/null >$(TTCalibAlgstamp)

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

$(TTCalibAlglibname).$(shlibsuffix) :: $(TTCalibAlglib) requirements $(use_requirements) $(TTCalibAlgstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" TTCalibAlg $(TTCalibAlg_shlibflags)
	$(lib_silent) cat /dev/null >$(TTCalibAlgshstamp)

$(TTCalibAlgshstamp) :: $(TTCalibAlglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(TTCalibAlglibname).$(shlibsuffix) ; then cat /dev/null >$(TTCalibAlgshstamp) ; fi

TTCalibAlgclean ::
	$(cleanup_echo) objects TTCalibAlg
	$(cleanup_silent) /bin/rm -f $(bin)TTCalibAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)TTCalibAlg.o) $(patsubst %.o,%.dep,$(bin)TTCalibAlg.o) $(patsubst %.o,%.d.stamp,$(bin)TTCalibAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf TTCalibAlg_deps TTCalibAlg_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
TTCalibAlginstallname = $(library_prefix)TTCalibAlg$(library_suffix).$(shlibsuffix)

TTCalibAlg :: TTCalibAlginstall ;

install :: TTCalibAlginstall ;

TTCalibAlginstall :: $(install_dir)/$(TTCalibAlginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(TTCalibAlginstallname) :: $(bin)$(TTCalibAlginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(TTCalibAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##TTCalibAlgclean :: TTCalibAlguninstall

uninstall :: TTCalibAlguninstall ;

TTCalibAlguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(TTCalibAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),TTCalibAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),TTCalibAlgprototype)

$(bin)TTCalibAlg_dependencies.make : $(use_requirements) $(cmt_final_setup_TTCalibAlg)
	$(echo) "(TTCalibAlg.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)TTCalibAlg.cc -end_all $(includes) $(app_TTCalibAlg_cppflags) $(lib_TTCalibAlg_cppflags) -name=TTCalibAlg $? -f=$(cmt_dependencies_in_TTCalibAlg) -without_cmt

-include $(bin)TTCalibAlg_dependencies.make

endif
endif
endif

TTCalibAlgclean ::
	$(cleanup_silent) \rm -rf $(bin)TTCalibAlg_deps $(bin)TTCalibAlg_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),TTCalibAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TTCalibAlg.d

$(bin)$(binobj)TTCalibAlg.d :

$(bin)$(binobj)TTCalibAlg.o : $(cmt_final_setup_TTCalibAlg)

$(bin)$(binobj)TTCalibAlg.o : $(src)TTCalibAlg.cc
	$(cpp_echo) $(src)TTCalibAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(TTCalibAlg_pp_cppflags) $(lib_TTCalibAlg_pp_cppflags) $(TTCalibAlg_pp_cppflags) $(use_cppflags) $(TTCalibAlg_cppflags) $(lib_TTCalibAlg_cppflags) $(TTCalibAlg_cppflags) $(TTCalibAlg_cc_cppflags)  $(src)TTCalibAlg.cc
endif
endif

else
$(bin)TTCalibAlg_dependencies.make : $(TTCalibAlg_cc_dependencies)

$(bin)TTCalibAlg_dependencies.make : $(src)TTCalibAlg.cc

$(bin)$(binobj)TTCalibAlg.o : $(TTCalibAlg_cc_dependencies)
	$(cpp_echo) $(src)TTCalibAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TTCalibAlg_pp_cppflags) $(lib_TTCalibAlg_pp_cppflags) $(TTCalibAlg_pp_cppflags) $(use_cppflags) $(TTCalibAlg_cppflags) $(lib_TTCalibAlg_cppflags) $(TTCalibAlg_cppflags) $(TTCalibAlg_cc_cppflags)  $(src)TTCalibAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: TTCalibAlgclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(TTCalibAlg.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

TTCalibAlgclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library TTCalibAlg
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)TTCalibAlg$(library_suffix).a $(library_prefix)TTCalibAlg$(library_suffix).$(shlibsuffix) TTCalibAlg.stamp TTCalibAlg.shstamp
#-- end of cleanup_library ---------------

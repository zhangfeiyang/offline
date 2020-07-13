#-- start of make_header -----------------

#====================================
#  Library PMTCalib
#
#   Generated Fri Jul 10 19:20:34 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PMTCalib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PMTCalib_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PMTCalib

PMTCalib_tag = $(tag)

#cmt_local_tagfile_PMTCalib = $(PMTCalib_tag)_PMTCalib.make
cmt_local_tagfile_PMTCalib = $(bin)$(PMTCalib_tag)_PMTCalib.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PMTCalib_tag = $(tag)

#cmt_local_tagfile_PMTCalib = $(PMTCalib_tag).make
cmt_local_tagfile_PMTCalib = $(bin)$(PMTCalib_tag).make

endif

include $(cmt_local_tagfile_PMTCalib)
#-include $(cmt_local_tagfile_PMTCalib)

ifdef cmt_PMTCalib_has_target_tag

cmt_final_setup_PMTCalib = $(bin)setup_PMTCalib.make
cmt_dependencies_in_PMTCalib = $(bin)dependencies_PMTCalib.in
#cmt_final_setup_PMTCalib = $(bin)PMTCalib_PMTCalibsetup.make
cmt_local_PMTCalib_makefile = $(bin)PMTCalib.make

else

cmt_final_setup_PMTCalib = $(bin)setup.make
cmt_dependencies_in_PMTCalib = $(bin)dependencies.in
#cmt_final_setup_PMTCalib = $(bin)PMTCalibsetup.make
cmt_local_PMTCalib_makefile = $(bin)PMTCalib.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PMTCalibsetup.make

#PMTCalib :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PMTCalib'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PMTCalib/
#PMTCalib::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

PMTCaliblibname   = $(bin)$(library_prefix)PMTCalib$(library_suffix)
PMTCaliblib       = $(PMTCaliblibname).a
PMTCalibstamp     = $(bin)PMTCalib.stamp
PMTCalibshstamp   = $(bin)PMTCalib.shstamp

PMTCalib :: dirs  PMTCalibLIB
	$(echo) "PMTCalib ok"

cmt_PMTCalib_has_prototypes = 1

#--------------------------------------

ifdef cmt_PMTCalib_has_prototypes

PMTCalibprototype :  ;

endif

PMTCalibcompile : $(bin)PMTCalib.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

PMTCalibLIB :: $(PMTCaliblib) $(PMTCalibshstamp)
	$(echo) "PMTCalib : library ok"

$(PMTCaliblib) :: $(bin)PMTCalib.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(PMTCaliblib) $(bin)PMTCalib.o
	$(lib_silent) $(ranlib) $(PMTCaliblib)
	$(lib_silent) cat /dev/null >$(PMTCalibstamp)

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

$(PMTCaliblibname).$(shlibsuffix) :: $(PMTCaliblib) requirements $(use_requirements) $(PMTCalibstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" PMTCalib $(PMTCalib_shlibflags)
	$(lib_silent) cat /dev/null >$(PMTCalibshstamp)

$(PMTCalibshstamp) :: $(PMTCaliblibname).$(shlibsuffix)
	$(lib_silent) if test -f $(PMTCaliblibname).$(shlibsuffix) ; then cat /dev/null >$(PMTCalibshstamp) ; fi

PMTCalibclean ::
	$(cleanup_echo) objects PMTCalib
	$(cleanup_silent) /bin/rm -f $(bin)PMTCalib.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PMTCalib.o) $(patsubst %.o,%.dep,$(bin)PMTCalib.o) $(patsubst %.o,%.d.stamp,$(bin)PMTCalib.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf PMTCalib_deps PMTCalib_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
PMTCalibinstallname = $(library_prefix)PMTCalib$(library_suffix).$(shlibsuffix)

PMTCalib :: PMTCalibinstall ;

install :: PMTCalibinstall ;

PMTCalibinstall :: $(install_dir)/$(PMTCalibinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(PMTCalibinstallname) :: $(bin)$(PMTCalibinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PMTCalibinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##PMTCalibclean :: PMTCalibuninstall

uninstall :: PMTCalibuninstall ;

PMTCalibuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PMTCalibinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),PMTCalibclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),PMTCalibprototype)

$(bin)PMTCalib_dependencies.make : $(use_requirements) $(cmt_final_setup_PMTCalib)
	$(echo) "(PMTCalib.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)PMTCalib.cc -end_all $(includes) $(app_PMTCalib_cppflags) $(lib_PMTCalib_cppflags) -name=PMTCalib $? -f=$(cmt_dependencies_in_PMTCalib) -without_cmt

-include $(bin)PMTCalib_dependencies.make

endif
endif
endif

PMTCalibclean ::
	$(cleanup_silent) \rm -rf $(bin)PMTCalib_deps $(bin)PMTCalib_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PMTCalibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PMTCalib.d

$(bin)$(binobj)PMTCalib.d :

$(bin)$(binobj)PMTCalib.o : $(cmt_final_setup_PMTCalib)

$(bin)$(binobj)PMTCalib.o : $(src)PMTCalib.cc
	$(cpp_echo) $(src)PMTCalib.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PMTCalib_pp_cppflags) $(lib_PMTCalib_pp_cppflags) $(PMTCalib_pp_cppflags) $(use_cppflags) $(PMTCalib_cppflags) $(lib_PMTCalib_cppflags) $(PMTCalib_cppflags) $(PMTCalib_cc_cppflags)  $(src)PMTCalib.cc
endif
endif

else
$(bin)PMTCalib_dependencies.make : $(PMTCalib_cc_dependencies)

$(bin)PMTCalib_dependencies.make : $(src)PMTCalib.cc

$(bin)$(binobj)PMTCalib.o : $(PMTCalib_cc_dependencies)
	$(cpp_echo) $(src)PMTCalib.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PMTCalib_pp_cppflags) $(lib_PMTCalib_pp_cppflags) $(PMTCalib_pp_cppflags) $(use_cppflags) $(PMTCalib_cppflags) $(lib_PMTCalib_cppflags) $(PMTCalib_cppflags) $(PMTCalib_cc_cppflags)  $(src)PMTCalib.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: PMTCalibclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PMTCalib.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PMTCalibclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library PMTCalib
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)PMTCalib$(library_suffix).a $(library_prefix)PMTCalib$(library_suffix).$(shlibsuffix) PMTCalib.stamp PMTCalib.shstamp
#-- end of cleanup_library ---------------

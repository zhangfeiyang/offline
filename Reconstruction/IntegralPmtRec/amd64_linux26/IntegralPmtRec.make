#-- start of make_header -----------------

#====================================
#  Library IntegralPmtRec
#
#   Generated Fri Jul 10 19:21:05 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_IntegralPmtRec_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_IntegralPmtRec_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_IntegralPmtRec

IntegralPmtRec_tag = $(tag)

#cmt_local_tagfile_IntegralPmtRec = $(IntegralPmtRec_tag)_IntegralPmtRec.make
cmt_local_tagfile_IntegralPmtRec = $(bin)$(IntegralPmtRec_tag)_IntegralPmtRec.make

else

tags      = $(tag),$(CMTEXTRATAGS)

IntegralPmtRec_tag = $(tag)

#cmt_local_tagfile_IntegralPmtRec = $(IntegralPmtRec_tag).make
cmt_local_tagfile_IntegralPmtRec = $(bin)$(IntegralPmtRec_tag).make

endif

include $(cmt_local_tagfile_IntegralPmtRec)
#-include $(cmt_local_tagfile_IntegralPmtRec)

ifdef cmt_IntegralPmtRec_has_target_tag

cmt_final_setup_IntegralPmtRec = $(bin)setup_IntegralPmtRec.make
cmt_dependencies_in_IntegralPmtRec = $(bin)dependencies_IntegralPmtRec.in
#cmt_final_setup_IntegralPmtRec = $(bin)IntegralPmtRec_IntegralPmtRecsetup.make
cmt_local_IntegralPmtRec_makefile = $(bin)IntegralPmtRec.make

else

cmt_final_setup_IntegralPmtRec = $(bin)setup.make
cmt_dependencies_in_IntegralPmtRec = $(bin)dependencies.in
#cmt_final_setup_IntegralPmtRec = $(bin)IntegralPmtRecsetup.make
cmt_local_IntegralPmtRec_makefile = $(bin)IntegralPmtRec.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)IntegralPmtRecsetup.make

#IntegralPmtRec :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'IntegralPmtRec'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = IntegralPmtRec/
#IntegralPmtRec::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

IntegralPmtReclibname   = $(bin)$(library_prefix)IntegralPmtRec$(library_suffix)
IntegralPmtReclib       = $(IntegralPmtReclibname).a
IntegralPmtRecstamp     = $(bin)IntegralPmtRec.stamp
IntegralPmtRecshstamp   = $(bin)IntegralPmtRec.shstamp

IntegralPmtRec :: dirs  IntegralPmtRecLIB
	$(echo) "IntegralPmtRec ok"

cmt_IntegralPmtRec_has_prototypes = 1

#--------------------------------------

ifdef cmt_IntegralPmtRec_has_prototypes

IntegralPmtRecprototype :  ;

endif

IntegralPmtReccompile : $(bin)IntegralPmtRec.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

IntegralPmtRecLIB :: $(IntegralPmtReclib) $(IntegralPmtRecshstamp)
	$(echo) "IntegralPmtRec : library ok"

$(IntegralPmtReclib) :: $(bin)IntegralPmtRec.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(IntegralPmtReclib) $(bin)IntegralPmtRec.o
	$(lib_silent) $(ranlib) $(IntegralPmtReclib)
	$(lib_silent) cat /dev/null >$(IntegralPmtRecstamp)

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

$(IntegralPmtReclibname).$(shlibsuffix) :: $(IntegralPmtReclib) requirements $(use_requirements) $(IntegralPmtRecstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" IntegralPmtRec $(IntegralPmtRec_shlibflags)
	$(lib_silent) cat /dev/null >$(IntegralPmtRecshstamp)

$(IntegralPmtRecshstamp) :: $(IntegralPmtReclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(IntegralPmtReclibname).$(shlibsuffix) ; then cat /dev/null >$(IntegralPmtRecshstamp) ; fi

IntegralPmtRecclean ::
	$(cleanup_echo) objects IntegralPmtRec
	$(cleanup_silent) /bin/rm -f $(bin)IntegralPmtRec.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)IntegralPmtRec.o) $(patsubst %.o,%.dep,$(bin)IntegralPmtRec.o) $(patsubst %.o,%.d.stamp,$(bin)IntegralPmtRec.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf IntegralPmtRec_deps IntegralPmtRec_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
IntegralPmtRecinstallname = $(library_prefix)IntegralPmtRec$(library_suffix).$(shlibsuffix)

IntegralPmtRec :: IntegralPmtRecinstall ;

install :: IntegralPmtRecinstall ;

IntegralPmtRecinstall :: $(install_dir)/$(IntegralPmtRecinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(IntegralPmtRecinstallname) :: $(bin)$(IntegralPmtRecinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(IntegralPmtRecinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##IntegralPmtRecclean :: IntegralPmtRecuninstall

uninstall :: IntegralPmtRecuninstall ;

IntegralPmtRecuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(IntegralPmtRecinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),IntegralPmtRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),IntegralPmtRecprototype)

$(bin)IntegralPmtRec_dependencies.make : $(use_requirements) $(cmt_final_setup_IntegralPmtRec)
	$(echo) "(IntegralPmtRec.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)IntegralPmtRec.cc -end_all $(includes) $(app_IntegralPmtRec_cppflags) $(lib_IntegralPmtRec_cppflags) -name=IntegralPmtRec $? -f=$(cmt_dependencies_in_IntegralPmtRec) -without_cmt

-include $(bin)IntegralPmtRec_dependencies.make

endif
endif
endif

IntegralPmtRecclean ::
	$(cleanup_silent) \rm -rf $(bin)IntegralPmtRec_deps $(bin)IntegralPmtRec_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),IntegralPmtRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IntegralPmtRec.d

$(bin)$(binobj)IntegralPmtRec.d :

$(bin)$(binobj)IntegralPmtRec.o : $(cmt_final_setup_IntegralPmtRec)

$(bin)$(binobj)IntegralPmtRec.o : $(src)IntegralPmtRec.cc
	$(cpp_echo) $(src)IntegralPmtRec.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(IntegralPmtRec_pp_cppflags) $(lib_IntegralPmtRec_pp_cppflags) $(IntegralPmtRec_pp_cppflags) $(use_cppflags) $(IntegralPmtRec_cppflags) $(lib_IntegralPmtRec_cppflags) $(IntegralPmtRec_cppflags) $(IntegralPmtRec_cc_cppflags)  $(src)IntegralPmtRec.cc
endif
endif

else
$(bin)IntegralPmtRec_dependencies.make : $(IntegralPmtRec_cc_dependencies)

$(bin)IntegralPmtRec_dependencies.make : $(src)IntegralPmtRec.cc

$(bin)$(binobj)IntegralPmtRec.o : $(IntegralPmtRec_cc_dependencies)
	$(cpp_echo) $(src)IntegralPmtRec.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(IntegralPmtRec_pp_cppflags) $(lib_IntegralPmtRec_pp_cppflags) $(IntegralPmtRec_pp_cppflags) $(use_cppflags) $(IntegralPmtRec_cppflags) $(lib_IntegralPmtRec_cppflags) $(IntegralPmtRec_cppflags) $(IntegralPmtRec_cc_cppflags)  $(src)IntegralPmtRec.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: IntegralPmtRecclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(IntegralPmtRec.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

IntegralPmtRecclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library IntegralPmtRec
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)IntegralPmtRec$(library_suffix).a $(library_prefix)IntegralPmtRec$(library_suffix).$(shlibsuffix) IntegralPmtRec.stamp IntegralPmtRec.shstamp
#-- end of cleanup_library ---------------

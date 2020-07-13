#-- start of make_header -----------------

#====================================
#  Library OMILREC
#
#   Generated Fri Jul 10 19:20:03 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_OMILREC_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_OMILREC_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_OMILREC

OMILREC_tag = $(tag)

#cmt_local_tagfile_OMILREC = $(OMILREC_tag)_OMILREC.make
cmt_local_tagfile_OMILREC = $(bin)$(OMILREC_tag)_OMILREC.make

else

tags      = $(tag),$(CMTEXTRATAGS)

OMILREC_tag = $(tag)

#cmt_local_tagfile_OMILREC = $(OMILREC_tag).make
cmt_local_tagfile_OMILREC = $(bin)$(OMILREC_tag).make

endif

include $(cmt_local_tagfile_OMILREC)
#-include $(cmt_local_tagfile_OMILREC)

ifdef cmt_OMILREC_has_target_tag

cmt_final_setup_OMILREC = $(bin)setup_OMILREC.make
cmt_dependencies_in_OMILREC = $(bin)dependencies_OMILREC.in
#cmt_final_setup_OMILREC = $(bin)OMILREC_OMILRECsetup.make
cmt_local_OMILREC_makefile = $(bin)OMILREC.make

else

cmt_final_setup_OMILREC = $(bin)setup.make
cmt_dependencies_in_OMILREC = $(bin)dependencies.in
#cmt_final_setup_OMILREC = $(bin)OMILRECsetup.make
cmt_local_OMILREC_makefile = $(bin)OMILREC.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)OMILRECsetup.make

#OMILREC :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'OMILREC'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = OMILREC/
#OMILREC::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

OMILREClibname   = $(bin)$(library_prefix)OMILREC$(library_suffix)
OMILREClib       = $(OMILREClibname).a
OMILRECstamp     = $(bin)OMILREC.stamp
OMILRECshstamp   = $(bin)OMILREC.shstamp

OMILREC :: dirs  OMILRECLIB
	$(echo) "OMILREC ok"

cmt_OMILREC_has_prototypes = 1

#--------------------------------------

ifdef cmt_OMILREC_has_prototypes

OMILRECprototype :  ;

endif

OMILRECcompile : $(bin)OMILREC.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

OMILRECLIB :: $(OMILREClib) $(OMILRECshstamp)
	$(echo) "OMILREC : library ok"

$(OMILREClib) :: $(bin)OMILREC.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(OMILREClib) $(bin)OMILREC.o
	$(lib_silent) $(ranlib) $(OMILREClib)
	$(lib_silent) cat /dev/null >$(OMILRECstamp)

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

$(OMILREClibname).$(shlibsuffix) :: $(OMILREClib) requirements $(use_requirements) $(OMILRECstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" OMILREC $(OMILREC_shlibflags)
	$(lib_silent) cat /dev/null >$(OMILRECshstamp)

$(OMILRECshstamp) :: $(OMILREClibname).$(shlibsuffix)
	$(lib_silent) if test -f $(OMILREClibname).$(shlibsuffix) ; then cat /dev/null >$(OMILRECshstamp) ; fi

OMILRECclean ::
	$(cleanup_echo) objects OMILREC
	$(cleanup_silent) /bin/rm -f $(bin)OMILREC.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)OMILREC.o) $(patsubst %.o,%.dep,$(bin)OMILREC.o) $(patsubst %.o,%.d.stamp,$(bin)OMILREC.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf OMILREC_deps OMILREC_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
OMILRECinstallname = $(library_prefix)OMILREC$(library_suffix).$(shlibsuffix)

OMILREC :: OMILRECinstall ;

install :: OMILRECinstall ;

OMILRECinstall :: $(install_dir)/$(OMILRECinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(OMILRECinstallname) :: $(bin)$(OMILRECinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(OMILRECinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##OMILRECclean :: OMILRECuninstall

uninstall :: OMILRECuninstall ;

OMILRECuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(OMILRECinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),OMILRECclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),OMILRECprototype)

$(bin)OMILREC_dependencies.make : $(use_requirements) $(cmt_final_setup_OMILREC)
	$(echo) "(OMILREC.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)OMILREC.cc -end_all $(includes) $(app_OMILREC_cppflags) $(lib_OMILREC_cppflags) -name=OMILREC $? -f=$(cmt_dependencies_in_OMILREC) -without_cmt

-include $(bin)OMILREC_dependencies.make

endif
endif
endif

OMILRECclean ::
	$(cleanup_silent) \rm -rf $(bin)OMILREC_deps $(bin)OMILREC_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),OMILRECclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)OMILREC.d

$(bin)$(binobj)OMILREC.d :

$(bin)$(binobj)OMILREC.o : $(cmt_final_setup_OMILREC)

$(bin)$(binobj)OMILREC.o : $(src)OMILREC.cc
	$(cpp_echo) $(src)OMILREC.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(OMILREC_pp_cppflags) $(lib_OMILREC_pp_cppflags) $(OMILREC_pp_cppflags) $(use_cppflags) $(OMILREC_cppflags) $(lib_OMILREC_cppflags) $(OMILREC_cppflags) $(OMILREC_cc_cppflags)  $(src)OMILREC.cc
endif
endif

else
$(bin)OMILREC_dependencies.make : $(OMILREC_cc_dependencies)

$(bin)OMILREC_dependencies.make : $(src)OMILREC.cc

$(bin)$(binobj)OMILREC.o : $(OMILREC_cc_dependencies)
	$(cpp_echo) $(src)OMILREC.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(OMILREC_pp_cppflags) $(lib_OMILREC_pp_cppflags) $(OMILREC_pp_cppflags) $(use_cppflags) $(OMILREC_cppflags) $(lib_OMILREC_cppflags) $(OMILREC_cppflags) $(OMILREC_cc_cppflags)  $(src)OMILREC.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: OMILRECclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(OMILREC.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

OMILRECclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library OMILREC
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)OMILREC$(library_suffix).a $(library_prefix)OMILREC$(library_suffix).$(shlibsuffix) OMILREC.stamp OMILREC.shstamp
#-- end of cleanup_library ---------------

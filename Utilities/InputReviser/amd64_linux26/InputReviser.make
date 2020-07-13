#-- start of make_header -----------------

#====================================
#  Library InputReviser
#
#   Generated Fri Jul 10 19:18:35 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_InputReviser_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_InputReviser_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_InputReviser

InputReviser_tag = $(tag)

#cmt_local_tagfile_InputReviser = $(InputReviser_tag)_InputReviser.make
cmt_local_tagfile_InputReviser = $(bin)$(InputReviser_tag)_InputReviser.make

else

tags      = $(tag),$(CMTEXTRATAGS)

InputReviser_tag = $(tag)

#cmt_local_tagfile_InputReviser = $(InputReviser_tag).make
cmt_local_tagfile_InputReviser = $(bin)$(InputReviser_tag).make

endif

include $(cmt_local_tagfile_InputReviser)
#-include $(cmt_local_tagfile_InputReviser)

ifdef cmt_InputReviser_has_target_tag

cmt_final_setup_InputReviser = $(bin)setup_InputReviser.make
cmt_dependencies_in_InputReviser = $(bin)dependencies_InputReviser.in
#cmt_final_setup_InputReviser = $(bin)InputReviser_InputRevisersetup.make
cmt_local_InputReviser_makefile = $(bin)InputReviser.make

else

cmt_final_setup_InputReviser = $(bin)setup.make
cmt_dependencies_in_InputReviser = $(bin)dependencies.in
#cmt_final_setup_InputReviser = $(bin)InputRevisersetup.make
cmt_local_InputReviser_makefile = $(bin)InputReviser.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)InputRevisersetup.make

#InputReviser :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'InputReviser'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = InputReviser/
#InputReviser::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

InputReviserlibname   = $(bin)$(library_prefix)InputReviser$(library_suffix)
InputReviserlib       = $(InputReviserlibname).a
InputReviserstamp     = $(bin)InputReviser.stamp
InputRevisershstamp   = $(bin)InputReviser.shstamp

InputReviser :: dirs  InputReviserLIB
	$(echo) "InputReviser ok"

cmt_InputReviser_has_prototypes = 1

#--------------------------------------

ifdef cmt_InputReviser_has_prototypes

InputReviserprototype :  ;

endif

InputRevisercompile : $(bin)InputReviser.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

InputReviserLIB :: $(InputReviserlib) $(InputRevisershstamp)
	$(echo) "InputReviser : library ok"

$(InputReviserlib) :: $(bin)InputReviser.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(InputReviserlib) $(bin)InputReviser.o
	$(lib_silent) $(ranlib) $(InputReviserlib)
	$(lib_silent) cat /dev/null >$(InputReviserstamp)

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

$(InputReviserlibname).$(shlibsuffix) :: $(InputReviserlib) requirements $(use_requirements) $(InputReviserstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" InputReviser $(InputReviser_shlibflags)
	$(lib_silent) cat /dev/null >$(InputRevisershstamp)

$(InputRevisershstamp) :: $(InputReviserlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(InputReviserlibname).$(shlibsuffix) ; then cat /dev/null >$(InputRevisershstamp) ; fi

InputReviserclean ::
	$(cleanup_echo) objects InputReviser
	$(cleanup_silent) /bin/rm -f $(bin)InputReviser.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)InputReviser.o) $(patsubst %.o,%.dep,$(bin)InputReviser.o) $(patsubst %.o,%.d.stamp,$(bin)InputReviser.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf InputReviser_deps InputReviser_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
InputReviserinstallname = $(library_prefix)InputReviser$(library_suffix).$(shlibsuffix)

InputReviser :: InputReviserinstall ;

install :: InputReviserinstall ;

InputReviserinstall :: $(install_dir)/$(InputReviserinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(InputReviserinstallname) :: $(bin)$(InputReviserinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(InputReviserinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##InputReviserclean :: InputReviseruninstall

uninstall :: InputReviseruninstall ;

InputReviseruninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(InputReviserinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),InputReviserclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),InputReviserprototype)

$(bin)InputReviser_dependencies.make : $(use_requirements) $(cmt_final_setup_InputReviser)
	$(echo) "(InputReviser.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)InputReviser.cc -end_all $(includes) $(app_InputReviser_cppflags) $(lib_InputReviser_cppflags) -name=InputReviser $? -f=$(cmt_dependencies_in_InputReviser) -without_cmt

-include $(bin)InputReviser_dependencies.make

endif
endif
endif

InputReviserclean ::
	$(cleanup_silent) \rm -rf $(bin)InputReviser_deps $(bin)InputReviser_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),InputReviserclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)InputReviser.d

$(bin)$(binobj)InputReviser.d :

$(bin)$(binobj)InputReviser.o : $(cmt_final_setup_InputReviser)

$(bin)$(binobj)InputReviser.o : $(src)InputReviser.cc
	$(cpp_echo) $(src)InputReviser.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(InputReviser_pp_cppflags) $(lib_InputReviser_pp_cppflags) $(InputReviser_pp_cppflags) $(use_cppflags) $(InputReviser_cppflags) $(lib_InputReviser_cppflags) $(InputReviser_cppflags) $(InputReviser_cc_cppflags)  $(src)InputReviser.cc
endif
endif

else
$(bin)InputReviser_dependencies.make : $(InputReviser_cc_dependencies)

$(bin)InputReviser_dependencies.make : $(src)InputReviser.cc

$(bin)$(binobj)InputReviser.o : $(InputReviser_cc_dependencies)
	$(cpp_echo) $(src)InputReviser.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(InputReviser_pp_cppflags) $(lib_InputReviser_pp_cppflags) $(InputReviser_pp_cppflags) $(use_cppflags) $(InputReviser_cppflags) $(lib_InputReviser_cppflags) $(InputReviser_cppflags) $(InputReviser_cc_cppflags)  $(src)InputReviser.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: InputReviserclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(InputReviser.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

InputReviserclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library InputReviser
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)InputReviser$(library_suffix).a $(library_prefix)InputReviser$(library_suffix).$(shlibsuffix) InputReviser.stamp InputReviser.shstamp
#-- end of cleanup_library ---------------

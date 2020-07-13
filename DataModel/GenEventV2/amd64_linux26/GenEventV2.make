#-- start of make_header -----------------

#====================================
#  Library GenEventV2
#
#   Generated Fri Jul 10 19:24:47 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GenEventV2_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GenEventV2_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GenEventV2

GenEventV2_tag = $(tag)

#cmt_local_tagfile_GenEventV2 = $(GenEventV2_tag)_GenEventV2.make
cmt_local_tagfile_GenEventV2 = $(bin)$(GenEventV2_tag)_GenEventV2.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GenEventV2_tag = $(tag)

#cmt_local_tagfile_GenEventV2 = $(GenEventV2_tag).make
cmt_local_tagfile_GenEventV2 = $(bin)$(GenEventV2_tag).make

endif

include $(cmt_local_tagfile_GenEventV2)
#-include $(cmt_local_tagfile_GenEventV2)

ifdef cmt_GenEventV2_has_target_tag

cmt_final_setup_GenEventV2 = $(bin)setup_GenEventV2.make
cmt_dependencies_in_GenEventV2 = $(bin)dependencies_GenEventV2.in
#cmt_final_setup_GenEventV2 = $(bin)GenEventV2_GenEventV2setup.make
cmt_local_GenEventV2_makefile = $(bin)GenEventV2.make

else

cmt_final_setup_GenEventV2 = $(bin)setup.make
cmt_dependencies_in_GenEventV2 = $(bin)dependencies.in
#cmt_final_setup_GenEventV2 = $(bin)GenEventV2setup.make
cmt_local_GenEventV2_makefile = $(bin)GenEventV2.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GenEventV2setup.make

#GenEventV2 :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GenEventV2'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GenEventV2/
#GenEventV2::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GenEventV2libname   = $(bin)$(library_prefix)GenEventV2$(library_suffix)
GenEventV2lib       = $(GenEventV2libname).a
GenEventV2stamp     = $(bin)GenEventV2.stamp
GenEventV2shstamp   = $(bin)GenEventV2.shstamp

GenEventV2 :: dirs  GenEventV2LIB
	$(echo) "GenEventV2 ok"

cmt_GenEventV2_has_prototypes = 1

#--------------------------------------

ifdef cmt_GenEventV2_has_prototypes

GenEventV2prototype :  ;

endif

GenEventV2compile : $(bin)GenHeaderDict.o $(bin)GenEvent.o $(bin)GenHeader.o $(bin)GenEventDict.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

GenEventV2LIB :: $(GenEventV2lib) $(GenEventV2shstamp)
	$(echo) "GenEventV2 : library ok"

$(GenEventV2lib) :: $(bin)GenHeaderDict.o $(bin)GenEvent.o $(bin)GenHeader.o $(bin)GenEventDict.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(GenEventV2lib) $(bin)GenHeaderDict.o $(bin)GenEvent.o $(bin)GenHeader.o $(bin)GenEventDict.o
	$(lib_silent) $(ranlib) $(GenEventV2lib)
	$(lib_silent) cat /dev/null >$(GenEventV2stamp)

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

$(GenEventV2libname).$(shlibsuffix) :: $(GenEventV2lib) requirements $(use_requirements) $(GenEventV2stamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" GenEventV2 $(GenEventV2_shlibflags)
	$(lib_silent) cat /dev/null >$(GenEventV2shstamp)

$(GenEventV2shstamp) :: $(GenEventV2libname).$(shlibsuffix)
	$(lib_silent) if test -f $(GenEventV2libname).$(shlibsuffix) ; then cat /dev/null >$(GenEventV2shstamp) ; fi

GenEventV2clean ::
	$(cleanup_echo) objects GenEventV2
	$(cleanup_silent) /bin/rm -f $(bin)GenHeaderDict.o $(bin)GenEvent.o $(bin)GenHeader.o $(bin)GenEventDict.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)GenHeaderDict.o $(bin)GenEvent.o $(bin)GenHeader.o $(bin)GenEventDict.o) $(patsubst %.o,%.dep,$(bin)GenHeaderDict.o $(bin)GenEvent.o $(bin)GenHeader.o $(bin)GenEventDict.o) $(patsubst %.o,%.d.stamp,$(bin)GenHeaderDict.o $(bin)GenEvent.o $(bin)GenHeader.o $(bin)GenEventDict.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GenEventV2_deps GenEventV2_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GenEventV2installname = $(library_prefix)GenEventV2$(library_suffix).$(shlibsuffix)

GenEventV2 :: GenEventV2install ;

install :: GenEventV2install ;

GenEventV2install :: $(install_dir)/$(GenEventV2installname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GenEventV2installname) :: $(bin)$(GenEventV2installname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GenEventV2installname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GenEventV2clean :: GenEventV2uninstall

uninstall :: GenEventV2uninstall ;

GenEventV2uninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GenEventV2installname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),GenEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),GenEventV2prototype)

$(bin)GenEventV2_dependencies.make : $(use_requirements) $(cmt_final_setup_GenEventV2)
	$(echo) "(GenEventV2.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)GenHeaderDict.cc $(src)GenEvent.cc $(src)GenHeader.cc $(src)GenEventDict.cc -end_all $(includes) $(app_GenEventV2_cppflags) $(lib_GenEventV2_cppflags) -name=GenEventV2 $? -f=$(cmt_dependencies_in_GenEventV2) -without_cmt

-include $(bin)GenEventV2_dependencies.make

endif
endif
endif

GenEventV2clean ::
	$(cleanup_silent) \rm -rf $(bin)GenEventV2_deps $(bin)GenEventV2_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GenHeaderDict.d

$(bin)$(binobj)GenHeaderDict.d :

$(bin)$(binobj)GenHeaderDict.o : $(cmt_final_setup_GenEventV2)

$(bin)$(binobj)GenHeaderDict.o : $(src)GenHeaderDict.cc
	$(cpp_echo) $(src)GenHeaderDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenEventV2_pp_cppflags) $(lib_GenEventV2_pp_cppflags) $(GenHeaderDict_pp_cppflags) $(use_cppflags) $(GenEventV2_cppflags) $(lib_GenEventV2_cppflags) $(GenHeaderDict_cppflags) $(GenHeaderDict_cc_cppflags)  $(src)GenHeaderDict.cc
endif
endif

else
$(bin)GenEventV2_dependencies.make : $(GenHeaderDict_cc_dependencies)

$(bin)GenEventV2_dependencies.make : $(src)GenHeaderDict.cc

$(bin)$(binobj)GenHeaderDict.o : $(GenHeaderDict_cc_dependencies)
	$(cpp_echo) $(src)GenHeaderDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenEventV2_pp_cppflags) $(lib_GenEventV2_pp_cppflags) $(GenHeaderDict_pp_cppflags) $(use_cppflags) $(GenEventV2_cppflags) $(lib_GenEventV2_cppflags) $(GenHeaderDict_cppflags) $(GenHeaderDict_cc_cppflags)  $(src)GenHeaderDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GenEvent.d

$(bin)$(binobj)GenEvent.d :

$(bin)$(binobj)GenEvent.o : $(cmt_final_setup_GenEventV2)

$(bin)$(binobj)GenEvent.o : $(src)GenEvent.cc
	$(cpp_echo) $(src)GenEvent.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenEventV2_pp_cppflags) $(lib_GenEventV2_pp_cppflags) $(GenEvent_pp_cppflags) $(use_cppflags) $(GenEventV2_cppflags) $(lib_GenEventV2_cppflags) $(GenEvent_cppflags) $(GenEvent_cc_cppflags)  $(src)GenEvent.cc
endif
endif

else
$(bin)GenEventV2_dependencies.make : $(GenEvent_cc_dependencies)

$(bin)GenEventV2_dependencies.make : $(src)GenEvent.cc

$(bin)$(binobj)GenEvent.o : $(GenEvent_cc_dependencies)
	$(cpp_echo) $(src)GenEvent.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenEventV2_pp_cppflags) $(lib_GenEventV2_pp_cppflags) $(GenEvent_pp_cppflags) $(use_cppflags) $(GenEventV2_cppflags) $(lib_GenEventV2_cppflags) $(GenEvent_cppflags) $(GenEvent_cc_cppflags)  $(src)GenEvent.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GenHeader.d

$(bin)$(binobj)GenHeader.d :

$(bin)$(binobj)GenHeader.o : $(cmt_final_setup_GenEventV2)

$(bin)$(binobj)GenHeader.o : $(src)GenHeader.cc
	$(cpp_echo) $(src)GenHeader.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenEventV2_pp_cppflags) $(lib_GenEventV2_pp_cppflags) $(GenHeader_pp_cppflags) $(use_cppflags) $(GenEventV2_cppflags) $(lib_GenEventV2_cppflags) $(GenHeader_cppflags) $(GenHeader_cc_cppflags)  $(src)GenHeader.cc
endif
endif

else
$(bin)GenEventV2_dependencies.make : $(GenHeader_cc_dependencies)

$(bin)GenEventV2_dependencies.make : $(src)GenHeader.cc

$(bin)$(binobj)GenHeader.o : $(GenHeader_cc_dependencies)
	$(cpp_echo) $(src)GenHeader.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenEventV2_pp_cppflags) $(lib_GenEventV2_pp_cppflags) $(GenHeader_pp_cppflags) $(use_cppflags) $(GenEventV2_cppflags) $(lib_GenEventV2_cppflags) $(GenHeader_cppflags) $(GenHeader_cc_cppflags)  $(src)GenHeader.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenEventV2clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GenEventDict.d

$(bin)$(binobj)GenEventDict.d :

$(bin)$(binobj)GenEventDict.o : $(cmt_final_setup_GenEventV2)

$(bin)$(binobj)GenEventDict.o : $(src)GenEventDict.cc
	$(cpp_echo) $(src)GenEventDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenEventV2_pp_cppflags) $(lib_GenEventV2_pp_cppflags) $(GenEventDict_pp_cppflags) $(use_cppflags) $(GenEventV2_cppflags) $(lib_GenEventV2_cppflags) $(GenEventDict_cppflags) $(GenEventDict_cc_cppflags)  $(src)GenEventDict.cc
endif
endif

else
$(bin)GenEventV2_dependencies.make : $(GenEventDict_cc_dependencies)

$(bin)GenEventV2_dependencies.make : $(src)GenEventDict.cc

$(bin)$(binobj)GenEventDict.o : $(GenEventDict_cc_dependencies)
	$(cpp_echo) $(src)GenEventDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenEventV2_pp_cppflags) $(lib_GenEventV2_pp_cppflags) $(GenEventDict_pp_cppflags) $(use_cppflags) $(GenEventV2_cppflags) $(lib_GenEventV2_cppflags) $(GenEventDict_cppflags) $(GenEventDict_cc_cppflags)  $(src)GenEventDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GenEventV2clean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GenEventV2.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GenEventV2clean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GenEventV2
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GenEventV2$(library_suffix).a $(library_prefix)GenEventV2$(library_suffix).$(shlibsuffix) GenEventV2.stamp GenEventV2.shstamp
#-- end of cleanup_library ---------------

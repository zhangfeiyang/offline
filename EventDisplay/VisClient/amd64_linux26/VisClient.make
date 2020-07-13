#-- start of make_header -----------------

#====================================
#  Library VisClient
#
#   Generated Fri Jul 10 19:21:47 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_VisClient_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_VisClient_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_VisClient

VisClient_tag = $(tag)

#cmt_local_tagfile_VisClient = $(VisClient_tag)_VisClient.make
cmt_local_tagfile_VisClient = $(bin)$(VisClient_tag)_VisClient.make

else

tags      = $(tag),$(CMTEXTRATAGS)

VisClient_tag = $(tag)

#cmt_local_tagfile_VisClient = $(VisClient_tag).make
cmt_local_tagfile_VisClient = $(bin)$(VisClient_tag).make

endif

include $(cmt_local_tagfile_VisClient)
#-include $(cmt_local_tagfile_VisClient)

ifdef cmt_VisClient_has_target_tag

cmt_final_setup_VisClient = $(bin)setup_VisClient.make
cmt_dependencies_in_VisClient = $(bin)dependencies_VisClient.in
#cmt_final_setup_VisClient = $(bin)VisClient_VisClientsetup.make
cmt_local_VisClient_makefile = $(bin)VisClient.make

else

cmt_final_setup_VisClient = $(bin)setup.make
cmt_dependencies_in_VisClient = $(bin)dependencies.in
#cmt_final_setup_VisClient = $(bin)VisClientsetup.make
cmt_local_VisClient_makefile = $(bin)VisClient.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)VisClientsetup.make

#VisClient :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'VisClient'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = VisClient/
#VisClient::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

VisClientlibname   = $(bin)$(library_prefix)VisClient$(library_suffix)
VisClientlib       = $(VisClientlibname).a
VisClientstamp     = $(bin)VisClient.stamp
VisClientshstamp   = $(bin)VisClient.shstamp

VisClient :: dirs  VisClientLIB
	$(echo) "VisClient ok"

cmt_VisClient_has_prototypes = 1

#--------------------------------------

ifdef cmt_VisClient_has_prototypes

VisClientprototype :  ;

endif

VisClientcompile : $(bin)VisHelp.o $(bin)VisClient.o $(bin)VisClientDict.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

VisClientLIB :: $(VisClientlib) $(VisClientshstamp)
	$(echo) "VisClient : library ok"

$(VisClientlib) :: $(bin)VisHelp.o $(bin)VisClient.o $(bin)VisClientDict.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(VisClientlib) $(bin)VisHelp.o $(bin)VisClient.o $(bin)VisClientDict.o
	$(lib_silent) $(ranlib) $(VisClientlib)
	$(lib_silent) cat /dev/null >$(VisClientstamp)

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

$(VisClientlibname).$(shlibsuffix) :: $(VisClientlib) requirements $(use_requirements) $(VisClientstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" VisClient $(VisClient_shlibflags)
	$(lib_silent) cat /dev/null >$(VisClientshstamp)

$(VisClientshstamp) :: $(VisClientlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(VisClientlibname).$(shlibsuffix) ; then cat /dev/null >$(VisClientshstamp) ; fi

VisClientclean ::
	$(cleanup_echo) objects VisClient
	$(cleanup_silent) /bin/rm -f $(bin)VisHelp.o $(bin)VisClient.o $(bin)VisClientDict.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)VisHelp.o $(bin)VisClient.o $(bin)VisClientDict.o) $(patsubst %.o,%.dep,$(bin)VisHelp.o $(bin)VisClient.o $(bin)VisClientDict.o) $(patsubst %.o,%.d.stamp,$(bin)VisHelp.o $(bin)VisClient.o $(bin)VisClientDict.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf VisClient_deps VisClient_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
VisClientinstallname = $(library_prefix)VisClient$(library_suffix).$(shlibsuffix)

VisClient :: VisClientinstall ;

install :: VisClientinstall ;

VisClientinstall :: $(install_dir)/$(VisClientinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(VisClientinstallname) :: $(bin)$(VisClientinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(VisClientinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##VisClientclean :: VisClientuninstall

uninstall :: VisClientuninstall ;

VisClientuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(VisClientinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),VisClientclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),VisClientprototype)

$(bin)VisClient_dependencies.make : $(use_requirements) $(cmt_final_setup_VisClient)
	$(echo) "(VisClient.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)VisHelp.cc $(src)VisClient.cc $(src)VisClientDict.cc -end_all $(includes) $(app_VisClient_cppflags) $(lib_VisClient_cppflags) -name=VisClient $? -f=$(cmt_dependencies_in_VisClient) -without_cmt

-include $(bin)VisClient_dependencies.make

endif
endif
endif

VisClientclean ::
	$(cleanup_silent) \rm -rf $(bin)VisClient_deps $(bin)VisClient_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),VisClientclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)VisHelp.d

$(bin)$(binobj)VisHelp.d :

$(bin)$(binobj)VisHelp.o : $(cmt_final_setup_VisClient)

$(bin)$(binobj)VisHelp.o : $(src)VisHelp.cc
	$(cpp_echo) $(src)VisHelp.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(VisClient_pp_cppflags) $(lib_VisClient_pp_cppflags) $(VisHelp_pp_cppflags) $(use_cppflags) $(VisClient_cppflags) $(lib_VisClient_cppflags) $(VisHelp_cppflags) $(VisHelp_cc_cppflags)  $(src)VisHelp.cc
endif
endif

else
$(bin)VisClient_dependencies.make : $(VisHelp_cc_dependencies)

$(bin)VisClient_dependencies.make : $(src)VisHelp.cc

$(bin)$(binobj)VisHelp.o : $(VisHelp_cc_dependencies)
	$(cpp_echo) $(src)VisHelp.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(VisClient_pp_cppflags) $(lib_VisClient_pp_cppflags) $(VisHelp_pp_cppflags) $(use_cppflags) $(VisClient_cppflags) $(lib_VisClient_cppflags) $(VisHelp_cppflags) $(VisHelp_cc_cppflags)  $(src)VisHelp.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),VisClientclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)VisClient.d

$(bin)$(binobj)VisClient.d :

$(bin)$(binobj)VisClient.o : $(cmt_final_setup_VisClient)

$(bin)$(binobj)VisClient.o : $(src)VisClient.cc
	$(cpp_echo) $(src)VisClient.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(VisClient_pp_cppflags) $(lib_VisClient_pp_cppflags) $(VisClient_pp_cppflags) $(use_cppflags) $(VisClient_cppflags) $(lib_VisClient_cppflags) $(VisClient_cppflags) $(VisClient_cc_cppflags)  $(src)VisClient.cc
endif
endif

else
$(bin)VisClient_dependencies.make : $(VisClient_cc_dependencies)

$(bin)VisClient_dependencies.make : $(src)VisClient.cc

$(bin)$(binobj)VisClient.o : $(VisClient_cc_dependencies)
	$(cpp_echo) $(src)VisClient.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(VisClient_pp_cppflags) $(lib_VisClient_pp_cppflags) $(VisClient_pp_cppflags) $(use_cppflags) $(VisClient_cppflags) $(lib_VisClient_cppflags) $(VisClient_cppflags) $(VisClient_cc_cppflags)  $(src)VisClient.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),VisClientclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)VisClientDict.d

$(bin)$(binobj)VisClientDict.d :

$(bin)$(binobj)VisClientDict.o : $(cmt_final_setup_VisClient)

$(bin)$(binobj)VisClientDict.o : $(src)VisClientDict.cc
	$(cpp_echo) $(src)VisClientDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(VisClient_pp_cppflags) $(lib_VisClient_pp_cppflags) $(VisClientDict_pp_cppflags) $(use_cppflags) $(VisClient_cppflags) $(lib_VisClient_cppflags) $(VisClientDict_cppflags) $(VisClientDict_cc_cppflags)  $(src)VisClientDict.cc
endif
endif

else
$(bin)VisClient_dependencies.make : $(VisClientDict_cc_dependencies)

$(bin)VisClient_dependencies.make : $(src)VisClientDict.cc

$(bin)$(binobj)VisClientDict.o : $(VisClientDict_cc_dependencies)
	$(cpp_echo) $(src)VisClientDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(VisClient_pp_cppflags) $(lib_VisClient_pp_cppflags) $(VisClientDict_pp_cppflags) $(use_cppflags) $(VisClient_cppflags) $(lib_VisClient_cppflags) $(VisClientDict_cppflags) $(VisClientDict_cc_cppflags)  $(src)VisClientDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: VisClientclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(VisClient.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

VisClientclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library VisClient
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)VisClient$(library_suffix).a $(library_prefix)VisClient$(library_suffix).$(shlibsuffix) VisClient.stamp VisClient.shstamp
#-- end of cleanup_library ---------------

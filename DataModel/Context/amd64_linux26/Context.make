#-- start of make_header -----------------

#====================================
#  Library Context
#
#   Generated Fri Jul 10 19:15:08 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Context_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Context_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Context

Context_tag = $(tag)

#cmt_local_tagfile_Context = $(Context_tag)_Context.make
cmt_local_tagfile_Context = $(bin)$(Context_tag)_Context.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Context_tag = $(tag)

#cmt_local_tagfile_Context = $(Context_tag).make
cmt_local_tagfile_Context = $(bin)$(Context_tag).make

endif

include $(cmt_local_tagfile_Context)
#-include $(cmt_local_tagfile_Context)

ifdef cmt_Context_has_target_tag

cmt_final_setup_Context = $(bin)setup_Context.make
cmt_dependencies_in_Context = $(bin)dependencies_Context.in
#cmt_final_setup_Context = $(bin)Context_Contextsetup.make
cmt_local_Context_makefile = $(bin)Context.make

else

cmt_final_setup_Context = $(bin)setup.make
cmt_dependencies_in_Context = $(bin)dependencies.in
#cmt_final_setup_Context = $(bin)Contextsetup.make
cmt_local_Context_makefile = $(bin)Context.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Contextsetup.make

#Context :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'Context'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Context/
#Context::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

Contextlibname   = $(bin)$(library_prefix)Context$(library_suffix)
Contextlib       = $(Contextlibname).a
Contextstamp     = $(bin)Context.stamp
Contextshstamp   = $(bin)Context.shstamp

Context :: dirs  ContextLIB
	$(echo) "Context ok"

cmt_Context_has_prototypes = 1

#--------------------------------------

ifdef cmt_Context_has_prototypes

Contextprototype :  ;

endif

Contextcompile : $(bin)TimeStampDict.o $(bin)TimeStamp.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

ContextLIB :: $(Contextlib) $(Contextshstamp)
	$(echo) "Context : library ok"

$(Contextlib) :: $(bin)TimeStampDict.o $(bin)TimeStamp.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(Contextlib) $(bin)TimeStampDict.o $(bin)TimeStamp.o
	$(lib_silent) $(ranlib) $(Contextlib)
	$(lib_silent) cat /dev/null >$(Contextstamp)

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

$(Contextlibname).$(shlibsuffix) :: $(Contextlib) requirements $(use_requirements) $(Contextstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" Context $(Context_shlibflags)
	$(lib_silent) cat /dev/null >$(Contextshstamp)

$(Contextshstamp) :: $(Contextlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(Contextlibname).$(shlibsuffix) ; then cat /dev/null >$(Contextshstamp) ; fi

Contextclean ::
	$(cleanup_echo) objects Context
	$(cleanup_silent) /bin/rm -f $(bin)TimeStampDict.o $(bin)TimeStamp.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)TimeStampDict.o $(bin)TimeStamp.o) $(patsubst %.o,%.dep,$(bin)TimeStampDict.o $(bin)TimeStamp.o) $(patsubst %.o,%.d.stamp,$(bin)TimeStampDict.o $(bin)TimeStamp.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf Context_deps Context_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
Contextinstallname = $(library_prefix)Context$(library_suffix).$(shlibsuffix)

Context :: Contextinstall ;

install :: Contextinstall ;

Contextinstall :: $(install_dir)/$(Contextinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(Contextinstallname) :: $(bin)$(Contextinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Contextinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##Contextclean :: Contextuninstall

uninstall :: Contextuninstall ;

Contextuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Contextinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),Contextclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),Contextprototype)

$(bin)Context_dependencies.make : $(use_requirements) $(cmt_final_setup_Context)
	$(echo) "(Context.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)TimeStampDict.cc $(src)TimeStamp.cc -end_all $(includes) $(app_Context_cppflags) $(lib_Context_cppflags) -name=Context $? -f=$(cmt_dependencies_in_Context) -without_cmt

-include $(bin)Context_dependencies.make

endif
endif
endif

Contextclean ::
	$(cleanup_silent) \rm -rf $(bin)Context_deps $(bin)Context_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Contextclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TimeStampDict.d

$(bin)$(binobj)TimeStampDict.d :

$(bin)$(binobj)TimeStampDict.o : $(cmt_final_setup_Context)

$(bin)$(binobj)TimeStampDict.o : $(src)TimeStampDict.cc
	$(cpp_echo) $(src)TimeStampDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Context_pp_cppflags) $(lib_Context_pp_cppflags) $(TimeStampDict_pp_cppflags) $(use_cppflags) $(Context_cppflags) $(lib_Context_cppflags) $(TimeStampDict_cppflags) $(TimeStampDict_cc_cppflags)  $(src)TimeStampDict.cc
endif
endif

else
$(bin)Context_dependencies.make : $(TimeStampDict_cc_dependencies)

$(bin)Context_dependencies.make : $(src)TimeStampDict.cc

$(bin)$(binobj)TimeStampDict.o : $(TimeStampDict_cc_dependencies)
	$(cpp_echo) $(src)TimeStampDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Context_pp_cppflags) $(lib_Context_pp_cppflags) $(TimeStampDict_pp_cppflags) $(use_cppflags) $(Context_cppflags) $(lib_Context_cppflags) $(TimeStampDict_cppflags) $(TimeStampDict_cc_cppflags)  $(src)TimeStampDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Contextclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TimeStamp.d

$(bin)$(binobj)TimeStamp.d :

$(bin)$(binobj)TimeStamp.o : $(cmt_final_setup_Context)

$(bin)$(binobj)TimeStamp.o : $(src)TimeStamp.cc
	$(cpp_echo) $(src)TimeStamp.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Context_pp_cppflags) $(lib_Context_pp_cppflags) $(TimeStamp_pp_cppflags) $(use_cppflags) $(Context_cppflags) $(lib_Context_cppflags) $(TimeStamp_cppflags) $(TimeStamp_cc_cppflags)  $(src)TimeStamp.cc
endif
endif

else
$(bin)Context_dependencies.make : $(TimeStamp_cc_dependencies)

$(bin)Context_dependencies.make : $(src)TimeStamp.cc

$(bin)$(binobj)TimeStamp.o : $(TimeStamp_cc_dependencies)
	$(cpp_echo) $(src)TimeStamp.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Context_pp_cppflags) $(lib_Context_pp_cppflags) $(TimeStamp_pp_cppflags) $(use_cppflags) $(Context_cppflags) $(lib_Context_cppflags) $(TimeStamp_cppflags) $(TimeStamp_cc_cppflags)  $(src)TimeStamp.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: Contextclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Context.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

Contextclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library Context
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)Context$(library_suffix).a $(library_prefix)Context$(library_suffix).$(shlibsuffix) Context.stamp Context.shstamp
#-- end of cleanup_library ---------------

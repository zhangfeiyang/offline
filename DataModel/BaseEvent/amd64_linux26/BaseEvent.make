#-- start of make_header -----------------

#====================================
#  Library BaseEvent
#
#   Generated Fri Jul 10 19:17:35 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_BaseEvent_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_BaseEvent_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_BaseEvent

BaseEvent_tag = $(tag)

#cmt_local_tagfile_BaseEvent = $(BaseEvent_tag)_BaseEvent.make
cmt_local_tagfile_BaseEvent = $(bin)$(BaseEvent_tag)_BaseEvent.make

else

tags      = $(tag),$(CMTEXTRATAGS)

BaseEvent_tag = $(tag)

#cmt_local_tagfile_BaseEvent = $(BaseEvent_tag).make
cmt_local_tagfile_BaseEvent = $(bin)$(BaseEvent_tag).make

endif

include $(cmt_local_tagfile_BaseEvent)
#-include $(cmt_local_tagfile_BaseEvent)

ifdef cmt_BaseEvent_has_target_tag

cmt_final_setup_BaseEvent = $(bin)setup_BaseEvent.make
cmt_dependencies_in_BaseEvent = $(bin)dependencies_BaseEvent.in
#cmt_final_setup_BaseEvent = $(bin)BaseEvent_BaseEventsetup.make
cmt_local_BaseEvent_makefile = $(bin)BaseEvent.make

else

cmt_final_setup_BaseEvent = $(bin)setup.make
cmt_dependencies_in_BaseEvent = $(bin)dependencies.in
#cmt_final_setup_BaseEvent = $(bin)BaseEventsetup.make
cmt_local_BaseEvent_makefile = $(bin)BaseEvent.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)BaseEventsetup.make

#BaseEvent :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'BaseEvent'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = BaseEvent/
#BaseEvent::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

BaseEventlibname   = $(bin)$(library_prefix)BaseEvent$(library_suffix)
BaseEventlib       = $(BaseEventlibname).a
BaseEventstamp     = $(bin)BaseEvent.stamp
BaseEventshstamp   = $(bin)BaseEvent.shstamp

BaseEvent :: dirs  BaseEventLIB
	$(echo) "BaseEvent ok"

cmt_BaseEvent_has_prototypes = 1

#--------------------------------------

ifdef cmt_BaseEvent_has_prototypes

BaseEventprototype :  ;

endif

BaseEventcompile : $(bin)HeaderObject.o $(bin)EventObject.o $(bin)HeaderObjectDict.o $(bin)EventObjectDict.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

BaseEventLIB :: $(BaseEventlib) $(BaseEventshstamp)
	$(echo) "BaseEvent : library ok"

$(BaseEventlib) :: $(bin)HeaderObject.o $(bin)EventObject.o $(bin)HeaderObjectDict.o $(bin)EventObjectDict.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(BaseEventlib) $(bin)HeaderObject.o $(bin)EventObject.o $(bin)HeaderObjectDict.o $(bin)EventObjectDict.o
	$(lib_silent) $(ranlib) $(BaseEventlib)
	$(lib_silent) cat /dev/null >$(BaseEventstamp)

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

$(BaseEventlibname).$(shlibsuffix) :: $(BaseEventlib) requirements $(use_requirements) $(BaseEventstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" BaseEvent $(BaseEvent_shlibflags)
	$(lib_silent) cat /dev/null >$(BaseEventshstamp)

$(BaseEventshstamp) :: $(BaseEventlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(BaseEventlibname).$(shlibsuffix) ; then cat /dev/null >$(BaseEventshstamp) ; fi

BaseEventclean ::
	$(cleanup_echo) objects BaseEvent
	$(cleanup_silent) /bin/rm -f $(bin)HeaderObject.o $(bin)EventObject.o $(bin)HeaderObjectDict.o $(bin)EventObjectDict.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)HeaderObject.o $(bin)EventObject.o $(bin)HeaderObjectDict.o $(bin)EventObjectDict.o) $(patsubst %.o,%.dep,$(bin)HeaderObject.o $(bin)EventObject.o $(bin)HeaderObjectDict.o $(bin)EventObjectDict.o) $(patsubst %.o,%.d.stamp,$(bin)HeaderObject.o $(bin)EventObject.o $(bin)HeaderObjectDict.o $(bin)EventObjectDict.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf BaseEvent_deps BaseEvent_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
BaseEventinstallname = $(library_prefix)BaseEvent$(library_suffix).$(shlibsuffix)

BaseEvent :: BaseEventinstall ;

install :: BaseEventinstall ;

BaseEventinstall :: $(install_dir)/$(BaseEventinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(BaseEventinstallname) :: $(bin)$(BaseEventinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(BaseEventinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##BaseEventclean :: BaseEventuninstall

uninstall :: BaseEventuninstall ;

BaseEventuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(BaseEventinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),BaseEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),BaseEventprototype)

$(bin)BaseEvent_dependencies.make : $(use_requirements) $(cmt_final_setup_BaseEvent)
	$(echo) "(BaseEvent.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)HeaderObject.cc $(src)EventObject.cc $(src)HeaderObjectDict.cc $(src)EventObjectDict.cc -end_all $(includes) $(app_BaseEvent_cppflags) $(lib_BaseEvent_cppflags) -name=BaseEvent $? -f=$(cmt_dependencies_in_BaseEvent) -without_cmt

-include $(bin)BaseEvent_dependencies.make

endif
endif
endif

BaseEventclean ::
	$(cleanup_silent) \rm -rf $(bin)BaseEvent_deps $(bin)BaseEvent_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),BaseEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HeaderObject.d

$(bin)$(binobj)HeaderObject.d :

$(bin)$(binobj)HeaderObject.o : $(cmt_final_setup_BaseEvent)

$(bin)$(binobj)HeaderObject.o : $(src)HeaderObject.cc
	$(cpp_echo) $(src)HeaderObject.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(BaseEvent_pp_cppflags) $(lib_BaseEvent_pp_cppflags) $(HeaderObject_pp_cppflags) $(use_cppflags) $(BaseEvent_cppflags) $(lib_BaseEvent_cppflags) $(HeaderObject_cppflags) $(HeaderObject_cc_cppflags)  $(src)HeaderObject.cc
endif
endif

else
$(bin)BaseEvent_dependencies.make : $(HeaderObject_cc_dependencies)

$(bin)BaseEvent_dependencies.make : $(src)HeaderObject.cc

$(bin)$(binobj)HeaderObject.o : $(HeaderObject_cc_dependencies)
	$(cpp_echo) $(src)HeaderObject.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BaseEvent_pp_cppflags) $(lib_BaseEvent_pp_cppflags) $(HeaderObject_pp_cppflags) $(use_cppflags) $(BaseEvent_cppflags) $(lib_BaseEvent_cppflags) $(HeaderObject_cppflags) $(HeaderObject_cc_cppflags)  $(src)HeaderObject.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),BaseEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EventObject.d

$(bin)$(binobj)EventObject.d :

$(bin)$(binobj)EventObject.o : $(cmt_final_setup_BaseEvent)

$(bin)$(binobj)EventObject.o : $(src)EventObject.cc
	$(cpp_echo) $(src)EventObject.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(BaseEvent_pp_cppflags) $(lib_BaseEvent_pp_cppflags) $(EventObject_pp_cppflags) $(use_cppflags) $(BaseEvent_cppflags) $(lib_BaseEvent_cppflags) $(EventObject_cppflags) $(EventObject_cc_cppflags)  $(src)EventObject.cc
endif
endif

else
$(bin)BaseEvent_dependencies.make : $(EventObject_cc_dependencies)

$(bin)BaseEvent_dependencies.make : $(src)EventObject.cc

$(bin)$(binobj)EventObject.o : $(EventObject_cc_dependencies)
	$(cpp_echo) $(src)EventObject.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BaseEvent_pp_cppflags) $(lib_BaseEvent_pp_cppflags) $(EventObject_pp_cppflags) $(use_cppflags) $(BaseEvent_cppflags) $(lib_BaseEvent_cppflags) $(EventObject_cppflags) $(EventObject_cc_cppflags)  $(src)EventObject.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),BaseEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HeaderObjectDict.d

$(bin)$(binobj)HeaderObjectDict.d :

$(bin)$(binobj)HeaderObjectDict.o : $(cmt_final_setup_BaseEvent)

$(bin)$(binobj)HeaderObjectDict.o : $(src)HeaderObjectDict.cc
	$(cpp_echo) $(src)HeaderObjectDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(BaseEvent_pp_cppflags) $(lib_BaseEvent_pp_cppflags) $(HeaderObjectDict_pp_cppflags) $(use_cppflags) $(BaseEvent_cppflags) $(lib_BaseEvent_cppflags) $(HeaderObjectDict_cppflags) $(HeaderObjectDict_cc_cppflags)  $(src)HeaderObjectDict.cc
endif
endif

else
$(bin)BaseEvent_dependencies.make : $(HeaderObjectDict_cc_dependencies)

$(bin)BaseEvent_dependencies.make : $(src)HeaderObjectDict.cc

$(bin)$(binobj)HeaderObjectDict.o : $(HeaderObjectDict_cc_dependencies)
	$(cpp_echo) $(src)HeaderObjectDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BaseEvent_pp_cppflags) $(lib_BaseEvent_pp_cppflags) $(HeaderObjectDict_pp_cppflags) $(use_cppflags) $(BaseEvent_cppflags) $(lib_BaseEvent_cppflags) $(HeaderObjectDict_cppflags) $(HeaderObjectDict_cc_cppflags)  $(src)HeaderObjectDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),BaseEventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EventObjectDict.d

$(bin)$(binobj)EventObjectDict.d :

$(bin)$(binobj)EventObjectDict.o : $(cmt_final_setup_BaseEvent)

$(bin)$(binobj)EventObjectDict.o : $(src)EventObjectDict.cc
	$(cpp_echo) $(src)EventObjectDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(BaseEvent_pp_cppflags) $(lib_BaseEvent_pp_cppflags) $(EventObjectDict_pp_cppflags) $(use_cppflags) $(BaseEvent_cppflags) $(lib_BaseEvent_cppflags) $(EventObjectDict_cppflags) $(EventObjectDict_cc_cppflags)  $(src)EventObjectDict.cc
endif
endif

else
$(bin)BaseEvent_dependencies.make : $(EventObjectDict_cc_dependencies)

$(bin)BaseEvent_dependencies.make : $(src)EventObjectDict.cc

$(bin)$(binobj)EventObjectDict.o : $(EventObjectDict_cc_dependencies)
	$(cpp_echo) $(src)EventObjectDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BaseEvent_pp_cppflags) $(lib_BaseEvent_pp_cppflags) $(EventObjectDict_pp_cppflags) $(use_cppflags) $(BaseEvent_cppflags) $(lib_BaseEvent_cppflags) $(EventObjectDict_cppflags) $(EventObjectDict_cc_cppflags)  $(src)EventObjectDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: BaseEventclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(BaseEvent.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

BaseEventclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library BaseEvent
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)BaseEvent$(library_suffix).a $(library_prefix)BaseEvent$(library_suffix).$(shlibsuffix) BaseEvent.stamp BaseEvent.shstamp
#-- end of cleanup_library ---------------

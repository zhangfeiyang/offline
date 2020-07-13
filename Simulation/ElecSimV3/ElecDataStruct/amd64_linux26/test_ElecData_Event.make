#-- start of make_header -----------------

#====================================
#  Application test_ElecData_Event
#
#   Generated Fri Jul 10 19:22:55 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_test_ElecData_Event_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_test_ElecData_Event_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_test_ElecData_Event

ElecDataStruct_tag = $(tag)

#cmt_local_tagfile_test_ElecData_Event = $(ElecDataStruct_tag)_test_ElecData_Event.make
cmt_local_tagfile_test_ElecData_Event = $(bin)$(ElecDataStruct_tag)_test_ElecData_Event.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ElecDataStruct_tag = $(tag)

#cmt_local_tagfile_test_ElecData_Event = $(ElecDataStruct_tag).make
cmt_local_tagfile_test_ElecData_Event = $(bin)$(ElecDataStruct_tag).make

endif

include $(cmt_local_tagfile_test_ElecData_Event)
#-include $(cmt_local_tagfile_test_ElecData_Event)

ifdef cmt_test_ElecData_Event_has_target_tag

cmt_final_setup_test_ElecData_Event = $(bin)setup_test_ElecData_Event.make
cmt_dependencies_in_test_ElecData_Event = $(bin)dependencies_test_ElecData_Event.in
#cmt_final_setup_test_ElecData_Event = $(bin)ElecDataStruct_test_ElecData_Eventsetup.make
cmt_local_test_ElecData_Event_makefile = $(bin)test_ElecData_Event.make

else

cmt_final_setup_test_ElecData_Event = $(bin)setup.make
cmt_dependencies_in_test_ElecData_Event = $(bin)dependencies.in
#cmt_final_setup_test_ElecData_Event = $(bin)ElecDataStructsetup.make
cmt_local_test_ElecData_Event_makefile = $(bin)test_ElecData_Event.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ElecDataStructsetup.make

#test_ElecData_Event :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'test_ElecData_Event'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = test_ElecData_Event/
#test_ElecData_Event::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

test_ElecData_Event :: dirs  $(bin)test_ElecData_Event${application_suffix}
	$(echo) "test_ElecData_Event ok"

cmt_test_ElecData_Event_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_ElecData_Event_has_prototypes

test_ElecData_Eventprototype :  ;

endif

test_ElecData_Eventcompile : $(bin)test_Event.o ;

#-- end of application_header
#-- start of application

$(bin)test_ElecData_Event${application_suffix} :: $(bin)test_Event.o $(use_stamps) $(test_ElecData_Event_stamps) $(test_ElecData_Eventstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)test_Event.o $(cmt_installarea_linkopts) $(test_ElecData_Event_use_linkopts) $(test_ElecData_Eventlinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
test_ElecData_Eventinstallname = test_ElecData_Event${application_suffix}

test_ElecData_Event :: test_ElecData_Eventinstall ;

install :: test_ElecData_Eventinstall ;

test_ElecData_Eventinstall :: $(install_dir)/$(test_ElecData_Eventinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(test_ElecData_Eventinstallname) :: $(bin)$(test_ElecData_Eventinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(test_ElecData_Eventinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##test_ElecData_Eventclean :: test_ElecData_Eventuninstall

uninstall :: test_ElecData_Eventuninstall ;

test_ElecData_Eventuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(test_ElecData_Eventinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (test_ElecData_Event.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),test_ElecData_Eventclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),test_ElecData_Eventprototype)

$(bin)test_ElecData_Event_dependencies.make : $(use_requirements) $(cmt_final_setup_test_ElecData_Event)
	$(echo) "(test_ElecData_Event.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all ../test/test_Event.cc -end_all $(includes) $(app_test_ElecData_Event_cppflags) $(lib_test_ElecData_Event_cppflags) -name=test_ElecData_Event $? -f=$(cmt_dependencies_in_test_ElecData_Event) -without_cmt

-include $(bin)test_ElecData_Event_dependencies.make

endif
endif
endif

test_ElecData_Eventclean ::
	$(cleanup_silent) \rm -rf $(bin)test_ElecData_Event_deps $(bin)test_ElecData_Event_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),test_ElecData_Eventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)test_Event.d

$(bin)$(binobj)test_Event.d :

$(bin)$(binobj)test_Event.o : $(cmt_final_setup_test_ElecData_Event)

$(bin)$(binobj)test_Event.o : ../test/test_Event.cc
	$(cpp_echo) ../test/test_Event.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(test_ElecData_Event_pp_cppflags) $(app_test_ElecData_Event_pp_cppflags) $(test_Event_pp_cppflags) $(use_cppflags) $(test_ElecData_Event_cppflags) $(app_test_ElecData_Event_cppflags) $(test_Event_cppflags) $(test_Event_cc_cppflags) -I../test ../test/test_Event.cc
endif
endif

else
$(bin)test_ElecData_Event_dependencies.make : $(test_Event_cc_dependencies)

$(bin)test_ElecData_Event_dependencies.make : ../test/test_Event.cc

$(bin)$(binobj)test_Event.o : $(test_Event_cc_dependencies)
	$(cpp_echo) ../test/test_Event.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(test_ElecData_Event_pp_cppflags) $(app_test_ElecData_Event_pp_cppflags) $(test_Event_pp_cppflags) $(use_cppflags) $(test_ElecData_Event_cppflags) $(app_test_ElecData_Event_cppflags) $(test_Event_cppflags) $(test_Event_cc_cppflags) -I../test ../test/test_Event.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: test_ElecData_Eventclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(test_ElecData_Event.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

test_ElecData_Eventclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application test_ElecData_Event
	-$(cleanup_silent) cd $(bin); /bin/rm -f test_ElecData_Event${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects test_ElecData_Event
	-$(cleanup_silent) /bin/rm -f $(bin)test_Event.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)test_Event.o) $(patsubst %.o,%.dep,$(bin)test_Event.o) $(patsubst %.o,%.d.stamp,$(bin)test_Event.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf test_ElecData_Event_deps test_ElecData_Event_dependencies.make
#-- end of cleanup_objects ------

#-- start of make_header -----------------

#====================================
#  Application test_SimEvent_write
#
#   Generated Fri Jul 10 19:21:28 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_test_SimEvent_write_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_test_SimEvent_write_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_test_SimEvent_write

SimEventV2_tag = $(tag)

#cmt_local_tagfile_test_SimEvent_write = $(SimEventV2_tag)_test_SimEvent_write.make
cmt_local_tagfile_test_SimEvent_write = $(bin)$(SimEventV2_tag)_test_SimEvent_write.make

else

tags      = $(tag),$(CMTEXTRATAGS)

SimEventV2_tag = $(tag)

#cmt_local_tagfile_test_SimEvent_write = $(SimEventV2_tag).make
cmt_local_tagfile_test_SimEvent_write = $(bin)$(SimEventV2_tag).make

endif

include $(cmt_local_tagfile_test_SimEvent_write)
#-include $(cmt_local_tagfile_test_SimEvent_write)

ifdef cmt_test_SimEvent_write_has_target_tag

cmt_final_setup_test_SimEvent_write = $(bin)setup_test_SimEvent_write.make
cmt_dependencies_in_test_SimEvent_write = $(bin)dependencies_test_SimEvent_write.in
#cmt_final_setup_test_SimEvent_write = $(bin)SimEventV2_test_SimEvent_writesetup.make
cmt_local_test_SimEvent_write_makefile = $(bin)test_SimEvent_write.make

else

cmt_final_setup_test_SimEvent_write = $(bin)setup.make
cmt_dependencies_in_test_SimEvent_write = $(bin)dependencies.in
#cmt_final_setup_test_SimEvent_write = $(bin)SimEventV2setup.make
cmt_local_test_SimEvent_write_makefile = $(bin)test_SimEvent_write.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)SimEventV2setup.make

#test_SimEvent_write :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'test_SimEvent_write'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = test_SimEvent_write/
#test_SimEvent_write::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

test_SimEvent_write :: dirs  $(bin)test_SimEvent_write${application_suffix}
	$(echo) "test_SimEvent_write ok"

cmt_test_SimEvent_write_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_SimEvent_write_has_prototypes

test_SimEvent_writeprototype :  ;

endif

test_SimEvent_writecompile : $(bin)write.o ;

#-- end of application_header
#-- start of application

$(bin)test_SimEvent_write${application_suffix} :: $(bin)write.o $(use_stamps) $(test_SimEvent_write_stamps) $(test_SimEvent_writestamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)write.o $(cmt_installarea_linkopts) $(test_SimEvent_write_use_linkopts) $(test_SimEvent_writelinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
test_SimEvent_writeinstallname = test_SimEvent_write${application_suffix}

test_SimEvent_write :: test_SimEvent_writeinstall ;

install :: test_SimEvent_writeinstall ;

test_SimEvent_writeinstall :: $(install_dir)/$(test_SimEvent_writeinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(test_SimEvent_writeinstallname) :: $(bin)$(test_SimEvent_writeinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(test_SimEvent_writeinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##test_SimEvent_writeclean :: test_SimEvent_writeuninstall

uninstall :: test_SimEvent_writeuninstall ;

test_SimEvent_writeuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(test_SimEvent_writeinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (test_SimEvent_write.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),test_SimEvent_writeclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),test_SimEvent_writeprototype)

$(bin)test_SimEvent_write_dependencies.make : $(use_requirements) $(cmt_final_setup_test_SimEvent_write)
	$(echo) "(test_SimEvent_write.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all ../tests/write.C -end_all $(includes) $(app_test_SimEvent_write_cppflags) $(lib_test_SimEvent_write_cppflags) -name=test_SimEvent_write $? -f=$(cmt_dependencies_in_test_SimEvent_write) -without_cmt

-include $(bin)test_SimEvent_write_dependencies.make

endif
endif
endif

test_SimEvent_writeclean ::
	$(cleanup_silent) \rm -rf $(bin)test_SimEvent_write_deps $(bin)test_SimEvent_write_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),test_SimEvent_writeclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)write.d

$(bin)$(binobj)write.d :

$(bin)$(binobj)write.o : $(cmt_final_setup_test_SimEvent_write)

$(bin)$(binobj)write.o : ../tests/write.C
	$(cpp_echo) ../tests/write.C
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(test_SimEvent_write_pp_cppflags) $(app_test_SimEvent_write_pp_cppflags) $(write_pp_cppflags) $(use_cppflags) $(test_SimEvent_write_cppflags) $(app_test_SimEvent_write_cppflags) $(write_cppflags) $(write_C_cppflags) -I../tests ../tests/write.C
endif
endif

else
$(bin)test_SimEvent_write_dependencies.make : $(write_C_dependencies)

$(bin)test_SimEvent_write_dependencies.make : ../tests/write.C

$(bin)$(binobj)write.o : $(write_C_dependencies)
	$(cpp_echo) ../tests/write.C
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(test_SimEvent_write_pp_cppflags) $(app_test_SimEvent_write_pp_cppflags) $(write_pp_cppflags) $(use_cppflags) $(test_SimEvent_write_cppflags) $(app_test_SimEvent_write_cppflags) $(write_cppflags) $(write_C_cppflags) -I../tests ../tests/write.C

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: test_SimEvent_writeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(test_SimEvent_write.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

test_SimEvent_writeclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application test_SimEvent_write
	-$(cleanup_silent) cd $(bin); /bin/rm -f test_SimEvent_write${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects test_SimEvent_write
	-$(cleanup_silent) /bin/rm -f $(bin)write.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)write.o) $(patsubst %.o,%.dep,$(bin)write.o) $(patsubst %.o,%.d.stamp,$(bin)write.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf test_SimEvent_write_deps test_SimEvent_write_dependencies.make
#-- end of cleanup_objects ------

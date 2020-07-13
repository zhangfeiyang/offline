#-- start of make_header -----------------

#====================================
#  Application test_Context_write
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

cmt_test_Context_write_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_test_Context_write_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_test_Context_write

Context_tag = $(tag)

#cmt_local_tagfile_test_Context_write = $(Context_tag)_test_Context_write.make
cmt_local_tagfile_test_Context_write = $(bin)$(Context_tag)_test_Context_write.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Context_tag = $(tag)

#cmt_local_tagfile_test_Context_write = $(Context_tag).make
cmt_local_tagfile_test_Context_write = $(bin)$(Context_tag).make

endif

include $(cmt_local_tagfile_test_Context_write)
#-include $(cmt_local_tagfile_test_Context_write)

ifdef cmt_test_Context_write_has_target_tag

cmt_final_setup_test_Context_write = $(bin)setup_test_Context_write.make
cmt_dependencies_in_test_Context_write = $(bin)dependencies_test_Context_write.in
#cmt_final_setup_test_Context_write = $(bin)Context_test_Context_writesetup.make
cmt_local_test_Context_write_makefile = $(bin)test_Context_write.make

else

cmt_final_setup_test_Context_write = $(bin)setup.make
cmt_dependencies_in_test_Context_write = $(bin)dependencies.in
#cmt_final_setup_test_Context_write = $(bin)Contextsetup.make
cmt_local_test_Context_write_makefile = $(bin)test_Context_write.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Contextsetup.make

#test_Context_write :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'test_Context_write'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = test_Context_write/
#test_Context_write::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

test_Context_write :: dirs  $(bin)test_Context_write${application_suffix}
	$(echo) "test_Context_write ok"

cmt_test_Context_write_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Context_write_has_prototypes

test_Context_writeprototype :  ;

endif

test_Context_writecompile : $(bin)write.o ;

#-- end of application_header
#-- start of application

$(bin)test_Context_write${application_suffix} :: $(bin)write.o $(use_stamps) $(test_Context_write_stamps) $(test_Context_writestamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)write.o $(cmt_installarea_linkopts) $(test_Context_write_use_linkopts) $(test_Context_writelinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
test_Context_writeinstallname = test_Context_write${application_suffix}

test_Context_write :: test_Context_writeinstall ;

install :: test_Context_writeinstall ;

test_Context_writeinstall :: $(install_dir)/$(test_Context_writeinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(test_Context_writeinstallname) :: $(bin)$(test_Context_writeinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(test_Context_writeinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##test_Context_writeclean :: test_Context_writeuninstall

uninstall :: test_Context_writeuninstall ;

test_Context_writeuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(test_Context_writeinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (test_Context_write.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),test_Context_writeclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),test_Context_writeprototype)

$(bin)test_Context_write_dependencies.make : $(use_requirements) $(cmt_final_setup_test_Context_write)
	$(echo) "(test_Context_write.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all ../test/write.C -end_all $(includes) $(app_test_Context_write_cppflags) $(lib_test_Context_write_cppflags) -name=test_Context_write $? -f=$(cmt_dependencies_in_test_Context_write) -without_cmt

-include $(bin)test_Context_write_dependencies.make

endif
endif
endif

test_Context_writeclean ::
	$(cleanup_silent) \rm -rf $(bin)test_Context_write_deps $(bin)test_Context_write_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),test_Context_writeclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)write.d

$(bin)$(binobj)write.d :

$(bin)$(binobj)write.o : $(cmt_final_setup_test_Context_write)

$(bin)$(binobj)write.o : ../test/write.C
	$(cpp_echo) ../test/write.C
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(test_Context_write_pp_cppflags) $(app_test_Context_write_pp_cppflags) $(write_pp_cppflags) $(use_cppflags) $(test_Context_write_cppflags) $(app_test_Context_write_cppflags) $(write_cppflags) $(write_C_cppflags) -I../test ../test/write.C
endif
endif

else
$(bin)test_Context_write_dependencies.make : $(write_C_dependencies)

$(bin)test_Context_write_dependencies.make : ../test/write.C

$(bin)$(binobj)write.o : $(write_C_dependencies)
	$(cpp_echo) ../test/write.C
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(test_Context_write_pp_cppflags) $(app_test_Context_write_pp_cppflags) $(write_pp_cppflags) $(use_cppflags) $(test_Context_write_cppflags) $(app_test_Context_write_cppflags) $(write_cppflags) $(write_C_cppflags) -I../test ../test/write.C

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: test_Context_writeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(test_Context_write.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

test_Context_writeclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application test_Context_write
	-$(cleanup_silent) cd $(bin); /bin/rm -f test_Context_write${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects test_Context_write
	-$(cleanup_silent) /bin/rm -f $(bin)write.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)write.o) $(patsubst %.o,%.dep,$(bin)write.o) $(patsubst %.o,%.d.stamp,$(bin)write.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf test_Context_write_deps test_Context_write_dependencies.make
#-- end of cleanup_objects ------

#-- start of make_header -----------------

#====================================
#  Application test_Context_read
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

cmt_test_Context_read_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_test_Context_read_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_test_Context_read

Context_tag = $(tag)

#cmt_local_tagfile_test_Context_read = $(Context_tag)_test_Context_read.make
cmt_local_tagfile_test_Context_read = $(bin)$(Context_tag)_test_Context_read.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Context_tag = $(tag)

#cmt_local_tagfile_test_Context_read = $(Context_tag).make
cmt_local_tagfile_test_Context_read = $(bin)$(Context_tag).make

endif

include $(cmt_local_tagfile_test_Context_read)
#-include $(cmt_local_tagfile_test_Context_read)

ifdef cmt_test_Context_read_has_target_tag

cmt_final_setup_test_Context_read = $(bin)setup_test_Context_read.make
cmt_dependencies_in_test_Context_read = $(bin)dependencies_test_Context_read.in
#cmt_final_setup_test_Context_read = $(bin)Context_test_Context_readsetup.make
cmt_local_test_Context_read_makefile = $(bin)test_Context_read.make

else

cmt_final_setup_test_Context_read = $(bin)setup.make
cmt_dependencies_in_test_Context_read = $(bin)dependencies.in
#cmt_final_setup_test_Context_read = $(bin)Contextsetup.make
cmt_local_test_Context_read_makefile = $(bin)test_Context_read.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Contextsetup.make

#test_Context_read :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'test_Context_read'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = test_Context_read/
#test_Context_read::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

test_Context_read :: dirs  $(bin)test_Context_read${application_suffix}
	$(echo) "test_Context_read ok"

cmt_test_Context_read_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Context_read_has_prototypes

test_Context_readprototype :  ;

endif

test_Context_readcompile : $(bin)read.o ;

#-- end of application_header
#-- start of application

$(bin)test_Context_read${application_suffix} :: $(bin)read.o $(use_stamps) $(test_Context_read_stamps) $(test_Context_readstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)read.o $(cmt_installarea_linkopts) $(test_Context_read_use_linkopts) $(test_Context_readlinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
test_Context_readinstallname = test_Context_read${application_suffix}

test_Context_read :: test_Context_readinstall ;

install :: test_Context_readinstall ;

test_Context_readinstall :: $(install_dir)/$(test_Context_readinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(test_Context_readinstallname) :: $(bin)$(test_Context_readinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(test_Context_readinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##test_Context_readclean :: test_Context_readuninstall

uninstall :: test_Context_readuninstall ;

test_Context_readuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(test_Context_readinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (test_Context_read.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),test_Context_readclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),test_Context_readprototype)

$(bin)test_Context_read_dependencies.make : $(use_requirements) $(cmt_final_setup_test_Context_read)
	$(echo) "(test_Context_read.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all ../test/read.C -end_all $(includes) $(app_test_Context_read_cppflags) $(lib_test_Context_read_cppflags) -name=test_Context_read $? -f=$(cmt_dependencies_in_test_Context_read) -without_cmt

-include $(bin)test_Context_read_dependencies.make

endif
endif
endif

test_Context_readclean ::
	$(cleanup_silent) \rm -rf $(bin)test_Context_read_deps $(bin)test_Context_read_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),test_Context_readclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)read.d

$(bin)$(binobj)read.d :

$(bin)$(binobj)read.o : $(cmt_final_setup_test_Context_read)

$(bin)$(binobj)read.o : ../test/read.C
	$(cpp_echo) ../test/read.C
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(test_Context_read_pp_cppflags) $(app_test_Context_read_pp_cppflags) $(read_pp_cppflags) $(use_cppflags) $(test_Context_read_cppflags) $(app_test_Context_read_cppflags) $(read_cppflags) $(read_C_cppflags) -I../test ../test/read.C
endif
endif

else
$(bin)test_Context_read_dependencies.make : $(read_C_dependencies)

$(bin)test_Context_read_dependencies.make : ../test/read.C

$(bin)$(binobj)read.o : $(read_C_dependencies)
	$(cpp_echo) ../test/read.C
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(test_Context_read_pp_cppflags) $(app_test_Context_read_pp_cppflags) $(read_pp_cppflags) $(use_cppflags) $(test_Context_read_cppflags) $(app_test_Context_read_cppflags) $(read_cppflags) $(read_C_cppflags) -I../test ../test/read.C

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: test_Context_readclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(test_Context_read.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

test_Context_readclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application test_Context_read
	-$(cleanup_silent) cd $(bin); /bin/rm -f test_Context_read${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects test_Context_read
	-$(cleanup_silent) /bin/rm -f $(bin)read.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)read.o) $(patsubst %.o,%.dep,$(bin)read.o) $(patsubst %.o,%.d.stamp,$(bin)read.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf test_Context_read_deps test_Context_read_dependencies.make
#-- end of cleanup_objects ------

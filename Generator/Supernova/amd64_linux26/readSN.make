#-- start of make_header -----------------

#====================================
#  Application readSN
#
#   Generated Fri Jul 10 19:14:46 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_readSN_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_readSN_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_readSN

Supernova_tag = $(tag)

#cmt_local_tagfile_readSN = $(Supernova_tag)_readSN.make
cmt_local_tagfile_readSN = $(bin)$(Supernova_tag)_readSN.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Supernova_tag = $(tag)

#cmt_local_tagfile_readSN = $(Supernova_tag).make
cmt_local_tagfile_readSN = $(bin)$(Supernova_tag).make

endif

include $(cmt_local_tagfile_readSN)
#-include $(cmt_local_tagfile_readSN)

ifdef cmt_readSN_has_target_tag

cmt_final_setup_readSN = $(bin)setup_readSN.make
cmt_dependencies_in_readSN = $(bin)dependencies_readSN.in
#cmt_final_setup_readSN = $(bin)Supernova_readSNsetup.make
cmt_local_readSN_makefile = $(bin)readSN.make

else

cmt_final_setup_readSN = $(bin)setup.make
cmt_dependencies_in_readSN = $(bin)dependencies.in
#cmt_final_setup_readSN = $(bin)Supernovasetup.make
cmt_local_readSN_makefile = $(bin)readSN.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Supernovasetup.make

#readSN :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'readSN'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = readSN/
#readSN::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

readSN :: dirs  $(bin)readSN${application_suffix}
	$(echo) "readSN ok"

cmt_readSN_has_prototypes = 1

#--------------------------------------

ifdef cmt_readSN_has_prototypes

readSNprototype :  ;

endif

readSNcompile : $(bin)event.o $(bin)sneventsinput.o $(bin)testRead.o ;

#-- end of application_header
#-- start of application

$(bin)readSN${application_suffix} :: $(bin)event.o $(bin)sneventsinput.o $(bin)testRead.o $(use_stamps) $(readSN_stamps) $(readSNstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)event.o $(bin)sneventsinput.o $(bin)testRead.o $(cmt_installarea_linkopts) $(readSN_use_linkopts) $(readSNlinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
readSNinstallname = readSN${application_suffix}

readSN :: readSNinstall ;

install :: readSNinstall ;

readSNinstall :: $(install_dir)/$(readSNinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(readSNinstallname) :: $(bin)$(readSNinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(readSNinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##readSNclean :: readSNuninstall

uninstall :: readSNuninstall ;

readSNuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(readSNinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (readSN.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),readSNclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),readSNprototype)

$(bin)readSN_dependencies.make : $(use_requirements) $(cmt_final_setup_readSN)
	$(echo) "(readSN.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all ../test/event.cc ../test/sneventsinput.cc ../test/testRead.cc -end_all $(includes) $(app_readSN_cppflags) $(lib_readSN_cppflags) -name=readSN $? -f=$(cmt_dependencies_in_readSN) -without_cmt

-include $(bin)readSN_dependencies.make

endif
endif
endif

readSNclean ::
	$(cleanup_silent) \rm -rf $(bin)readSN_deps $(bin)readSN_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),readSNclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)event.d

$(bin)$(binobj)event.d :

$(bin)$(binobj)event.o : $(cmt_final_setup_readSN)

$(bin)$(binobj)event.o : ../test/event.cc
	$(cpp_echo) ../test/event.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(readSN_pp_cppflags) $(app_readSN_pp_cppflags) $(event_pp_cppflags) $(use_cppflags) $(readSN_cppflags) $(app_readSN_cppflags) $(event_cppflags) $(event_cc_cppflags) -I../test ../test/event.cc
endif
endif

else
$(bin)readSN_dependencies.make : $(event_cc_dependencies)

$(bin)readSN_dependencies.make : ../test/event.cc

$(bin)$(binobj)event.o : $(event_cc_dependencies)
	$(cpp_echo) ../test/event.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(readSN_pp_cppflags) $(app_readSN_pp_cppflags) $(event_pp_cppflags) $(use_cppflags) $(readSN_cppflags) $(app_readSN_cppflags) $(event_cppflags) $(event_cc_cppflags) -I../test ../test/event.cc

endif

#-- end of cpp ------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),readSNclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)sneventsinput.d

$(bin)$(binobj)sneventsinput.d :

$(bin)$(binobj)sneventsinput.o : $(cmt_final_setup_readSN)

$(bin)$(binobj)sneventsinput.o : ../test/sneventsinput.cc
	$(cpp_echo) ../test/sneventsinput.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(readSN_pp_cppflags) $(app_readSN_pp_cppflags) $(sneventsinput_pp_cppflags) $(use_cppflags) $(readSN_cppflags) $(app_readSN_cppflags) $(sneventsinput_cppflags) $(sneventsinput_cc_cppflags) -I../test ../test/sneventsinput.cc
endif
endif

else
$(bin)readSN_dependencies.make : $(sneventsinput_cc_dependencies)

$(bin)readSN_dependencies.make : ../test/sneventsinput.cc

$(bin)$(binobj)sneventsinput.o : $(sneventsinput_cc_dependencies)
	$(cpp_echo) ../test/sneventsinput.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(readSN_pp_cppflags) $(app_readSN_pp_cppflags) $(sneventsinput_pp_cppflags) $(use_cppflags) $(readSN_cppflags) $(app_readSN_cppflags) $(sneventsinput_cppflags) $(sneventsinput_cc_cppflags) -I../test ../test/sneventsinput.cc

endif

#-- end of cpp ------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),readSNclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)testRead.d

$(bin)$(binobj)testRead.d :

$(bin)$(binobj)testRead.o : $(cmt_final_setup_readSN)

$(bin)$(binobj)testRead.o : ../test/testRead.cc
	$(cpp_echo) ../test/testRead.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(readSN_pp_cppflags) $(app_readSN_pp_cppflags) $(testRead_pp_cppflags) $(use_cppflags) $(readSN_cppflags) $(app_readSN_cppflags) $(testRead_cppflags) $(testRead_cc_cppflags) -I../test ../test/testRead.cc
endif
endif

else
$(bin)readSN_dependencies.make : $(testRead_cc_dependencies)

$(bin)readSN_dependencies.make : ../test/testRead.cc

$(bin)$(binobj)testRead.o : $(testRead_cc_dependencies)
	$(cpp_echo) ../test/testRead.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(readSN_pp_cppflags) $(app_readSN_pp_cppflags) $(testRead_pp_cppflags) $(use_cppflags) $(readSN_cppflags) $(app_readSN_cppflags) $(testRead_cppflags) $(testRead_cc_cppflags) -I../test ../test/testRead.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: readSNclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(readSN.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

readSNclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application readSN
	-$(cleanup_silent) cd $(bin); /bin/rm -f readSN${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects readSN
	-$(cleanup_silent) /bin/rm -f $(bin)event.o $(bin)sneventsinput.o $(bin)testRead.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)event.o $(bin)sneventsinput.o $(bin)testRead.o) $(patsubst %.o,%.dep,$(bin)event.o $(bin)sneventsinput.o $(bin)testRead.o) $(patsubst %.o,%.d.stamp,$(bin)event.o $(bin)sneventsinput.o $(bin)testRead.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf readSN_deps readSN_dependencies.make
#-- end of cleanup_objects ------

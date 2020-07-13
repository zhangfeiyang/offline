#-- start of make_header -----------------

#====================================
#  Application AmBe
#
#   Generated Fri Jul 10 19:14:51 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_AmBe_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_AmBe_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_AmBe

AmBe_tag = $(tag)

#cmt_local_tagfile_AmBe = $(AmBe_tag)_AmBe.make
cmt_local_tagfile_AmBe = $(bin)$(AmBe_tag)_AmBe.make

else

tags      = $(tag),$(CMTEXTRATAGS)

AmBe_tag = $(tag)

#cmt_local_tagfile_AmBe = $(AmBe_tag).make
cmt_local_tagfile_AmBe = $(bin)$(AmBe_tag).make

endif

include $(cmt_local_tagfile_AmBe)
#-include $(cmt_local_tagfile_AmBe)

ifdef cmt_AmBe_has_target_tag

cmt_final_setup_AmBe = $(bin)setup_AmBe.make
cmt_dependencies_in_AmBe = $(bin)dependencies_AmBe.in
#cmt_final_setup_AmBe = $(bin)AmBe_AmBesetup.make
cmt_local_AmBe_makefile = $(bin)AmBe.make

else

cmt_final_setup_AmBe = $(bin)setup.make
cmt_dependencies_in_AmBe = $(bin)dependencies.in
#cmt_final_setup_AmBe = $(bin)AmBesetup.make
cmt_local_AmBe_makefile = $(bin)AmBe.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)AmBesetup.make

#AmBe :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'AmBe'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = AmBe/
#AmBe::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

AmBe :: dirs  $(bin)AmBe${application_suffix}
	$(echo) "AmBe ok"

cmt_AmBe_has_prototypes = 1

#--------------------------------------

ifdef cmt_AmBe_has_prototypes

AmBeprototype :  ;

endif

AmBecompile : $(bin)AmBe.o ;

#-- end of application_header
#-- start of application

$(bin)AmBe${application_suffix} :: $(bin)AmBe.o $(use_stamps) $(AmBe_stamps) $(AmBestamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)AmBe.o $(cmt_installarea_linkopts) $(AmBe_use_linkopts) $(AmBelinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
AmBeinstallname = AmBe${application_suffix}

AmBe :: AmBeinstall ;

install :: AmBeinstall ;

AmBeinstall :: $(install_dir)/$(AmBeinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(AmBeinstallname) :: $(bin)$(AmBeinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(AmBeinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##AmBeclean :: AmBeuninstall

uninstall :: AmBeuninstall ;

AmBeuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(AmBeinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (AmBe.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),AmBeclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),AmBeprototype)

$(bin)AmBe_dependencies.make : $(use_requirements) $(cmt_final_setup_AmBe)
	$(echo) "(AmBe.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)AmBe.cc -end_all $(includes) $(app_AmBe_cppflags) $(lib_AmBe_cppflags) -name=AmBe $? -f=$(cmt_dependencies_in_AmBe) -without_cmt

-include $(bin)AmBe_dependencies.make

endif
endif
endif

AmBeclean ::
	$(cleanup_silent) \rm -rf $(bin)AmBe_deps $(bin)AmBe_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),AmBeclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AmBe.d

$(bin)$(binobj)AmBe.d :

$(bin)$(binobj)AmBe.o : $(cmt_final_setup_AmBe)

$(bin)$(binobj)AmBe.o : $(src)AmBe.cc
	$(cpp_echo) $(src)AmBe.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(AmBe_pp_cppflags) $(app_AmBe_pp_cppflags) $(AmBe_pp_cppflags) $(use_cppflags) $(AmBe_cppflags) $(app_AmBe_cppflags) $(AmBe_cppflags) $(AmBe_cc_cppflags)  $(src)AmBe.cc
endif
endif

else
$(bin)AmBe_dependencies.make : $(AmBe_cc_dependencies)

$(bin)AmBe_dependencies.make : $(src)AmBe.cc

$(bin)$(binobj)AmBe.o : $(AmBe_cc_dependencies)
	$(cpp_echo) $(src)AmBe.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(AmBe_pp_cppflags) $(app_AmBe_pp_cppflags) $(AmBe_pp_cppflags) $(use_cppflags) $(AmBe_cppflags) $(app_AmBe_cppflags) $(AmBe_cppflags) $(AmBe_cc_cppflags)  $(src)AmBe.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: AmBeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(AmBe.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

AmBeclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application AmBe
	-$(cleanup_silent) cd $(bin); /bin/rm -f AmBe${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects AmBe
	-$(cleanup_silent) /bin/rm -f $(bin)AmBe.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)AmBe.o) $(patsubst %.o,%.dep,$(bin)AmBe.o) $(patsubst %.o,%.d.stamp,$(bin)AmBe.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf AmBe_deps AmBe_dependencies.make
#-- end of cleanup_objects ------

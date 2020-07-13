#-- start of make_header -----------------

#====================================
#  Application AmC
#
#   Generated Fri Jul 10 19:14:52 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_AmC_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_AmC_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_AmC

AmC_tag = $(tag)

#cmt_local_tagfile_AmC = $(AmC_tag)_AmC.make
cmt_local_tagfile_AmC = $(bin)$(AmC_tag)_AmC.make

else

tags      = $(tag),$(CMTEXTRATAGS)

AmC_tag = $(tag)

#cmt_local_tagfile_AmC = $(AmC_tag).make
cmt_local_tagfile_AmC = $(bin)$(AmC_tag).make

endif

include $(cmt_local_tagfile_AmC)
#-include $(cmt_local_tagfile_AmC)

ifdef cmt_AmC_has_target_tag

cmt_final_setup_AmC = $(bin)setup_AmC.make
cmt_dependencies_in_AmC = $(bin)dependencies_AmC.in
#cmt_final_setup_AmC = $(bin)AmC_AmCsetup.make
cmt_local_AmC_makefile = $(bin)AmC.make

else

cmt_final_setup_AmC = $(bin)setup.make
cmt_dependencies_in_AmC = $(bin)dependencies.in
#cmt_final_setup_AmC = $(bin)AmCsetup.make
cmt_local_AmC_makefile = $(bin)AmC.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)AmCsetup.make

#AmC :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'AmC'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = AmC/
#AmC::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

AmC :: dirs  $(bin)AmC${application_suffix}
	$(echo) "AmC ok"

cmt_AmC_has_prototypes = 1

#--------------------------------------

ifdef cmt_AmC_has_prototypes

AmCprototype :  ;

endif

AmCcompile : $(bin)AmC.o ;

#-- end of application_header
#-- start of application

$(bin)AmC${application_suffix} :: $(bin)AmC.o $(use_stamps) $(AmC_stamps) $(AmCstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)AmC.o $(cmt_installarea_linkopts) $(AmC_use_linkopts) $(AmClinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
AmCinstallname = AmC${application_suffix}

AmC :: AmCinstall ;

install :: AmCinstall ;

AmCinstall :: $(install_dir)/$(AmCinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(AmCinstallname) :: $(bin)$(AmCinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(AmCinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##AmCclean :: AmCuninstall

uninstall :: AmCuninstall ;

AmCuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(AmCinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (AmC.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),AmCclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),AmCprototype)

$(bin)AmC_dependencies.make : $(use_requirements) $(cmt_final_setup_AmC)
	$(echo) "(AmC.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)AmC.cc -end_all $(includes) $(app_AmC_cppflags) $(lib_AmC_cppflags) -name=AmC $? -f=$(cmt_dependencies_in_AmC) -without_cmt

-include $(bin)AmC_dependencies.make

endif
endif
endif

AmCclean ::
	$(cleanup_silent) \rm -rf $(bin)AmC_deps $(bin)AmC_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),AmCclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AmC.d

$(bin)$(binobj)AmC.d :

$(bin)$(binobj)AmC.o : $(cmt_final_setup_AmC)

$(bin)$(binobj)AmC.o : $(src)AmC.cc
	$(cpp_echo) $(src)AmC.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(AmC_pp_cppflags) $(app_AmC_pp_cppflags) $(AmC_pp_cppflags) $(use_cppflags) $(AmC_cppflags) $(app_AmC_cppflags) $(AmC_cppflags) $(AmC_cc_cppflags)  $(src)AmC.cc
endif
endif

else
$(bin)AmC_dependencies.make : $(AmC_cc_dependencies)

$(bin)AmC_dependencies.make : $(src)AmC.cc

$(bin)$(binobj)AmC.o : $(AmC_cc_dependencies)
	$(cpp_echo) $(src)AmC.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(AmC_pp_cppflags) $(app_AmC_pp_cppflags) $(AmC_pp_cppflags) $(use_cppflags) $(AmC_cppflags) $(app_AmC_cppflags) $(AmC_cppflags) $(AmC_cc_cppflags)  $(src)AmC.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: AmCclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(AmC.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

AmCclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application AmC
	-$(cleanup_silent) cd $(bin); /bin/rm -f AmC${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects AmC
	-$(cleanup_silent) /bin/rm -f $(bin)AmC.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)AmC.o) $(patsubst %.o,%.dep,$(bin)AmC.o) $(patsubst %.o,%.d.stamp,$(bin)AmC.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf AmC_deps AmC_dependencies.make
#-- end of cleanup_objects ------

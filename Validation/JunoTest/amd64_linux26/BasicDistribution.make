#-- start of make_header -----------------

#====================================
#  Application BasicDistribution
#
#   Generated Fri Jul 10 19:15:06 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_BasicDistribution_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_BasicDistribution_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_BasicDistribution

JunoTest_tag = $(tag)

#cmt_local_tagfile_BasicDistribution = $(JunoTest_tag)_BasicDistribution.make
cmt_local_tagfile_BasicDistribution = $(bin)$(JunoTest_tag)_BasicDistribution.make

else

tags      = $(tag),$(CMTEXTRATAGS)

JunoTest_tag = $(tag)

#cmt_local_tagfile_BasicDistribution = $(JunoTest_tag).make
cmt_local_tagfile_BasicDistribution = $(bin)$(JunoTest_tag).make

endif

include $(cmt_local_tagfile_BasicDistribution)
#-include $(cmt_local_tagfile_BasicDistribution)

ifdef cmt_BasicDistribution_has_target_tag

cmt_final_setup_BasicDistribution = $(bin)setup_BasicDistribution.make
cmt_dependencies_in_BasicDistribution = $(bin)dependencies_BasicDistribution.in
#cmt_final_setup_BasicDistribution = $(bin)JunoTest_BasicDistributionsetup.make
cmt_local_BasicDistribution_makefile = $(bin)BasicDistribution.make

else

cmt_final_setup_BasicDistribution = $(bin)setup.make
cmt_dependencies_in_BasicDistribution = $(bin)dependencies.in
#cmt_final_setup_BasicDistribution = $(bin)JunoTestsetup.make
cmt_local_BasicDistribution_makefile = $(bin)BasicDistribution.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)JunoTestsetup.make

#BasicDistribution :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'BasicDistribution'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = BasicDistribution/
#BasicDistribution::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

BasicDistribution :: dirs  $(bin)BasicDistribution${application_suffix}
	$(echo) "BasicDistribution ok"

cmt_BasicDistribution_has_prototypes = 1

#--------------------------------------

ifdef cmt_BasicDistribution_has_prototypes

BasicDistributionprototype :  ;

endif

BasicDistributioncompile : $(bin)BasicDistribution.o ;

#-- end of application_header
#-- start of application

$(bin)BasicDistribution${application_suffix} :: $(bin)BasicDistribution.o $(use_stamps) $(BasicDistribution_stamps) $(BasicDistributionstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)BasicDistribution.o $(cmt_installarea_linkopts) $(BasicDistribution_use_linkopts) $(BasicDistributionlinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
BasicDistributioninstallname = BasicDistribution${application_suffix}

BasicDistribution :: BasicDistributioninstall ;

install :: BasicDistributioninstall ;

BasicDistributioninstall :: $(install_dir)/$(BasicDistributioninstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(BasicDistributioninstallname) :: $(bin)$(BasicDistributioninstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(BasicDistributioninstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##BasicDistributionclean :: BasicDistributionuninstall

uninstall :: BasicDistributionuninstall ;

BasicDistributionuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(BasicDistributioninstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (BasicDistribution.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),BasicDistributionclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),BasicDistributionprototype)

$(bin)BasicDistribution_dependencies.make : $(use_requirements) $(cmt_final_setup_BasicDistribution)
	$(echo) "(BasicDistribution.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all ../production/IBD-BasicDistribution/BasicDistribution.cc -end_all $(includes) $(app_BasicDistribution_cppflags) $(lib_BasicDistribution_cppflags) -name=BasicDistribution $? -f=$(cmt_dependencies_in_BasicDistribution) -without_cmt

-include $(bin)BasicDistribution_dependencies.make

endif
endif
endif

BasicDistributionclean ::
	$(cleanup_silent) \rm -rf $(bin)BasicDistribution_deps $(bin)BasicDistribution_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),BasicDistributionclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BasicDistribution.d

$(bin)$(binobj)BasicDistribution.d :

$(bin)$(binobj)BasicDistribution.o : $(cmt_final_setup_BasicDistribution)

$(bin)$(binobj)BasicDistribution.o : ../production/IBD-BasicDistribution/BasicDistribution.cc
	$(cpp_echo) ../production/IBD-BasicDistribution/BasicDistribution.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(BasicDistribution_pp_cppflags) $(app_BasicDistribution_pp_cppflags) $(BasicDistribution_pp_cppflags) $(use_cppflags) $(BasicDistribution_cppflags) $(app_BasicDistribution_cppflags) $(BasicDistribution_cppflags) $(BasicDistribution_cc_cppflags) -I../production/IBD-BasicDistribution ../production/IBD-BasicDistribution/BasicDistribution.cc
endif
endif

else
$(bin)BasicDistribution_dependencies.make : $(BasicDistribution_cc_dependencies)

$(bin)BasicDistribution_dependencies.make : ../production/IBD-BasicDistribution/BasicDistribution.cc

$(bin)$(binobj)BasicDistribution.o : $(BasicDistribution_cc_dependencies)
	$(cpp_echo) ../production/IBD-BasicDistribution/BasicDistribution.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BasicDistribution_pp_cppflags) $(app_BasicDistribution_pp_cppflags) $(BasicDistribution_pp_cppflags) $(use_cppflags) $(BasicDistribution_cppflags) $(app_BasicDistribution_cppflags) $(BasicDistribution_cppflags) $(BasicDistribution_cc_cppflags) -I../production/IBD-BasicDistribution ../production/IBD-BasicDistribution/BasicDistribution.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: BasicDistributionclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(BasicDistribution.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

BasicDistributionclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application BasicDistribution
	-$(cleanup_silent) cd $(bin); /bin/rm -f BasicDistribution${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects BasicDistribution
	-$(cleanup_silent) /bin/rm -f $(bin)BasicDistribution.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)BasicDistribution.o) $(patsubst %.o,%.dep,$(bin)BasicDistribution.o) $(patsubst %.o,%.d.stamp,$(bin)BasicDistribution.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf BasicDistribution_deps BasicDistribution_dependencies.make
#-- end of cleanup_objects ------

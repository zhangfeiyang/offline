#-- start of make_header -----------------

#====================================
#  Application IBD
#
#   Generated Fri Jul 10 19:15:01 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_IBD_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_IBD_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_IBD

InverseBeta_tag = $(tag)

#cmt_local_tagfile_IBD = $(InverseBeta_tag)_IBD.make
cmt_local_tagfile_IBD = $(bin)$(InverseBeta_tag)_IBD.make

else

tags      = $(tag),$(CMTEXTRATAGS)

InverseBeta_tag = $(tag)

#cmt_local_tagfile_IBD = $(InverseBeta_tag).make
cmt_local_tagfile_IBD = $(bin)$(InverseBeta_tag).make

endif

include $(cmt_local_tagfile_IBD)
#-include $(cmt_local_tagfile_IBD)

ifdef cmt_IBD_has_target_tag

cmt_final_setup_IBD = $(bin)setup_IBD.make
cmt_dependencies_in_IBD = $(bin)dependencies_IBD.in
#cmt_final_setup_IBD = $(bin)InverseBeta_IBDsetup.make
cmt_local_IBD_makefile = $(bin)IBD.make

else

cmt_final_setup_IBD = $(bin)setup.make
cmt_dependencies_in_IBD = $(bin)dependencies.in
#cmt_final_setup_IBD = $(bin)InverseBetasetup.make
cmt_local_IBD_makefile = $(bin)IBD.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)InverseBetasetup.make

#IBD :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'IBD'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = IBD/
#IBD::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

IBD :: dirs  $(bin)IBD${application_suffix}
	$(echo) "IBD ok"

cmt_IBD_has_prototypes = 1

#--------------------------------------

ifdef cmt_IBD_has_prototypes

IBDprototype :  ;

endif

IBDcompile : $(bin)NuOscillations.o $(bin)inverse_beta.o $(bin)KRLReactorFlux.o $(bin)KRLInverseBeta.o ;

#-- end of application_header
#-- start of application

$(bin)IBD${application_suffix} :: $(bin)NuOscillations.o $(bin)inverse_beta.o $(bin)KRLReactorFlux.o $(bin)KRLInverseBeta.o $(use_stamps) $(IBD_stamps) $(IBDstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)NuOscillations.o $(bin)inverse_beta.o $(bin)KRLReactorFlux.o $(bin)KRLInverseBeta.o $(cmt_installarea_linkopts) $(IBD_use_linkopts) $(IBDlinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
IBDinstallname = IBD${application_suffix}

IBD :: IBDinstall ;

install :: IBDinstall ;

IBDinstall :: $(install_dir)/$(IBDinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(IBDinstallname) :: $(bin)$(IBDinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(IBDinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##IBDclean :: IBDuninstall

uninstall :: IBDuninstall ;

IBDuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(IBDinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (IBD.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),IBDclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),IBDprototype)

$(bin)IBD_dependencies.make : $(use_requirements) $(cmt_final_setup_IBD)
	$(echo) "(IBD.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)NuOscillations.cc $(src)inverse_beta.cc $(src)KRLReactorFlux.cc $(src)KRLInverseBeta.cc -end_all $(includes) $(app_IBD_cppflags) $(lib_IBD_cppflags) -name=IBD $? -f=$(cmt_dependencies_in_IBD) -without_cmt

-include $(bin)IBD_dependencies.make

endif
endif
endif

IBDclean ::
	$(cleanup_silent) \rm -rf $(bin)IBD_deps $(bin)IBD_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),IBDclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NuOscillations.d

$(bin)$(binobj)NuOscillations.d :

$(bin)$(binobj)NuOscillations.o : $(cmt_final_setup_IBD)

$(bin)$(binobj)NuOscillations.o : $(src)NuOscillations.cc
	$(cpp_echo) $(src)NuOscillations.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(IBD_pp_cppflags) $(app_IBD_pp_cppflags) $(NuOscillations_pp_cppflags) $(use_cppflags) $(IBD_cppflags) $(app_IBD_cppflags) $(NuOscillations_cppflags) $(NuOscillations_cc_cppflags)  $(src)NuOscillations.cc
endif
endif

else
$(bin)IBD_dependencies.make : $(NuOscillations_cc_dependencies)

$(bin)IBD_dependencies.make : $(src)NuOscillations.cc

$(bin)$(binobj)NuOscillations.o : $(NuOscillations_cc_dependencies)
	$(cpp_echo) $(src)NuOscillations.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(IBD_pp_cppflags) $(app_IBD_pp_cppflags) $(NuOscillations_pp_cppflags) $(use_cppflags) $(IBD_cppflags) $(app_IBD_cppflags) $(NuOscillations_cppflags) $(NuOscillations_cc_cppflags)  $(src)NuOscillations.cc

endif

#-- end of cpp ------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),IBDclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)inverse_beta.d

$(bin)$(binobj)inverse_beta.d :

$(bin)$(binobj)inverse_beta.o : $(cmt_final_setup_IBD)

$(bin)$(binobj)inverse_beta.o : $(src)inverse_beta.cc
	$(cpp_echo) $(src)inverse_beta.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(IBD_pp_cppflags) $(app_IBD_pp_cppflags) $(inverse_beta_pp_cppflags) $(use_cppflags) $(IBD_cppflags) $(app_IBD_cppflags) $(inverse_beta_cppflags) $(inverse_beta_cc_cppflags)  $(src)inverse_beta.cc
endif
endif

else
$(bin)IBD_dependencies.make : $(inverse_beta_cc_dependencies)

$(bin)IBD_dependencies.make : $(src)inverse_beta.cc

$(bin)$(binobj)inverse_beta.o : $(inverse_beta_cc_dependencies)
	$(cpp_echo) $(src)inverse_beta.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(IBD_pp_cppflags) $(app_IBD_pp_cppflags) $(inverse_beta_pp_cppflags) $(use_cppflags) $(IBD_cppflags) $(app_IBD_cppflags) $(inverse_beta_cppflags) $(inverse_beta_cc_cppflags)  $(src)inverse_beta.cc

endif

#-- end of cpp ------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),IBDclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)KRLReactorFlux.d

$(bin)$(binobj)KRLReactorFlux.d :

$(bin)$(binobj)KRLReactorFlux.o : $(cmt_final_setup_IBD)

$(bin)$(binobj)KRLReactorFlux.o : $(src)KRLReactorFlux.cc
	$(cpp_echo) $(src)KRLReactorFlux.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(IBD_pp_cppflags) $(app_IBD_pp_cppflags) $(KRLReactorFlux_pp_cppflags) $(use_cppflags) $(IBD_cppflags) $(app_IBD_cppflags) $(KRLReactorFlux_cppflags) $(KRLReactorFlux_cc_cppflags)  $(src)KRLReactorFlux.cc
endif
endif

else
$(bin)IBD_dependencies.make : $(KRLReactorFlux_cc_dependencies)

$(bin)IBD_dependencies.make : $(src)KRLReactorFlux.cc

$(bin)$(binobj)KRLReactorFlux.o : $(KRLReactorFlux_cc_dependencies)
	$(cpp_echo) $(src)KRLReactorFlux.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(IBD_pp_cppflags) $(app_IBD_pp_cppflags) $(KRLReactorFlux_pp_cppflags) $(use_cppflags) $(IBD_cppflags) $(app_IBD_cppflags) $(KRLReactorFlux_cppflags) $(KRLReactorFlux_cc_cppflags)  $(src)KRLReactorFlux.cc

endif

#-- end of cpp ------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),IBDclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)KRLInverseBeta.d

$(bin)$(binobj)KRLInverseBeta.d :

$(bin)$(binobj)KRLInverseBeta.o : $(cmt_final_setup_IBD)

$(bin)$(binobj)KRLInverseBeta.o : $(src)KRLInverseBeta.cc
	$(cpp_echo) $(src)KRLInverseBeta.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(IBD_pp_cppflags) $(app_IBD_pp_cppflags) $(KRLInverseBeta_pp_cppflags) $(use_cppflags) $(IBD_cppflags) $(app_IBD_cppflags) $(KRLInverseBeta_cppflags) $(KRLInverseBeta_cc_cppflags)  $(src)KRLInverseBeta.cc
endif
endif

else
$(bin)IBD_dependencies.make : $(KRLInverseBeta_cc_dependencies)

$(bin)IBD_dependencies.make : $(src)KRLInverseBeta.cc

$(bin)$(binobj)KRLInverseBeta.o : $(KRLInverseBeta_cc_dependencies)
	$(cpp_echo) $(src)KRLInverseBeta.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(IBD_pp_cppflags) $(app_IBD_pp_cppflags) $(KRLInverseBeta_pp_cppflags) $(use_cppflags) $(IBD_cppflags) $(app_IBD_cppflags) $(KRLInverseBeta_cppflags) $(KRLInverseBeta_cc_cppflags)  $(src)KRLInverseBeta.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: IBDclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(IBD.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

IBDclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application IBD
	-$(cleanup_silent) cd $(bin); /bin/rm -f IBD${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects IBD
	-$(cleanup_silent) /bin/rm -f $(bin)NuOscillations.o $(bin)inverse_beta.o $(bin)KRLReactorFlux.o $(bin)KRLInverseBeta.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)NuOscillations.o $(bin)inverse_beta.o $(bin)KRLReactorFlux.o $(bin)KRLInverseBeta.o) $(patsubst %.o,%.dep,$(bin)NuOscillations.o $(bin)inverse_beta.o $(bin)KRLReactorFlux.o $(bin)KRLInverseBeta.o) $(patsubst %.o,%.d.stamp,$(bin)NuOscillations.o $(bin)inverse_beta.o $(bin)KRLReactorFlux.o $(bin)KRLInverseBeta.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf IBD_deps IBD_dependencies.make
#-- end of cleanup_objects ------

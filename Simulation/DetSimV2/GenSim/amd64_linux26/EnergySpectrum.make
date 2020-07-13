#-- start of make_header -----------------

#====================================
#  Application EnergySpectrum
#
#   Generated Fri Jul 10 19:15:44 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_EnergySpectrum_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_EnergySpectrum_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_EnergySpectrum

GenSim_tag = $(tag)

#cmt_local_tagfile_EnergySpectrum = $(GenSim_tag)_EnergySpectrum.make
cmt_local_tagfile_EnergySpectrum = $(bin)$(GenSim_tag)_EnergySpectrum.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GenSim_tag = $(tag)

#cmt_local_tagfile_EnergySpectrum = $(GenSim_tag).make
cmt_local_tagfile_EnergySpectrum = $(bin)$(GenSim_tag).make

endif

include $(cmt_local_tagfile_EnergySpectrum)
#-include $(cmt_local_tagfile_EnergySpectrum)

ifdef cmt_EnergySpectrum_has_target_tag

cmt_final_setup_EnergySpectrum = $(bin)setup_EnergySpectrum.make
cmt_dependencies_in_EnergySpectrum = $(bin)dependencies_EnergySpectrum.in
#cmt_final_setup_EnergySpectrum = $(bin)GenSim_EnergySpectrumsetup.make
cmt_local_EnergySpectrum_makefile = $(bin)EnergySpectrum.make

else

cmt_final_setup_EnergySpectrum = $(bin)setup.make
cmt_dependencies_in_EnergySpectrum = $(bin)dependencies.in
#cmt_final_setup_EnergySpectrum = $(bin)GenSimsetup.make
cmt_local_EnergySpectrum_makefile = $(bin)EnergySpectrum.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GenSimsetup.make

#EnergySpectrum :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'EnergySpectrum'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = EnergySpectrum/
#EnergySpectrum::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

EnergySpectrum :: dirs  $(bin)EnergySpectrum${application_suffix}
	$(echo) "EnergySpectrum ok"

cmt_EnergySpectrum_has_prototypes = 1

#--------------------------------------

ifdef cmt_EnergySpectrum_has_prototypes

EnergySpectrumprototype :  ;

endif

EnergySpectrumcompile : $(bin)EnergySpectrum.o ;

#-- end of application_header
#-- start of application

$(bin)EnergySpectrum${application_suffix} :: $(bin)EnergySpectrum.o $(use_stamps) $(EnergySpectrum_stamps) $(EnergySpectrumstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)EnergySpectrum.o $(cmt_installarea_linkopts) $(EnergySpectrum_use_linkopts) $(EnergySpectrumlinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
EnergySpectruminstallname = EnergySpectrum${application_suffix}

EnergySpectrum :: EnergySpectruminstall ;

install :: EnergySpectruminstall ;

EnergySpectruminstall :: $(install_dir)/$(EnergySpectruminstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(EnergySpectruminstallname) :: $(bin)$(EnergySpectruminstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(EnergySpectruminstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##EnergySpectrumclean :: EnergySpectrumuninstall

uninstall :: EnergySpectrumuninstall ;

EnergySpectrumuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(EnergySpectruminstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (EnergySpectrum.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),EnergySpectrumclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),EnergySpectrumprototype)

$(bin)EnergySpectrum_dependencies.make : $(use_requirements) $(cmt_final_setup_EnergySpectrum)
	$(echo) "(EnergySpectrum.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all ../apps/EnergySpectrum.cc -end_all $(includes) $(app_EnergySpectrum_cppflags) $(lib_EnergySpectrum_cppflags) -name=EnergySpectrum $? -f=$(cmt_dependencies_in_EnergySpectrum) -without_cmt

-include $(bin)EnergySpectrum_dependencies.make

endif
endif
endif

EnergySpectrumclean ::
	$(cleanup_silent) \rm -rf $(bin)EnergySpectrum_deps $(bin)EnergySpectrum_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),EnergySpectrumclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EnergySpectrum.d

$(bin)$(binobj)EnergySpectrum.d :

$(bin)$(binobj)EnergySpectrum.o : $(cmt_final_setup_EnergySpectrum)

$(bin)$(binobj)EnergySpectrum.o : ../apps/EnergySpectrum.cc
	$(cpp_echo) ../apps/EnergySpectrum.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(EnergySpectrum_pp_cppflags) $(app_EnergySpectrum_pp_cppflags) $(EnergySpectrum_pp_cppflags) $(use_cppflags) $(EnergySpectrum_cppflags) $(app_EnergySpectrum_cppflags) $(EnergySpectrum_cppflags) $(EnergySpectrum_cc_cppflags) -I../apps ../apps/EnergySpectrum.cc
endif
endif

else
$(bin)EnergySpectrum_dependencies.make : $(EnergySpectrum_cc_dependencies)

$(bin)EnergySpectrum_dependencies.make : ../apps/EnergySpectrum.cc

$(bin)$(binobj)EnergySpectrum.o : $(EnergySpectrum_cc_dependencies)
	$(cpp_echo) ../apps/EnergySpectrum.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EnergySpectrum_pp_cppflags) $(app_EnergySpectrum_pp_cppflags) $(EnergySpectrum_pp_cppflags) $(use_cppflags) $(EnergySpectrum_cppflags) $(app_EnergySpectrum_cppflags) $(EnergySpectrum_cppflags) $(EnergySpectrum_cc_cppflags) -I../apps ../apps/EnergySpectrum.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: EnergySpectrumclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(EnergySpectrum.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

EnergySpectrumclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application EnergySpectrum
	-$(cleanup_silent) cd $(bin); /bin/rm -f EnergySpectrum${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects EnergySpectrum
	-$(cleanup_silent) /bin/rm -f $(bin)EnergySpectrum.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)EnergySpectrum.o) $(patsubst %.o,%.dep,$(bin)EnergySpectrum.o) $(patsubst %.o,%.d.stamp,$(bin)EnergySpectrum.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf EnergySpectrum_deps EnergySpectrum_dependencies.make
#-- end of cleanup_objects ------

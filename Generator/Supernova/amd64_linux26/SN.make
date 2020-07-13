#-- start of make_header -----------------

#====================================
#  Application SN
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

cmt_SN_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_SN_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_SN

Supernova_tag = $(tag)

#cmt_local_tagfile_SN = $(Supernova_tag)_SN.make
cmt_local_tagfile_SN = $(bin)$(Supernova_tag)_SN.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Supernova_tag = $(tag)

#cmt_local_tagfile_SN = $(Supernova_tag).make
cmt_local_tagfile_SN = $(bin)$(Supernova_tag).make

endif

include $(cmt_local_tagfile_SN)
#-include $(cmt_local_tagfile_SN)

ifdef cmt_SN_has_target_tag

cmt_final_setup_SN = $(bin)setup_SN.make
cmt_dependencies_in_SN = $(bin)dependencies_SN.in
#cmt_final_setup_SN = $(bin)Supernova_SNsetup.make
cmt_local_SN_makefile = $(bin)SN.make

else

cmt_final_setup_SN = $(bin)setup.make
cmt_dependencies_in_SN = $(bin)dependencies.in
#cmt_final_setup_SN = $(bin)Supernovasetup.make
cmt_local_SN_makefile = $(bin)SN.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Supernovasetup.make

#SN :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'SN'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = SN/
#SN::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

SN :: dirs  $(bin)SN${application_suffix}
	$(echo) "SN ok"

cmt_SN_has_prototypes = 1

#--------------------------------------

ifdef cmt_SN_has_prototypes

SNprototype :  ;

endif

SNcompile : $(bin)genSN.o $(bin)event.o $(bin)detector.o $(bin)dataflux.o $(bin)sneventsoutput.o ;

#-- end of application_header
#-- start of application

$(bin)SN${application_suffix} :: $(bin)genSN.o $(bin)event.o $(bin)detector.o $(bin)dataflux.o $(bin)sneventsoutput.o $(use_stamps) $(SN_stamps) $(SNstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)genSN.o $(bin)event.o $(bin)detector.o $(bin)dataflux.o $(bin)sneventsoutput.o $(cmt_installarea_linkopts) $(SN_use_linkopts) $(SNlinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
SNinstallname = SN${application_suffix}

SN :: SNinstall ;

install :: SNinstall ;

SNinstall :: $(install_dir)/$(SNinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(SNinstallname) :: $(bin)$(SNinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(SNinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##SNclean :: SNuninstall

uninstall :: SNuninstall ;

SNuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(SNinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (SN.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),SNclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),SNprototype)

$(bin)SN_dependencies.make : $(use_requirements) $(cmt_final_setup_SN)
	$(echo) "(SN.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)genSN.cc $(src)event.cc $(src)detector.cc $(src)dataflux.cc $(src)sneventsoutput.cc -end_all $(includes) $(app_SN_cppflags) $(lib_SN_cppflags) -name=SN $? -f=$(cmt_dependencies_in_SN) -without_cmt

-include $(bin)SN_dependencies.make

endif
endif
endif

SNclean ::
	$(cleanup_silent) \rm -rf $(bin)SN_deps $(bin)SN_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),SNclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)genSN.d

$(bin)$(binobj)genSN.d :

$(bin)$(binobj)genSN.o : $(cmt_final_setup_SN)

$(bin)$(binobj)genSN.o : $(src)genSN.cc
	$(cpp_echo) $(src)genSN.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SN_pp_cppflags) $(app_SN_pp_cppflags) $(genSN_pp_cppflags) $(use_cppflags) $(SN_cppflags) $(app_SN_cppflags) $(genSN_cppflags) $(genSN_cc_cppflags)  $(src)genSN.cc
endif
endif

else
$(bin)SN_dependencies.make : $(genSN_cc_dependencies)

$(bin)SN_dependencies.make : $(src)genSN.cc

$(bin)$(binobj)genSN.o : $(genSN_cc_dependencies)
	$(cpp_echo) $(src)genSN.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SN_pp_cppflags) $(app_SN_pp_cppflags) $(genSN_pp_cppflags) $(use_cppflags) $(SN_cppflags) $(app_SN_cppflags) $(genSN_cppflags) $(genSN_cc_cppflags)  $(src)genSN.cc

endif

#-- end of cpp ------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),SNclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)event.d

$(bin)$(binobj)event.d :

$(bin)$(binobj)event.o : $(cmt_final_setup_SN)

$(bin)$(binobj)event.o : $(src)event.cc
	$(cpp_echo) $(src)event.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SN_pp_cppflags) $(app_SN_pp_cppflags) $(event_pp_cppflags) $(use_cppflags) $(SN_cppflags) $(app_SN_cppflags) $(event_cppflags) $(event_cc_cppflags)  $(src)event.cc
endif
endif

else
$(bin)SN_dependencies.make : $(event_cc_dependencies)

$(bin)SN_dependencies.make : $(src)event.cc

$(bin)$(binobj)event.o : $(event_cc_dependencies)
	$(cpp_echo) $(src)event.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SN_pp_cppflags) $(app_SN_pp_cppflags) $(event_pp_cppflags) $(use_cppflags) $(SN_cppflags) $(app_SN_cppflags) $(event_cppflags) $(event_cc_cppflags)  $(src)event.cc

endif

#-- end of cpp ------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),SNclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)detector.d

$(bin)$(binobj)detector.d :

$(bin)$(binobj)detector.o : $(cmt_final_setup_SN)

$(bin)$(binobj)detector.o : $(src)detector.cc
	$(cpp_echo) $(src)detector.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SN_pp_cppflags) $(app_SN_pp_cppflags) $(detector_pp_cppflags) $(use_cppflags) $(SN_cppflags) $(app_SN_cppflags) $(detector_cppflags) $(detector_cc_cppflags)  $(src)detector.cc
endif
endif

else
$(bin)SN_dependencies.make : $(detector_cc_dependencies)

$(bin)SN_dependencies.make : $(src)detector.cc

$(bin)$(binobj)detector.o : $(detector_cc_dependencies)
	$(cpp_echo) $(src)detector.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SN_pp_cppflags) $(app_SN_pp_cppflags) $(detector_pp_cppflags) $(use_cppflags) $(SN_cppflags) $(app_SN_cppflags) $(detector_cppflags) $(detector_cc_cppflags)  $(src)detector.cc

endif

#-- end of cpp ------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),SNclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)dataflux.d

$(bin)$(binobj)dataflux.d :

$(bin)$(binobj)dataflux.o : $(cmt_final_setup_SN)

$(bin)$(binobj)dataflux.o : $(src)dataflux.cc
	$(cpp_echo) $(src)dataflux.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SN_pp_cppflags) $(app_SN_pp_cppflags) $(dataflux_pp_cppflags) $(use_cppflags) $(SN_cppflags) $(app_SN_cppflags) $(dataflux_cppflags) $(dataflux_cc_cppflags)  $(src)dataflux.cc
endif
endif

else
$(bin)SN_dependencies.make : $(dataflux_cc_dependencies)

$(bin)SN_dependencies.make : $(src)dataflux.cc

$(bin)$(binobj)dataflux.o : $(dataflux_cc_dependencies)
	$(cpp_echo) $(src)dataflux.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SN_pp_cppflags) $(app_SN_pp_cppflags) $(dataflux_pp_cppflags) $(use_cppflags) $(SN_cppflags) $(app_SN_cppflags) $(dataflux_cppflags) $(dataflux_cc_cppflags)  $(src)dataflux.cc

endif

#-- end of cpp ------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),SNclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)sneventsoutput.d

$(bin)$(binobj)sneventsoutput.d :

$(bin)$(binobj)sneventsoutput.o : $(cmt_final_setup_SN)

$(bin)$(binobj)sneventsoutput.o : $(src)sneventsoutput.cc
	$(cpp_echo) $(src)sneventsoutput.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(SN_pp_cppflags) $(app_SN_pp_cppflags) $(sneventsoutput_pp_cppflags) $(use_cppflags) $(SN_cppflags) $(app_SN_cppflags) $(sneventsoutput_cppflags) $(sneventsoutput_cc_cppflags)  $(src)sneventsoutput.cc
endif
endif

else
$(bin)SN_dependencies.make : $(sneventsoutput_cc_dependencies)

$(bin)SN_dependencies.make : $(src)sneventsoutput.cc

$(bin)$(binobj)sneventsoutput.o : $(sneventsoutput_cc_dependencies)
	$(cpp_echo) $(src)sneventsoutput.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(SN_pp_cppflags) $(app_SN_pp_cppflags) $(sneventsoutput_pp_cppflags) $(use_cppflags) $(SN_cppflags) $(app_SN_cppflags) $(sneventsoutput_cppflags) $(sneventsoutput_cc_cppflags)  $(src)sneventsoutput.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: SNclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(SN.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

SNclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application SN
	-$(cleanup_silent) cd $(bin); /bin/rm -f SN${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects SN
	-$(cleanup_silent) /bin/rm -f $(bin)genSN.o $(bin)event.o $(bin)detector.o $(bin)dataflux.o $(bin)sneventsoutput.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)genSN.o $(bin)event.o $(bin)detector.o $(bin)dataflux.o $(bin)sneventsoutput.o) $(patsubst %.o,%.dep,$(bin)genSN.o $(bin)event.o $(bin)detector.o $(bin)dataflux.o $(bin)sneventsoutput.o) $(patsubst %.o,%.d.stamp,$(bin)genSN.o $(bin)event.o $(bin)detector.o $(bin)dataflux.o $(bin)sneventsoutput.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf SN_deps SN_dependencies.make
#-- end of cleanup_objects ------

#-- start of make_header -----------------

#====================================
#  Application DSNB-NC
#
#   Generated Fri Jul 10 19:14:45 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_DSNB-NC_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_DSNB-NC_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_DSNB-NC

DSNB_tag = $(tag)

#cmt_local_tagfile_DSNB-NC = $(DSNB_tag)_DSNB-NC.make
cmt_local_tagfile_DSNB-NC = $(bin)$(DSNB_tag)_DSNB-NC.make

else

tags      = $(tag),$(CMTEXTRATAGS)

DSNB_tag = $(tag)

#cmt_local_tagfile_DSNB-NC = $(DSNB_tag).make
cmt_local_tagfile_DSNB-NC = $(bin)$(DSNB_tag).make

endif

include $(cmt_local_tagfile_DSNB-NC)
#-include $(cmt_local_tagfile_DSNB-NC)

ifdef cmt_DSNB-NC_has_target_tag

cmt_final_setup_DSNB-NC = $(bin)setup_DSNB-NC.make
cmt_dependencies_in_DSNB-NC = $(bin)dependencies_DSNB-NC.in
#cmt_final_setup_DSNB-NC = $(bin)DSNB_DSNB-NCsetup.make
cmt_local_DSNB-NC_makefile = $(bin)DSNB-NC.make

else

cmt_final_setup_DSNB-NC = $(bin)setup.make
cmt_dependencies_in_DSNB-NC = $(bin)dependencies.in
#cmt_final_setup_DSNB-NC = $(bin)DSNBsetup.make
cmt_local_DSNB-NC_makefile = $(bin)DSNB-NC.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)DSNBsetup.make

#DSNB-NC :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'DSNB-NC'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = DSNB-NC/
#DSNB-NC::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

DSNB-NC :: dirs  $(bin)DSNB-NC${application_suffix}
	$(echo) "DSNB-NC ok"

cmt_DSNB-NC_has_prototypes = 1

#--------------------------------------

ifdef cmt_DSNB-NC_has_prototypes

DSNB-NCprototype :  ;

endif

DSNB-NCcompile : $(bin)deex.o $(bin)NCGenerator.o ;

#-- end of application_header
#-- start of application

$(bin)DSNB-NC${application_suffix} :: $(bin)deex.o $(bin)NCGenerator.o $(use_stamps) $(DSNB-NC_stamps) $(DSNB-NCstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)deex.o $(bin)NCGenerator.o $(cmt_installarea_linkopts) $(DSNB-NC_use_linkopts) $(DSNB-NClinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
DSNB-NCinstallname = DSNB-NC${application_suffix}

DSNB-NC :: DSNB-NCinstall ;

install :: DSNB-NCinstall ;

DSNB-NCinstall :: $(install_dir)/$(DSNB-NCinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(DSNB-NCinstallname) :: $(bin)$(DSNB-NCinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(DSNB-NCinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##DSNB-NCclean :: DSNB-NCuninstall

uninstall :: DSNB-NCuninstall ;

DSNB-NCuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(DSNB-NCinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (DSNB-NC.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),DSNB-NCclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),DSNB-NCprototype)

$(bin)DSNB-NC_dependencies.make : $(use_requirements) $(cmt_final_setup_DSNB-NC)
	$(echo) "(DSNB-NC.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)deex.cc $(src)NCGenerator.cc -end_all $(includes) $(app_DSNB-NC_cppflags) $(lib_DSNB-NC_cppflags) -name=DSNB-NC $? -f=$(cmt_dependencies_in_DSNB-NC) -without_cmt

-include $(bin)DSNB-NC_dependencies.make

endif
endif
endif

DSNB-NCclean ::
	$(cleanup_silent) \rm -rf $(bin)DSNB-NC_deps $(bin)DSNB-NC_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),DSNB-NCclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)deex.d

$(bin)$(binobj)deex.d :

$(bin)$(binobj)deex.o : $(cmt_final_setup_DSNB-NC)

$(bin)$(binobj)deex.o : $(src)deex.cc
	$(cpp_echo) $(src)deex.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(DSNB-NC_pp_cppflags) $(app_DSNB-NC_pp_cppflags) $(deex_pp_cppflags) $(use_cppflags) $(DSNB-NC_cppflags) $(app_DSNB-NC_cppflags) $(deex_cppflags) $(deex_cc_cppflags)  $(src)deex.cc
endif
endif

else
$(bin)DSNB-NC_dependencies.make : $(deex_cc_dependencies)

$(bin)DSNB-NC_dependencies.make : $(src)deex.cc

$(bin)$(binobj)deex.o : $(deex_cc_dependencies)
	$(cpp_echo) $(src)deex.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(DSNB-NC_pp_cppflags) $(app_DSNB-NC_pp_cppflags) $(deex_pp_cppflags) $(use_cppflags) $(DSNB-NC_cppflags) $(app_DSNB-NC_cppflags) $(deex_cppflags) $(deex_cc_cppflags)  $(src)deex.cc

endif

#-- end of cpp ------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),DSNB-NCclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NCGenerator.d

$(bin)$(binobj)NCGenerator.d :

$(bin)$(binobj)NCGenerator.o : $(cmt_final_setup_DSNB-NC)

$(bin)$(binobj)NCGenerator.o : $(src)NCGenerator.cc
	$(cpp_echo) $(src)NCGenerator.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(DSNB-NC_pp_cppflags) $(app_DSNB-NC_pp_cppflags) $(NCGenerator_pp_cppflags) $(use_cppflags) $(DSNB-NC_cppflags) $(app_DSNB-NC_cppflags) $(NCGenerator_cppflags) $(NCGenerator_cc_cppflags)  $(src)NCGenerator.cc
endif
endif

else
$(bin)DSNB-NC_dependencies.make : $(NCGenerator_cc_dependencies)

$(bin)DSNB-NC_dependencies.make : $(src)NCGenerator.cc

$(bin)$(binobj)NCGenerator.o : $(NCGenerator_cc_dependencies)
	$(cpp_echo) $(src)NCGenerator.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(DSNB-NC_pp_cppflags) $(app_DSNB-NC_pp_cppflags) $(NCGenerator_pp_cppflags) $(use_cppflags) $(DSNB-NC_cppflags) $(app_DSNB-NC_cppflags) $(NCGenerator_cppflags) $(NCGenerator_cc_cppflags)  $(src)NCGenerator.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: DSNB-NCclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(DSNB-NC.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

DSNB-NCclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application DSNB-NC
	-$(cleanup_silent) cd $(bin); /bin/rm -f DSNB-NC${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects DSNB-NC
	-$(cleanup_silent) /bin/rm -f $(bin)deex.o $(bin)NCGenerator.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)deex.o $(bin)NCGenerator.o) $(patsubst %.o,%.dep,$(bin)deex.o $(bin)NCGenerator.o) $(patsubst %.o,%.d.stamp,$(bin)deex.o $(bin)NCGenerator.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf DSNB-NC_deps DSNB-NC_dependencies.make
#-- end of cleanup_objects ------

#-- start of make_header -----------------

#====================================
#  Application serena
#
#   Generated Fri Jul 10 19:21:47 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_serena_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_serena_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_serena

VisClient_tag = $(tag)

#cmt_local_tagfile_serena = $(VisClient_tag)_serena.make
cmt_local_tagfile_serena = $(bin)$(VisClient_tag)_serena.make

else

tags      = $(tag),$(CMTEXTRATAGS)

VisClient_tag = $(tag)

#cmt_local_tagfile_serena = $(VisClient_tag).make
cmt_local_tagfile_serena = $(bin)$(VisClient_tag).make

endif

include $(cmt_local_tagfile_serena)
#-include $(cmt_local_tagfile_serena)

ifdef cmt_serena_has_target_tag

cmt_final_setup_serena = $(bin)setup_serena.make
cmt_dependencies_in_serena = $(bin)dependencies_serena.in
#cmt_final_setup_serena = $(bin)VisClient_serenasetup.make
cmt_local_serena_makefile = $(bin)serena.make

else

cmt_final_setup_serena = $(bin)setup.make
cmt_dependencies_in_serena = $(bin)dependencies.in
#cmt_final_setup_serena = $(bin)VisClientsetup.make
cmt_local_serena_makefile = $(bin)serena.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)VisClientsetup.make

#serena :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'serena'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = serena/
#serena::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

serena :: dirs  $(bin)serena${application_suffix}
	$(echo) "serena ok"

cmt_serena_has_prototypes = 1

#--------------------------------------

ifdef cmt_serena_has_prototypes

serenaprototype :  ;

endif

serenacompile : $(bin)jvis.o ;

#-- end of application_header
#-- start of application

$(bin)serena${application_suffix} :: $(bin)jvis.o $(use_stamps) $(serena_stamps) $(serenastamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)jvis.o $(cmt_installarea_linkopts) $(serena_use_linkopts) $(serenalinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
serenainstallname = serena${application_suffix}

serena :: serenainstall ;

install :: serenainstall ;

serenainstall :: $(install_dir)/$(serenainstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(serenainstallname) :: $(bin)$(serenainstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(serenainstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##serenaclean :: serenauninstall

uninstall :: serenauninstall ;

serenauninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(serenainstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (serena.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),serenaclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),serenaprototype)

$(bin)serena_dependencies.make : $(use_requirements) $(cmt_final_setup_serena)
	$(echo) "(serena.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)jvis.C -end_all $(includes) $(app_serena_cppflags) $(lib_serena_cppflags) -name=serena $? -f=$(cmt_dependencies_in_serena) -without_cmt

-include $(bin)serena_dependencies.make

endif
endif
endif

serenaclean ::
	$(cleanup_silent) \rm -rf $(bin)serena_deps $(bin)serena_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),serenaclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)jvis.d

$(bin)$(binobj)jvis.d :

$(bin)$(binobj)jvis.o : $(cmt_final_setup_serena)

$(bin)$(binobj)jvis.o : $(src)jvis.C
	$(cpp_echo) $(src)jvis.C
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(serena_pp_cppflags) $(app_serena_pp_cppflags) $(jvis_pp_cppflags) $(use_cppflags) $(serena_cppflags) $(app_serena_cppflags) $(jvis_cppflags) $(jvis_C_cppflags)  $(src)jvis.C
endif
endif

else
$(bin)serena_dependencies.make : $(jvis_C_dependencies)

$(bin)serena_dependencies.make : $(src)jvis.C

$(bin)$(binobj)jvis.o : $(jvis_C_dependencies)
	$(cpp_echo) $(src)jvis.C
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(serena_pp_cppflags) $(app_serena_pp_cppflags) $(jvis_pp_cppflags) $(use_cppflags) $(serena_cppflags) $(app_serena_cppflags) $(jvis_cppflags) $(jvis_C_cppflags)  $(src)jvis.C

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: serenaclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(serena.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

serenaclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application serena
	-$(cleanup_silent) cd $(bin); /bin/rm -f serena${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects serena
	-$(cleanup_silent) /bin/rm -f $(bin)jvis.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)jvis.o) $(patsubst %.o,%.dep,$(bin)jvis.o) $(patsubst %.o,%.d.stamp,$(bin)jvis.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf serena_deps serena_dependencies.make
#-- end of cleanup_objects ------

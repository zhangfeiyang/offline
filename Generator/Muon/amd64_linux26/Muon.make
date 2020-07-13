#-- start of make_header -----------------

#====================================
#  Application Muon
#
#   Generated Fri Jul 10 19:14:59 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Muon_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Muon_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Muon

Muon_tag = $(tag)

#cmt_local_tagfile_Muon = $(Muon_tag)_Muon.make
cmt_local_tagfile_Muon = $(bin)$(Muon_tag)_Muon.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Muon_tag = $(tag)

#cmt_local_tagfile_Muon = $(Muon_tag).make
cmt_local_tagfile_Muon = $(bin)$(Muon_tag).make

endif

include $(cmt_local_tagfile_Muon)
#-include $(cmt_local_tagfile_Muon)

ifdef cmt_Muon_has_target_tag

cmt_final_setup_Muon = $(bin)setup_Muon.make
cmt_dependencies_in_Muon = $(bin)dependencies_Muon.in
#cmt_final_setup_Muon = $(bin)Muon_Muonsetup.make
cmt_local_Muon_makefile = $(bin)Muon.make

else

cmt_final_setup_Muon = $(bin)setup.make
cmt_dependencies_in_Muon = $(bin)dependencies.in
#cmt_final_setup_Muon = $(bin)Muonsetup.make
cmt_local_Muon_makefile = $(bin)Muon.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Muonsetup.make

#Muon :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'Muon'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Muon/
#Muon::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

Muon :: dirs  $(bin)Muon${application_suffix}
	$(echo) "Muon ok"

cmt_Muon_has_prototypes = 1

#--------------------------------------

ifdef cmt_Muon_has_prototypes

Muonprototype :  ;

endif

Muoncompile : $(bin)muon_generator.o ;

#-- end of application_header
#-- start of application

$(bin)Muon${application_suffix} :: $(bin)muon_generator.o $(use_stamps) $(Muon_stamps) $(Muonstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)muon_generator.o $(cmt_installarea_linkopts) $(Muon_use_linkopts) $(Muonlinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
Muoninstallname = Muon${application_suffix}

Muon :: Muoninstall ;

install :: Muoninstall ;

Muoninstall :: $(install_dir)/$(Muoninstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(Muoninstallname) :: $(bin)$(Muoninstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Muoninstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##Muonclean :: Muonuninstall

uninstall :: Muonuninstall ;

Muonuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Muoninstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (Muon.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),Muonclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),Muonprototype)

$(bin)Muon_dependencies.make : $(use_requirements) $(cmt_final_setup_Muon)
	$(echo) "(Muon.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)muon_generator.cc -end_all $(includes) $(app_Muon_cppflags) $(lib_Muon_cppflags) -name=Muon $? -f=$(cmt_dependencies_in_Muon) -without_cmt

-include $(bin)Muon_dependencies.make

endif
endif
endif

Muonclean ::
	$(cleanup_silent) \rm -rf $(bin)Muon_deps $(bin)Muon_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),Muonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)muon_generator.d

$(bin)$(binobj)muon_generator.d :

$(bin)$(binobj)muon_generator.o : $(cmt_final_setup_Muon)

$(bin)$(binobj)muon_generator.o : $(src)muon_generator.cc
	$(cpp_echo) $(src)muon_generator.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Muon_pp_cppflags) $(app_Muon_pp_cppflags) $(muon_generator_pp_cppflags) $(use_cppflags) $(Muon_cppflags) $(app_Muon_cppflags) $(muon_generator_cppflags) $(muon_generator_cc_cppflags)  $(src)muon_generator.cc
endif
endif

else
$(bin)Muon_dependencies.make : $(muon_generator_cc_dependencies)

$(bin)Muon_dependencies.make : $(src)muon_generator.cc

$(bin)$(binobj)muon_generator.o : $(muon_generator_cc_dependencies)
	$(cpp_echo) $(src)muon_generator.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Muon_pp_cppflags) $(app_Muon_pp_cppflags) $(muon_generator_pp_cppflags) $(use_cppflags) $(Muon_cppflags) $(app_Muon_cppflags) $(muon_generator_cppflags) $(muon_generator_cc_cppflags)  $(src)muon_generator.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: Muonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Muon.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

Muonclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application Muon
	-$(cleanup_silent) cd $(bin); /bin/rm -f Muon${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects Muon
	-$(cleanup_silent) /bin/rm -f $(bin)muon_generator.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)muon_generator.o) $(patsubst %.o,%.dep,$(bin)muon_generator.o) $(patsubst %.o,%.d.stamp,$(bin)muon_generator.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf Muon_deps Muon_dependencies.make
#-- end of cleanup_objects ------

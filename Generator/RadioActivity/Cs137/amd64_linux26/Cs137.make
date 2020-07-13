#-- start of make_header -----------------

#====================================
#  Application Cs137
#
#   Generated Fri Jul 10 19:14:49 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Cs137_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Cs137_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Cs137

Cs137_tag = $(tag)

#cmt_local_tagfile_Cs137 = $(Cs137_tag)_Cs137.make
cmt_local_tagfile_Cs137 = $(bin)$(Cs137_tag)_Cs137.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Cs137_tag = $(tag)

#cmt_local_tagfile_Cs137 = $(Cs137_tag).make
cmt_local_tagfile_Cs137 = $(bin)$(Cs137_tag).make

endif

include $(cmt_local_tagfile_Cs137)
#-include $(cmt_local_tagfile_Cs137)

ifdef cmt_Cs137_has_target_tag

cmt_final_setup_Cs137 = $(bin)setup_Cs137.make
cmt_dependencies_in_Cs137 = $(bin)dependencies_Cs137.in
#cmt_final_setup_Cs137 = $(bin)Cs137_Cs137setup.make
cmt_local_Cs137_makefile = $(bin)Cs137.make

else

cmt_final_setup_Cs137 = $(bin)setup.make
cmt_dependencies_in_Cs137 = $(bin)dependencies.in
#cmt_final_setup_Cs137 = $(bin)Cs137setup.make
cmt_local_Cs137_makefile = $(bin)Cs137.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Cs137setup.make

#Cs137 :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'Cs137'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Cs137/
#Cs137::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

Cs137 :: dirs  $(bin)Cs137${application_suffix}
	$(echo) "Cs137 ok"

cmt_Cs137_has_prototypes = 1

#--------------------------------------

ifdef cmt_Cs137_has_prototypes

Cs137prototype :  ;

endif

Cs137compile : $(bin)Cs137DecayGen.o ;

#-- end of application_header
#-- start of application

$(bin)Cs137${application_suffix} :: $(bin)Cs137DecayGen.o $(use_stamps) $(Cs137_stamps) $(Cs137stamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)Cs137DecayGen.o $(cmt_installarea_linkopts) $(Cs137_use_linkopts) $(Cs137linkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
Cs137installname = Cs137${application_suffix}

Cs137 :: Cs137install ;

install :: Cs137install ;

Cs137install :: $(install_dir)/$(Cs137installname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(Cs137installname) :: $(bin)$(Cs137installname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Cs137installname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##Cs137clean :: Cs137uninstall

uninstall :: Cs137uninstall ;

Cs137uninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Cs137installname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (Cs137.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),Cs137clean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),Cs137prototype)

$(bin)Cs137_dependencies.make : $(use_requirements) $(cmt_final_setup_Cs137)
	$(echo) "(Cs137.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)Cs137DecayGen.cc -end_all $(includes) $(app_Cs137_cppflags) $(lib_Cs137_cppflags) -name=Cs137 $? -f=$(cmt_dependencies_in_Cs137) -without_cmt

-include $(bin)Cs137_dependencies.make

endif
endif
endif

Cs137clean ::
	$(cleanup_silent) \rm -rf $(bin)Cs137_deps $(bin)Cs137_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),Cs137clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Cs137DecayGen.d

$(bin)$(binobj)Cs137DecayGen.d :

$(bin)$(binobj)Cs137DecayGen.o : $(cmt_final_setup_Cs137)

$(bin)$(binobj)Cs137DecayGen.o : $(src)Cs137DecayGen.cc
	$(cpp_echo) $(src)Cs137DecayGen.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Cs137_pp_cppflags) $(app_Cs137_pp_cppflags) $(Cs137DecayGen_pp_cppflags) $(use_cppflags) $(Cs137_cppflags) $(app_Cs137_cppflags) $(Cs137DecayGen_cppflags) $(Cs137DecayGen_cc_cppflags)  $(src)Cs137DecayGen.cc
endif
endif

else
$(bin)Cs137_dependencies.make : $(Cs137DecayGen_cc_dependencies)

$(bin)Cs137_dependencies.make : $(src)Cs137DecayGen.cc

$(bin)$(binobj)Cs137DecayGen.o : $(Cs137DecayGen_cc_dependencies)
	$(cpp_echo) $(src)Cs137DecayGen.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Cs137_pp_cppflags) $(app_Cs137_pp_cppflags) $(Cs137DecayGen_pp_cppflags) $(use_cppflags) $(Cs137_cppflags) $(app_Cs137_cppflags) $(Cs137DecayGen_cppflags) $(Cs137DecayGen_cc_cppflags)  $(src)Cs137DecayGen.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: Cs137clean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Cs137.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

Cs137clean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application Cs137
	-$(cleanup_silent) cd $(bin); /bin/rm -f Cs137${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects Cs137
	-$(cleanup_silent) /bin/rm -f $(bin)Cs137DecayGen.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)Cs137DecayGen.o) $(patsubst %.o,%.dep,$(bin)Cs137DecayGen.o) $(patsubst %.o,%.d.stamp,$(bin)Cs137DecayGen.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf Cs137_deps Cs137_dependencies.make
#-- end of cleanup_objects ------

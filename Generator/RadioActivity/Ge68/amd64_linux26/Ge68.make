#-- start of make_header -----------------

#====================================
#  Application Ge68
#
#   Generated Fri Jul 10 19:14:55 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Ge68_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Ge68_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Ge68

Ge68_tag = $(tag)

#cmt_local_tagfile_Ge68 = $(Ge68_tag)_Ge68.make
cmt_local_tagfile_Ge68 = $(bin)$(Ge68_tag)_Ge68.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Ge68_tag = $(tag)

#cmt_local_tagfile_Ge68 = $(Ge68_tag).make
cmt_local_tagfile_Ge68 = $(bin)$(Ge68_tag).make

endif

include $(cmt_local_tagfile_Ge68)
#-include $(cmt_local_tagfile_Ge68)

ifdef cmt_Ge68_has_target_tag

cmt_final_setup_Ge68 = $(bin)setup_Ge68.make
cmt_dependencies_in_Ge68 = $(bin)dependencies_Ge68.in
#cmt_final_setup_Ge68 = $(bin)Ge68_Ge68setup.make
cmt_local_Ge68_makefile = $(bin)Ge68.make

else

cmt_final_setup_Ge68 = $(bin)setup.make
cmt_dependencies_in_Ge68 = $(bin)dependencies.in
#cmt_final_setup_Ge68 = $(bin)Ge68setup.make
cmt_local_Ge68_makefile = $(bin)Ge68.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Ge68setup.make

#Ge68 :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'Ge68'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Ge68/
#Ge68::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

Ge68 :: dirs  $(bin)Ge68${application_suffix}
	$(echo) "Ge68 ok"

cmt_Ge68_has_prototypes = 1

#--------------------------------------

ifdef cmt_Ge68_has_prototypes

Ge68prototype :  ;

endif

Ge68compile : $(bin)Ge68.o ;

#-- end of application_header
#-- start of application

$(bin)Ge68${application_suffix} :: $(bin)Ge68.o $(use_stamps) $(Ge68_stamps) $(Ge68stamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)Ge68.o $(cmt_installarea_linkopts) $(Ge68_use_linkopts) $(Ge68linkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
Ge68installname = Ge68${application_suffix}

Ge68 :: Ge68install ;

install :: Ge68install ;

Ge68install :: $(install_dir)/$(Ge68installname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(Ge68installname) :: $(bin)$(Ge68installname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Ge68installname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##Ge68clean :: Ge68uninstall

uninstall :: Ge68uninstall ;

Ge68uninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Ge68installname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (Ge68.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),Ge68clean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),Ge68prototype)

$(bin)Ge68_dependencies.make : $(use_requirements) $(cmt_final_setup_Ge68)
	$(echo) "(Ge68.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)Ge68.cc -end_all $(includes) $(app_Ge68_cppflags) $(lib_Ge68_cppflags) -name=Ge68 $? -f=$(cmt_dependencies_in_Ge68) -without_cmt

-include $(bin)Ge68_dependencies.make

endif
endif
endif

Ge68clean ::
	$(cleanup_silent) \rm -rf $(bin)Ge68_deps $(bin)Ge68_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),Ge68clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Ge68.d

$(bin)$(binobj)Ge68.d :

$(bin)$(binobj)Ge68.o : $(cmt_final_setup_Ge68)

$(bin)$(binobj)Ge68.o : $(src)Ge68.cc
	$(cpp_echo) $(src)Ge68.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Ge68_pp_cppflags) $(app_Ge68_pp_cppflags) $(Ge68_pp_cppflags) $(use_cppflags) $(Ge68_cppflags) $(app_Ge68_cppflags) $(Ge68_cppflags) $(Ge68_cc_cppflags)  $(src)Ge68.cc
endif
endif

else
$(bin)Ge68_dependencies.make : $(Ge68_cc_dependencies)

$(bin)Ge68_dependencies.make : $(src)Ge68.cc

$(bin)$(binobj)Ge68.o : $(Ge68_cc_dependencies)
	$(cpp_echo) $(src)Ge68.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Ge68_pp_cppflags) $(app_Ge68_pp_cppflags) $(Ge68_pp_cppflags) $(use_cppflags) $(Ge68_cppflags) $(app_Ge68_cppflags) $(Ge68_cppflags) $(Ge68_cc_cppflags)  $(src)Ge68.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: Ge68clean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Ge68.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

Ge68clean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application Ge68
	-$(cleanup_silent) cd $(bin); /bin/rm -f Ge68${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects Ge68
	-$(cleanup_silent) /bin/rm -f $(bin)Ge68.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)Ge68.o) $(patsubst %.o,%.dep,$(bin)Ge68.o) $(patsubst %.o,%.d.stamp,$(bin)Ge68.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf Ge68_deps Ge68_dependencies.make
#-- end of cleanup_objects ------

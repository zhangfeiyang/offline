#-- start of make_header -----------------

#====================================
#  Application Cf252
#
#   Generated Fri Jul 10 19:14:54 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Cf252_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Cf252_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Cf252

Cf252_tag = $(tag)

#cmt_local_tagfile_Cf252 = $(Cf252_tag)_Cf252.make
cmt_local_tagfile_Cf252 = $(bin)$(Cf252_tag)_Cf252.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Cf252_tag = $(tag)

#cmt_local_tagfile_Cf252 = $(Cf252_tag).make
cmt_local_tagfile_Cf252 = $(bin)$(Cf252_tag).make

endif

include $(cmt_local_tagfile_Cf252)
#-include $(cmt_local_tagfile_Cf252)

ifdef cmt_Cf252_has_target_tag

cmt_final_setup_Cf252 = $(bin)setup_Cf252.make
cmt_dependencies_in_Cf252 = $(bin)dependencies_Cf252.in
#cmt_final_setup_Cf252 = $(bin)Cf252_Cf252setup.make
cmt_local_Cf252_makefile = $(bin)Cf252.make

else

cmt_final_setup_Cf252 = $(bin)setup.make
cmt_dependencies_in_Cf252 = $(bin)dependencies.in
#cmt_final_setup_Cf252 = $(bin)Cf252setup.make
cmt_local_Cf252_makefile = $(bin)Cf252.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Cf252setup.make

#Cf252 :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'Cf252'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Cf252/
#Cf252::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

Cf252 :: dirs  $(bin)Cf252${application_suffix}
	$(echo) "Cf252 ok"

cmt_Cf252_has_prototypes = 1

#--------------------------------------

ifdef cmt_Cf252_has_prototypes

Cf252prototype :  ;

endif

Cf252compile : $(bin)Cf252.o ;

#-- end of application_header
#-- start of application

$(bin)Cf252${application_suffix} :: $(bin)Cf252.o $(use_stamps) $(Cf252_stamps) $(Cf252stamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)Cf252.o $(cmt_installarea_linkopts) $(Cf252_use_linkopts) $(Cf252linkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
Cf252installname = Cf252${application_suffix}

Cf252 :: Cf252install ;

install :: Cf252install ;

Cf252install :: $(install_dir)/$(Cf252installname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(Cf252installname) :: $(bin)$(Cf252installname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Cf252installname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##Cf252clean :: Cf252uninstall

uninstall :: Cf252uninstall ;

Cf252uninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Cf252installname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (Cf252.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),Cf252clean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),Cf252prototype)

$(bin)Cf252_dependencies.make : $(use_requirements) $(cmt_final_setup_Cf252)
	$(echo) "(Cf252.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)Cf252.cc -end_all $(includes) $(app_Cf252_cppflags) $(lib_Cf252_cppflags) -name=Cf252 $? -f=$(cmt_dependencies_in_Cf252) -without_cmt

-include $(bin)Cf252_dependencies.make

endif
endif
endif

Cf252clean ::
	$(cleanup_silent) \rm -rf $(bin)Cf252_deps $(bin)Cf252_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),Cf252clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Cf252.d

$(bin)$(binobj)Cf252.d :

$(bin)$(binobj)Cf252.o : $(cmt_final_setup_Cf252)

$(bin)$(binobj)Cf252.o : $(src)Cf252.cc
	$(cpp_echo) $(src)Cf252.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Cf252_pp_cppflags) $(app_Cf252_pp_cppflags) $(Cf252_pp_cppflags) $(use_cppflags) $(Cf252_cppflags) $(app_Cf252_cppflags) $(Cf252_cppflags) $(Cf252_cc_cppflags)  $(src)Cf252.cc
endif
endif

else
$(bin)Cf252_dependencies.make : $(Cf252_cc_dependencies)

$(bin)Cf252_dependencies.make : $(src)Cf252.cc

$(bin)$(binobj)Cf252.o : $(Cf252_cc_dependencies)
	$(cpp_echo) $(src)Cf252.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Cf252_pp_cppflags) $(app_Cf252_pp_cppflags) $(Cf252_pp_cppflags) $(use_cppflags) $(Cf252_cppflags) $(app_Cf252_cppflags) $(Cf252_cppflags) $(Cf252_cc_cppflags)  $(src)Cf252.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: Cf252clean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Cf252.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

Cf252clean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application Cf252
	-$(cleanup_silent) cd $(bin); /bin/rm -f Cf252${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects Cf252
	-$(cleanup_silent) /bin/rm -f $(bin)Cf252.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)Cf252.o) $(patsubst %.o,%.dep,$(bin)Cf252.o) $(patsubst %.o,%.d.stamp,$(bin)Cf252.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf Cf252_deps Cf252_dependencies.make
#-- end of cleanup_objects ------

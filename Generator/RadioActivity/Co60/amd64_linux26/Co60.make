#-- start of make_header -----------------

#====================================
#  Application Co60
#
#   Generated Fri Jul 10 19:14:57 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Co60_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Co60_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Co60

Co60_tag = $(tag)

#cmt_local_tagfile_Co60 = $(Co60_tag)_Co60.make
cmt_local_tagfile_Co60 = $(bin)$(Co60_tag)_Co60.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Co60_tag = $(tag)

#cmt_local_tagfile_Co60 = $(Co60_tag).make
cmt_local_tagfile_Co60 = $(bin)$(Co60_tag).make

endif

include $(cmt_local_tagfile_Co60)
#-include $(cmt_local_tagfile_Co60)

ifdef cmt_Co60_has_target_tag

cmt_final_setup_Co60 = $(bin)setup_Co60.make
cmt_dependencies_in_Co60 = $(bin)dependencies_Co60.in
#cmt_final_setup_Co60 = $(bin)Co60_Co60setup.make
cmt_local_Co60_makefile = $(bin)Co60.make

else

cmt_final_setup_Co60 = $(bin)setup.make
cmt_dependencies_in_Co60 = $(bin)dependencies.in
#cmt_final_setup_Co60 = $(bin)Co60setup.make
cmt_local_Co60_makefile = $(bin)Co60.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Co60setup.make

#Co60 :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'Co60'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Co60/
#Co60::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

Co60 :: dirs  $(bin)Co60${application_suffix}
	$(echo) "Co60 ok"

cmt_Co60_has_prototypes = 1

#--------------------------------------

ifdef cmt_Co60_has_prototypes

Co60prototype :  ;

endif

Co60compile : $(bin)Cobalt_60_gammas.o ;

#-- end of application_header
#-- start of application

$(bin)Co60${application_suffix} :: $(bin)Cobalt_60_gammas.o $(use_stamps) $(Co60_stamps) $(Co60stamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)Cobalt_60_gammas.o $(cmt_installarea_linkopts) $(Co60_use_linkopts) $(Co60linkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
Co60installname = Co60${application_suffix}

Co60 :: Co60install ;

install :: Co60install ;

Co60install :: $(install_dir)/$(Co60installname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(Co60installname) :: $(bin)$(Co60installname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Co60installname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##Co60clean :: Co60uninstall

uninstall :: Co60uninstall ;

Co60uninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Co60installname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (Co60.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),Co60clean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),Co60prototype)

$(bin)Co60_dependencies.make : $(use_requirements) $(cmt_final_setup_Co60)
	$(echo) "(Co60.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)Cobalt_60_gammas.cc -end_all $(includes) $(app_Co60_cppflags) $(lib_Co60_cppflags) -name=Co60 $? -f=$(cmt_dependencies_in_Co60) -without_cmt

-include $(bin)Co60_dependencies.make

endif
endif
endif

Co60clean ::
	$(cleanup_silent) \rm -rf $(bin)Co60_deps $(bin)Co60_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),Co60clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Cobalt_60_gammas.d

$(bin)$(binobj)Cobalt_60_gammas.d :

$(bin)$(binobj)Cobalt_60_gammas.o : $(cmt_final_setup_Co60)

$(bin)$(binobj)Cobalt_60_gammas.o : $(src)Cobalt_60_gammas.cc
	$(cpp_echo) $(src)Cobalt_60_gammas.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Co60_pp_cppflags) $(app_Co60_pp_cppflags) $(Cobalt_60_gammas_pp_cppflags) $(use_cppflags) $(Co60_cppflags) $(app_Co60_cppflags) $(Cobalt_60_gammas_cppflags) $(Cobalt_60_gammas_cc_cppflags)  $(src)Cobalt_60_gammas.cc
endif
endif

else
$(bin)Co60_dependencies.make : $(Cobalt_60_gammas_cc_dependencies)

$(bin)Co60_dependencies.make : $(src)Cobalt_60_gammas.cc

$(bin)$(binobj)Cobalt_60_gammas.o : $(Cobalt_60_gammas_cc_dependencies)
	$(cpp_echo) $(src)Cobalt_60_gammas.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Co60_pp_cppflags) $(app_Co60_pp_cppflags) $(Cobalt_60_gammas_pp_cppflags) $(use_cppflags) $(Co60_cppflags) $(app_Co60_cppflags) $(Cobalt_60_gammas_cppflags) $(Cobalt_60_gammas_cc_cppflags)  $(src)Cobalt_60_gammas.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: Co60clean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Co60.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

Co60clean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application Co60
	-$(cleanup_silent) cd $(bin); /bin/rm -f Co60${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects Co60
	-$(cleanup_silent) /bin/rm -f $(bin)Cobalt_60_gammas.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)Cobalt_60_gammas.o) $(patsubst %.o,%.dep,$(bin)Cobalt_60_gammas.o) $(patsubst %.o,%.d.stamp,$(bin)Cobalt_60_gammas.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf Co60_deps Co60_dependencies.make
#-- end of cleanup_objects ------

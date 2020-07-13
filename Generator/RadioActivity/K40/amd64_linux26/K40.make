#-- start of make_header -----------------

#====================================
#  Application K40
#
#   Generated Fri Jul 10 19:14:58 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_K40_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_K40_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_K40

K40_tag = $(tag)

#cmt_local_tagfile_K40 = $(K40_tag)_K40.make
cmt_local_tagfile_K40 = $(bin)$(K40_tag)_K40.make

else

tags      = $(tag),$(CMTEXTRATAGS)

K40_tag = $(tag)

#cmt_local_tagfile_K40 = $(K40_tag).make
cmt_local_tagfile_K40 = $(bin)$(K40_tag).make

endif

include $(cmt_local_tagfile_K40)
#-include $(cmt_local_tagfile_K40)

ifdef cmt_K40_has_target_tag

cmt_final_setup_K40 = $(bin)setup_K40.make
cmt_dependencies_in_K40 = $(bin)dependencies_K40.in
#cmt_final_setup_K40 = $(bin)K40_K40setup.make
cmt_local_K40_makefile = $(bin)K40.make

else

cmt_final_setup_K40 = $(bin)setup.make
cmt_dependencies_in_K40 = $(bin)dependencies.in
#cmt_final_setup_K40 = $(bin)K40setup.make
cmt_local_K40_makefile = $(bin)K40.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)K40setup.make

#K40 :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'K40'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = K40/
#K40::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

K40 :: dirs  $(bin)K40${application_suffix}
	$(echo) "K40 ok"

cmt_K40_has_prototypes = 1

#--------------------------------------

ifdef cmt_K40_has_prototypes

K40prototype :  ;

endif

K40compile : $(bin)Potassium_40_gammas.o ;

#-- end of application_header
#-- start of application

$(bin)K40${application_suffix} :: $(bin)Potassium_40_gammas.o $(use_stamps) $(K40_stamps) $(K40stamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)Potassium_40_gammas.o $(cmt_installarea_linkopts) $(K40_use_linkopts) $(K40linkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
K40installname = K40${application_suffix}

K40 :: K40install ;

install :: K40install ;

K40install :: $(install_dir)/$(K40installname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(K40installname) :: $(bin)$(K40installname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(K40installname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##K40clean :: K40uninstall

uninstall :: K40uninstall ;

K40uninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(K40installname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (K40.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),K40clean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),K40prototype)

$(bin)K40_dependencies.make : $(use_requirements) $(cmt_final_setup_K40)
	$(echo) "(K40.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)Potassium_40_gammas.cc -end_all $(includes) $(app_K40_cppflags) $(lib_K40_cppflags) -name=K40 $? -f=$(cmt_dependencies_in_K40) -without_cmt

-include $(bin)K40_dependencies.make

endif
endif
endif

K40clean ::
	$(cleanup_silent) \rm -rf $(bin)K40_deps $(bin)K40_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),K40clean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Potassium_40_gammas.d

$(bin)$(binobj)Potassium_40_gammas.d :

$(bin)$(binobj)Potassium_40_gammas.o : $(cmt_final_setup_K40)

$(bin)$(binobj)Potassium_40_gammas.o : $(src)Potassium_40_gammas.cc
	$(cpp_echo) $(src)Potassium_40_gammas.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(K40_pp_cppflags) $(app_K40_pp_cppflags) $(Potassium_40_gammas_pp_cppflags) $(use_cppflags) $(K40_cppflags) $(app_K40_cppflags) $(Potassium_40_gammas_cppflags) $(Potassium_40_gammas_cc_cppflags)  $(src)Potassium_40_gammas.cc
endif
endif

else
$(bin)K40_dependencies.make : $(Potassium_40_gammas_cc_dependencies)

$(bin)K40_dependencies.make : $(src)Potassium_40_gammas.cc

$(bin)$(binobj)Potassium_40_gammas.o : $(Potassium_40_gammas_cc_dependencies)
	$(cpp_echo) $(src)Potassium_40_gammas.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(K40_pp_cppflags) $(app_K40_pp_cppflags) $(Potassium_40_gammas_pp_cppflags) $(use_cppflags) $(K40_cppflags) $(app_K40_cppflags) $(Potassium_40_gammas_cppflags) $(Potassium_40_gammas_cc_cppflags)  $(src)Potassium_40_gammas.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: K40clean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(K40.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

K40clean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application K40
	-$(cleanup_silent) cd $(bin); /bin/rm -f K40${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects K40
	-$(cleanup_silent) /bin/rm -f $(bin)Potassium_40_gammas.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)Potassium_40_gammas.o) $(patsubst %.o,%.dep,$(bin)Potassium_40_gammas.o) $(patsubst %.o,%.d.stamp,$(bin)Potassium_40_gammas.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf K40_deps K40_dependencies.make
#-- end of cleanup_objects ------

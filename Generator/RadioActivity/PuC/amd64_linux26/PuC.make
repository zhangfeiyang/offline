#-- start of make_header -----------------

#====================================
#  Application PuC
#
#   Generated Fri Jul 10 19:14:48 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PuC_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PuC_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PuC

PuC_tag = $(tag)

#cmt_local_tagfile_PuC = $(PuC_tag)_PuC.make
cmt_local_tagfile_PuC = $(bin)$(PuC_tag)_PuC.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PuC_tag = $(tag)

#cmt_local_tagfile_PuC = $(PuC_tag).make
cmt_local_tagfile_PuC = $(bin)$(PuC_tag).make

endif

include $(cmt_local_tagfile_PuC)
#-include $(cmt_local_tagfile_PuC)

ifdef cmt_PuC_has_target_tag

cmt_final_setup_PuC = $(bin)setup_PuC.make
cmt_dependencies_in_PuC = $(bin)dependencies_PuC.in
#cmt_final_setup_PuC = $(bin)PuC_PuCsetup.make
cmt_local_PuC_makefile = $(bin)PuC.make

else

cmt_final_setup_PuC = $(bin)setup.make
cmt_dependencies_in_PuC = $(bin)dependencies.in
#cmt_final_setup_PuC = $(bin)PuCsetup.make
cmt_local_PuC_makefile = $(bin)PuC.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PuCsetup.make

#PuC :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PuC'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PuC/
#PuC::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

PuC :: dirs  $(bin)PuC${application_suffix}
	$(echo) "PuC ok"

cmt_PuC_has_prototypes = 1

#--------------------------------------

ifdef cmt_PuC_has_prototypes

PuCprototype :  ;

endif

PuCcompile : $(bin)PuC.o ;

#-- end of application_header
#-- start of application

$(bin)PuC${application_suffix} :: $(bin)PuC.o $(use_stamps) $(PuC_stamps) $(PuCstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)PuC.o $(cmt_installarea_linkopts) $(PuC_use_linkopts) $(PuClinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
PuCinstallname = PuC${application_suffix}

PuC :: PuCinstall ;

install :: PuCinstall ;

PuCinstall :: $(install_dir)/$(PuCinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(PuCinstallname) :: $(bin)$(PuCinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PuCinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##PuCclean :: PuCuninstall

uninstall :: PuCuninstall ;

PuCuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PuCinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (PuC.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),PuCclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),PuCprototype)

$(bin)PuC_dependencies.make : $(use_requirements) $(cmt_final_setup_PuC)
	$(echo) "(PuC.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)PuC.cc -end_all $(includes) $(app_PuC_cppflags) $(lib_PuC_cppflags) -name=PuC $? -f=$(cmt_dependencies_in_PuC) -without_cmt

-include $(bin)PuC_dependencies.make

endif
endif
endif

PuCclean ::
	$(cleanup_silent) \rm -rf $(bin)PuC_deps $(bin)PuC_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),PuCclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PuC.d

$(bin)$(binobj)PuC.d :

$(bin)$(binobj)PuC.o : $(cmt_final_setup_PuC)

$(bin)$(binobj)PuC.o : $(src)PuC.cc
	$(cpp_echo) $(src)PuC.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PuC_pp_cppflags) $(app_PuC_pp_cppflags) $(PuC_pp_cppflags) $(use_cppflags) $(PuC_cppflags) $(app_PuC_cppflags) $(PuC_cppflags) $(PuC_cc_cppflags)  $(src)PuC.cc
endif
endif

else
$(bin)PuC_dependencies.make : $(PuC_cc_dependencies)

$(bin)PuC_dependencies.make : $(src)PuC.cc

$(bin)$(binobj)PuC.o : $(PuC_cc_dependencies)
	$(cpp_echo) $(src)PuC.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PuC_pp_cppflags) $(app_PuC_pp_cppflags) $(PuC_pp_cppflags) $(use_cppflags) $(PuC_cppflags) $(app_PuC_cppflags) $(PuC_cppflags) $(PuC_cc_cppflags)  $(src)PuC.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: PuCclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PuC.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PuCclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application PuC
	-$(cleanup_silent) cd $(bin); /bin/rm -f PuC${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects PuC
	-$(cleanup_silent) /bin/rm -f $(bin)PuC.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PuC.o) $(patsubst %.o,%.dep,$(bin)PuC.o) $(patsubst %.o,%.d.stamp,$(bin)PuC.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf PuC_deps PuC_dependencies.make
#-- end of cleanup_objects ------

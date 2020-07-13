
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

PmtParamSvc_tag = $(tag)

#cmt_local_tagfile = $(PmtParamSvc_tag).make
cmt_local_tagfile = $(bin)$(PmtParamSvc_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)PmtParamSvcsetup.make
cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)$(package)setup.make

cmt_build_library_linksstamp = $(bin)cmt_build_library_links.stamp
#--------------------------------------------------------

#cmt_lock_setup = /tmp/lock$(cmt_lock_pid).make
#cmt_temp_tag = /tmp/tag$(cmt_lock_pid).make

#first :: $(cmt_local_tagfile)
#	@echo $(cmt_local_tagfile) ok
#ifndef QUICK
#first :: $(cmt_final_setup) ;
#else
#first :: ;
#endif

##	@bin=`$(cmtexe) show macro_value bin`

#$(cmt_local_tagfile) : $(cmt_lock_setup)
#	@echo "#CMT> Error: $@: No such file" >&2; exit 1
#$(cmt_local_tagfile) :
#	@echo "#CMT> Warning: $@: No such file" >&2; exit
#	@echo "#CMT> Info: $@: No need to rebuild file" >&2; exit

#$(cmt_final_setup) : $(cmt_local_tagfile) 
#	$(echo) "(constituents.make) Rebuilding $@"
#	@if test ! -d $(@D); then $(mkdir) -p $(@D); fi; \
#	  if test -f $(cmt_local_setup); then /bin/rm -f $(cmt_local_setup); fi; \
#	  trap '/bin/rm -f $(cmt_local_setup)' 0 1 2 15; \
#	  $(cmtexe) -tag=$(tags) show setup >>$(cmt_local_setup); \
#	  if test ! -f $@; then \
#	    mv $(cmt_local_setup) $@; \
#	  else \
#	    if /usr/bin/diff $(cmt_local_setup) $@ >/dev/null ; then \
#	      : ; \
#	    else \
#	      mv $(cmt_local_setup) $@; \
#	    fi; \
#	  fi

#	@/bin/echo $@ ok   

#config :: checkuses
#	@exit 0
#checkuses : ;

env.make ::
	printenv >env.make.tmp; $(cmtexe) check files env.make.tmp env.make

ifndef QUICK
all :: build_library_links ;
else
all :: $(cmt_build_library_linksstamp) ;
endif

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

dirs :: requirements
	@if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi
#	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
#	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

#requirements :
#	@if test ! -r requirements ; then echo "No requirements file" ; fi

build_library_links : dirs
	$(echo) "(constituents.make) Rebuilding library links"; \
	 $(build_library_links)
#	if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi; \
#	$(build_library_links)

$(cmt_build_library_linksstamp) : $(cmt_final_setup) $(cmt_local_tagfile) $(bin)library_links.in
	$(echo) "(constituents.make) Rebuilding library links"; \
	 $(build_library_links) -f=$(bin)library_links.in -without_cmt
	$(silent) \touch $@

ifndef PEDANTIC
.DEFAULT ::
#.DEFAULT :
	$(echo) "(constituents.make) $@: No rule for such target" >&2
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of constituents_header ------
#-- start of group ------

all_groups :: all

all :: $(all_dependencies)  $(all_pre_constituents) $(all_constituents)  $(all_post_constituents)
	$(echo) "all ok."

#	@/bin/echo " all ok."

clean :: allclean

allclean ::  $(all_constituentsclean)
	$(echo) $(all_constituentsclean)
	$(echo) "allclean ok."

#	@echo $(all_constituentsclean)
#	@/bin/echo " allclean ok."

#-- end of group ------
#-- start of group ------

all_groups :: cmt_actions

cmt_actions :: $(cmt_actions_dependencies)  $(cmt_actions_pre_constituents) $(cmt_actions_constituents)  $(cmt_actions_post_constituents)
	$(echo) "cmt_actions ok."

#	@/bin/echo " cmt_actions ok."

clean :: allclean

cmt_actionsclean ::  $(cmt_actions_constituentsclean)
	$(echo) $(cmt_actions_constituentsclean)
	$(echo) "cmt_actionsclean ok."

#	@echo $(cmt_actions_constituentsclean)
#	@/bin/echo " cmt_actionsclean ok."

#-- end of group ------
#-- start of constituent_app_lib ------

cmt_PmtParamSvc_has_no_target_tag = 1
cmt_PmtParamSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_PmtParamSvc_has_target_tag

cmt_local_tagfile_PmtParamSvc = $(bin)$(PmtParamSvc_tag)_PmtParamSvc.make
cmt_final_setup_PmtParamSvc = $(bin)setup_PmtParamSvc.make
cmt_local_PmtParamSvc_makefile = $(bin)PmtParamSvc.make

PmtParamSvc_extratags = -tag_add=target_PmtParamSvc

else

cmt_local_tagfile_PmtParamSvc = $(bin)$(PmtParamSvc_tag).make
cmt_final_setup_PmtParamSvc = $(bin)setup.make
cmt_local_PmtParamSvc_makefile = $(bin)PmtParamSvc.make

endif

not_PmtParamSvccompile_dependencies = { n=0; for p in $?; do m=0; for d in $(PmtParamSvccompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PmtParamSvcdirs :
	@if test ! -d $(bin)PmtParamSvc; then $(mkdir) -p $(bin)PmtParamSvc; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PmtParamSvc
else
PmtParamSvcdirs : ;
endif

ifdef cmt_PmtParamSvc_has_target_tag

ifndef QUICK
$(cmt_local_PmtParamSvc_makefile) : $(PmtParamSvccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PmtParamSvc.make"; \
	  $(cmtexe) -tag=$(tags) $(PmtParamSvc_extratags) build constituent_config -out=$(cmt_local_PmtParamSvc_makefile) PmtParamSvc
else
$(cmt_local_PmtParamSvc_makefile) : $(PmtParamSvccompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PmtParamSvc) ] || \
	  [ ! -f $(cmt_final_setup_PmtParamSvc) ] || \
	  $(not_PmtParamSvccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PmtParamSvc.make"; \
	  $(cmtexe) -tag=$(tags) $(PmtParamSvc_extratags) build constituent_config -out=$(cmt_local_PmtParamSvc_makefile) PmtParamSvc; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PmtParamSvc_makefile) : $(PmtParamSvccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PmtParamSvc.make"; \
	  $(cmtexe) -f=$(bin)PmtParamSvc.in -tag=$(tags) $(PmtParamSvc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PmtParamSvc_makefile) PmtParamSvc
else
$(cmt_local_PmtParamSvc_makefile) : $(PmtParamSvccompile_dependencies) $(cmt_build_library_linksstamp) $(bin)PmtParamSvc.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PmtParamSvc) ] || \
	  [ ! -f $(cmt_final_setup_PmtParamSvc) ] || \
	  $(not_PmtParamSvccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PmtParamSvc.make"; \
	  $(cmtexe) -f=$(bin)PmtParamSvc.in -tag=$(tags) $(PmtParamSvc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PmtParamSvc_makefile) PmtParamSvc; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PmtParamSvc_extratags) build constituent_makefile -out=$(cmt_local_PmtParamSvc_makefile) PmtParamSvc

PmtParamSvc :: PmtParamSvccompile PmtParamSvcinstall ;

ifdef cmt_PmtParamSvc_has_prototypes

PmtParamSvcprototype : $(PmtParamSvcprototype_dependencies) $(cmt_local_PmtParamSvc_makefile) dirs PmtParamSvcdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PmtParamSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_PmtParamSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PmtParamSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

PmtParamSvccompile : PmtParamSvcprototype

endif

PmtParamSvccompile : $(PmtParamSvccompile_dependencies) $(cmt_local_PmtParamSvc_makefile) dirs PmtParamSvcdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PmtParamSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_PmtParamSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PmtParamSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: PmtParamSvcclean ;

PmtParamSvcclean :: $(PmtParamSvcclean_dependencies) ##$(cmt_local_PmtParamSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PmtParamSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_PmtParamSvc_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_PmtParamSvc_makefile) PmtParamSvcclean

##	  /bin/rm -f $(cmt_local_PmtParamSvc_makefile) $(bin)PmtParamSvc_dependencies.make

install :: PmtParamSvcinstall ;

PmtParamSvcinstall :: PmtParamSvccompile $(PmtParamSvc_dependencies) $(cmt_local_PmtParamSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PmtParamSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_PmtParamSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PmtParamSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : PmtParamSvcuninstall

$(foreach d,$(PmtParamSvc_dependencies),$(eval $(d)uninstall_dependencies += PmtParamSvcuninstall))

PmtParamSvcuninstall : $(PmtParamSvcuninstall_dependencies) ##$(cmt_local_PmtParamSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PmtParamSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_PmtParamSvc_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PmtParamSvc_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PmtParamSvcuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PmtParamSvc"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PmtParamSvc done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_more_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_more_includes_has_target_tag

cmt_local_tagfile_install_more_includes = $(bin)$(PmtParamSvc_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(PmtParamSvc_tag).make
cmt_final_setup_install_more_includes = $(bin)setup.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

endif

not_install_more_includes_dependencies = { n=0; for p in $?; do m=0; for d in $(install_more_includes_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_more_includesdirs :
	@if test ! -d $(bin)install_more_includes; then $(mkdir) -p $(bin)install_more_includes; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_more_includes
else
install_more_includesdirs : ;
endif

ifdef cmt_install_more_includes_has_target_tag

ifndef QUICK
$(cmt_local_install_more_includes_makefile) : $(install_more_includes_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_more_includes.make"; \
	  $(cmtexe) -tag=$(tags) $(install_more_includes_extratags) build constituent_config -out=$(cmt_local_install_more_includes_makefile) install_more_includes
else
$(cmt_local_install_more_includes_makefile) : $(install_more_includes_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_more_includes) ] || \
	  [ ! -f $(cmt_final_setup_install_more_includes) ] || \
	  $(not_install_more_includes_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_more_includes.make"; \
	  $(cmtexe) -tag=$(tags) $(install_more_includes_extratags) build constituent_config -out=$(cmt_local_install_more_includes_makefile) install_more_includes; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_more_includes_makefile) : $(install_more_includes_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_more_includes.make"; \
	  $(cmtexe) -f=$(bin)install_more_includes.in -tag=$(tags) $(install_more_includes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_more_includes_makefile) install_more_includes
else
$(cmt_local_install_more_includes_makefile) : $(install_more_includes_dependencies) $(cmt_build_library_linksstamp) $(bin)install_more_includes.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_more_includes) ] || \
	  [ ! -f $(cmt_final_setup_install_more_includes) ] || \
	  $(not_install_more_includes_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_more_includes.make"; \
	  $(cmtexe) -f=$(bin)install_more_includes.in -tag=$(tags) $(install_more_includes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_more_includes_makefile) install_more_includes; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_more_includes_extratags) build constituent_makefile -out=$(cmt_local_install_more_includes_makefile) install_more_includes

install_more_includes :: $(install_more_includes_dependencies) $(cmt_local_install_more_includes_makefile) dirs install_more_includesdirs
	$(echo) "(constituents.make) Starting install_more_includes"
	@if test -f $(cmt_local_install_more_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_more_includes_makefile) install_more_includes; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_more_includes_makefile) install_more_includes
	$(echo) "(constituents.make) install_more_includes done"

clean :: install_more_includesclean ;

install_more_includesclean :: $(install_more_includesclean_dependencies) ##$(cmt_local_install_more_includes_makefile)
	$(echo) "(constituents.make) Starting install_more_includesclean"
	@-if test -f $(cmt_local_install_more_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_more_includes_makefile) install_more_includesclean; \
	fi
	$(echo) "(constituents.make) install_more_includesclean done"
#	@-$(MAKE) -f $(cmt_local_install_more_includes_makefile) install_more_includesclean

##	  /bin/rm -f $(cmt_local_install_more_includes_makefile) $(bin)install_more_includes_dependencies.make

install :: install_more_includesinstall ;

install_more_includesinstall :: $(install_more_includes_dependencies) $(cmt_local_install_more_includes_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_more_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_more_includes_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_more_includes_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_more_includesuninstall

$(foreach d,$(install_more_includes_dependencies),$(eval $(d)uninstall_dependencies += install_more_includesuninstall))

install_more_includesuninstall : $(install_more_includesuninstall_dependencies) ##$(cmt_local_install_more_includes_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_more_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_more_includes_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_more_includes_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_more_includesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_more_includes"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_more_includes done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_PmtParamSvc_python_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_PmtParamSvc_python_has_target_tag

cmt_local_tagfile_PmtParamSvc_python = $(bin)$(PmtParamSvc_tag)_PmtParamSvc_python.make
cmt_final_setup_PmtParamSvc_python = $(bin)setup_PmtParamSvc_python.make
cmt_local_PmtParamSvc_python_makefile = $(bin)PmtParamSvc_python.make

PmtParamSvc_python_extratags = -tag_add=target_PmtParamSvc_python

else

cmt_local_tagfile_PmtParamSvc_python = $(bin)$(PmtParamSvc_tag).make
cmt_final_setup_PmtParamSvc_python = $(bin)setup.make
cmt_local_PmtParamSvc_python_makefile = $(bin)PmtParamSvc_python.make

endif

not_PmtParamSvc_python_dependencies = { n=0; for p in $?; do m=0; for d in $(PmtParamSvc_python_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PmtParamSvc_pythondirs :
	@if test ! -d $(bin)PmtParamSvc_python; then $(mkdir) -p $(bin)PmtParamSvc_python; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PmtParamSvc_python
else
PmtParamSvc_pythondirs : ;
endif

ifdef cmt_PmtParamSvc_python_has_target_tag

ifndef QUICK
$(cmt_local_PmtParamSvc_python_makefile) : $(PmtParamSvc_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building PmtParamSvc_python.make"; \
	  $(cmtexe) -tag=$(tags) $(PmtParamSvc_python_extratags) build constituent_config -out=$(cmt_local_PmtParamSvc_python_makefile) PmtParamSvc_python
else
$(cmt_local_PmtParamSvc_python_makefile) : $(PmtParamSvc_python_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PmtParamSvc_python) ] || \
	  [ ! -f $(cmt_final_setup_PmtParamSvc_python) ] || \
	  $(not_PmtParamSvc_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PmtParamSvc_python.make"; \
	  $(cmtexe) -tag=$(tags) $(PmtParamSvc_python_extratags) build constituent_config -out=$(cmt_local_PmtParamSvc_python_makefile) PmtParamSvc_python; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PmtParamSvc_python_makefile) : $(PmtParamSvc_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building PmtParamSvc_python.make"; \
	  $(cmtexe) -f=$(bin)PmtParamSvc_python.in -tag=$(tags) $(PmtParamSvc_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PmtParamSvc_python_makefile) PmtParamSvc_python
else
$(cmt_local_PmtParamSvc_python_makefile) : $(PmtParamSvc_python_dependencies) $(cmt_build_library_linksstamp) $(bin)PmtParamSvc_python.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PmtParamSvc_python) ] || \
	  [ ! -f $(cmt_final_setup_PmtParamSvc_python) ] || \
	  $(not_PmtParamSvc_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PmtParamSvc_python.make"; \
	  $(cmtexe) -f=$(bin)PmtParamSvc_python.in -tag=$(tags) $(PmtParamSvc_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PmtParamSvc_python_makefile) PmtParamSvc_python; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PmtParamSvc_python_extratags) build constituent_makefile -out=$(cmt_local_PmtParamSvc_python_makefile) PmtParamSvc_python

PmtParamSvc_python :: $(PmtParamSvc_python_dependencies) $(cmt_local_PmtParamSvc_python_makefile) dirs PmtParamSvc_pythondirs
	$(echo) "(constituents.make) Starting PmtParamSvc_python"
	@if test -f $(cmt_local_PmtParamSvc_python_makefile); then \
	  $(MAKE) -f $(cmt_local_PmtParamSvc_python_makefile) PmtParamSvc_python; \
	  fi
#	@$(MAKE) -f $(cmt_local_PmtParamSvc_python_makefile) PmtParamSvc_python
	$(echo) "(constituents.make) PmtParamSvc_python done"

clean :: PmtParamSvc_pythonclean ;

PmtParamSvc_pythonclean :: $(PmtParamSvc_pythonclean_dependencies) ##$(cmt_local_PmtParamSvc_python_makefile)
	$(echo) "(constituents.make) Starting PmtParamSvc_pythonclean"
	@-if test -f $(cmt_local_PmtParamSvc_python_makefile); then \
	  $(MAKE) -f $(cmt_local_PmtParamSvc_python_makefile) PmtParamSvc_pythonclean; \
	fi
	$(echo) "(constituents.make) PmtParamSvc_pythonclean done"
#	@-$(MAKE) -f $(cmt_local_PmtParamSvc_python_makefile) PmtParamSvc_pythonclean

##	  /bin/rm -f $(cmt_local_PmtParamSvc_python_makefile) $(bin)PmtParamSvc_python_dependencies.make

install :: PmtParamSvc_pythoninstall ;

PmtParamSvc_pythoninstall :: $(PmtParamSvc_python_dependencies) $(cmt_local_PmtParamSvc_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PmtParamSvc_python_makefile); then \
	  $(MAKE) -f $(cmt_local_PmtParamSvc_python_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_PmtParamSvc_python_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : PmtParamSvc_pythonuninstall

$(foreach d,$(PmtParamSvc_python_dependencies),$(eval $(d)uninstall_dependencies += PmtParamSvc_pythonuninstall))

PmtParamSvc_pythonuninstall : $(PmtParamSvc_pythonuninstall_dependencies) ##$(cmt_local_PmtParamSvc_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PmtParamSvc_python_makefile); then \
	  $(MAKE) -f $(cmt_local_PmtParamSvc_python_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PmtParamSvc_python_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PmtParamSvc_pythonuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PmtParamSvc_python"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PmtParamSvc_python done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(PmtParamSvc_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(PmtParamSvc_tag).make
cmt_final_setup_make = $(bin)setup.make
cmt_local_make_makefile = $(bin)make.make

endif

not_make_dependencies = { n=0; for p in $?; do m=0; for d in $(make_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
makedirs :
	@if test ! -d $(bin)make; then $(mkdir) -p $(bin)make; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)make
else
makedirs : ;
endif

ifdef cmt_make_has_target_tag

ifndef QUICK
$(cmt_local_make_makefile) : $(make_dependencies) build_library_links
	$(echo) "(constituents.make) Building make.make"; \
	  $(cmtexe) -tag=$(tags) $(make_extratags) build constituent_config -out=$(cmt_local_make_makefile) make
else
$(cmt_local_make_makefile) : $(make_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_make) ] || \
	  [ ! -f $(cmt_final_setup_make) ] || \
	  $(not_make_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building make.make"; \
	  $(cmtexe) -tag=$(tags) $(make_extratags) build constituent_config -out=$(cmt_local_make_makefile) make; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_make_makefile) : $(make_dependencies) build_library_links
	$(echo) "(constituents.make) Building make.make"; \
	  $(cmtexe) -f=$(bin)make.in -tag=$(tags) $(make_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_make_makefile) make
else
$(cmt_local_make_makefile) : $(make_dependencies) $(cmt_build_library_linksstamp) $(bin)make.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_make) ] || \
	  [ ! -f $(cmt_final_setup_make) ] || \
	  $(not_make_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building make.make"; \
	  $(cmtexe) -f=$(bin)make.in -tag=$(tags) $(make_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_make_makefile) make; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(make_extratags) build constituent_makefile -out=$(cmt_local_make_makefile) make

make :: $(make_dependencies) $(cmt_local_make_makefile) dirs makedirs
	$(echo) "(constituents.make) Starting make"
	@if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) make; \
	  fi
#	@$(MAKE) -f $(cmt_local_make_makefile) make
	$(echo) "(constituents.make) make done"

clean :: makeclean ;

makeclean :: $(makeclean_dependencies) ##$(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting makeclean"
	@-if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) makeclean; \
	fi
	$(echo) "(constituents.make) makeclean done"
#	@-$(MAKE) -f $(cmt_local_make_makefile) makeclean

##	  /bin/rm -f $(cmt_local_make_makefile) $(bin)make_dependencies.make

install :: makeinstall ;

makeinstall :: $(make_dependencies) $(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_make_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : makeuninstall

$(foreach d,$(make_dependencies),$(eval $(d)uninstall_dependencies += makeuninstall))

makeuninstall : $(makeuninstall_dependencies) ##$(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_make_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: makeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ make"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ make done"
endif

#-- end of constituent ------
#-- start of constituents_trailer ------

uninstall : remove_library_links ;
clean ::
	$(cleanup_echo) $(cmt_build_library_linksstamp)
	-$(cleanup_silent) \rm -f $(cmt_build_library_linksstamp)
#clean :: remove_library_links

remove_library_links ::
ifndef QUICK
	$(echo) "(constituents.make) Removing library links"; \
	  $(remove_library_links)
else
	$(echo) "(constituents.make) Removing library links"; \
	  $(remove_library_links) -f=$(bin)library_links.in -without_cmt
endif

#-- end of constituents_trailer ------

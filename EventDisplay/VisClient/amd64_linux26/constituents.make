
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

VisClient_tag = $(tag)

#cmt_local_tagfile = $(VisClient_tag).make
cmt_local_tagfile = $(bin)$(VisClient_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)VisClientsetup.make
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
#-- start of constituent ------

cmt_VisClientDict_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_VisClientDict_has_target_tag

cmt_local_tagfile_VisClientDict = $(bin)$(VisClient_tag)_VisClientDict.make
cmt_final_setup_VisClientDict = $(bin)setup_VisClientDict.make
cmt_local_VisClientDict_makefile = $(bin)VisClientDict.make

VisClientDict_extratags = -tag_add=target_VisClientDict

else

cmt_local_tagfile_VisClientDict = $(bin)$(VisClient_tag).make
cmt_final_setup_VisClientDict = $(bin)setup.make
cmt_local_VisClientDict_makefile = $(bin)VisClientDict.make

endif

not_VisClientDict_dependencies = { n=0; for p in $?; do m=0; for d in $(VisClientDict_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
VisClientDictdirs :
	@if test ! -d $(bin)VisClientDict; then $(mkdir) -p $(bin)VisClientDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)VisClientDict
else
VisClientDictdirs : ;
endif

ifdef cmt_VisClientDict_has_target_tag

ifndef QUICK
$(cmt_local_VisClientDict_makefile) : $(VisClientDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building VisClientDict.make"; \
	  $(cmtexe) -tag=$(tags) $(VisClientDict_extratags) build constituent_config -out=$(cmt_local_VisClientDict_makefile) VisClientDict
else
$(cmt_local_VisClientDict_makefile) : $(VisClientDict_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_VisClientDict) ] || \
	  [ ! -f $(cmt_final_setup_VisClientDict) ] || \
	  $(not_VisClientDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building VisClientDict.make"; \
	  $(cmtexe) -tag=$(tags) $(VisClientDict_extratags) build constituent_config -out=$(cmt_local_VisClientDict_makefile) VisClientDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_VisClientDict_makefile) : $(VisClientDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building VisClientDict.make"; \
	  $(cmtexe) -f=$(bin)VisClientDict.in -tag=$(tags) $(VisClientDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_VisClientDict_makefile) VisClientDict
else
$(cmt_local_VisClientDict_makefile) : $(VisClientDict_dependencies) $(cmt_build_library_linksstamp) $(bin)VisClientDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_VisClientDict) ] || \
	  [ ! -f $(cmt_final_setup_VisClientDict) ] || \
	  $(not_VisClientDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building VisClientDict.make"; \
	  $(cmtexe) -f=$(bin)VisClientDict.in -tag=$(tags) $(VisClientDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_VisClientDict_makefile) VisClientDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(VisClientDict_extratags) build constituent_makefile -out=$(cmt_local_VisClientDict_makefile) VisClientDict

VisClientDict :: $(VisClientDict_dependencies) $(cmt_local_VisClientDict_makefile) dirs VisClientDictdirs
	$(echo) "(constituents.make) Starting VisClientDict"
	@if test -f $(cmt_local_VisClientDict_makefile); then \
	  $(MAKE) -f $(cmt_local_VisClientDict_makefile) VisClientDict; \
	  fi
#	@$(MAKE) -f $(cmt_local_VisClientDict_makefile) VisClientDict
	$(echo) "(constituents.make) VisClientDict done"

clean :: VisClientDictclean ;

VisClientDictclean :: $(VisClientDictclean_dependencies) ##$(cmt_local_VisClientDict_makefile)
	$(echo) "(constituents.make) Starting VisClientDictclean"
	@-if test -f $(cmt_local_VisClientDict_makefile); then \
	  $(MAKE) -f $(cmt_local_VisClientDict_makefile) VisClientDictclean; \
	fi
	$(echo) "(constituents.make) VisClientDictclean done"
#	@-$(MAKE) -f $(cmt_local_VisClientDict_makefile) VisClientDictclean

##	  /bin/rm -f $(cmt_local_VisClientDict_makefile) $(bin)VisClientDict_dependencies.make

install :: VisClientDictinstall ;

VisClientDictinstall :: $(VisClientDict_dependencies) $(cmt_local_VisClientDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_VisClientDict_makefile); then \
	  $(MAKE) -f $(cmt_local_VisClientDict_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_VisClientDict_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : VisClientDictuninstall

$(foreach d,$(VisClientDict_dependencies),$(eval $(d)uninstall_dependencies += VisClientDictuninstall))

VisClientDictuninstall : $(VisClientDictuninstall_dependencies) ##$(cmt_local_VisClientDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_VisClientDict_makefile); then \
	  $(MAKE) -f $(cmt_local_VisClientDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_VisClientDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: VisClientDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ VisClientDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ VisClientDict done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_more_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_more_includes_has_target_tag

cmt_local_tagfile_install_more_includes = $(bin)$(VisClient_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(VisClient_tag).make
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
#-- start of constituent_app_lib ------

cmt_VisClient_has_no_target_tag = 1
cmt_VisClient_has_prototypes = 1

#--------------------------------------

ifdef cmt_VisClient_has_target_tag

cmt_local_tagfile_VisClient = $(bin)$(VisClient_tag)_VisClient.make
cmt_final_setup_VisClient = $(bin)setup_VisClient.make
cmt_local_VisClient_makefile = $(bin)VisClient.make

VisClient_extratags = -tag_add=target_VisClient

else

cmt_local_tagfile_VisClient = $(bin)$(VisClient_tag).make
cmt_final_setup_VisClient = $(bin)setup.make
cmt_local_VisClient_makefile = $(bin)VisClient.make

endif

not_VisClientcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(VisClientcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
VisClientdirs :
	@if test ! -d $(bin)VisClient; then $(mkdir) -p $(bin)VisClient; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)VisClient
else
VisClientdirs : ;
endif

ifdef cmt_VisClient_has_target_tag

ifndef QUICK
$(cmt_local_VisClient_makefile) : $(VisClientcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building VisClient.make"; \
	  $(cmtexe) -tag=$(tags) $(VisClient_extratags) build constituent_config -out=$(cmt_local_VisClient_makefile) VisClient
else
$(cmt_local_VisClient_makefile) : $(VisClientcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_VisClient) ] || \
	  [ ! -f $(cmt_final_setup_VisClient) ] || \
	  $(not_VisClientcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building VisClient.make"; \
	  $(cmtexe) -tag=$(tags) $(VisClient_extratags) build constituent_config -out=$(cmt_local_VisClient_makefile) VisClient; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_VisClient_makefile) : $(VisClientcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building VisClient.make"; \
	  $(cmtexe) -f=$(bin)VisClient.in -tag=$(tags) $(VisClient_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_VisClient_makefile) VisClient
else
$(cmt_local_VisClient_makefile) : $(VisClientcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)VisClient.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_VisClient) ] || \
	  [ ! -f $(cmt_final_setup_VisClient) ] || \
	  $(not_VisClientcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building VisClient.make"; \
	  $(cmtexe) -f=$(bin)VisClient.in -tag=$(tags) $(VisClient_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_VisClient_makefile) VisClient; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(VisClient_extratags) build constituent_makefile -out=$(cmt_local_VisClient_makefile) VisClient

VisClient :: VisClientcompile VisClientinstall ;

ifdef cmt_VisClient_has_prototypes

VisClientprototype : $(VisClientprototype_dependencies) $(cmt_local_VisClient_makefile) dirs VisClientdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_VisClient_makefile); then \
	  $(MAKE) -f $(cmt_local_VisClient_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_VisClient_makefile) $@
	$(echo) "(constituents.make) $@ done"

VisClientcompile : VisClientprototype

endif

VisClientcompile : $(VisClientcompile_dependencies) $(cmt_local_VisClient_makefile) dirs VisClientdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_VisClient_makefile); then \
	  $(MAKE) -f $(cmt_local_VisClient_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_VisClient_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: VisClientclean ;

VisClientclean :: $(VisClientclean_dependencies) ##$(cmt_local_VisClient_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_VisClient_makefile); then \
	  $(MAKE) -f $(cmt_local_VisClient_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_VisClient_makefile) VisClientclean

##	  /bin/rm -f $(cmt_local_VisClient_makefile) $(bin)VisClient_dependencies.make

install :: VisClientinstall ;

VisClientinstall :: VisClientcompile $(VisClient_dependencies) $(cmt_local_VisClient_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_VisClient_makefile); then \
	  $(MAKE) -f $(cmt_local_VisClient_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_VisClient_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : VisClientuninstall

$(foreach d,$(VisClient_dependencies),$(eval $(d)uninstall_dependencies += VisClientuninstall))

VisClientuninstall : $(VisClientuninstall_dependencies) ##$(cmt_local_VisClient_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_VisClient_makefile); then \
	  $(MAKE) -f $(cmt_local_VisClient_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_VisClient_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: VisClientuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ VisClient"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ VisClient done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_serena_has_no_target_tag = 1
cmt_serena_has_prototypes = 1

#--------------------------------------

ifdef cmt_serena_has_target_tag

cmt_local_tagfile_serena = $(bin)$(VisClient_tag)_serena.make
cmt_final_setup_serena = $(bin)setup_serena.make
cmt_local_serena_makefile = $(bin)serena.make

serena_extratags = -tag_add=target_serena

else

cmt_local_tagfile_serena = $(bin)$(VisClient_tag).make
cmt_final_setup_serena = $(bin)setup.make
cmt_local_serena_makefile = $(bin)serena.make

endif

not_serenacompile_dependencies = { n=0; for p in $?; do m=0; for d in $(serenacompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
serenadirs :
	@if test ! -d $(bin)serena; then $(mkdir) -p $(bin)serena; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)serena
else
serenadirs : ;
endif

ifdef cmt_serena_has_target_tag

ifndef QUICK
$(cmt_local_serena_makefile) : $(serenacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building serena.make"; \
	  $(cmtexe) -tag=$(tags) $(serena_extratags) build constituent_config -out=$(cmt_local_serena_makefile) serena
else
$(cmt_local_serena_makefile) : $(serenacompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_serena) ] || \
	  [ ! -f $(cmt_final_setup_serena) ] || \
	  $(not_serenacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building serena.make"; \
	  $(cmtexe) -tag=$(tags) $(serena_extratags) build constituent_config -out=$(cmt_local_serena_makefile) serena; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_serena_makefile) : $(serenacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building serena.make"; \
	  $(cmtexe) -f=$(bin)serena.in -tag=$(tags) $(serena_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_serena_makefile) serena
else
$(cmt_local_serena_makefile) : $(serenacompile_dependencies) $(cmt_build_library_linksstamp) $(bin)serena.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_serena) ] || \
	  [ ! -f $(cmt_final_setup_serena) ] || \
	  $(not_serenacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building serena.make"; \
	  $(cmtexe) -f=$(bin)serena.in -tag=$(tags) $(serena_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_serena_makefile) serena; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(serena_extratags) build constituent_makefile -out=$(cmt_local_serena_makefile) serena

serena :: serenacompile serenainstall ;

ifdef cmt_serena_has_prototypes

serenaprototype : $(serenaprototype_dependencies) $(cmt_local_serena_makefile) dirs serenadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_serena_makefile); then \
	  $(MAKE) -f $(cmt_local_serena_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_serena_makefile) $@
	$(echo) "(constituents.make) $@ done"

serenacompile : serenaprototype

endif

serenacompile : $(serenacompile_dependencies) $(cmt_local_serena_makefile) dirs serenadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_serena_makefile); then \
	  $(MAKE) -f $(cmt_local_serena_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_serena_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: serenaclean ;

serenaclean :: $(serenaclean_dependencies) ##$(cmt_local_serena_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_serena_makefile); then \
	  $(MAKE) -f $(cmt_local_serena_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_serena_makefile) serenaclean

##	  /bin/rm -f $(cmt_local_serena_makefile) $(bin)serena_dependencies.make

install :: serenainstall ;

serenainstall :: serenacompile $(serena_dependencies) $(cmt_local_serena_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_serena_makefile); then \
	  $(MAKE) -f $(cmt_local_serena_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_serena_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : serenauninstall

$(foreach d,$(serena_dependencies),$(eval $(d)uninstall_dependencies += serenauninstall))

serenauninstall : $(serenauninstall_dependencies) ##$(cmt_local_serena_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_serena_makefile); then \
	  $(MAKE) -f $(cmt_local_serena_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_serena_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: serenauninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ serena"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ serena done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(VisClient_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(VisClient_tag).make
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

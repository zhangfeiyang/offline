
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

Context_tag = $(tag)

#cmt_local_tagfile = $(Context_tag).make
cmt_local_tagfile = $(bin)$(Context_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)Contextsetup.make
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

cmt_install_more_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_more_includes_has_target_tag

cmt_local_tagfile_install_more_includes = $(bin)$(Context_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(Context_tag).make
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

cmt_ContextDict_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_ContextDict_has_target_tag

cmt_local_tagfile_ContextDict = $(bin)$(Context_tag)_ContextDict.make
cmt_final_setup_ContextDict = $(bin)setup_ContextDict.make
cmt_local_ContextDict_makefile = $(bin)ContextDict.make

ContextDict_extratags = -tag_add=target_ContextDict

else

cmt_local_tagfile_ContextDict = $(bin)$(Context_tag).make
cmt_final_setup_ContextDict = $(bin)setup.make
cmt_local_ContextDict_makefile = $(bin)ContextDict.make

endif

not_ContextDict_dependencies = { n=0; for p in $?; do m=0; for d in $(ContextDict_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
ContextDictdirs :
	@if test ! -d $(bin)ContextDict; then $(mkdir) -p $(bin)ContextDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)ContextDict
else
ContextDictdirs : ;
endif

ifdef cmt_ContextDict_has_target_tag

ifndef QUICK
$(cmt_local_ContextDict_makefile) : $(ContextDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building ContextDict.make"; \
	  $(cmtexe) -tag=$(tags) $(ContextDict_extratags) build constituent_config -out=$(cmt_local_ContextDict_makefile) ContextDict
else
$(cmt_local_ContextDict_makefile) : $(ContextDict_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ContextDict) ] || \
	  [ ! -f $(cmt_final_setup_ContextDict) ] || \
	  $(not_ContextDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ContextDict.make"; \
	  $(cmtexe) -tag=$(tags) $(ContextDict_extratags) build constituent_config -out=$(cmt_local_ContextDict_makefile) ContextDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_ContextDict_makefile) : $(ContextDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building ContextDict.make"; \
	  $(cmtexe) -f=$(bin)ContextDict.in -tag=$(tags) $(ContextDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ContextDict_makefile) ContextDict
else
$(cmt_local_ContextDict_makefile) : $(ContextDict_dependencies) $(cmt_build_library_linksstamp) $(bin)ContextDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ContextDict) ] || \
	  [ ! -f $(cmt_final_setup_ContextDict) ] || \
	  $(not_ContextDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ContextDict.make"; \
	  $(cmtexe) -f=$(bin)ContextDict.in -tag=$(tags) $(ContextDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ContextDict_makefile) ContextDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(ContextDict_extratags) build constituent_makefile -out=$(cmt_local_ContextDict_makefile) ContextDict

ContextDict :: $(ContextDict_dependencies) $(cmt_local_ContextDict_makefile) dirs ContextDictdirs
	$(echo) "(constituents.make) Starting ContextDict"
	@if test -f $(cmt_local_ContextDict_makefile); then \
	  $(MAKE) -f $(cmt_local_ContextDict_makefile) ContextDict; \
	  fi
#	@$(MAKE) -f $(cmt_local_ContextDict_makefile) ContextDict
	$(echo) "(constituents.make) ContextDict done"

clean :: ContextDictclean ;

ContextDictclean :: $(ContextDictclean_dependencies) ##$(cmt_local_ContextDict_makefile)
	$(echo) "(constituents.make) Starting ContextDictclean"
	@-if test -f $(cmt_local_ContextDict_makefile); then \
	  $(MAKE) -f $(cmt_local_ContextDict_makefile) ContextDictclean; \
	fi
	$(echo) "(constituents.make) ContextDictclean done"
#	@-$(MAKE) -f $(cmt_local_ContextDict_makefile) ContextDictclean

##	  /bin/rm -f $(cmt_local_ContextDict_makefile) $(bin)ContextDict_dependencies.make

install :: ContextDictinstall ;

ContextDictinstall :: $(ContextDict_dependencies) $(cmt_local_ContextDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_ContextDict_makefile); then \
	  $(MAKE) -f $(cmt_local_ContextDict_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_ContextDict_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : ContextDictuninstall

$(foreach d,$(ContextDict_dependencies),$(eval $(d)uninstall_dependencies += ContextDictuninstall))

ContextDictuninstall : $(ContextDictuninstall_dependencies) ##$(cmt_local_ContextDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_ContextDict_makefile); then \
	  $(MAKE) -f $(cmt_local_ContextDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_ContextDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: ContextDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ ContextDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ ContextDict done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_Context_has_no_target_tag = 1
cmt_Context_has_prototypes = 1

#--------------------------------------

ifdef cmt_Context_has_target_tag

cmt_local_tagfile_Context = $(bin)$(Context_tag)_Context.make
cmt_final_setup_Context = $(bin)setup_Context.make
cmt_local_Context_makefile = $(bin)Context.make

Context_extratags = -tag_add=target_Context

else

cmt_local_tagfile_Context = $(bin)$(Context_tag).make
cmt_final_setup_Context = $(bin)setup.make
cmt_local_Context_makefile = $(bin)Context.make

endif

not_Contextcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(Contextcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
Contextdirs :
	@if test ! -d $(bin)Context; then $(mkdir) -p $(bin)Context; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)Context
else
Contextdirs : ;
endif

ifdef cmt_Context_has_target_tag

ifndef QUICK
$(cmt_local_Context_makefile) : $(Contextcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building Context.make"; \
	  $(cmtexe) -tag=$(tags) $(Context_extratags) build constituent_config -out=$(cmt_local_Context_makefile) Context
else
$(cmt_local_Context_makefile) : $(Contextcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Context) ] || \
	  [ ! -f $(cmt_final_setup_Context) ] || \
	  $(not_Contextcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Context.make"; \
	  $(cmtexe) -tag=$(tags) $(Context_extratags) build constituent_config -out=$(cmt_local_Context_makefile) Context; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_Context_makefile) : $(Contextcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building Context.make"; \
	  $(cmtexe) -f=$(bin)Context.in -tag=$(tags) $(Context_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Context_makefile) Context
else
$(cmt_local_Context_makefile) : $(Contextcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)Context.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Context) ] || \
	  [ ! -f $(cmt_final_setup_Context) ] || \
	  $(not_Contextcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Context.make"; \
	  $(cmtexe) -f=$(bin)Context.in -tag=$(tags) $(Context_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Context_makefile) Context; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(Context_extratags) build constituent_makefile -out=$(cmt_local_Context_makefile) Context

Context :: Contextcompile Contextinstall ;

ifdef cmt_Context_has_prototypes

Contextprototype : $(Contextprototype_dependencies) $(cmt_local_Context_makefile) dirs Contextdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Context_makefile); then \
	  $(MAKE) -f $(cmt_local_Context_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Context_makefile) $@
	$(echo) "(constituents.make) $@ done"

Contextcompile : Contextprototype

endif

Contextcompile : $(Contextcompile_dependencies) $(cmt_local_Context_makefile) dirs Contextdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Context_makefile); then \
	  $(MAKE) -f $(cmt_local_Context_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Context_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: Contextclean ;

Contextclean :: $(Contextclean_dependencies) ##$(cmt_local_Context_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_Context_makefile); then \
	  $(MAKE) -f $(cmt_local_Context_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_Context_makefile) Contextclean

##	  /bin/rm -f $(cmt_local_Context_makefile) $(bin)Context_dependencies.make

install :: Contextinstall ;

Contextinstall :: Contextcompile $(Context_dependencies) $(cmt_local_Context_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Context_makefile); then \
	  $(MAKE) -f $(cmt_local_Context_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Context_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : Contextuninstall

$(foreach d,$(Context_dependencies),$(eval $(d)uninstall_dependencies += Contextuninstall))

Contextuninstall : $(Contextuninstall_dependencies) ##$(cmt_local_Context_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_Context_makefile); then \
	  $(MAKE) -f $(cmt_local_Context_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_Context_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: Contextuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ Context"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ Context done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Context_write_has_no_target_tag = 1
cmt_test_Context_write_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Context_write_has_target_tag

cmt_local_tagfile_test_Context_write = $(bin)$(Context_tag)_test_Context_write.make
cmt_final_setup_test_Context_write = $(bin)setup_test_Context_write.make
cmt_local_test_Context_write_makefile = $(bin)test_Context_write.make

test_Context_write_extratags = -tag_add=target_test_Context_write

else

cmt_local_tagfile_test_Context_write = $(bin)$(Context_tag).make
cmt_final_setup_test_Context_write = $(bin)setup.make
cmt_local_test_Context_write_makefile = $(bin)test_Context_write.make

endif

not_test_Context_writecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Context_writecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Context_writedirs :
	@if test ! -d $(bin)test_Context_write; then $(mkdir) -p $(bin)test_Context_write; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Context_write
else
test_Context_writedirs : ;
endif

ifdef cmt_test_Context_write_has_target_tag

ifndef QUICK
$(cmt_local_test_Context_write_makefile) : $(test_Context_writecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Context_write.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Context_write_extratags) build constituent_config -out=$(cmt_local_test_Context_write_makefile) test_Context_write
else
$(cmt_local_test_Context_write_makefile) : $(test_Context_writecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Context_write) ] || \
	  [ ! -f $(cmt_final_setup_test_Context_write) ] || \
	  $(not_test_Context_writecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Context_write.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Context_write_extratags) build constituent_config -out=$(cmt_local_test_Context_write_makefile) test_Context_write; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Context_write_makefile) : $(test_Context_writecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Context_write.make"; \
	  $(cmtexe) -f=$(bin)test_Context_write.in -tag=$(tags) $(test_Context_write_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Context_write_makefile) test_Context_write
else
$(cmt_local_test_Context_write_makefile) : $(test_Context_writecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Context_write.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Context_write) ] || \
	  [ ! -f $(cmt_final_setup_test_Context_write) ] || \
	  $(not_test_Context_writecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Context_write.make"; \
	  $(cmtexe) -f=$(bin)test_Context_write.in -tag=$(tags) $(test_Context_write_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Context_write_makefile) test_Context_write; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Context_write_extratags) build constituent_makefile -out=$(cmt_local_test_Context_write_makefile) test_Context_write

test_Context_write :: test_Context_writecompile test_Context_writeinstall ;

ifdef cmt_test_Context_write_has_prototypes

test_Context_writeprototype : $(test_Context_writeprototype_dependencies) $(cmt_local_test_Context_write_makefile) dirs test_Context_writedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Context_write_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Context_write_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Context_write_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Context_writecompile : test_Context_writeprototype

endif

test_Context_writecompile : $(test_Context_writecompile_dependencies) $(cmt_local_test_Context_write_makefile) dirs test_Context_writedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Context_write_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Context_write_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Context_write_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Context_writeclean ;

test_Context_writeclean :: $(test_Context_writeclean_dependencies) ##$(cmt_local_test_Context_write_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Context_write_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Context_write_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Context_write_makefile) test_Context_writeclean

##	  /bin/rm -f $(cmt_local_test_Context_write_makefile) $(bin)test_Context_write_dependencies.make

install :: test_Context_writeinstall ;

test_Context_writeinstall :: test_Context_writecompile $(test_Context_write_dependencies) $(cmt_local_test_Context_write_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Context_write_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Context_write_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Context_write_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Context_writeuninstall

$(foreach d,$(test_Context_write_dependencies),$(eval $(d)uninstall_dependencies += test_Context_writeuninstall))

test_Context_writeuninstall : $(test_Context_writeuninstall_dependencies) ##$(cmt_local_test_Context_write_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Context_write_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Context_write_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Context_write_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Context_writeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Context_write"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Context_write done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Context_read_has_no_target_tag = 1
cmt_test_Context_read_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Context_read_has_target_tag

cmt_local_tagfile_test_Context_read = $(bin)$(Context_tag)_test_Context_read.make
cmt_final_setup_test_Context_read = $(bin)setup_test_Context_read.make
cmt_local_test_Context_read_makefile = $(bin)test_Context_read.make

test_Context_read_extratags = -tag_add=target_test_Context_read

else

cmt_local_tagfile_test_Context_read = $(bin)$(Context_tag).make
cmt_final_setup_test_Context_read = $(bin)setup.make
cmt_local_test_Context_read_makefile = $(bin)test_Context_read.make

endif

not_test_Context_readcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Context_readcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Context_readdirs :
	@if test ! -d $(bin)test_Context_read; then $(mkdir) -p $(bin)test_Context_read; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Context_read
else
test_Context_readdirs : ;
endif

ifdef cmt_test_Context_read_has_target_tag

ifndef QUICK
$(cmt_local_test_Context_read_makefile) : $(test_Context_readcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Context_read.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Context_read_extratags) build constituent_config -out=$(cmt_local_test_Context_read_makefile) test_Context_read
else
$(cmt_local_test_Context_read_makefile) : $(test_Context_readcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Context_read) ] || \
	  [ ! -f $(cmt_final_setup_test_Context_read) ] || \
	  $(not_test_Context_readcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Context_read.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Context_read_extratags) build constituent_config -out=$(cmt_local_test_Context_read_makefile) test_Context_read; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Context_read_makefile) : $(test_Context_readcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Context_read.make"; \
	  $(cmtexe) -f=$(bin)test_Context_read.in -tag=$(tags) $(test_Context_read_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Context_read_makefile) test_Context_read
else
$(cmt_local_test_Context_read_makefile) : $(test_Context_readcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Context_read.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Context_read) ] || \
	  [ ! -f $(cmt_final_setup_test_Context_read) ] || \
	  $(not_test_Context_readcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Context_read.make"; \
	  $(cmtexe) -f=$(bin)test_Context_read.in -tag=$(tags) $(test_Context_read_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Context_read_makefile) test_Context_read; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Context_read_extratags) build constituent_makefile -out=$(cmt_local_test_Context_read_makefile) test_Context_read

test_Context_read :: test_Context_readcompile test_Context_readinstall ;

ifdef cmt_test_Context_read_has_prototypes

test_Context_readprototype : $(test_Context_readprototype_dependencies) $(cmt_local_test_Context_read_makefile) dirs test_Context_readdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Context_read_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Context_read_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Context_read_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Context_readcompile : test_Context_readprototype

endif

test_Context_readcompile : $(test_Context_readcompile_dependencies) $(cmt_local_test_Context_read_makefile) dirs test_Context_readdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Context_read_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Context_read_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Context_read_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Context_readclean ;

test_Context_readclean :: $(test_Context_readclean_dependencies) ##$(cmt_local_test_Context_read_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Context_read_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Context_read_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Context_read_makefile) test_Context_readclean

##	  /bin/rm -f $(cmt_local_test_Context_read_makefile) $(bin)test_Context_read_dependencies.make

install :: test_Context_readinstall ;

test_Context_readinstall :: test_Context_readcompile $(test_Context_read_dependencies) $(cmt_local_test_Context_read_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Context_read_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Context_read_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Context_read_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Context_readuninstall

$(foreach d,$(test_Context_read_dependencies),$(eval $(d)uninstall_dependencies += test_Context_readuninstall))

test_Context_readuninstall : $(test_Context_readuninstall_dependencies) ##$(cmt_local_test_Context_read_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Context_read_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Context_read_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Context_read_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Context_readuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Context_read"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Context_read done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(Context_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(Context_tag).make
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

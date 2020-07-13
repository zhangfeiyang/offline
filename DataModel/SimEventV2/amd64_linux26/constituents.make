
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

SimEventV2_tag = $(tag)

#cmt_local_tagfile = $(SimEventV2_tag).make
cmt_local_tagfile = $(bin)$(SimEventV2_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)SimEventV2setup.make
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

cmt_local_tagfile_install_more_includes = $(bin)$(SimEventV2_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(SimEventV2_tag).make
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

cmt_SimEventV2Dict_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_SimEventV2Dict_has_target_tag

cmt_local_tagfile_SimEventV2Dict = $(bin)$(SimEventV2_tag)_SimEventV2Dict.make
cmt_final_setup_SimEventV2Dict = $(bin)setup_SimEventV2Dict.make
cmt_local_SimEventV2Dict_makefile = $(bin)SimEventV2Dict.make

SimEventV2Dict_extratags = -tag_add=target_SimEventV2Dict

else

cmt_local_tagfile_SimEventV2Dict = $(bin)$(SimEventV2_tag).make
cmt_final_setup_SimEventV2Dict = $(bin)setup.make
cmt_local_SimEventV2Dict_makefile = $(bin)SimEventV2Dict.make

endif

not_SimEventV2Dict_dependencies = { n=0; for p in $?; do m=0; for d in $(SimEventV2Dict_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
SimEventV2Dictdirs :
	@if test ! -d $(bin)SimEventV2Dict; then $(mkdir) -p $(bin)SimEventV2Dict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)SimEventV2Dict
else
SimEventV2Dictdirs : ;
endif

ifdef cmt_SimEventV2Dict_has_target_tag

ifndef QUICK
$(cmt_local_SimEventV2Dict_makefile) : $(SimEventV2Dict_dependencies) build_library_links
	$(echo) "(constituents.make) Building SimEventV2Dict.make"; \
	  $(cmtexe) -tag=$(tags) $(SimEventV2Dict_extratags) build constituent_config -out=$(cmt_local_SimEventV2Dict_makefile) SimEventV2Dict
else
$(cmt_local_SimEventV2Dict_makefile) : $(SimEventV2Dict_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_SimEventV2Dict) ] || \
	  [ ! -f $(cmt_final_setup_SimEventV2Dict) ] || \
	  $(not_SimEventV2Dict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building SimEventV2Dict.make"; \
	  $(cmtexe) -tag=$(tags) $(SimEventV2Dict_extratags) build constituent_config -out=$(cmt_local_SimEventV2Dict_makefile) SimEventV2Dict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_SimEventV2Dict_makefile) : $(SimEventV2Dict_dependencies) build_library_links
	$(echo) "(constituents.make) Building SimEventV2Dict.make"; \
	  $(cmtexe) -f=$(bin)SimEventV2Dict.in -tag=$(tags) $(SimEventV2Dict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_SimEventV2Dict_makefile) SimEventV2Dict
else
$(cmt_local_SimEventV2Dict_makefile) : $(SimEventV2Dict_dependencies) $(cmt_build_library_linksstamp) $(bin)SimEventV2Dict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_SimEventV2Dict) ] || \
	  [ ! -f $(cmt_final_setup_SimEventV2Dict) ] || \
	  $(not_SimEventV2Dict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building SimEventV2Dict.make"; \
	  $(cmtexe) -f=$(bin)SimEventV2Dict.in -tag=$(tags) $(SimEventV2Dict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_SimEventV2Dict_makefile) SimEventV2Dict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(SimEventV2Dict_extratags) build constituent_makefile -out=$(cmt_local_SimEventV2Dict_makefile) SimEventV2Dict

SimEventV2Dict :: $(SimEventV2Dict_dependencies) $(cmt_local_SimEventV2Dict_makefile) dirs SimEventV2Dictdirs
	$(echo) "(constituents.make) Starting SimEventV2Dict"
	@if test -f $(cmt_local_SimEventV2Dict_makefile); then \
	  $(MAKE) -f $(cmt_local_SimEventV2Dict_makefile) SimEventV2Dict; \
	  fi
#	@$(MAKE) -f $(cmt_local_SimEventV2Dict_makefile) SimEventV2Dict
	$(echo) "(constituents.make) SimEventV2Dict done"

clean :: SimEventV2Dictclean ;

SimEventV2Dictclean :: $(SimEventV2Dictclean_dependencies) ##$(cmt_local_SimEventV2Dict_makefile)
	$(echo) "(constituents.make) Starting SimEventV2Dictclean"
	@-if test -f $(cmt_local_SimEventV2Dict_makefile); then \
	  $(MAKE) -f $(cmt_local_SimEventV2Dict_makefile) SimEventV2Dictclean; \
	fi
	$(echo) "(constituents.make) SimEventV2Dictclean done"
#	@-$(MAKE) -f $(cmt_local_SimEventV2Dict_makefile) SimEventV2Dictclean

##	  /bin/rm -f $(cmt_local_SimEventV2Dict_makefile) $(bin)SimEventV2Dict_dependencies.make

install :: SimEventV2Dictinstall ;

SimEventV2Dictinstall :: $(SimEventV2Dict_dependencies) $(cmt_local_SimEventV2Dict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_SimEventV2Dict_makefile); then \
	  $(MAKE) -f $(cmt_local_SimEventV2Dict_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_SimEventV2Dict_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : SimEventV2Dictuninstall

$(foreach d,$(SimEventV2Dict_dependencies),$(eval $(d)uninstall_dependencies += SimEventV2Dictuninstall))

SimEventV2Dictuninstall : $(SimEventV2Dictuninstall_dependencies) ##$(cmt_local_SimEventV2Dict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_SimEventV2Dict_makefile); then \
	  $(MAKE) -f $(cmt_local_SimEventV2Dict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_SimEventV2Dict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: SimEventV2Dictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ SimEventV2Dict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ SimEventV2Dict done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_SimEventV2_has_no_target_tag = 1
cmt_SimEventV2_has_prototypes = 1

#--------------------------------------

ifdef cmt_SimEventV2_has_target_tag

cmt_local_tagfile_SimEventV2 = $(bin)$(SimEventV2_tag)_SimEventV2.make
cmt_final_setup_SimEventV2 = $(bin)setup_SimEventV2.make
cmt_local_SimEventV2_makefile = $(bin)SimEventV2.make

SimEventV2_extratags = -tag_add=target_SimEventV2

else

cmt_local_tagfile_SimEventV2 = $(bin)$(SimEventV2_tag).make
cmt_final_setup_SimEventV2 = $(bin)setup.make
cmt_local_SimEventV2_makefile = $(bin)SimEventV2.make

endif

not_SimEventV2compile_dependencies = { n=0; for p in $?; do m=0; for d in $(SimEventV2compile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
SimEventV2dirs :
	@if test ! -d $(bin)SimEventV2; then $(mkdir) -p $(bin)SimEventV2; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)SimEventV2
else
SimEventV2dirs : ;
endif

ifdef cmt_SimEventV2_has_target_tag

ifndef QUICK
$(cmt_local_SimEventV2_makefile) : $(SimEventV2compile_dependencies) build_library_links
	$(echo) "(constituents.make) Building SimEventV2.make"; \
	  $(cmtexe) -tag=$(tags) $(SimEventV2_extratags) build constituent_config -out=$(cmt_local_SimEventV2_makefile) SimEventV2
else
$(cmt_local_SimEventV2_makefile) : $(SimEventV2compile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_SimEventV2) ] || \
	  [ ! -f $(cmt_final_setup_SimEventV2) ] || \
	  $(not_SimEventV2compile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building SimEventV2.make"; \
	  $(cmtexe) -tag=$(tags) $(SimEventV2_extratags) build constituent_config -out=$(cmt_local_SimEventV2_makefile) SimEventV2; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_SimEventV2_makefile) : $(SimEventV2compile_dependencies) build_library_links
	$(echo) "(constituents.make) Building SimEventV2.make"; \
	  $(cmtexe) -f=$(bin)SimEventV2.in -tag=$(tags) $(SimEventV2_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_SimEventV2_makefile) SimEventV2
else
$(cmt_local_SimEventV2_makefile) : $(SimEventV2compile_dependencies) $(cmt_build_library_linksstamp) $(bin)SimEventV2.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_SimEventV2) ] || \
	  [ ! -f $(cmt_final_setup_SimEventV2) ] || \
	  $(not_SimEventV2compile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building SimEventV2.make"; \
	  $(cmtexe) -f=$(bin)SimEventV2.in -tag=$(tags) $(SimEventV2_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_SimEventV2_makefile) SimEventV2; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(SimEventV2_extratags) build constituent_makefile -out=$(cmt_local_SimEventV2_makefile) SimEventV2

SimEventV2 :: SimEventV2compile SimEventV2install ;

ifdef cmt_SimEventV2_has_prototypes

SimEventV2prototype : $(SimEventV2prototype_dependencies) $(cmt_local_SimEventV2_makefile) dirs SimEventV2dirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_SimEventV2_makefile); then \
	  $(MAKE) -f $(cmt_local_SimEventV2_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_SimEventV2_makefile) $@
	$(echo) "(constituents.make) $@ done"

SimEventV2compile : SimEventV2prototype

endif

SimEventV2compile : $(SimEventV2compile_dependencies) $(cmt_local_SimEventV2_makefile) dirs SimEventV2dirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_SimEventV2_makefile); then \
	  $(MAKE) -f $(cmt_local_SimEventV2_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_SimEventV2_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: SimEventV2clean ;

SimEventV2clean :: $(SimEventV2clean_dependencies) ##$(cmt_local_SimEventV2_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_SimEventV2_makefile); then \
	  $(MAKE) -f $(cmt_local_SimEventV2_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_SimEventV2_makefile) SimEventV2clean

##	  /bin/rm -f $(cmt_local_SimEventV2_makefile) $(bin)SimEventV2_dependencies.make

install :: SimEventV2install ;

SimEventV2install :: SimEventV2compile $(SimEventV2_dependencies) $(cmt_local_SimEventV2_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_SimEventV2_makefile); then \
	  $(MAKE) -f $(cmt_local_SimEventV2_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_SimEventV2_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : SimEventV2uninstall

$(foreach d,$(SimEventV2_dependencies),$(eval $(d)uninstall_dependencies += SimEventV2uninstall))

SimEventV2uninstall : $(SimEventV2uninstall_dependencies) ##$(cmt_local_SimEventV2_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_SimEventV2_makefile); then \
	  $(MAKE) -f $(cmt_local_SimEventV2_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_SimEventV2_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: SimEventV2uninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ SimEventV2"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ SimEventV2 done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_SimEvent_write_has_no_target_tag = 1
cmt_test_SimEvent_write_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_SimEvent_write_has_target_tag

cmt_local_tagfile_test_SimEvent_write = $(bin)$(SimEventV2_tag)_test_SimEvent_write.make
cmt_final_setup_test_SimEvent_write = $(bin)setup_test_SimEvent_write.make
cmt_local_test_SimEvent_write_makefile = $(bin)test_SimEvent_write.make

test_SimEvent_write_extratags = -tag_add=target_test_SimEvent_write

else

cmt_local_tagfile_test_SimEvent_write = $(bin)$(SimEventV2_tag).make
cmt_final_setup_test_SimEvent_write = $(bin)setup.make
cmt_local_test_SimEvent_write_makefile = $(bin)test_SimEvent_write.make

endif

not_test_SimEvent_writecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_SimEvent_writecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_SimEvent_writedirs :
	@if test ! -d $(bin)test_SimEvent_write; then $(mkdir) -p $(bin)test_SimEvent_write; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_SimEvent_write
else
test_SimEvent_writedirs : ;
endif

ifdef cmt_test_SimEvent_write_has_target_tag

ifndef QUICK
$(cmt_local_test_SimEvent_write_makefile) : $(test_SimEvent_writecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_SimEvent_write.make"; \
	  $(cmtexe) -tag=$(tags) $(test_SimEvent_write_extratags) build constituent_config -out=$(cmt_local_test_SimEvent_write_makefile) test_SimEvent_write
else
$(cmt_local_test_SimEvent_write_makefile) : $(test_SimEvent_writecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_SimEvent_write) ] || \
	  [ ! -f $(cmt_final_setup_test_SimEvent_write) ] || \
	  $(not_test_SimEvent_writecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_SimEvent_write.make"; \
	  $(cmtexe) -tag=$(tags) $(test_SimEvent_write_extratags) build constituent_config -out=$(cmt_local_test_SimEvent_write_makefile) test_SimEvent_write; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_SimEvent_write_makefile) : $(test_SimEvent_writecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_SimEvent_write.make"; \
	  $(cmtexe) -f=$(bin)test_SimEvent_write.in -tag=$(tags) $(test_SimEvent_write_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_SimEvent_write_makefile) test_SimEvent_write
else
$(cmt_local_test_SimEvent_write_makefile) : $(test_SimEvent_writecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_SimEvent_write.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_SimEvent_write) ] || \
	  [ ! -f $(cmt_final_setup_test_SimEvent_write) ] || \
	  $(not_test_SimEvent_writecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_SimEvent_write.make"; \
	  $(cmtexe) -f=$(bin)test_SimEvent_write.in -tag=$(tags) $(test_SimEvent_write_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_SimEvent_write_makefile) test_SimEvent_write; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_SimEvent_write_extratags) build constituent_makefile -out=$(cmt_local_test_SimEvent_write_makefile) test_SimEvent_write

test_SimEvent_write :: test_SimEvent_writecompile test_SimEvent_writeinstall ;

ifdef cmt_test_SimEvent_write_has_prototypes

test_SimEvent_writeprototype : $(test_SimEvent_writeprototype_dependencies) $(cmt_local_test_SimEvent_write_makefile) dirs test_SimEvent_writedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_SimEvent_write_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SimEvent_write_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_SimEvent_write_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_SimEvent_writecompile : test_SimEvent_writeprototype

endif

test_SimEvent_writecompile : $(test_SimEvent_writecompile_dependencies) $(cmt_local_test_SimEvent_write_makefile) dirs test_SimEvent_writedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_SimEvent_write_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SimEvent_write_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_SimEvent_write_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_SimEvent_writeclean ;

test_SimEvent_writeclean :: $(test_SimEvent_writeclean_dependencies) ##$(cmt_local_test_SimEvent_write_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_SimEvent_write_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SimEvent_write_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_SimEvent_write_makefile) test_SimEvent_writeclean

##	  /bin/rm -f $(cmt_local_test_SimEvent_write_makefile) $(bin)test_SimEvent_write_dependencies.make

install :: test_SimEvent_writeinstall ;

test_SimEvent_writeinstall :: test_SimEvent_writecompile $(test_SimEvent_write_dependencies) $(cmt_local_test_SimEvent_write_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_SimEvent_write_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SimEvent_write_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_SimEvent_write_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_SimEvent_writeuninstall

$(foreach d,$(test_SimEvent_write_dependencies),$(eval $(d)uninstall_dependencies += test_SimEvent_writeuninstall))

test_SimEvent_writeuninstall : $(test_SimEvent_writeuninstall_dependencies) ##$(cmt_local_test_SimEvent_write_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_SimEvent_write_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SimEvent_write_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_SimEvent_write_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_SimEvent_writeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_SimEvent_write"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_SimEvent_write done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_SimEvent_read_has_no_target_tag = 1
cmt_test_SimEvent_read_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_SimEvent_read_has_target_tag

cmt_local_tagfile_test_SimEvent_read = $(bin)$(SimEventV2_tag)_test_SimEvent_read.make
cmt_final_setup_test_SimEvent_read = $(bin)setup_test_SimEvent_read.make
cmt_local_test_SimEvent_read_makefile = $(bin)test_SimEvent_read.make

test_SimEvent_read_extratags = -tag_add=target_test_SimEvent_read

else

cmt_local_tagfile_test_SimEvent_read = $(bin)$(SimEventV2_tag).make
cmt_final_setup_test_SimEvent_read = $(bin)setup.make
cmt_local_test_SimEvent_read_makefile = $(bin)test_SimEvent_read.make

endif

not_test_SimEvent_readcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_SimEvent_readcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_SimEvent_readdirs :
	@if test ! -d $(bin)test_SimEvent_read; then $(mkdir) -p $(bin)test_SimEvent_read; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_SimEvent_read
else
test_SimEvent_readdirs : ;
endif

ifdef cmt_test_SimEvent_read_has_target_tag

ifndef QUICK
$(cmt_local_test_SimEvent_read_makefile) : $(test_SimEvent_readcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_SimEvent_read.make"; \
	  $(cmtexe) -tag=$(tags) $(test_SimEvent_read_extratags) build constituent_config -out=$(cmt_local_test_SimEvent_read_makefile) test_SimEvent_read
else
$(cmt_local_test_SimEvent_read_makefile) : $(test_SimEvent_readcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_SimEvent_read) ] || \
	  [ ! -f $(cmt_final_setup_test_SimEvent_read) ] || \
	  $(not_test_SimEvent_readcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_SimEvent_read.make"; \
	  $(cmtexe) -tag=$(tags) $(test_SimEvent_read_extratags) build constituent_config -out=$(cmt_local_test_SimEvent_read_makefile) test_SimEvent_read; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_SimEvent_read_makefile) : $(test_SimEvent_readcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_SimEvent_read.make"; \
	  $(cmtexe) -f=$(bin)test_SimEvent_read.in -tag=$(tags) $(test_SimEvent_read_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_SimEvent_read_makefile) test_SimEvent_read
else
$(cmt_local_test_SimEvent_read_makefile) : $(test_SimEvent_readcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_SimEvent_read.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_SimEvent_read) ] || \
	  [ ! -f $(cmt_final_setup_test_SimEvent_read) ] || \
	  $(not_test_SimEvent_readcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_SimEvent_read.make"; \
	  $(cmtexe) -f=$(bin)test_SimEvent_read.in -tag=$(tags) $(test_SimEvent_read_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_SimEvent_read_makefile) test_SimEvent_read; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_SimEvent_read_extratags) build constituent_makefile -out=$(cmt_local_test_SimEvent_read_makefile) test_SimEvent_read

test_SimEvent_read :: test_SimEvent_readcompile test_SimEvent_readinstall ;

ifdef cmt_test_SimEvent_read_has_prototypes

test_SimEvent_readprototype : $(test_SimEvent_readprototype_dependencies) $(cmt_local_test_SimEvent_read_makefile) dirs test_SimEvent_readdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_SimEvent_read_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SimEvent_read_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_SimEvent_read_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_SimEvent_readcompile : test_SimEvent_readprototype

endif

test_SimEvent_readcompile : $(test_SimEvent_readcompile_dependencies) $(cmt_local_test_SimEvent_read_makefile) dirs test_SimEvent_readdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_SimEvent_read_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SimEvent_read_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_SimEvent_read_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_SimEvent_readclean ;

test_SimEvent_readclean :: $(test_SimEvent_readclean_dependencies) ##$(cmt_local_test_SimEvent_read_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_SimEvent_read_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SimEvent_read_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_SimEvent_read_makefile) test_SimEvent_readclean

##	  /bin/rm -f $(cmt_local_test_SimEvent_read_makefile) $(bin)test_SimEvent_read_dependencies.make

install :: test_SimEvent_readinstall ;

test_SimEvent_readinstall :: test_SimEvent_readcompile $(test_SimEvent_read_dependencies) $(cmt_local_test_SimEvent_read_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_SimEvent_read_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SimEvent_read_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_SimEvent_read_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_SimEvent_readuninstall

$(foreach d,$(test_SimEvent_read_dependencies),$(eval $(d)uninstall_dependencies += test_SimEvent_readuninstall))

test_SimEvent_readuninstall : $(test_SimEvent_readuninstall_dependencies) ##$(cmt_local_test_SimEvent_read_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_SimEvent_read_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SimEvent_read_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_SimEvent_read_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_SimEvent_readuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_SimEvent_read"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_SimEvent_read done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(SimEventV2_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(SimEventV2_tag).make
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

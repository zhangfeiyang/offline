
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

ElecDataStruct_tag = $(tag)

#cmt_local_tagfile = $(ElecDataStruct_tag).make
cmt_local_tagfile = $(bin)$(ElecDataStruct_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)ElecDataStructsetup.make
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

cmt_local_tagfile_install_more_includes = $(bin)$(ElecDataStruct_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(ElecDataStruct_tag).make
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

cmt_ElecDataStruct_has_no_target_tag = 1
cmt_ElecDataStruct_has_prototypes = 1

#--------------------------------------

ifdef cmt_ElecDataStruct_has_target_tag

cmt_local_tagfile_ElecDataStruct = $(bin)$(ElecDataStruct_tag)_ElecDataStruct.make
cmt_final_setup_ElecDataStruct = $(bin)setup_ElecDataStruct.make
cmt_local_ElecDataStruct_makefile = $(bin)ElecDataStruct.make

ElecDataStruct_extratags = -tag_add=target_ElecDataStruct

else

cmt_local_tagfile_ElecDataStruct = $(bin)$(ElecDataStruct_tag).make
cmt_final_setup_ElecDataStruct = $(bin)setup.make
cmt_local_ElecDataStruct_makefile = $(bin)ElecDataStruct.make

endif

not_ElecDataStructcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(ElecDataStructcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
ElecDataStructdirs :
	@if test ! -d $(bin)ElecDataStruct; then $(mkdir) -p $(bin)ElecDataStruct; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)ElecDataStruct
else
ElecDataStructdirs : ;
endif

ifdef cmt_ElecDataStruct_has_target_tag

ifndef QUICK
$(cmt_local_ElecDataStruct_makefile) : $(ElecDataStructcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building ElecDataStruct.make"; \
	  $(cmtexe) -tag=$(tags) $(ElecDataStruct_extratags) build constituent_config -out=$(cmt_local_ElecDataStruct_makefile) ElecDataStruct
else
$(cmt_local_ElecDataStruct_makefile) : $(ElecDataStructcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ElecDataStruct) ] || \
	  [ ! -f $(cmt_final_setup_ElecDataStruct) ] || \
	  $(not_ElecDataStructcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ElecDataStruct.make"; \
	  $(cmtexe) -tag=$(tags) $(ElecDataStruct_extratags) build constituent_config -out=$(cmt_local_ElecDataStruct_makefile) ElecDataStruct; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_ElecDataStruct_makefile) : $(ElecDataStructcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building ElecDataStruct.make"; \
	  $(cmtexe) -f=$(bin)ElecDataStruct.in -tag=$(tags) $(ElecDataStruct_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ElecDataStruct_makefile) ElecDataStruct
else
$(cmt_local_ElecDataStruct_makefile) : $(ElecDataStructcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)ElecDataStruct.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ElecDataStruct) ] || \
	  [ ! -f $(cmt_final_setup_ElecDataStruct) ] || \
	  $(not_ElecDataStructcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ElecDataStruct.make"; \
	  $(cmtexe) -f=$(bin)ElecDataStruct.in -tag=$(tags) $(ElecDataStruct_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ElecDataStruct_makefile) ElecDataStruct; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(ElecDataStruct_extratags) build constituent_makefile -out=$(cmt_local_ElecDataStruct_makefile) ElecDataStruct

ElecDataStruct :: ElecDataStructcompile ElecDataStructinstall ;

ifdef cmt_ElecDataStruct_has_prototypes

ElecDataStructprototype : $(ElecDataStructprototype_dependencies) $(cmt_local_ElecDataStruct_makefile) dirs ElecDataStructdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_ElecDataStruct_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecDataStruct_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecDataStruct_makefile) $@
	$(echo) "(constituents.make) $@ done"

ElecDataStructcompile : ElecDataStructprototype

endif

ElecDataStructcompile : $(ElecDataStructcompile_dependencies) $(cmt_local_ElecDataStruct_makefile) dirs ElecDataStructdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_ElecDataStruct_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecDataStruct_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecDataStruct_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: ElecDataStructclean ;

ElecDataStructclean :: $(ElecDataStructclean_dependencies) ##$(cmt_local_ElecDataStruct_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_ElecDataStruct_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecDataStruct_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_ElecDataStruct_makefile) ElecDataStructclean

##	  /bin/rm -f $(cmt_local_ElecDataStruct_makefile) $(bin)ElecDataStruct_dependencies.make

install :: ElecDataStructinstall ;

ElecDataStructinstall :: ElecDataStructcompile $(ElecDataStruct_dependencies) $(cmt_local_ElecDataStruct_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_ElecDataStruct_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecDataStruct_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecDataStruct_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : ElecDataStructuninstall

$(foreach d,$(ElecDataStruct_dependencies),$(eval $(d)uninstall_dependencies += ElecDataStructuninstall))

ElecDataStructuninstall : $(ElecDataStructuninstall_dependencies) ##$(cmt_local_ElecDataStruct_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_ElecDataStruct_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecDataStruct_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecDataStruct_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: ElecDataStructuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ ElecDataStruct"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ ElecDataStruct done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_ElecData_Event_has_no_target_tag = 1
cmt_test_ElecData_Event_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_ElecData_Event_has_target_tag

cmt_local_tagfile_test_ElecData_Event = $(bin)$(ElecDataStruct_tag)_test_ElecData_Event.make
cmt_final_setup_test_ElecData_Event = $(bin)setup_test_ElecData_Event.make
cmt_local_test_ElecData_Event_makefile = $(bin)test_ElecData_Event.make

test_ElecData_Event_extratags = -tag_add=target_test_ElecData_Event

else

cmt_local_tagfile_test_ElecData_Event = $(bin)$(ElecDataStruct_tag).make
cmt_final_setup_test_ElecData_Event = $(bin)setup.make
cmt_local_test_ElecData_Event_makefile = $(bin)test_ElecData_Event.make

endif

not_test_ElecData_Eventcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_ElecData_Eventcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_ElecData_Eventdirs :
	@if test ! -d $(bin)test_ElecData_Event; then $(mkdir) -p $(bin)test_ElecData_Event; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_ElecData_Event
else
test_ElecData_Eventdirs : ;
endif

ifdef cmt_test_ElecData_Event_has_target_tag

ifndef QUICK
$(cmt_local_test_ElecData_Event_makefile) : $(test_ElecData_Eventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_ElecData_Event.make"; \
	  $(cmtexe) -tag=$(tags) $(test_ElecData_Event_extratags) build constituent_config -out=$(cmt_local_test_ElecData_Event_makefile) test_ElecData_Event
else
$(cmt_local_test_ElecData_Event_makefile) : $(test_ElecData_Eventcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_ElecData_Event) ] || \
	  [ ! -f $(cmt_final_setup_test_ElecData_Event) ] || \
	  $(not_test_ElecData_Eventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_ElecData_Event.make"; \
	  $(cmtexe) -tag=$(tags) $(test_ElecData_Event_extratags) build constituent_config -out=$(cmt_local_test_ElecData_Event_makefile) test_ElecData_Event; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_ElecData_Event_makefile) : $(test_ElecData_Eventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_ElecData_Event.make"; \
	  $(cmtexe) -f=$(bin)test_ElecData_Event.in -tag=$(tags) $(test_ElecData_Event_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_ElecData_Event_makefile) test_ElecData_Event
else
$(cmt_local_test_ElecData_Event_makefile) : $(test_ElecData_Eventcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_ElecData_Event.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_ElecData_Event) ] || \
	  [ ! -f $(cmt_final_setup_test_ElecData_Event) ] || \
	  $(not_test_ElecData_Eventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_ElecData_Event.make"; \
	  $(cmtexe) -f=$(bin)test_ElecData_Event.in -tag=$(tags) $(test_ElecData_Event_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_ElecData_Event_makefile) test_ElecData_Event; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_ElecData_Event_extratags) build constituent_makefile -out=$(cmt_local_test_ElecData_Event_makefile) test_ElecData_Event

test_ElecData_Event :: test_ElecData_Eventcompile test_ElecData_Eventinstall ;

ifdef cmt_test_ElecData_Event_has_prototypes

test_ElecData_Eventprototype : $(test_ElecData_Eventprototype_dependencies) $(cmt_local_test_ElecData_Event_makefile) dirs test_ElecData_Eventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_ElecData_Event_makefile); then \
	  $(MAKE) -f $(cmt_local_test_ElecData_Event_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_ElecData_Event_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_ElecData_Eventcompile : test_ElecData_Eventprototype

endif

test_ElecData_Eventcompile : $(test_ElecData_Eventcompile_dependencies) $(cmt_local_test_ElecData_Event_makefile) dirs test_ElecData_Eventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_ElecData_Event_makefile); then \
	  $(MAKE) -f $(cmt_local_test_ElecData_Event_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_ElecData_Event_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_ElecData_Eventclean ;

test_ElecData_Eventclean :: $(test_ElecData_Eventclean_dependencies) ##$(cmt_local_test_ElecData_Event_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_ElecData_Event_makefile); then \
	  $(MAKE) -f $(cmt_local_test_ElecData_Event_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_ElecData_Event_makefile) test_ElecData_Eventclean

##	  /bin/rm -f $(cmt_local_test_ElecData_Event_makefile) $(bin)test_ElecData_Event_dependencies.make

install :: test_ElecData_Eventinstall ;

test_ElecData_Eventinstall :: test_ElecData_Eventcompile $(test_ElecData_Event_dependencies) $(cmt_local_test_ElecData_Event_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_ElecData_Event_makefile); then \
	  $(MAKE) -f $(cmt_local_test_ElecData_Event_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_ElecData_Event_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_ElecData_Eventuninstall

$(foreach d,$(test_ElecData_Event_dependencies),$(eval $(d)uninstall_dependencies += test_ElecData_Eventuninstall))

test_ElecData_Eventuninstall : $(test_ElecData_Eventuninstall_dependencies) ##$(cmt_local_test_ElecData_Event_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_ElecData_Event_makefile); then \
	  $(MAKE) -f $(cmt_local_test_ElecData_Event_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_ElecData_Event_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_ElecData_Eventuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_ElecData_Event"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_ElecData_Event done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_ElecData_CircularBuffer_has_no_target_tag = 1
cmt_test_ElecData_CircularBuffer_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_ElecData_CircularBuffer_has_target_tag

cmt_local_tagfile_test_ElecData_CircularBuffer = $(bin)$(ElecDataStruct_tag)_test_ElecData_CircularBuffer.make
cmt_final_setup_test_ElecData_CircularBuffer = $(bin)setup_test_ElecData_CircularBuffer.make
cmt_local_test_ElecData_CircularBuffer_makefile = $(bin)test_ElecData_CircularBuffer.make

test_ElecData_CircularBuffer_extratags = -tag_add=target_test_ElecData_CircularBuffer

else

cmt_local_tagfile_test_ElecData_CircularBuffer = $(bin)$(ElecDataStruct_tag).make
cmt_final_setup_test_ElecData_CircularBuffer = $(bin)setup.make
cmt_local_test_ElecData_CircularBuffer_makefile = $(bin)test_ElecData_CircularBuffer.make

endif

not_test_ElecData_CircularBuffercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_ElecData_CircularBuffercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_ElecData_CircularBufferdirs :
	@if test ! -d $(bin)test_ElecData_CircularBuffer; then $(mkdir) -p $(bin)test_ElecData_CircularBuffer; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_ElecData_CircularBuffer
else
test_ElecData_CircularBufferdirs : ;
endif

ifdef cmt_test_ElecData_CircularBuffer_has_target_tag

ifndef QUICK
$(cmt_local_test_ElecData_CircularBuffer_makefile) : $(test_ElecData_CircularBuffercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_ElecData_CircularBuffer.make"; \
	  $(cmtexe) -tag=$(tags) $(test_ElecData_CircularBuffer_extratags) build constituent_config -out=$(cmt_local_test_ElecData_CircularBuffer_makefile) test_ElecData_CircularBuffer
else
$(cmt_local_test_ElecData_CircularBuffer_makefile) : $(test_ElecData_CircularBuffercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_ElecData_CircularBuffer) ] || \
	  [ ! -f $(cmt_final_setup_test_ElecData_CircularBuffer) ] || \
	  $(not_test_ElecData_CircularBuffercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_ElecData_CircularBuffer.make"; \
	  $(cmtexe) -tag=$(tags) $(test_ElecData_CircularBuffer_extratags) build constituent_config -out=$(cmt_local_test_ElecData_CircularBuffer_makefile) test_ElecData_CircularBuffer; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_ElecData_CircularBuffer_makefile) : $(test_ElecData_CircularBuffercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_ElecData_CircularBuffer.make"; \
	  $(cmtexe) -f=$(bin)test_ElecData_CircularBuffer.in -tag=$(tags) $(test_ElecData_CircularBuffer_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_ElecData_CircularBuffer_makefile) test_ElecData_CircularBuffer
else
$(cmt_local_test_ElecData_CircularBuffer_makefile) : $(test_ElecData_CircularBuffercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_ElecData_CircularBuffer.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_ElecData_CircularBuffer) ] || \
	  [ ! -f $(cmt_final_setup_test_ElecData_CircularBuffer) ] || \
	  $(not_test_ElecData_CircularBuffercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_ElecData_CircularBuffer.make"; \
	  $(cmtexe) -f=$(bin)test_ElecData_CircularBuffer.in -tag=$(tags) $(test_ElecData_CircularBuffer_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_ElecData_CircularBuffer_makefile) test_ElecData_CircularBuffer; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_ElecData_CircularBuffer_extratags) build constituent_makefile -out=$(cmt_local_test_ElecData_CircularBuffer_makefile) test_ElecData_CircularBuffer

test_ElecData_CircularBuffer :: test_ElecData_CircularBuffercompile test_ElecData_CircularBufferinstall ;

ifdef cmt_test_ElecData_CircularBuffer_has_prototypes

test_ElecData_CircularBufferprototype : $(test_ElecData_CircularBufferprototype_dependencies) $(cmt_local_test_ElecData_CircularBuffer_makefile) dirs test_ElecData_CircularBufferdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_ElecData_CircularBuffer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_ElecData_CircularBuffer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_ElecData_CircularBuffer_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_ElecData_CircularBuffercompile : test_ElecData_CircularBufferprototype

endif

test_ElecData_CircularBuffercompile : $(test_ElecData_CircularBuffercompile_dependencies) $(cmt_local_test_ElecData_CircularBuffer_makefile) dirs test_ElecData_CircularBufferdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_ElecData_CircularBuffer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_ElecData_CircularBuffer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_ElecData_CircularBuffer_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_ElecData_CircularBufferclean ;

test_ElecData_CircularBufferclean :: $(test_ElecData_CircularBufferclean_dependencies) ##$(cmt_local_test_ElecData_CircularBuffer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_ElecData_CircularBuffer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_ElecData_CircularBuffer_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_ElecData_CircularBuffer_makefile) test_ElecData_CircularBufferclean

##	  /bin/rm -f $(cmt_local_test_ElecData_CircularBuffer_makefile) $(bin)test_ElecData_CircularBuffer_dependencies.make

install :: test_ElecData_CircularBufferinstall ;

test_ElecData_CircularBufferinstall :: test_ElecData_CircularBuffercompile $(test_ElecData_CircularBuffer_dependencies) $(cmt_local_test_ElecData_CircularBuffer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_ElecData_CircularBuffer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_ElecData_CircularBuffer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_ElecData_CircularBuffer_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_ElecData_CircularBufferuninstall

$(foreach d,$(test_ElecData_CircularBuffer_dependencies),$(eval $(d)uninstall_dependencies += test_ElecData_CircularBufferuninstall))

test_ElecData_CircularBufferuninstall : $(test_ElecData_CircularBufferuninstall_dependencies) ##$(cmt_local_test_ElecData_CircularBuffer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_ElecData_CircularBuffer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_ElecData_CircularBuffer_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_ElecData_CircularBuffer_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_ElecData_CircularBufferuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_ElecData_CircularBuffer"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_ElecData_CircularBuffer done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(ElecDataStruct_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(ElecDataStruct_tag).make
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

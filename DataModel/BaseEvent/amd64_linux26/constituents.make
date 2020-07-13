
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

BaseEvent_tag = $(tag)

#cmt_local_tagfile = $(BaseEvent_tag).make
cmt_local_tagfile = $(bin)$(BaseEvent_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)BaseEventsetup.make
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

cmt_BaseEventObj2Doth_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_BaseEventObj2Doth_has_target_tag

cmt_local_tagfile_BaseEventObj2Doth = $(bin)$(BaseEvent_tag)_BaseEventObj2Doth.make
cmt_final_setup_BaseEventObj2Doth = $(bin)setup_BaseEventObj2Doth.make
cmt_local_BaseEventObj2Doth_makefile = $(bin)BaseEventObj2Doth.make

BaseEventObj2Doth_extratags = -tag_add=target_BaseEventObj2Doth

else

cmt_local_tagfile_BaseEventObj2Doth = $(bin)$(BaseEvent_tag).make
cmt_final_setup_BaseEventObj2Doth = $(bin)setup.make
cmt_local_BaseEventObj2Doth_makefile = $(bin)BaseEventObj2Doth.make

endif

not_BaseEventObj2Doth_dependencies = { n=0; for p in $?; do m=0; for d in $(BaseEventObj2Doth_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
BaseEventObj2Dothdirs :
	@if test ! -d $(bin)BaseEventObj2Doth; then $(mkdir) -p $(bin)BaseEventObj2Doth; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)BaseEventObj2Doth
else
BaseEventObj2Dothdirs : ;
endif

ifdef cmt_BaseEventObj2Doth_has_target_tag

ifndef QUICK
$(cmt_local_BaseEventObj2Doth_makefile) : $(BaseEventObj2Doth_dependencies) build_library_links
	$(echo) "(constituents.make) Building BaseEventObj2Doth.make"; \
	  $(cmtexe) -tag=$(tags) $(BaseEventObj2Doth_extratags) build constituent_config -out=$(cmt_local_BaseEventObj2Doth_makefile) BaseEventObj2Doth
else
$(cmt_local_BaseEventObj2Doth_makefile) : $(BaseEventObj2Doth_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_BaseEventObj2Doth) ] || \
	  [ ! -f $(cmt_final_setup_BaseEventObj2Doth) ] || \
	  $(not_BaseEventObj2Doth_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building BaseEventObj2Doth.make"; \
	  $(cmtexe) -tag=$(tags) $(BaseEventObj2Doth_extratags) build constituent_config -out=$(cmt_local_BaseEventObj2Doth_makefile) BaseEventObj2Doth; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_BaseEventObj2Doth_makefile) : $(BaseEventObj2Doth_dependencies) build_library_links
	$(echo) "(constituents.make) Building BaseEventObj2Doth.make"; \
	  $(cmtexe) -f=$(bin)BaseEventObj2Doth.in -tag=$(tags) $(BaseEventObj2Doth_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_BaseEventObj2Doth_makefile) BaseEventObj2Doth
else
$(cmt_local_BaseEventObj2Doth_makefile) : $(BaseEventObj2Doth_dependencies) $(cmt_build_library_linksstamp) $(bin)BaseEventObj2Doth.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_BaseEventObj2Doth) ] || \
	  [ ! -f $(cmt_final_setup_BaseEventObj2Doth) ] || \
	  $(not_BaseEventObj2Doth_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building BaseEventObj2Doth.make"; \
	  $(cmtexe) -f=$(bin)BaseEventObj2Doth.in -tag=$(tags) $(BaseEventObj2Doth_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_BaseEventObj2Doth_makefile) BaseEventObj2Doth; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(BaseEventObj2Doth_extratags) build constituent_makefile -out=$(cmt_local_BaseEventObj2Doth_makefile) BaseEventObj2Doth

BaseEventObj2Doth :: $(BaseEventObj2Doth_dependencies) $(cmt_local_BaseEventObj2Doth_makefile) dirs BaseEventObj2Dothdirs
	$(echo) "(constituents.make) Starting BaseEventObj2Doth"
	@if test -f $(cmt_local_BaseEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEventObj2Doth_makefile) BaseEventObj2Doth; \
	  fi
#	@$(MAKE) -f $(cmt_local_BaseEventObj2Doth_makefile) BaseEventObj2Doth
	$(echo) "(constituents.make) BaseEventObj2Doth done"

clean :: BaseEventObj2Dothclean ;

BaseEventObj2Dothclean :: $(BaseEventObj2Dothclean_dependencies) ##$(cmt_local_BaseEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting BaseEventObj2Dothclean"
	@-if test -f $(cmt_local_BaseEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEventObj2Doth_makefile) BaseEventObj2Dothclean; \
	fi
	$(echo) "(constituents.make) BaseEventObj2Dothclean done"
#	@-$(MAKE) -f $(cmt_local_BaseEventObj2Doth_makefile) BaseEventObj2Dothclean

##	  /bin/rm -f $(cmt_local_BaseEventObj2Doth_makefile) $(bin)BaseEventObj2Doth_dependencies.make

install :: BaseEventObj2Dothinstall ;

BaseEventObj2Dothinstall :: $(BaseEventObj2Doth_dependencies) $(cmt_local_BaseEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_BaseEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEventObj2Doth_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_BaseEventObj2Doth_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : BaseEventObj2Dothuninstall

$(foreach d,$(BaseEventObj2Doth_dependencies),$(eval $(d)uninstall_dependencies += BaseEventObj2Dothuninstall))

BaseEventObj2Dothuninstall : $(BaseEventObj2Dothuninstall_dependencies) ##$(cmt_local_BaseEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_BaseEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEventObj2Doth_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_BaseEventObj2Doth_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: BaseEventObj2Dothuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ BaseEventObj2Doth"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ BaseEventObj2Doth done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_more_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_more_includes_has_target_tag

cmt_local_tagfile_install_more_includes = $(bin)$(BaseEvent_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(BaseEvent_tag).make
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

cmt_BaseEventDict_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_BaseEventDict_has_target_tag

cmt_local_tagfile_BaseEventDict = $(bin)$(BaseEvent_tag)_BaseEventDict.make
cmt_final_setup_BaseEventDict = $(bin)setup_BaseEventDict.make
cmt_local_BaseEventDict_makefile = $(bin)BaseEventDict.make

BaseEventDict_extratags = -tag_add=target_BaseEventDict

else

cmt_local_tagfile_BaseEventDict = $(bin)$(BaseEvent_tag).make
cmt_final_setup_BaseEventDict = $(bin)setup.make
cmt_local_BaseEventDict_makefile = $(bin)BaseEventDict.make

endif

not_BaseEventDict_dependencies = { n=0; for p in $?; do m=0; for d in $(BaseEventDict_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
BaseEventDictdirs :
	@if test ! -d $(bin)BaseEventDict; then $(mkdir) -p $(bin)BaseEventDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)BaseEventDict
else
BaseEventDictdirs : ;
endif

ifdef cmt_BaseEventDict_has_target_tag

ifndef QUICK
$(cmt_local_BaseEventDict_makefile) : $(BaseEventDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building BaseEventDict.make"; \
	  $(cmtexe) -tag=$(tags) $(BaseEventDict_extratags) build constituent_config -out=$(cmt_local_BaseEventDict_makefile) BaseEventDict
else
$(cmt_local_BaseEventDict_makefile) : $(BaseEventDict_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_BaseEventDict) ] || \
	  [ ! -f $(cmt_final_setup_BaseEventDict) ] || \
	  $(not_BaseEventDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building BaseEventDict.make"; \
	  $(cmtexe) -tag=$(tags) $(BaseEventDict_extratags) build constituent_config -out=$(cmt_local_BaseEventDict_makefile) BaseEventDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_BaseEventDict_makefile) : $(BaseEventDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building BaseEventDict.make"; \
	  $(cmtexe) -f=$(bin)BaseEventDict.in -tag=$(tags) $(BaseEventDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_BaseEventDict_makefile) BaseEventDict
else
$(cmt_local_BaseEventDict_makefile) : $(BaseEventDict_dependencies) $(cmt_build_library_linksstamp) $(bin)BaseEventDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_BaseEventDict) ] || \
	  [ ! -f $(cmt_final_setup_BaseEventDict) ] || \
	  $(not_BaseEventDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building BaseEventDict.make"; \
	  $(cmtexe) -f=$(bin)BaseEventDict.in -tag=$(tags) $(BaseEventDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_BaseEventDict_makefile) BaseEventDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(BaseEventDict_extratags) build constituent_makefile -out=$(cmt_local_BaseEventDict_makefile) BaseEventDict

BaseEventDict :: $(BaseEventDict_dependencies) $(cmt_local_BaseEventDict_makefile) dirs BaseEventDictdirs
	$(echo) "(constituents.make) Starting BaseEventDict"
	@if test -f $(cmt_local_BaseEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEventDict_makefile) BaseEventDict; \
	  fi
#	@$(MAKE) -f $(cmt_local_BaseEventDict_makefile) BaseEventDict
	$(echo) "(constituents.make) BaseEventDict done"

clean :: BaseEventDictclean ;

BaseEventDictclean :: $(BaseEventDictclean_dependencies) ##$(cmt_local_BaseEventDict_makefile)
	$(echo) "(constituents.make) Starting BaseEventDictclean"
	@-if test -f $(cmt_local_BaseEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEventDict_makefile) BaseEventDictclean; \
	fi
	$(echo) "(constituents.make) BaseEventDictclean done"
#	@-$(MAKE) -f $(cmt_local_BaseEventDict_makefile) BaseEventDictclean

##	  /bin/rm -f $(cmt_local_BaseEventDict_makefile) $(bin)BaseEventDict_dependencies.make

install :: BaseEventDictinstall ;

BaseEventDictinstall :: $(BaseEventDict_dependencies) $(cmt_local_BaseEventDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_BaseEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEventDict_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_BaseEventDict_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : BaseEventDictuninstall

$(foreach d,$(BaseEventDict_dependencies),$(eval $(d)uninstall_dependencies += BaseEventDictuninstall))

BaseEventDictuninstall : $(BaseEventDictuninstall_dependencies) ##$(cmt_local_BaseEventDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_BaseEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEventDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_BaseEventDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: BaseEventDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ BaseEventDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ BaseEventDict done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_BaseEventxodsrc_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_BaseEventxodsrc_has_target_tag

cmt_local_tagfile_BaseEventxodsrc = $(bin)$(BaseEvent_tag)_BaseEventxodsrc.make
cmt_final_setup_BaseEventxodsrc = $(bin)setup_BaseEventxodsrc.make
cmt_local_BaseEventxodsrc_makefile = $(bin)BaseEventxodsrc.make

BaseEventxodsrc_extratags = -tag_add=target_BaseEventxodsrc

else

cmt_local_tagfile_BaseEventxodsrc = $(bin)$(BaseEvent_tag).make
cmt_final_setup_BaseEventxodsrc = $(bin)setup.make
cmt_local_BaseEventxodsrc_makefile = $(bin)BaseEventxodsrc.make

endif

not_BaseEventxodsrc_dependencies = { n=0; for p in $?; do m=0; for d in $(BaseEventxodsrc_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
BaseEventxodsrcdirs :
	@if test ! -d $(bin)BaseEventxodsrc; then $(mkdir) -p $(bin)BaseEventxodsrc; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)BaseEventxodsrc
else
BaseEventxodsrcdirs : ;
endif

ifdef cmt_BaseEventxodsrc_has_target_tag

ifndef QUICK
$(cmt_local_BaseEventxodsrc_makefile) : $(BaseEventxodsrc_dependencies) build_library_links
	$(echo) "(constituents.make) Building BaseEventxodsrc.make"; \
	  $(cmtexe) -tag=$(tags) $(BaseEventxodsrc_extratags) build constituent_config -out=$(cmt_local_BaseEventxodsrc_makefile) BaseEventxodsrc
else
$(cmt_local_BaseEventxodsrc_makefile) : $(BaseEventxodsrc_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_BaseEventxodsrc) ] || \
	  [ ! -f $(cmt_final_setup_BaseEventxodsrc) ] || \
	  $(not_BaseEventxodsrc_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building BaseEventxodsrc.make"; \
	  $(cmtexe) -tag=$(tags) $(BaseEventxodsrc_extratags) build constituent_config -out=$(cmt_local_BaseEventxodsrc_makefile) BaseEventxodsrc; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_BaseEventxodsrc_makefile) : $(BaseEventxodsrc_dependencies) build_library_links
	$(echo) "(constituents.make) Building BaseEventxodsrc.make"; \
	  $(cmtexe) -f=$(bin)BaseEventxodsrc.in -tag=$(tags) $(BaseEventxodsrc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_BaseEventxodsrc_makefile) BaseEventxodsrc
else
$(cmt_local_BaseEventxodsrc_makefile) : $(BaseEventxodsrc_dependencies) $(cmt_build_library_linksstamp) $(bin)BaseEventxodsrc.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_BaseEventxodsrc) ] || \
	  [ ! -f $(cmt_final_setup_BaseEventxodsrc) ] || \
	  $(not_BaseEventxodsrc_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building BaseEventxodsrc.make"; \
	  $(cmtexe) -f=$(bin)BaseEventxodsrc.in -tag=$(tags) $(BaseEventxodsrc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_BaseEventxodsrc_makefile) BaseEventxodsrc; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(BaseEventxodsrc_extratags) build constituent_makefile -out=$(cmt_local_BaseEventxodsrc_makefile) BaseEventxodsrc

BaseEventxodsrc :: $(BaseEventxodsrc_dependencies) $(cmt_local_BaseEventxodsrc_makefile) dirs BaseEventxodsrcdirs
	$(echo) "(constituents.make) Starting BaseEventxodsrc"
	@if test -f $(cmt_local_BaseEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEventxodsrc_makefile) BaseEventxodsrc; \
	  fi
#	@$(MAKE) -f $(cmt_local_BaseEventxodsrc_makefile) BaseEventxodsrc
	$(echo) "(constituents.make) BaseEventxodsrc done"

clean :: BaseEventxodsrcclean ;

BaseEventxodsrcclean :: $(BaseEventxodsrcclean_dependencies) ##$(cmt_local_BaseEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting BaseEventxodsrcclean"
	@-if test -f $(cmt_local_BaseEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEventxodsrc_makefile) BaseEventxodsrcclean; \
	fi
	$(echo) "(constituents.make) BaseEventxodsrcclean done"
#	@-$(MAKE) -f $(cmt_local_BaseEventxodsrc_makefile) BaseEventxodsrcclean

##	  /bin/rm -f $(cmt_local_BaseEventxodsrc_makefile) $(bin)BaseEventxodsrc_dependencies.make

install :: BaseEventxodsrcinstall ;

BaseEventxodsrcinstall :: $(BaseEventxodsrc_dependencies) $(cmt_local_BaseEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_BaseEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEventxodsrc_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_BaseEventxodsrc_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : BaseEventxodsrcuninstall

$(foreach d,$(BaseEventxodsrc_dependencies),$(eval $(d)uninstall_dependencies += BaseEventxodsrcuninstall))

BaseEventxodsrcuninstall : $(BaseEventxodsrcuninstall_dependencies) ##$(cmt_local_BaseEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_BaseEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEventxodsrc_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_BaseEventxodsrc_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: BaseEventxodsrcuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ BaseEventxodsrc"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ BaseEventxodsrc done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_BaseEvent_has_no_target_tag = 1
cmt_BaseEvent_has_prototypes = 1

#--------------------------------------

ifdef cmt_BaseEvent_has_target_tag

cmt_local_tagfile_BaseEvent = $(bin)$(BaseEvent_tag)_BaseEvent.make
cmt_final_setup_BaseEvent = $(bin)setup_BaseEvent.make
cmt_local_BaseEvent_makefile = $(bin)BaseEvent.make

BaseEvent_extratags = -tag_add=target_BaseEvent

else

cmt_local_tagfile_BaseEvent = $(bin)$(BaseEvent_tag).make
cmt_final_setup_BaseEvent = $(bin)setup.make
cmt_local_BaseEvent_makefile = $(bin)BaseEvent.make

endif

not_BaseEventcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(BaseEventcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
BaseEventdirs :
	@if test ! -d $(bin)BaseEvent; then $(mkdir) -p $(bin)BaseEvent; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)BaseEvent
else
BaseEventdirs : ;
endif

ifdef cmt_BaseEvent_has_target_tag

ifndef QUICK
$(cmt_local_BaseEvent_makefile) : $(BaseEventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building BaseEvent.make"; \
	  $(cmtexe) -tag=$(tags) $(BaseEvent_extratags) build constituent_config -out=$(cmt_local_BaseEvent_makefile) BaseEvent
else
$(cmt_local_BaseEvent_makefile) : $(BaseEventcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_BaseEvent) ] || \
	  [ ! -f $(cmt_final_setup_BaseEvent) ] || \
	  $(not_BaseEventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building BaseEvent.make"; \
	  $(cmtexe) -tag=$(tags) $(BaseEvent_extratags) build constituent_config -out=$(cmt_local_BaseEvent_makefile) BaseEvent; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_BaseEvent_makefile) : $(BaseEventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building BaseEvent.make"; \
	  $(cmtexe) -f=$(bin)BaseEvent.in -tag=$(tags) $(BaseEvent_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_BaseEvent_makefile) BaseEvent
else
$(cmt_local_BaseEvent_makefile) : $(BaseEventcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)BaseEvent.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_BaseEvent) ] || \
	  [ ! -f $(cmt_final_setup_BaseEvent) ] || \
	  $(not_BaseEventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building BaseEvent.make"; \
	  $(cmtexe) -f=$(bin)BaseEvent.in -tag=$(tags) $(BaseEvent_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_BaseEvent_makefile) BaseEvent; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(BaseEvent_extratags) build constituent_makefile -out=$(cmt_local_BaseEvent_makefile) BaseEvent

BaseEvent :: BaseEventcompile BaseEventinstall ;

ifdef cmt_BaseEvent_has_prototypes

BaseEventprototype : $(BaseEventprototype_dependencies) $(cmt_local_BaseEvent_makefile) dirs BaseEventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_BaseEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_BaseEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

BaseEventcompile : BaseEventprototype

endif

BaseEventcompile : $(BaseEventcompile_dependencies) $(cmt_local_BaseEvent_makefile) dirs BaseEventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_BaseEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_BaseEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: BaseEventclean ;

BaseEventclean :: $(BaseEventclean_dependencies) ##$(cmt_local_BaseEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_BaseEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEvent_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_BaseEvent_makefile) BaseEventclean

##	  /bin/rm -f $(cmt_local_BaseEvent_makefile) $(bin)BaseEvent_dependencies.make

install :: BaseEventinstall ;

BaseEventinstall :: BaseEventcompile $(BaseEvent_dependencies) $(cmt_local_BaseEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_BaseEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_BaseEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : BaseEventuninstall

$(foreach d,$(BaseEvent_dependencies),$(eval $(d)uninstall_dependencies += BaseEventuninstall))

BaseEventuninstall : $(BaseEventuninstall_dependencies) ##$(cmt_local_BaseEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_BaseEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_BaseEvent_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_BaseEvent_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: BaseEventuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ BaseEvent"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ BaseEvent done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(BaseEvent_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(BaseEvent_tag).make
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

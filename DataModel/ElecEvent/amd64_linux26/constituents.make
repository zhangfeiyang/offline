
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

ElecEvent_tag = $(tag)

#cmt_local_tagfile = $(ElecEvent_tag).make
cmt_local_tagfile = $(bin)$(ElecEvent_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)ElecEventsetup.make
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

cmt_ElecEventObj2Doth_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_ElecEventObj2Doth_has_target_tag

cmt_local_tagfile_ElecEventObj2Doth = $(bin)$(ElecEvent_tag)_ElecEventObj2Doth.make
cmt_final_setup_ElecEventObj2Doth = $(bin)setup_ElecEventObj2Doth.make
cmt_local_ElecEventObj2Doth_makefile = $(bin)ElecEventObj2Doth.make

ElecEventObj2Doth_extratags = -tag_add=target_ElecEventObj2Doth

else

cmt_local_tagfile_ElecEventObj2Doth = $(bin)$(ElecEvent_tag).make
cmt_final_setup_ElecEventObj2Doth = $(bin)setup.make
cmt_local_ElecEventObj2Doth_makefile = $(bin)ElecEventObj2Doth.make

endif

not_ElecEventObj2Doth_dependencies = { n=0; for p in $?; do m=0; for d in $(ElecEventObj2Doth_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
ElecEventObj2Dothdirs :
	@if test ! -d $(bin)ElecEventObj2Doth; then $(mkdir) -p $(bin)ElecEventObj2Doth; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)ElecEventObj2Doth
else
ElecEventObj2Dothdirs : ;
endif

ifdef cmt_ElecEventObj2Doth_has_target_tag

ifndef QUICK
$(cmt_local_ElecEventObj2Doth_makefile) : $(ElecEventObj2Doth_dependencies) build_library_links
	$(echo) "(constituents.make) Building ElecEventObj2Doth.make"; \
	  $(cmtexe) -tag=$(tags) $(ElecEventObj2Doth_extratags) build constituent_config -out=$(cmt_local_ElecEventObj2Doth_makefile) ElecEventObj2Doth
else
$(cmt_local_ElecEventObj2Doth_makefile) : $(ElecEventObj2Doth_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ElecEventObj2Doth) ] || \
	  [ ! -f $(cmt_final_setup_ElecEventObj2Doth) ] || \
	  $(not_ElecEventObj2Doth_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ElecEventObj2Doth.make"; \
	  $(cmtexe) -tag=$(tags) $(ElecEventObj2Doth_extratags) build constituent_config -out=$(cmt_local_ElecEventObj2Doth_makefile) ElecEventObj2Doth; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_ElecEventObj2Doth_makefile) : $(ElecEventObj2Doth_dependencies) build_library_links
	$(echo) "(constituents.make) Building ElecEventObj2Doth.make"; \
	  $(cmtexe) -f=$(bin)ElecEventObj2Doth.in -tag=$(tags) $(ElecEventObj2Doth_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ElecEventObj2Doth_makefile) ElecEventObj2Doth
else
$(cmt_local_ElecEventObj2Doth_makefile) : $(ElecEventObj2Doth_dependencies) $(cmt_build_library_linksstamp) $(bin)ElecEventObj2Doth.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ElecEventObj2Doth) ] || \
	  [ ! -f $(cmt_final_setup_ElecEventObj2Doth) ] || \
	  $(not_ElecEventObj2Doth_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ElecEventObj2Doth.make"; \
	  $(cmtexe) -f=$(bin)ElecEventObj2Doth.in -tag=$(tags) $(ElecEventObj2Doth_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ElecEventObj2Doth_makefile) ElecEventObj2Doth; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(ElecEventObj2Doth_extratags) build constituent_makefile -out=$(cmt_local_ElecEventObj2Doth_makefile) ElecEventObj2Doth

ElecEventObj2Doth :: $(ElecEventObj2Doth_dependencies) $(cmt_local_ElecEventObj2Doth_makefile) dirs ElecEventObj2Dothdirs
	$(echo) "(constituents.make) Starting ElecEventObj2Doth"
	@if test -f $(cmt_local_ElecEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEventObj2Doth_makefile) ElecEventObj2Doth; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecEventObj2Doth_makefile) ElecEventObj2Doth
	$(echo) "(constituents.make) ElecEventObj2Doth done"

clean :: ElecEventObj2Dothclean ;

ElecEventObj2Dothclean :: $(ElecEventObj2Dothclean_dependencies) ##$(cmt_local_ElecEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting ElecEventObj2Dothclean"
	@-if test -f $(cmt_local_ElecEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEventObj2Doth_makefile) ElecEventObj2Dothclean; \
	fi
	$(echo) "(constituents.make) ElecEventObj2Dothclean done"
#	@-$(MAKE) -f $(cmt_local_ElecEventObj2Doth_makefile) ElecEventObj2Dothclean

##	  /bin/rm -f $(cmt_local_ElecEventObj2Doth_makefile) $(bin)ElecEventObj2Doth_dependencies.make

install :: ElecEventObj2Dothinstall ;

ElecEventObj2Dothinstall :: $(ElecEventObj2Doth_dependencies) $(cmt_local_ElecEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_ElecEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEventObj2Doth_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_ElecEventObj2Doth_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : ElecEventObj2Dothuninstall

$(foreach d,$(ElecEventObj2Doth_dependencies),$(eval $(d)uninstall_dependencies += ElecEventObj2Dothuninstall))

ElecEventObj2Dothuninstall : $(ElecEventObj2Dothuninstall_dependencies) ##$(cmt_local_ElecEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_ElecEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEventObj2Doth_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecEventObj2Doth_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: ElecEventObj2Dothuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ ElecEventObj2Doth"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ ElecEventObj2Doth done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_more_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_more_includes_has_target_tag

cmt_local_tagfile_install_more_includes = $(bin)$(ElecEvent_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(ElecEvent_tag).make
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

cmt_ElecEventDict_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_ElecEventDict_has_target_tag

cmt_local_tagfile_ElecEventDict = $(bin)$(ElecEvent_tag)_ElecEventDict.make
cmt_final_setup_ElecEventDict = $(bin)setup_ElecEventDict.make
cmt_local_ElecEventDict_makefile = $(bin)ElecEventDict.make

ElecEventDict_extratags = -tag_add=target_ElecEventDict

else

cmt_local_tagfile_ElecEventDict = $(bin)$(ElecEvent_tag).make
cmt_final_setup_ElecEventDict = $(bin)setup.make
cmt_local_ElecEventDict_makefile = $(bin)ElecEventDict.make

endif

not_ElecEventDict_dependencies = { n=0; for p in $?; do m=0; for d in $(ElecEventDict_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
ElecEventDictdirs :
	@if test ! -d $(bin)ElecEventDict; then $(mkdir) -p $(bin)ElecEventDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)ElecEventDict
else
ElecEventDictdirs : ;
endif

ifdef cmt_ElecEventDict_has_target_tag

ifndef QUICK
$(cmt_local_ElecEventDict_makefile) : $(ElecEventDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building ElecEventDict.make"; \
	  $(cmtexe) -tag=$(tags) $(ElecEventDict_extratags) build constituent_config -out=$(cmt_local_ElecEventDict_makefile) ElecEventDict
else
$(cmt_local_ElecEventDict_makefile) : $(ElecEventDict_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ElecEventDict) ] || \
	  [ ! -f $(cmt_final_setup_ElecEventDict) ] || \
	  $(not_ElecEventDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ElecEventDict.make"; \
	  $(cmtexe) -tag=$(tags) $(ElecEventDict_extratags) build constituent_config -out=$(cmt_local_ElecEventDict_makefile) ElecEventDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_ElecEventDict_makefile) : $(ElecEventDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building ElecEventDict.make"; \
	  $(cmtexe) -f=$(bin)ElecEventDict.in -tag=$(tags) $(ElecEventDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ElecEventDict_makefile) ElecEventDict
else
$(cmt_local_ElecEventDict_makefile) : $(ElecEventDict_dependencies) $(cmt_build_library_linksstamp) $(bin)ElecEventDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ElecEventDict) ] || \
	  [ ! -f $(cmt_final_setup_ElecEventDict) ] || \
	  $(not_ElecEventDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ElecEventDict.make"; \
	  $(cmtexe) -f=$(bin)ElecEventDict.in -tag=$(tags) $(ElecEventDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ElecEventDict_makefile) ElecEventDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(ElecEventDict_extratags) build constituent_makefile -out=$(cmt_local_ElecEventDict_makefile) ElecEventDict

ElecEventDict :: $(ElecEventDict_dependencies) $(cmt_local_ElecEventDict_makefile) dirs ElecEventDictdirs
	$(echo) "(constituents.make) Starting ElecEventDict"
	@if test -f $(cmt_local_ElecEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEventDict_makefile) ElecEventDict; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecEventDict_makefile) ElecEventDict
	$(echo) "(constituents.make) ElecEventDict done"

clean :: ElecEventDictclean ;

ElecEventDictclean :: $(ElecEventDictclean_dependencies) ##$(cmt_local_ElecEventDict_makefile)
	$(echo) "(constituents.make) Starting ElecEventDictclean"
	@-if test -f $(cmt_local_ElecEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEventDict_makefile) ElecEventDictclean; \
	fi
	$(echo) "(constituents.make) ElecEventDictclean done"
#	@-$(MAKE) -f $(cmt_local_ElecEventDict_makefile) ElecEventDictclean

##	  /bin/rm -f $(cmt_local_ElecEventDict_makefile) $(bin)ElecEventDict_dependencies.make

install :: ElecEventDictinstall ;

ElecEventDictinstall :: $(ElecEventDict_dependencies) $(cmt_local_ElecEventDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_ElecEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEventDict_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_ElecEventDict_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : ElecEventDictuninstall

$(foreach d,$(ElecEventDict_dependencies),$(eval $(d)uninstall_dependencies += ElecEventDictuninstall))

ElecEventDictuninstall : $(ElecEventDictuninstall_dependencies) ##$(cmt_local_ElecEventDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_ElecEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEventDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecEventDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: ElecEventDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ ElecEventDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ ElecEventDict done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_ElecEventxodsrc_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_ElecEventxodsrc_has_target_tag

cmt_local_tagfile_ElecEventxodsrc = $(bin)$(ElecEvent_tag)_ElecEventxodsrc.make
cmt_final_setup_ElecEventxodsrc = $(bin)setup_ElecEventxodsrc.make
cmt_local_ElecEventxodsrc_makefile = $(bin)ElecEventxodsrc.make

ElecEventxodsrc_extratags = -tag_add=target_ElecEventxodsrc

else

cmt_local_tagfile_ElecEventxodsrc = $(bin)$(ElecEvent_tag).make
cmt_final_setup_ElecEventxodsrc = $(bin)setup.make
cmt_local_ElecEventxodsrc_makefile = $(bin)ElecEventxodsrc.make

endif

not_ElecEventxodsrc_dependencies = { n=0; for p in $?; do m=0; for d in $(ElecEventxodsrc_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
ElecEventxodsrcdirs :
	@if test ! -d $(bin)ElecEventxodsrc; then $(mkdir) -p $(bin)ElecEventxodsrc; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)ElecEventxodsrc
else
ElecEventxodsrcdirs : ;
endif

ifdef cmt_ElecEventxodsrc_has_target_tag

ifndef QUICK
$(cmt_local_ElecEventxodsrc_makefile) : $(ElecEventxodsrc_dependencies) build_library_links
	$(echo) "(constituents.make) Building ElecEventxodsrc.make"; \
	  $(cmtexe) -tag=$(tags) $(ElecEventxodsrc_extratags) build constituent_config -out=$(cmt_local_ElecEventxodsrc_makefile) ElecEventxodsrc
else
$(cmt_local_ElecEventxodsrc_makefile) : $(ElecEventxodsrc_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ElecEventxodsrc) ] || \
	  [ ! -f $(cmt_final_setup_ElecEventxodsrc) ] || \
	  $(not_ElecEventxodsrc_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ElecEventxodsrc.make"; \
	  $(cmtexe) -tag=$(tags) $(ElecEventxodsrc_extratags) build constituent_config -out=$(cmt_local_ElecEventxodsrc_makefile) ElecEventxodsrc; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_ElecEventxodsrc_makefile) : $(ElecEventxodsrc_dependencies) build_library_links
	$(echo) "(constituents.make) Building ElecEventxodsrc.make"; \
	  $(cmtexe) -f=$(bin)ElecEventxodsrc.in -tag=$(tags) $(ElecEventxodsrc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ElecEventxodsrc_makefile) ElecEventxodsrc
else
$(cmt_local_ElecEventxodsrc_makefile) : $(ElecEventxodsrc_dependencies) $(cmt_build_library_linksstamp) $(bin)ElecEventxodsrc.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ElecEventxodsrc) ] || \
	  [ ! -f $(cmt_final_setup_ElecEventxodsrc) ] || \
	  $(not_ElecEventxodsrc_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ElecEventxodsrc.make"; \
	  $(cmtexe) -f=$(bin)ElecEventxodsrc.in -tag=$(tags) $(ElecEventxodsrc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ElecEventxodsrc_makefile) ElecEventxodsrc; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(ElecEventxodsrc_extratags) build constituent_makefile -out=$(cmt_local_ElecEventxodsrc_makefile) ElecEventxodsrc

ElecEventxodsrc :: $(ElecEventxodsrc_dependencies) $(cmt_local_ElecEventxodsrc_makefile) dirs ElecEventxodsrcdirs
	$(echo) "(constituents.make) Starting ElecEventxodsrc"
	@if test -f $(cmt_local_ElecEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEventxodsrc_makefile) ElecEventxodsrc; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecEventxodsrc_makefile) ElecEventxodsrc
	$(echo) "(constituents.make) ElecEventxodsrc done"

clean :: ElecEventxodsrcclean ;

ElecEventxodsrcclean :: $(ElecEventxodsrcclean_dependencies) ##$(cmt_local_ElecEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting ElecEventxodsrcclean"
	@-if test -f $(cmt_local_ElecEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEventxodsrc_makefile) ElecEventxodsrcclean; \
	fi
	$(echo) "(constituents.make) ElecEventxodsrcclean done"
#	@-$(MAKE) -f $(cmt_local_ElecEventxodsrc_makefile) ElecEventxodsrcclean

##	  /bin/rm -f $(cmt_local_ElecEventxodsrc_makefile) $(bin)ElecEventxodsrc_dependencies.make

install :: ElecEventxodsrcinstall ;

ElecEventxodsrcinstall :: $(ElecEventxodsrc_dependencies) $(cmt_local_ElecEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_ElecEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEventxodsrc_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_ElecEventxodsrc_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : ElecEventxodsrcuninstall

$(foreach d,$(ElecEventxodsrc_dependencies),$(eval $(d)uninstall_dependencies += ElecEventxodsrcuninstall))

ElecEventxodsrcuninstall : $(ElecEventxodsrcuninstall_dependencies) ##$(cmt_local_ElecEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_ElecEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEventxodsrc_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecEventxodsrc_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: ElecEventxodsrcuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ ElecEventxodsrc"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ ElecEventxodsrc done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_ElecEvent_has_no_target_tag = 1
cmt_ElecEvent_has_prototypes = 1

#--------------------------------------

ifdef cmt_ElecEvent_has_target_tag

cmt_local_tagfile_ElecEvent = $(bin)$(ElecEvent_tag)_ElecEvent.make
cmt_final_setup_ElecEvent = $(bin)setup_ElecEvent.make
cmt_local_ElecEvent_makefile = $(bin)ElecEvent.make

ElecEvent_extratags = -tag_add=target_ElecEvent

else

cmt_local_tagfile_ElecEvent = $(bin)$(ElecEvent_tag).make
cmt_final_setup_ElecEvent = $(bin)setup.make
cmt_local_ElecEvent_makefile = $(bin)ElecEvent.make

endif

not_ElecEventcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(ElecEventcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
ElecEventdirs :
	@if test ! -d $(bin)ElecEvent; then $(mkdir) -p $(bin)ElecEvent; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)ElecEvent
else
ElecEventdirs : ;
endif

ifdef cmt_ElecEvent_has_target_tag

ifndef QUICK
$(cmt_local_ElecEvent_makefile) : $(ElecEventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building ElecEvent.make"; \
	  $(cmtexe) -tag=$(tags) $(ElecEvent_extratags) build constituent_config -out=$(cmt_local_ElecEvent_makefile) ElecEvent
else
$(cmt_local_ElecEvent_makefile) : $(ElecEventcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ElecEvent) ] || \
	  [ ! -f $(cmt_final_setup_ElecEvent) ] || \
	  $(not_ElecEventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ElecEvent.make"; \
	  $(cmtexe) -tag=$(tags) $(ElecEvent_extratags) build constituent_config -out=$(cmt_local_ElecEvent_makefile) ElecEvent; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_ElecEvent_makefile) : $(ElecEventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building ElecEvent.make"; \
	  $(cmtexe) -f=$(bin)ElecEvent.in -tag=$(tags) $(ElecEvent_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ElecEvent_makefile) ElecEvent
else
$(cmt_local_ElecEvent_makefile) : $(ElecEventcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)ElecEvent.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ElecEvent) ] || \
	  [ ! -f $(cmt_final_setup_ElecEvent) ] || \
	  $(not_ElecEventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ElecEvent.make"; \
	  $(cmtexe) -f=$(bin)ElecEvent.in -tag=$(tags) $(ElecEvent_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ElecEvent_makefile) ElecEvent; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(ElecEvent_extratags) build constituent_makefile -out=$(cmt_local_ElecEvent_makefile) ElecEvent

ElecEvent :: ElecEventcompile ElecEventinstall ;

ifdef cmt_ElecEvent_has_prototypes

ElecEventprototype : $(ElecEventprototype_dependencies) $(cmt_local_ElecEvent_makefile) dirs ElecEventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_ElecEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

ElecEventcompile : ElecEventprototype

endif

ElecEventcompile : $(ElecEventcompile_dependencies) $(cmt_local_ElecEvent_makefile) dirs ElecEventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_ElecEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: ElecEventclean ;

ElecEventclean :: $(ElecEventclean_dependencies) ##$(cmt_local_ElecEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_ElecEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEvent_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_ElecEvent_makefile) ElecEventclean

##	  /bin/rm -f $(cmt_local_ElecEvent_makefile) $(bin)ElecEvent_dependencies.make

install :: ElecEventinstall ;

ElecEventinstall :: ElecEventcompile $(ElecEvent_dependencies) $(cmt_local_ElecEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_ElecEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : ElecEventuninstall

$(foreach d,$(ElecEvent_dependencies),$(eval $(d)uninstall_dependencies += ElecEventuninstall))

ElecEventuninstall : $(ElecEventuninstall_dependencies) ##$(cmt_local_ElecEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_ElecEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_ElecEvent_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_ElecEvent_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: ElecEventuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ ElecEvent"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ ElecEvent done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(ElecEvent_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(ElecEvent_tag).make
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


#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

PhyEvent_tag = $(tag)

#cmt_local_tagfile = $(PhyEvent_tag).make
cmt_local_tagfile = $(bin)$(PhyEvent_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)PhyEventsetup.make
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

cmt_PhyEventObj2Doth_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_PhyEventObj2Doth_has_target_tag

cmt_local_tagfile_PhyEventObj2Doth = $(bin)$(PhyEvent_tag)_PhyEventObj2Doth.make
cmt_final_setup_PhyEventObj2Doth = $(bin)setup_PhyEventObj2Doth.make
cmt_local_PhyEventObj2Doth_makefile = $(bin)PhyEventObj2Doth.make

PhyEventObj2Doth_extratags = -tag_add=target_PhyEventObj2Doth

else

cmt_local_tagfile_PhyEventObj2Doth = $(bin)$(PhyEvent_tag).make
cmt_final_setup_PhyEventObj2Doth = $(bin)setup.make
cmt_local_PhyEventObj2Doth_makefile = $(bin)PhyEventObj2Doth.make

endif

not_PhyEventObj2Doth_dependencies = { n=0; for p in $?; do m=0; for d in $(PhyEventObj2Doth_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PhyEventObj2Dothdirs :
	@if test ! -d $(bin)PhyEventObj2Doth; then $(mkdir) -p $(bin)PhyEventObj2Doth; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PhyEventObj2Doth
else
PhyEventObj2Dothdirs : ;
endif

ifdef cmt_PhyEventObj2Doth_has_target_tag

ifndef QUICK
$(cmt_local_PhyEventObj2Doth_makefile) : $(PhyEventObj2Doth_dependencies) build_library_links
	$(echo) "(constituents.make) Building PhyEventObj2Doth.make"; \
	  $(cmtexe) -tag=$(tags) $(PhyEventObj2Doth_extratags) build constituent_config -out=$(cmt_local_PhyEventObj2Doth_makefile) PhyEventObj2Doth
else
$(cmt_local_PhyEventObj2Doth_makefile) : $(PhyEventObj2Doth_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PhyEventObj2Doth) ] || \
	  [ ! -f $(cmt_final_setup_PhyEventObj2Doth) ] || \
	  $(not_PhyEventObj2Doth_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PhyEventObj2Doth.make"; \
	  $(cmtexe) -tag=$(tags) $(PhyEventObj2Doth_extratags) build constituent_config -out=$(cmt_local_PhyEventObj2Doth_makefile) PhyEventObj2Doth; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PhyEventObj2Doth_makefile) : $(PhyEventObj2Doth_dependencies) build_library_links
	$(echo) "(constituents.make) Building PhyEventObj2Doth.make"; \
	  $(cmtexe) -f=$(bin)PhyEventObj2Doth.in -tag=$(tags) $(PhyEventObj2Doth_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PhyEventObj2Doth_makefile) PhyEventObj2Doth
else
$(cmt_local_PhyEventObj2Doth_makefile) : $(PhyEventObj2Doth_dependencies) $(cmt_build_library_linksstamp) $(bin)PhyEventObj2Doth.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PhyEventObj2Doth) ] || \
	  [ ! -f $(cmt_final_setup_PhyEventObj2Doth) ] || \
	  $(not_PhyEventObj2Doth_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PhyEventObj2Doth.make"; \
	  $(cmtexe) -f=$(bin)PhyEventObj2Doth.in -tag=$(tags) $(PhyEventObj2Doth_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PhyEventObj2Doth_makefile) PhyEventObj2Doth; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PhyEventObj2Doth_extratags) build constituent_makefile -out=$(cmt_local_PhyEventObj2Doth_makefile) PhyEventObj2Doth

PhyEventObj2Doth :: $(PhyEventObj2Doth_dependencies) $(cmt_local_PhyEventObj2Doth_makefile) dirs PhyEventObj2Dothdirs
	$(echo) "(constituents.make) Starting PhyEventObj2Doth"
	@if test -f $(cmt_local_PhyEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEventObj2Doth_makefile) PhyEventObj2Doth; \
	  fi
#	@$(MAKE) -f $(cmt_local_PhyEventObj2Doth_makefile) PhyEventObj2Doth
	$(echo) "(constituents.make) PhyEventObj2Doth done"

clean :: PhyEventObj2Dothclean ;

PhyEventObj2Dothclean :: $(PhyEventObj2Dothclean_dependencies) ##$(cmt_local_PhyEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting PhyEventObj2Dothclean"
	@-if test -f $(cmt_local_PhyEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEventObj2Doth_makefile) PhyEventObj2Dothclean; \
	fi
	$(echo) "(constituents.make) PhyEventObj2Dothclean done"
#	@-$(MAKE) -f $(cmt_local_PhyEventObj2Doth_makefile) PhyEventObj2Dothclean

##	  /bin/rm -f $(cmt_local_PhyEventObj2Doth_makefile) $(bin)PhyEventObj2Doth_dependencies.make

install :: PhyEventObj2Dothinstall ;

PhyEventObj2Dothinstall :: $(PhyEventObj2Doth_dependencies) $(cmt_local_PhyEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PhyEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEventObj2Doth_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_PhyEventObj2Doth_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : PhyEventObj2Dothuninstall

$(foreach d,$(PhyEventObj2Doth_dependencies),$(eval $(d)uninstall_dependencies += PhyEventObj2Dothuninstall))

PhyEventObj2Dothuninstall : $(PhyEventObj2Dothuninstall_dependencies) ##$(cmt_local_PhyEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PhyEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEventObj2Doth_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PhyEventObj2Doth_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PhyEventObj2Dothuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PhyEventObj2Doth"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PhyEventObj2Doth done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_more_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_more_includes_has_target_tag

cmt_local_tagfile_install_more_includes = $(bin)$(PhyEvent_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(PhyEvent_tag).make
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

cmt_PhyEventDict_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_PhyEventDict_has_target_tag

cmt_local_tagfile_PhyEventDict = $(bin)$(PhyEvent_tag)_PhyEventDict.make
cmt_final_setup_PhyEventDict = $(bin)setup_PhyEventDict.make
cmt_local_PhyEventDict_makefile = $(bin)PhyEventDict.make

PhyEventDict_extratags = -tag_add=target_PhyEventDict

else

cmt_local_tagfile_PhyEventDict = $(bin)$(PhyEvent_tag).make
cmt_final_setup_PhyEventDict = $(bin)setup.make
cmt_local_PhyEventDict_makefile = $(bin)PhyEventDict.make

endif

not_PhyEventDict_dependencies = { n=0; for p in $?; do m=0; for d in $(PhyEventDict_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PhyEventDictdirs :
	@if test ! -d $(bin)PhyEventDict; then $(mkdir) -p $(bin)PhyEventDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PhyEventDict
else
PhyEventDictdirs : ;
endif

ifdef cmt_PhyEventDict_has_target_tag

ifndef QUICK
$(cmt_local_PhyEventDict_makefile) : $(PhyEventDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building PhyEventDict.make"; \
	  $(cmtexe) -tag=$(tags) $(PhyEventDict_extratags) build constituent_config -out=$(cmt_local_PhyEventDict_makefile) PhyEventDict
else
$(cmt_local_PhyEventDict_makefile) : $(PhyEventDict_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PhyEventDict) ] || \
	  [ ! -f $(cmt_final_setup_PhyEventDict) ] || \
	  $(not_PhyEventDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PhyEventDict.make"; \
	  $(cmtexe) -tag=$(tags) $(PhyEventDict_extratags) build constituent_config -out=$(cmt_local_PhyEventDict_makefile) PhyEventDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PhyEventDict_makefile) : $(PhyEventDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building PhyEventDict.make"; \
	  $(cmtexe) -f=$(bin)PhyEventDict.in -tag=$(tags) $(PhyEventDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PhyEventDict_makefile) PhyEventDict
else
$(cmt_local_PhyEventDict_makefile) : $(PhyEventDict_dependencies) $(cmt_build_library_linksstamp) $(bin)PhyEventDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PhyEventDict) ] || \
	  [ ! -f $(cmt_final_setup_PhyEventDict) ] || \
	  $(not_PhyEventDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PhyEventDict.make"; \
	  $(cmtexe) -f=$(bin)PhyEventDict.in -tag=$(tags) $(PhyEventDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PhyEventDict_makefile) PhyEventDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PhyEventDict_extratags) build constituent_makefile -out=$(cmt_local_PhyEventDict_makefile) PhyEventDict

PhyEventDict :: $(PhyEventDict_dependencies) $(cmt_local_PhyEventDict_makefile) dirs PhyEventDictdirs
	$(echo) "(constituents.make) Starting PhyEventDict"
	@if test -f $(cmt_local_PhyEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEventDict_makefile) PhyEventDict; \
	  fi
#	@$(MAKE) -f $(cmt_local_PhyEventDict_makefile) PhyEventDict
	$(echo) "(constituents.make) PhyEventDict done"

clean :: PhyEventDictclean ;

PhyEventDictclean :: $(PhyEventDictclean_dependencies) ##$(cmt_local_PhyEventDict_makefile)
	$(echo) "(constituents.make) Starting PhyEventDictclean"
	@-if test -f $(cmt_local_PhyEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEventDict_makefile) PhyEventDictclean; \
	fi
	$(echo) "(constituents.make) PhyEventDictclean done"
#	@-$(MAKE) -f $(cmt_local_PhyEventDict_makefile) PhyEventDictclean

##	  /bin/rm -f $(cmt_local_PhyEventDict_makefile) $(bin)PhyEventDict_dependencies.make

install :: PhyEventDictinstall ;

PhyEventDictinstall :: $(PhyEventDict_dependencies) $(cmt_local_PhyEventDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PhyEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEventDict_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_PhyEventDict_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : PhyEventDictuninstall

$(foreach d,$(PhyEventDict_dependencies),$(eval $(d)uninstall_dependencies += PhyEventDictuninstall))

PhyEventDictuninstall : $(PhyEventDictuninstall_dependencies) ##$(cmt_local_PhyEventDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PhyEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEventDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PhyEventDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PhyEventDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PhyEventDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PhyEventDict done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_PhyEventxodsrc_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_PhyEventxodsrc_has_target_tag

cmt_local_tagfile_PhyEventxodsrc = $(bin)$(PhyEvent_tag)_PhyEventxodsrc.make
cmt_final_setup_PhyEventxodsrc = $(bin)setup_PhyEventxodsrc.make
cmt_local_PhyEventxodsrc_makefile = $(bin)PhyEventxodsrc.make

PhyEventxodsrc_extratags = -tag_add=target_PhyEventxodsrc

else

cmt_local_tagfile_PhyEventxodsrc = $(bin)$(PhyEvent_tag).make
cmt_final_setup_PhyEventxodsrc = $(bin)setup.make
cmt_local_PhyEventxodsrc_makefile = $(bin)PhyEventxodsrc.make

endif

not_PhyEventxodsrc_dependencies = { n=0; for p in $?; do m=0; for d in $(PhyEventxodsrc_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PhyEventxodsrcdirs :
	@if test ! -d $(bin)PhyEventxodsrc; then $(mkdir) -p $(bin)PhyEventxodsrc; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PhyEventxodsrc
else
PhyEventxodsrcdirs : ;
endif

ifdef cmt_PhyEventxodsrc_has_target_tag

ifndef QUICK
$(cmt_local_PhyEventxodsrc_makefile) : $(PhyEventxodsrc_dependencies) build_library_links
	$(echo) "(constituents.make) Building PhyEventxodsrc.make"; \
	  $(cmtexe) -tag=$(tags) $(PhyEventxodsrc_extratags) build constituent_config -out=$(cmt_local_PhyEventxodsrc_makefile) PhyEventxodsrc
else
$(cmt_local_PhyEventxodsrc_makefile) : $(PhyEventxodsrc_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PhyEventxodsrc) ] || \
	  [ ! -f $(cmt_final_setup_PhyEventxodsrc) ] || \
	  $(not_PhyEventxodsrc_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PhyEventxodsrc.make"; \
	  $(cmtexe) -tag=$(tags) $(PhyEventxodsrc_extratags) build constituent_config -out=$(cmt_local_PhyEventxodsrc_makefile) PhyEventxodsrc; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PhyEventxodsrc_makefile) : $(PhyEventxodsrc_dependencies) build_library_links
	$(echo) "(constituents.make) Building PhyEventxodsrc.make"; \
	  $(cmtexe) -f=$(bin)PhyEventxodsrc.in -tag=$(tags) $(PhyEventxodsrc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PhyEventxodsrc_makefile) PhyEventxodsrc
else
$(cmt_local_PhyEventxodsrc_makefile) : $(PhyEventxodsrc_dependencies) $(cmt_build_library_linksstamp) $(bin)PhyEventxodsrc.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PhyEventxodsrc) ] || \
	  [ ! -f $(cmt_final_setup_PhyEventxodsrc) ] || \
	  $(not_PhyEventxodsrc_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PhyEventxodsrc.make"; \
	  $(cmtexe) -f=$(bin)PhyEventxodsrc.in -tag=$(tags) $(PhyEventxodsrc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PhyEventxodsrc_makefile) PhyEventxodsrc; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PhyEventxodsrc_extratags) build constituent_makefile -out=$(cmt_local_PhyEventxodsrc_makefile) PhyEventxodsrc

PhyEventxodsrc :: $(PhyEventxodsrc_dependencies) $(cmt_local_PhyEventxodsrc_makefile) dirs PhyEventxodsrcdirs
	$(echo) "(constituents.make) Starting PhyEventxodsrc"
	@if test -f $(cmt_local_PhyEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEventxodsrc_makefile) PhyEventxodsrc; \
	  fi
#	@$(MAKE) -f $(cmt_local_PhyEventxodsrc_makefile) PhyEventxodsrc
	$(echo) "(constituents.make) PhyEventxodsrc done"

clean :: PhyEventxodsrcclean ;

PhyEventxodsrcclean :: $(PhyEventxodsrcclean_dependencies) ##$(cmt_local_PhyEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting PhyEventxodsrcclean"
	@-if test -f $(cmt_local_PhyEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEventxodsrc_makefile) PhyEventxodsrcclean; \
	fi
	$(echo) "(constituents.make) PhyEventxodsrcclean done"
#	@-$(MAKE) -f $(cmt_local_PhyEventxodsrc_makefile) PhyEventxodsrcclean

##	  /bin/rm -f $(cmt_local_PhyEventxodsrc_makefile) $(bin)PhyEventxodsrc_dependencies.make

install :: PhyEventxodsrcinstall ;

PhyEventxodsrcinstall :: $(PhyEventxodsrc_dependencies) $(cmt_local_PhyEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PhyEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEventxodsrc_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_PhyEventxodsrc_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : PhyEventxodsrcuninstall

$(foreach d,$(PhyEventxodsrc_dependencies),$(eval $(d)uninstall_dependencies += PhyEventxodsrcuninstall))

PhyEventxodsrcuninstall : $(PhyEventxodsrcuninstall_dependencies) ##$(cmt_local_PhyEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PhyEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEventxodsrc_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PhyEventxodsrc_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PhyEventxodsrcuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PhyEventxodsrc"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PhyEventxodsrc done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_PhyEvent_has_no_target_tag = 1
cmt_PhyEvent_has_prototypes = 1

#--------------------------------------

ifdef cmt_PhyEvent_has_target_tag

cmt_local_tagfile_PhyEvent = $(bin)$(PhyEvent_tag)_PhyEvent.make
cmt_final_setup_PhyEvent = $(bin)setup_PhyEvent.make
cmt_local_PhyEvent_makefile = $(bin)PhyEvent.make

PhyEvent_extratags = -tag_add=target_PhyEvent

else

cmt_local_tagfile_PhyEvent = $(bin)$(PhyEvent_tag).make
cmt_final_setup_PhyEvent = $(bin)setup.make
cmt_local_PhyEvent_makefile = $(bin)PhyEvent.make

endif

not_PhyEventcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(PhyEventcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PhyEventdirs :
	@if test ! -d $(bin)PhyEvent; then $(mkdir) -p $(bin)PhyEvent; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PhyEvent
else
PhyEventdirs : ;
endif

ifdef cmt_PhyEvent_has_target_tag

ifndef QUICK
$(cmt_local_PhyEvent_makefile) : $(PhyEventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PhyEvent.make"; \
	  $(cmtexe) -tag=$(tags) $(PhyEvent_extratags) build constituent_config -out=$(cmt_local_PhyEvent_makefile) PhyEvent
else
$(cmt_local_PhyEvent_makefile) : $(PhyEventcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PhyEvent) ] || \
	  [ ! -f $(cmt_final_setup_PhyEvent) ] || \
	  $(not_PhyEventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PhyEvent.make"; \
	  $(cmtexe) -tag=$(tags) $(PhyEvent_extratags) build constituent_config -out=$(cmt_local_PhyEvent_makefile) PhyEvent; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PhyEvent_makefile) : $(PhyEventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PhyEvent.make"; \
	  $(cmtexe) -f=$(bin)PhyEvent.in -tag=$(tags) $(PhyEvent_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PhyEvent_makefile) PhyEvent
else
$(cmt_local_PhyEvent_makefile) : $(PhyEventcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)PhyEvent.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PhyEvent) ] || \
	  [ ! -f $(cmt_final_setup_PhyEvent) ] || \
	  $(not_PhyEventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PhyEvent.make"; \
	  $(cmtexe) -f=$(bin)PhyEvent.in -tag=$(tags) $(PhyEvent_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PhyEvent_makefile) PhyEvent; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PhyEvent_extratags) build constituent_makefile -out=$(cmt_local_PhyEvent_makefile) PhyEvent

PhyEvent :: PhyEventcompile PhyEventinstall ;

ifdef cmt_PhyEvent_has_prototypes

PhyEventprototype : $(PhyEventprototype_dependencies) $(cmt_local_PhyEvent_makefile) dirs PhyEventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PhyEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PhyEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

PhyEventcompile : PhyEventprototype

endif

PhyEventcompile : $(PhyEventcompile_dependencies) $(cmt_local_PhyEvent_makefile) dirs PhyEventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PhyEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PhyEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: PhyEventclean ;

PhyEventclean :: $(PhyEventclean_dependencies) ##$(cmt_local_PhyEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PhyEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEvent_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_PhyEvent_makefile) PhyEventclean

##	  /bin/rm -f $(cmt_local_PhyEvent_makefile) $(bin)PhyEvent_dependencies.make

install :: PhyEventinstall ;

PhyEventinstall :: PhyEventcompile $(PhyEvent_dependencies) $(cmt_local_PhyEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PhyEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PhyEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : PhyEventuninstall

$(foreach d,$(PhyEvent_dependencies),$(eval $(d)uninstall_dependencies += PhyEventuninstall))

PhyEventuninstall : $(PhyEventuninstall_dependencies) ##$(cmt_local_PhyEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PhyEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_PhyEvent_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PhyEvent_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PhyEventuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PhyEvent"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PhyEvent done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(PhyEvent_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(PhyEvent_tag).make
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


#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

CalibEvent_tag = $(tag)

#cmt_local_tagfile = $(CalibEvent_tag).make
cmt_local_tagfile = $(bin)$(CalibEvent_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)CalibEventsetup.make
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

cmt_CalibEventObj2Doth_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_CalibEventObj2Doth_has_target_tag

cmt_local_tagfile_CalibEventObj2Doth = $(bin)$(CalibEvent_tag)_CalibEventObj2Doth.make
cmt_final_setup_CalibEventObj2Doth = $(bin)setup_CalibEventObj2Doth.make
cmt_local_CalibEventObj2Doth_makefile = $(bin)CalibEventObj2Doth.make

CalibEventObj2Doth_extratags = -tag_add=target_CalibEventObj2Doth

else

cmt_local_tagfile_CalibEventObj2Doth = $(bin)$(CalibEvent_tag).make
cmt_final_setup_CalibEventObj2Doth = $(bin)setup.make
cmt_local_CalibEventObj2Doth_makefile = $(bin)CalibEventObj2Doth.make

endif

not_CalibEventObj2Doth_dependencies = { n=0; for p in $?; do m=0; for d in $(CalibEventObj2Doth_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
CalibEventObj2Dothdirs :
	@if test ! -d $(bin)CalibEventObj2Doth; then $(mkdir) -p $(bin)CalibEventObj2Doth; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)CalibEventObj2Doth
else
CalibEventObj2Dothdirs : ;
endif

ifdef cmt_CalibEventObj2Doth_has_target_tag

ifndef QUICK
$(cmt_local_CalibEventObj2Doth_makefile) : $(CalibEventObj2Doth_dependencies) build_library_links
	$(echo) "(constituents.make) Building CalibEventObj2Doth.make"; \
	  $(cmtexe) -tag=$(tags) $(CalibEventObj2Doth_extratags) build constituent_config -out=$(cmt_local_CalibEventObj2Doth_makefile) CalibEventObj2Doth
else
$(cmt_local_CalibEventObj2Doth_makefile) : $(CalibEventObj2Doth_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CalibEventObj2Doth) ] || \
	  [ ! -f $(cmt_final_setup_CalibEventObj2Doth) ] || \
	  $(not_CalibEventObj2Doth_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CalibEventObj2Doth.make"; \
	  $(cmtexe) -tag=$(tags) $(CalibEventObj2Doth_extratags) build constituent_config -out=$(cmt_local_CalibEventObj2Doth_makefile) CalibEventObj2Doth; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_CalibEventObj2Doth_makefile) : $(CalibEventObj2Doth_dependencies) build_library_links
	$(echo) "(constituents.make) Building CalibEventObj2Doth.make"; \
	  $(cmtexe) -f=$(bin)CalibEventObj2Doth.in -tag=$(tags) $(CalibEventObj2Doth_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CalibEventObj2Doth_makefile) CalibEventObj2Doth
else
$(cmt_local_CalibEventObj2Doth_makefile) : $(CalibEventObj2Doth_dependencies) $(cmt_build_library_linksstamp) $(bin)CalibEventObj2Doth.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CalibEventObj2Doth) ] || \
	  [ ! -f $(cmt_final_setup_CalibEventObj2Doth) ] || \
	  $(not_CalibEventObj2Doth_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CalibEventObj2Doth.make"; \
	  $(cmtexe) -f=$(bin)CalibEventObj2Doth.in -tag=$(tags) $(CalibEventObj2Doth_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CalibEventObj2Doth_makefile) CalibEventObj2Doth; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(CalibEventObj2Doth_extratags) build constituent_makefile -out=$(cmt_local_CalibEventObj2Doth_makefile) CalibEventObj2Doth

CalibEventObj2Doth :: $(CalibEventObj2Doth_dependencies) $(cmt_local_CalibEventObj2Doth_makefile) dirs CalibEventObj2Dothdirs
	$(echo) "(constituents.make) Starting CalibEventObj2Doth"
	@if test -f $(cmt_local_CalibEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEventObj2Doth_makefile) CalibEventObj2Doth; \
	  fi
#	@$(MAKE) -f $(cmt_local_CalibEventObj2Doth_makefile) CalibEventObj2Doth
	$(echo) "(constituents.make) CalibEventObj2Doth done"

clean :: CalibEventObj2Dothclean ;

CalibEventObj2Dothclean :: $(CalibEventObj2Dothclean_dependencies) ##$(cmt_local_CalibEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting CalibEventObj2Dothclean"
	@-if test -f $(cmt_local_CalibEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEventObj2Doth_makefile) CalibEventObj2Dothclean; \
	fi
	$(echo) "(constituents.make) CalibEventObj2Dothclean done"
#	@-$(MAKE) -f $(cmt_local_CalibEventObj2Doth_makefile) CalibEventObj2Dothclean

##	  /bin/rm -f $(cmt_local_CalibEventObj2Doth_makefile) $(bin)CalibEventObj2Doth_dependencies.make

install :: CalibEventObj2Dothinstall ;

CalibEventObj2Dothinstall :: $(CalibEventObj2Doth_dependencies) $(cmt_local_CalibEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_CalibEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEventObj2Doth_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_CalibEventObj2Doth_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : CalibEventObj2Dothuninstall

$(foreach d,$(CalibEventObj2Doth_dependencies),$(eval $(d)uninstall_dependencies += CalibEventObj2Dothuninstall))

CalibEventObj2Dothuninstall : $(CalibEventObj2Dothuninstall_dependencies) ##$(cmt_local_CalibEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_CalibEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEventObj2Doth_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_CalibEventObj2Doth_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: CalibEventObj2Dothuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ CalibEventObj2Doth"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ CalibEventObj2Doth done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_more_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_more_includes_has_target_tag

cmt_local_tagfile_install_more_includes = $(bin)$(CalibEvent_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(CalibEvent_tag).make
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

cmt_CalibEventDict_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_CalibEventDict_has_target_tag

cmt_local_tagfile_CalibEventDict = $(bin)$(CalibEvent_tag)_CalibEventDict.make
cmt_final_setup_CalibEventDict = $(bin)setup_CalibEventDict.make
cmt_local_CalibEventDict_makefile = $(bin)CalibEventDict.make

CalibEventDict_extratags = -tag_add=target_CalibEventDict

else

cmt_local_tagfile_CalibEventDict = $(bin)$(CalibEvent_tag).make
cmt_final_setup_CalibEventDict = $(bin)setup.make
cmt_local_CalibEventDict_makefile = $(bin)CalibEventDict.make

endif

not_CalibEventDict_dependencies = { n=0; for p in $?; do m=0; for d in $(CalibEventDict_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
CalibEventDictdirs :
	@if test ! -d $(bin)CalibEventDict; then $(mkdir) -p $(bin)CalibEventDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)CalibEventDict
else
CalibEventDictdirs : ;
endif

ifdef cmt_CalibEventDict_has_target_tag

ifndef QUICK
$(cmt_local_CalibEventDict_makefile) : $(CalibEventDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building CalibEventDict.make"; \
	  $(cmtexe) -tag=$(tags) $(CalibEventDict_extratags) build constituent_config -out=$(cmt_local_CalibEventDict_makefile) CalibEventDict
else
$(cmt_local_CalibEventDict_makefile) : $(CalibEventDict_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CalibEventDict) ] || \
	  [ ! -f $(cmt_final_setup_CalibEventDict) ] || \
	  $(not_CalibEventDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CalibEventDict.make"; \
	  $(cmtexe) -tag=$(tags) $(CalibEventDict_extratags) build constituent_config -out=$(cmt_local_CalibEventDict_makefile) CalibEventDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_CalibEventDict_makefile) : $(CalibEventDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building CalibEventDict.make"; \
	  $(cmtexe) -f=$(bin)CalibEventDict.in -tag=$(tags) $(CalibEventDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CalibEventDict_makefile) CalibEventDict
else
$(cmt_local_CalibEventDict_makefile) : $(CalibEventDict_dependencies) $(cmt_build_library_linksstamp) $(bin)CalibEventDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CalibEventDict) ] || \
	  [ ! -f $(cmt_final_setup_CalibEventDict) ] || \
	  $(not_CalibEventDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CalibEventDict.make"; \
	  $(cmtexe) -f=$(bin)CalibEventDict.in -tag=$(tags) $(CalibEventDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CalibEventDict_makefile) CalibEventDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(CalibEventDict_extratags) build constituent_makefile -out=$(cmt_local_CalibEventDict_makefile) CalibEventDict

CalibEventDict :: $(CalibEventDict_dependencies) $(cmt_local_CalibEventDict_makefile) dirs CalibEventDictdirs
	$(echo) "(constituents.make) Starting CalibEventDict"
	@if test -f $(cmt_local_CalibEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEventDict_makefile) CalibEventDict; \
	  fi
#	@$(MAKE) -f $(cmt_local_CalibEventDict_makefile) CalibEventDict
	$(echo) "(constituents.make) CalibEventDict done"

clean :: CalibEventDictclean ;

CalibEventDictclean :: $(CalibEventDictclean_dependencies) ##$(cmt_local_CalibEventDict_makefile)
	$(echo) "(constituents.make) Starting CalibEventDictclean"
	@-if test -f $(cmt_local_CalibEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEventDict_makefile) CalibEventDictclean; \
	fi
	$(echo) "(constituents.make) CalibEventDictclean done"
#	@-$(MAKE) -f $(cmt_local_CalibEventDict_makefile) CalibEventDictclean

##	  /bin/rm -f $(cmt_local_CalibEventDict_makefile) $(bin)CalibEventDict_dependencies.make

install :: CalibEventDictinstall ;

CalibEventDictinstall :: $(CalibEventDict_dependencies) $(cmt_local_CalibEventDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_CalibEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEventDict_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_CalibEventDict_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : CalibEventDictuninstall

$(foreach d,$(CalibEventDict_dependencies),$(eval $(d)uninstall_dependencies += CalibEventDictuninstall))

CalibEventDictuninstall : $(CalibEventDictuninstall_dependencies) ##$(cmt_local_CalibEventDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_CalibEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEventDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_CalibEventDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: CalibEventDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ CalibEventDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ CalibEventDict done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_CalibEventxodsrc_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_CalibEventxodsrc_has_target_tag

cmt_local_tagfile_CalibEventxodsrc = $(bin)$(CalibEvent_tag)_CalibEventxodsrc.make
cmt_final_setup_CalibEventxodsrc = $(bin)setup_CalibEventxodsrc.make
cmt_local_CalibEventxodsrc_makefile = $(bin)CalibEventxodsrc.make

CalibEventxodsrc_extratags = -tag_add=target_CalibEventxodsrc

else

cmt_local_tagfile_CalibEventxodsrc = $(bin)$(CalibEvent_tag).make
cmt_final_setup_CalibEventxodsrc = $(bin)setup.make
cmt_local_CalibEventxodsrc_makefile = $(bin)CalibEventxodsrc.make

endif

not_CalibEventxodsrc_dependencies = { n=0; for p in $?; do m=0; for d in $(CalibEventxodsrc_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
CalibEventxodsrcdirs :
	@if test ! -d $(bin)CalibEventxodsrc; then $(mkdir) -p $(bin)CalibEventxodsrc; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)CalibEventxodsrc
else
CalibEventxodsrcdirs : ;
endif

ifdef cmt_CalibEventxodsrc_has_target_tag

ifndef QUICK
$(cmt_local_CalibEventxodsrc_makefile) : $(CalibEventxodsrc_dependencies) build_library_links
	$(echo) "(constituents.make) Building CalibEventxodsrc.make"; \
	  $(cmtexe) -tag=$(tags) $(CalibEventxodsrc_extratags) build constituent_config -out=$(cmt_local_CalibEventxodsrc_makefile) CalibEventxodsrc
else
$(cmt_local_CalibEventxodsrc_makefile) : $(CalibEventxodsrc_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CalibEventxodsrc) ] || \
	  [ ! -f $(cmt_final_setup_CalibEventxodsrc) ] || \
	  $(not_CalibEventxodsrc_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CalibEventxodsrc.make"; \
	  $(cmtexe) -tag=$(tags) $(CalibEventxodsrc_extratags) build constituent_config -out=$(cmt_local_CalibEventxodsrc_makefile) CalibEventxodsrc; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_CalibEventxodsrc_makefile) : $(CalibEventxodsrc_dependencies) build_library_links
	$(echo) "(constituents.make) Building CalibEventxodsrc.make"; \
	  $(cmtexe) -f=$(bin)CalibEventxodsrc.in -tag=$(tags) $(CalibEventxodsrc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CalibEventxodsrc_makefile) CalibEventxodsrc
else
$(cmt_local_CalibEventxodsrc_makefile) : $(CalibEventxodsrc_dependencies) $(cmt_build_library_linksstamp) $(bin)CalibEventxodsrc.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CalibEventxodsrc) ] || \
	  [ ! -f $(cmt_final_setup_CalibEventxodsrc) ] || \
	  $(not_CalibEventxodsrc_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CalibEventxodsrc.make"; \
	  $(cmtexe) -f=$(bin)CalibEventxodsrc.in -tag=$(tags) $(CalibEventxodsrc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CalibEventxodsrc_makefile) CalibEventxodsrc; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(CalibEventxodsrc_extratags) build constituent_makefile -out=$(cmt_local_CalibEventxodsrc_makefile) CalibEventxodsrc

CalibEventxodsrc :: $(CalibEventxodsrc_dependencies) $(cmt_local_CalibEventxodsrc_makefile) dirs CalibEventxodsrcdirs
	$(echo) "(constituents.make) Starting CalibEventxodsrc"
	@if test -f $(cmt_local_CalibEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEventxodsrc_makefile) CalibEventxodsrc; \
	  fi
#	@$(MAKE) -f $(cmt_local_CalibEventxodsrc_makefile) CalibEventxodsrc
	$(echo) "(constituents.make) CalibEventxodsrc done"

clean :: CalibEventxodsrcclean ;

CalibEventxodsrcclean :: $(CalibEventxodsrcclean_dependencies) ##$(cmt_local_CalibEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting CalibEventxodsrcclean"
	@-if test -f $(cmt_local_CalibEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEventxodsrc_makefile) CalibEventxodsrcclean; \
	fi
	$(echo) "(constituents.make) CalibEventxodsrcclean done"
#	@-$(MAKE) -f $(cmt_local_CalibEventxodsrc_makefile) CalibEventxodsrcclean

##	  /bin/rm -f $(cmt_local_CalibEventxodsrc_makefile) $(bin)CalibEventxodsrc_dependencies.make

install :: CalibEventxodsrcinstall ;

CalibEventxodsrcinstall :: $(CalibEventxodsrc_dependencies) $(cmt_local_CalibEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_CalibEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEventxodsrc_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_CalibEventxodsrc_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : CalibEventxodsrcuninstall

$(foreach d,$(CalibEventxodsrc_dependencies),$(eval $(d)uninstall_dependencies += CalibEventxodsrcuninstall))

CalibEventxodsrcuninstall : $(CalibEventxodsrcuninstall_dependencies) ##$(cmt_local_CalibEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_CalibEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEventxodsrc_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_CalibEventxodsrc_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: CalibEventxodsrcuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ CalibEventxodsrc"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ CalibEventxodsrc done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_CalibEvent_has_no_target_tag = 1
cmt_CalibEvent_has_prototypes = 1

#--------------------------------------

ifdef cmt_CalibEvent_has_target_tag

cmt_local_tagfile_CalibEvent = $(bin)$(CalibEvent_tag)_CalibEvent.make
cmt_final_setup_CalibEvent = $(bin)setup_CalibEvent.make
cmt_local_CalibEvent_makefile = $(bin)CalibEvent.make

CalibEvent_extratags = -tag_add=target_CalibEvent

else

cmt_local_tagfile_CalibEvent = $(bin)$(CalibEvent_tag).make
cmt_final_setup_CalibEvent = $(bin)setup.make
cmt_local_CalibEvent_makefile = $(bin)CalibEvent.make

endif

not_CalibEventcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(CalibEventcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
CalibEventdirs :
	@if test ! -d $(bin)CalibEvent; then $(mkdir) -p $(bin)CalibEvent; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)CalibEvent
else
CalibEventdirs : ;
endif

ifdef cmt_CalibEvent_has_target_tag

ifndef QUICK
$(cmt_local_CalibEvent_makefile) : $(CalibEventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building CalibEvent.make"; \
	  $(cmtexe) -tag=$(tags) $(CalibEvent_extratags) build constituent_config -out=$(cmt_local_CalibEvent_makefile) CalibEvent
else
$(cmt_local_CalibEvent_makefile) : $(CalibEventcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CalibEvent) ] || \
	  [ ! -f $(cmt_final_setup_CalibEvent) ] || \
	  $(not_CalibEventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CalibEvent.make"; \
	  $(cmtexe) -tag=$(tags) $(CalibEvent_extratags) build constituent_config -out=$(cmt_local_CalibEvent_makefile) CalibEvent; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_CalibEvent_makefile) : $(CalibEventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building CalibEvent.make"; \
	  $(cmtexe) -f=$(bin)CalibEvent.in -tag=$(tags) $(CalibEvent_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CalibEvent_makefile) CalibEvent
else
$(cmt_local_CalibEvent_makefile) : $(CalibEventcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)CalibEvent.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CalibEvent) ] || \
	  [ ! -f $(cmt_final_setup_CalibEvent) ] || \
	  $(not_CalibEventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CalibEvent.make"; \
	  $(cmtexe) -f=$(bin)CalibEvent.in -tag=$(tags) $(CalibEvent_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CalibEvent_makefile) CalibEvent; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(CalibEvent_extratags) build constituent_makefile -out=$(cmt_local_CalibEvent_makefile) CalibEvent

CalibEvent :: CalibEventcompile CalibEventinstall ;

ifdef cmt_CalibEvent_has_prototypes

CalibEventprototype : $(CalibEventprototype_dependencies) $(cmt_local_CalibEvent_makefile) dirs CalibEventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_CalibEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_CalibEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

CalibEventcompile : CalibEventprototype

endif

CalibEventcompile : $(CalibEventcompile_dependencies) $(cmt_local_CalibEvent_makefile) dirs CalibEventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_CalibEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_CalibEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: CalibEventclean ;

CalibEventclean :: $(CalibEventclean_dependencies) ##$(cmt_local_CalibEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_CalibEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEvent_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_CalibEvent_makefile) CalibEventclean

##	  /bin/rm -f $(cmt_local_CalibEvent_makefile) $(bin)CalibEvent_dependencies.make

install :: CalibEventinstall ;

CalibEventinstall :: CalibEventcompile $(CalibEvent_dependencies) $(cmt_local_CalibEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_CalibEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_CalibEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : CalibEventuninstall

$(foreach d,$(CalibEvent_dependencies),$(eval $(d)uninstall_dependencies += CalibEventuninstall))

CalibEventuninstall : $(CalibEventuninstall_dependencies) ##$(cmt_local_CalibEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_CalibEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_CalibEvent_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_CalibEvent_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: CalibEventuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ CalibEvent"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ CalibEvent done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(CalibEvent_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(CalibEvent_tag).make
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

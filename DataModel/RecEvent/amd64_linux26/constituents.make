
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

RecEvent_tag = $(tag)

#cmt_local_tagfile = $(RecEvent_tag).make
cmt_local_tagfile = $(bin)$(RecEvent_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)RecEventsetup.make
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

cmt_RecEventObj2Doth_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RecEventObj2Doth_has_target_tag

cmt_local_tagfile_RecEventObj2Doth = $(bin)$(RecEvent_tag)_RecEventObj2Doth.make
cmt_final_setup_RecEventObj2Doth = $(bin)setup_RecEventObj2Doth.make
cmt_local_RecEventObj2Doth_makefile = $(bin)RecEventObj2Doth.make

RecEventObj2Doth_extratags = -tag_add=target_RecEventObj2Doth

else

cmt_local_tagfile_RecEventObj2Doth = $(bin)$(RecEvent_tag).make
cmt_final_setup_RecEventObj2Doth = $(bin)setup.make
cmt_local_RecEventObj2Doth_makefile = $(bin)RecEventObj2Doth.make

endif

not_RecEventObj2Doth_dependencies = { n=0; for p in $?; do m=0; for d in $(RecEventObj2Doth_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RecEventObj2Dothdirs :
	@if test ! -d $(bin)RecEventObj2Doth; then $(mkdir) -p $(bin)RecEventObj2Doth; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RecEventObj2Doth
else
RecEventObj2Dothdirs : ;
endif

ifdef cmt_RecEventObj2Doth_has_target_tag

ifndef QUICK
$(cmt_local_RecEventObj2Doth_makefile) : $(RecEventObj2Doth_dependencies) build_library_links
	$(echo) "(constituents.make) Building RecEventObj2Doth.make"; \
	  $(cmtexe) -tag=$(tags) $(RecEventObj2Doth_extratags) build constituent_config -out=$(cmt_local_RecEventObj2Doth_makefile) RecEventObj2Doth
else
$(cmt_local_RecEventObj2Doth_makefile) : $(RecEventObj2Doth_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RecEventObj2Doth) ] || \
	  [ ! -f $(cmt_final_setup_RecEventObj2Doth) ] || \
	  $(not_RecEventObj2Doth_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RecEventObj2Doth.make"; \
	  $(cmtexe) -tag=$(tags) $(RecEventObj2Doth_extratags) build constituent_config -out=$(cmt_local_RecEventObj2Doth_makefile) RecEventObj2Doth; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RecEventObj2Doth_makefile) : $(RecEventObj2Doth_dependencies) build_library_links
	$(echo) "(constituents.make) Building RecEventObj2Doth.make"; \
	  $(cmtexe) -f=$(bin)RecEventObj2Doth.in -tag=$(tags) $(RecEventObj2Doth_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RecEventObj2Doth_makefile) RecEventObj2Doth
else
$(cmt_local_RecEventObj2Doth_makefile) : $(RecEventObj2Doth_dependencies) $(cmt_build_library_linksstamp) $(bin)RecEventObj2Doth.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RecEventObj2Doth) ] || \
	  [ ! -f $(cmt_final_setup_RecEventObj2Doth) ] || \
	  $(not_RecEventObj2Doth_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RecEventObj2Doth.make"; \
	  $(cmtexe) -f=$(bin)RecEventObj2Doth.in -tag=$(tags) $(RecEventObj2Doth_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RecEventObj2Doth_makefile) RecEventObj2Doth; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RecEventObj2Doth_extratags) build constituent_makefile -out=$(cmt_local_RecEventObj2Doth_makefile) RecEventObj2Doth

RecEventObj2Doth :: $(RecEventObj2Doth_dependencies) $(cmt_local_RecEventObj2Doth_makefile) dirs RecEventObj2Dothdirs
	$(echo) "(constituents.make) Starting RecEventObj2Doth"
	@if test -f $(cmt_local_RecEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEventObj2Doth_makefile) RecEventObj2Doth; \
	  fi
#	@$(MAKE) -f $(cmt_local_RecEventObj2Doth_makefile) RecEventObj2Doth
	$(echo) "(constituents.make) RecEventObj2Doth done"

clean :: RecEventObj2Dothclean ;

RecEventObj2Dothclean :: $(RecEventObj2Dothclean_dependencies) ##$(cmt_local_RecEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting RecEventObj2Dothclean"
	@-if test -f $(cmt_local_RecEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEventObj2Doth_makefile) RecEventObj2Dothclean; \
	fi
	$(echo) "(constituents.make) RecEventObj2Dothclean done"
#	@-$(MAKE) -f $(cmt_local_RecEventObj2Doth_makefile) RecEventObj2Dothclean

##	  /bin/rm -f $(cmt_local_RecEventObj2Doth_makefile) $(bin)RecEventObj2Doth_dependencies.make

install :: RecEventObj2Dothinstall ;

RecEventObj2Dothinstall :: $(RecEventObj2Doth_dependencies) $(cmt_local_RecEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RecEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEventObj2Doth_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RecEventObj2Doth_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RecEventObj2Dothuninstall

$(foreach d,$(RecEventObj2Doth_dependencies),$(eval $(d)uninstall_dependencies += RecEventObj2Dothuninstall))

RecEventObj2Dothuninstall : $(RecEventObj2Dothuninstall_dependencies) ##$(cmt_local_RecEventObj2Doth_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RecEventObj2Doth_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEventObj2Doth_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RecEventObj2Doth_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RecEventObj2Dothuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RecEventObj2Doth"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RecEventObj2Doth done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_more_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_more_includes_has_target_tag

cmt_local_tagfile_install_more_includes = $(bin)$(RecEvent_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(RecEvent_tag).make
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

cmt_RecEventDict_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RecEventDict_has_target_tag

cmt_local_tagfile_RecEventDict = $(bin)$(RecEvent_tag)_RecEventDict.make
cmt_final_setup_RecEventDict = $(bin)setup_RecEventDict.make
cmt_local_RecEventDict_makefile = $(bin)RecEventDict.make

RecEventDict_extratags = -tag_add=target_RecEventDict

else

cmt_local_tagfile_RecEventDict = $(bin)$(RecEvent_tag).make
cmt_final_setup_RecEventDict = $(bin)setup.make
cmt_local_RecEventDict_makefile = $(bin)RecEventDict.make

endif

not_RecEventDict_dependencies = { n=0; for p in $?; do m=0; for d in $(RecEventDict_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RecEventDictdirs :
	@if test ! -d $(bin)RecEventDict; then $(mkdir) -p $(bin)RecEventDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RecEventDict
else
RecEventDictdirs : ;
endif

ifdef cmt_RecEventDict_has_target_tag

ifndef QUICK
$(cmt_local_RecEventDict_makefile) : $(RecEventDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building RecEventDict.make"; \
	  $(cmtexe) -tag=$(tags) $(RecEventDict_extratags) build constituent_config -out=$(cmt_local_RecEventDict_makefile) RecEventDict
else
$(cmt_local_RecEventDict_makefile) : $(RecEventDict_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RecEventDict) ] || \
	  [ ! -f $(cmt_final_setup_RecEventDict) ] || \
	  $(not_RecEventDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RecEventDict.make"; \
	  $(cmtexe) -tag=$(tags) $(RecEventDict_extratags) build constituent_config -out=$(cmt_local_RecEventDict_makefile) RecEventDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RecEventDict_makefile) : $(RecEventDict_dependencies) build_library_links
	$(echo) "(constituents.make) Building RecEventDict.make"; \
	  $(cmtexe) -f=$(bin)RecEventDict.in -tag=$(tags) $(RecEventDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RecEventDict_makefile) RecEventDict
else
$(cmt_local_RecEventDict_makefile) : $(RecEventDict_dependencies) $(cmt_build_library_linksstamp) $(bin)RecEventDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RecEventDict) ] || \
	  [ ! -f $(cmt_final_setup_RecEventDict) ] || \
	  $(not_RecEventDict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RecEventDict.make"; \
	  $(cmtexe) -f=$(bin)RecEventDict.in -tag=$(tags) $(RecEventDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RecEventDict_makefile) RecEventDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RecEventDict_extratags) build constituent_makefile -out=$(cmt_local_RecEventDict_makefile) RecEventDict

RecEventDict :: $(RecEventDict_dependencies) $(cmt_local_RecEventDict_makefile) dirs RecEventDictdirs
	$(echo) "(constituents.make) Starting RecEventDict"
	@if test -f $(cmt_local_RecEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEventDict_makefile) RecEventDict; \
	  fi
#	@$(MAKE) -f $(cmt_local_RecEventDict_makefile) RecEventDict
	$(echo) "(constituents.make) RecEventDict done"

clean :: RecEventDictclean ;

RecEventDictclean :: $(RecEventDictclean_dependencies) ##$(cmt_local_RecEventDict_makefile)
	$(echo) "(constituents.make) Starting RecEventDictclean"
	@-if test -f $(cmt_local_RecEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEventDict_makefile) RecEventDictclean; \
	fi
	$(echo) "(constituents.make) RecEventDictclean done"
#	@-$(MAKE) -f $(cmt_local_RecEventDict_makefile) RecEventDictclean

##	  /bin/rm -f $(cmt_local_RecEventDict_makefile) $(bin)RecEventDict_dependencies.make

install :: RecEventDictinstall ;

RecEventDictinstall :: $(RecEventDict_dependencies) $(cmt_local_RecEventDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RecEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEventDict_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RecEventDict_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RecEventDictuninstall

$(foreach d,$(RecEventDict_dependencies),$(eval $(d)uninstall_dependencies += RecEventDictuninstall))

RecEventDictuninstall : $(RecEventDictuninstall_dependencies) ##$(cmt_local_RecEventDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RecEventDict_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEventDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RecEventDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RecEventDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RecEventDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RecEventDict done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_RecEventxodsrc_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RecEventxodsrc_has_target_tag

cmt_local_tagfile_RecEventxodsrc = $(bin)$(RecEvent_tag)_RecEventxodsrc.make
cmt_final_setup_RecEventxodsrc = $(bin)setup_RecEventxodsrc.make
cmt_local_RecEventxodsrc_makefile = $(bin)RecEventxodsrc.make

RecEventxodsrc_extratags = -tag_add=target_RecEventxodsrc

else

cmt_local_tagfile_RecEventxodsrc = $(bin)$(RecEvent_tag).make
cmt_final_setup_RecEventxodsrc = $(bin)setup.make
cmt_local_RecEventxodsrc_makefile = $(bin)RecEventxodsrc.make

endif

not_RecEventxodsrc_dependencies = { n=0; for p in $?; do m=0; for d in $(RecEventxodsrc_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RecEventxodsrcdirs :
	@if test ! -d $(bin)RecEventxodsrc; then $(mkdir) -p $(bin)RecEventxodsrc; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RecEventxodsrc
else
RecEventxodsrcdirs : ;
endif

ifdef cmt_RecEventxodsrc_has_target_tag

ifndef QUICK
$(cmt_local_RecEventxodsrc_makefile) : $(RecEventxodsrc_dependencies) build_library_links
	$(echo) "(constituents.make) Building RecEventxodsrc.make"; \
	  $(cmtexe) -tag=$(tags) $(RecEventxodsrc_extratags) build constituent_config -out=$(cmt_local_RecEventxodsrc_makefile) RecEventxodsrc
else
$(cmt_local_RecEventxodsrc_makefile) : $(RecEventxodsrc_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RecEventxodsrc) ] || \
	  [ ! -f $(cmt_final_setup_RecEventxodsrc) ] || \
	  $(not_RecEventxodsrc_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RecEventxodsrc.make"; \
	  $(cmtexe) -tag=$(tags) $(RecEventxodsrc_extratags) build constituent_config -out=$(cmt_local_RecEventxodsrc_makefile) RecEventxodsrc; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RecEventxodsrc_makefile) : $(RecEventxodsrc_dependencies) build_library_links
	$(echo) "(constituents.make) Building RecEventxodsrc.make"; \
	  $(cmtexe) -f=$(bin)RecEventxodsrc.in -tag=$(tags) $(RecEventxodsrc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RecEventxodsrc_makefile) RecEventxodsrc
else
$(cmt_local_RecEventxodsrc_makefile) : $(RecEventxodsrc_dependencies) $(cmt_build_library_linksstamp) $(bin)RecEventxodsrc.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RecEventxodsrc) ] || \
	  [ ! -f $(cmt_final_setup_RecEventxodsrc) ] || \
	  $(not_RecEventxodsrc_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RecEventxodsrc.make"; \
	  $(cmtexe) -f=$(bin)RecEventxodsrc.in -tag=$(tags) $(RecEventxodsrc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RecEventxodsrc_makefile) RecEventxodsrc; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RecEventxodsrc_extratags) build constituent_makefile -out=$(cmt_local_RecEventxodsrc_makefile) RecEventxodsrc

RecEventxodsrc :: $(RecEventxodsrc_dependencies) $(cmt_local_RecEventxodsrc_makefile) dirs RecEventxodsrcdirs
	$(echo) "(constituents.make) Starting RecEventxodsrc"
	@if test -f $(cmt_local_RecEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEventxodsrc_makefile) RecEventxodsrc; \
	  fi
#	@$(MAKE) -f $(cmt_local_RecEventxodsrc_makefile) RecEventxodsrc
	$(echo) "(constituents.make) RecEventxodsrc done"

clean :: RecEventxodsrcclean ;

RecEventxodsrcclean :: $(RecEventxodsrcclean_dependencies) ##$(cmt_local_RecEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting RecEventxodsrcclean"
	@-if test -f $(cmt_local_RecEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEventxodsrc_makefile) RecEventxodsrcclean; \
	fi
	$(echo) "(constituents.make) RecEventxodsrcclean done"
#	@-$(MAKE) -f $(cmt_local_RecEventxodsrc_makefile) RecEventxodsrcclean

##	  /bin/rm -f $(cmt_local_RecEventxodsrc_makefile) $(bin)RecEventxodsrc_dependencies.make

install :: RecEventxodsrcinstall ;

RecEventxodsrcinstall :: $(RecEventxodsrc_dependencies) $(cmt_local_RecEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RecEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEventxodsrc_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RecEventxodsrc_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RecEventxodsrcuninstall

$(foreach d,$(RecEventxodsrc_dependencies),$(eval $(d)uninstall_dependencies += RecEventxodsrcuninstall))

RecEventxodsrcuninstall : $(RecEventxodsrcuninstall_dependencies) ##$(cmt_local_RecEventxodsrc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RecEventxodsrc_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEventxodsrc_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RecEventxodsrc_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RecEventxodsrcuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RecEventxodsrc"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RecEventxodsrc done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_RecEvent_has_no_target_tag = 1
cmt_RecEvent_has_prototypes = 1

#--------------------------------------

ifdef cmt_RecEvent_has_target_tag

cmt_local_tagfile_RecEvent = $(bin)$(RecEvent_tag)_RecEvent.make
cmt_final_setup_RecEvent = $(bin)setup_RecEvent.make
cmt_local_RecEvent_makefile = $(bin)RecEvent.make

RecEvent_extratags = -tag_add=target_RecEvent

else

cmt_local_tagfile_RecEvent = $(bin)$(RecEvent_tag).make
cmt_final_setup_RecEvent = $(bin)setup.make
cmt_local_RecEvent_makefile = $(bin)RecEvent.make

endif

not_RecEventcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(RecEventcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RecEventdirs :
	@if test ! -d $(bin)RecEvent; then $(mkdir) -p $(bin)RecEvent; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RecEvent
else
RecEventdirs : ;
endif

ifdef cmt_RecEvent_has_target_tag

ifndef QUICK
$(cmt_local_RecEvent_makefile) : $(RecEventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building RecEvent.make"; \
	  $(cmtexe) -tag=$(tags) $(RecEvent_extratags) build constituent_config -out=$(cmt_local_RecEvent_makefile) RecEvent
else
$(cmt_local_RecEvent_makefile) : $(RecEventcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RecEvent) ] || \
	  [ ! -f $(cmt_final_setup_RecEvent) ] || \
	  $(not_RecEventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RecEvent.make"; \
	  $(cmtexe) -tag=$(tags) $(RecEvent_extratags) build constituent_config -out=$(cmt_local_RecEvent_makefile) RecEvent; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RecEvent_makefile) : $(RecEventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building RecEvent.make"; \
	  $(cmtexe) -f=$(bin)RecEvent.in -tag=$(tags) $(RecEvent_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RecEvent_makefile) RecEvent
else
$(cmt_local_RecEvent_makefile) : $(RecEventcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)RecEvent.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RecEvent) ] || \
	  [ ! -f $(cmt_final_setup_RecEvent) ] || \
	  $(not_RecEventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RecEvent.make"; \
	  $(cmtexe) -f=$(bin)RecEvent.in -tag=$(tags) $(RecEvent_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RecEvent_makefile) RecEvent; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RecEvent_extratags) build constituent_makefile -out=$(cmt_local_RecEvent_makefile) RecEvent

RecEvent :: RecEventcompile RecEventinstall ;

ifdef cmt_RecEvent_has_prototypes

RecEventprototype : $(RecEventprototype_dependencies) $(cmt_local_RecEvent_makefile) dirs RecEventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RecEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RecEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

RecEventcompile : RecEventprototype

endif

RecEventcompile : $(RecEventcompile_dependencies) $(cmt_local_RecEvent_makefile) dirs RecEventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RecEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RecEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: RecEventclean ;

RecEventclean :: $(RecEventclean_dependencies) ##$(cmt_local_RecEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RecEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEvent_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_RecEvent_makefile) RecEventclean

##	  /bin/rm -f $(cmt_local_RecEvent_makefile) $(bin)RecEvent_dependencies.make

install :: RecEventinstall ;

RecEventinstall :: RecEventcompile $(RecEvent_dependencies) $(cmt_local_RecEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RecEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEvent_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RecEvent_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : RecEventuninstall

$(foreach d,$(RecEvent_dependencies),$(eval $(d)uninstall_dependencies += RecEventuninstall))

RecEventuninstall : $(RecEventuninstall_dependencies) ##$(cmt_local_RecEvent_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RecEvent_makefile); then \
	  $(MAKE) -f $(cmt_local_RecEvent_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RecEvent_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RecEventuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RecEvent"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RecEvent done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(RecEvent_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(RecEvent_tag).make
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


#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

PMTSimAlg_tag = $(tag)

#cmt_local_tagfile = $(PMTSimAlg_tag).make
cmt_local_tagfile = $(bin)$(PMTSimAlg_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)PMTSimAlgsetup.make
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

cmt_PMTSimAlg_has_no_target_tag = 1
cmt_PMTSimAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_PMTSimAlg_has_target_tag

cmt_local_tagfile_PMTSimAlg = $(bin)$(PMTSimAlg_tag)_PMTSimAlg.make
cmt_final_setup_PMTSimAlg = $(bin)setup_PMTSimAlg.make
cmt_local_PMTSimAlg_makefile = $(bin)PMTSimAlg.make

PMTSimAlg_extratags = -tag_add=target_PMTSimAlg

else

cmt_local_tagfile_PMTSimAlg = $(bin)$(PMTSimAlg_tag).make
cmt_final_setup_PMTSimAlg = $(bin)setup.make
cmt_local_PMTSimAlg_makefile = $(bin)PMTSimAlg.make

endif

not_PMTSimAlgcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(PMTSimAlgcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PMTSimAlgdirs :
	@if test ! -d $(bin)PMTSimAlg; then $(mkdir) -p $(bin)PMTSimAlg; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PMTSimAlg
else
PMTSimAlgdirs : ;
endif

ifdef cmt_PMTSimAlg_has_target_tag

ifndef QUICK
$(cmt_local_PMTSimAlg_makefile) : $(PMTSimAlgcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PMTSimAlg.make"; \
	  $(cmtexe) -tag=$(tags) $(PMTSimAlg_extratags) build constituent_config -out=$(cmt_local_PMTSimAlg_makefile) PMTSimAlg
else
$(cmt_local_PMTSimAlg_makefile) : $(PMTSimAlgcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PMTSimAlg) ] || \
	  [ ! -f $(cmt_final_setup_PMTSimAlg) ] || \
	  $(not_PMTSimAlgcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PMTSimAlg.make"; \
	  $(cmtexe) -tag=$(tags) $(PMTSimAlg_extratags) build constituent_config -out=$(cmt_local_PMTSimAlg_makefile) PMTSimAlg; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PMTSimAlg_makefile) : $(PMTSimAlgcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PMTSimAlg.make"; \
	  $(cmtexe) -f=$(bin)PMTSimAlg.in -tag=$(tags) $(PMTSimAlg_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PMTSimAlg_makefile) PMTSimAlg
else
$(cmt_local_PMTSimAlg_makefile) : $(PMTSimAlgcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)PMTSimAlg.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PMTSimAlg) ] || \
	  [ ! -f $(cmt_final_setup_PMTSimAlg) ] || \
	  $(not_PMTSimAlgcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PMTSimAlg.make"; \
	  $(cmtexe) -f=$(bin)PMTSimAlg.in -tag=$(tags) $(PMTSimAlg_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PMTSimAlg_makefile) PMTSimAlg; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PMTSimAlg_extratags) build constituent_makefile -out=$(cmt_local_PMTSimAlg_makefile) PMTSimAlg

PMTSimAlg :: PMTSimAlgcompile PMTSimAlginstall ;

ifdef cmt_PMTSimAlg_has_prototypes

PMTSimAlgprototype : $(PMTSimAlgprototype_dependencies) $(cmt_local_PMTSimAlg_makefile) dirs PMTSimAlgdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PMTSimAlg_makefile); then \
	  $(MAKE) -f $(cmt_local_PMTSimAlg_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PMTSimAlg_makefile) $@
	$(echo) "(constituents.make) $@ done"

PMTSimAlgcompile : PMTSimAlgprototype

endif

PMTSimAlgcompile : $(PMTSimAlgcompile_dependencies) $(cmt_local_PMTSimAlg_makefile) dirs PMTSimAlgdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PMTSimAlg_makefile); then \
	  $(MAKE) -f $(cmt_local_PMTSimAlg_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PMTSimAlg_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: PMTSimAlgclean ;

PMTSimAlgclean :: $(PMTSimAlgclean_dependencies) ##$(cmt_local_PMTSimAlg_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PMTSimAlg_makefile); then \
	  $(MAKE) -f $(cmt_local_PMTSimAlg_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_PMTSimAlg_makefile) PMTSimAlgclean

##	  /bin/rm -f $(cmt_local_PMTSimAlg_makefile) $(bin)PMTSimAlg_dependencies.make

install :: PMTSimAlginstall ;

PMTSimAlginstall :: PMTSimAlgcompile $(PMTSimAlg_dependencies) $(cmt_local_PMTSimAlg_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PMTSimAlg_makefile); then \
	  $(MAKE) -f $(cmt_local_PMTSimAlg_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PMTSimAlg_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : PMTSimAlguninstall

$(foreach d,$(PMTSimAlg_dependencies),$(eval $(d)uninstall_dependencies += PMTSimAlguninstall))

PMTSimAlguninstall : $(PMTSimAlguninstall_dependencies) ##$(cmt_local_PMTSimAlg_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PMTSimAlg_makefile); then \
	  $(MAKE) -f $(cmt_local_PMTSimAlg_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PMTSimAlg_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PMTSimAlguninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PMTSimAlg"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PMTSimAlg done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_PMTSimAlg_python_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_PMTSimAlg_python_has_target_tag

cmt_local_tagfile_PMTSimAlg_python = $(bin)$(PMTSimAlg_tag)_PMTSimAlg_python.make
cmt_final_setup_PMTSimAlg_python = $(bin)setup_PMTSimAlg_python.make
cmt_local_PMTSimAlg_python_makefile = $(bin)PMTSimAlg_python.make

PMTSimAlg_python_extratags = -tag_add=target_PMTSimAlg_python

else

cmt_local_tagfile_PMTSimAlg_python = $(bin)$(PMTSimAlg_tag).make
cmt_final_setup_PMTSimAlg_python = $(bin)setup.make
cmt_local_PMTSimAlg_python_makefile = $(bin)PMTSimAlg_python.make

endif

not_PMTSimAlg_python_dependencies = { n=0; for p in $?; do m=0; for d in $(PMTSimAlg_python_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PMTSimAlg_pythondirs :
	@if test ! -d $(bin)PMTSimAlg_python; then $(mkdir) -p $(bin)PMTSimAlg_python; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PMTSimAlg_python
else
PMTSimAlg_pythondirs : ;
endif

ifdef cmt_PMTSimAlg_python_has_target_tag

ifndef QUICK
$(cmt_local_PMTSimAlg_python_makefile) : $(PMTSimAlg_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building PMTSimAlg_python.make"; \
	  $(cmtexe) -tag=$(tags) $(PMTSimAlg_python_extratags) build constituent_config -out=$(cmt_local_PMTSimAlg_python_makefile) PMTSimAlg_python
else
$(cmt_local_PMTSimAlg_python_makefile) : $(PMTSimAlg_python_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PMTSimAlg_python) ] || \
	  [ ! -f $(cmt_final_setup_PMTSimAlg_python) ] || \
	  $(not_PMTSimAlg_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PMTSimAlg_python.make"; \
	  $(cmtexe) -tag=$(tags) $(PMTSimAlg_python_extratags) build constituent_config -out=$(cmt_local_PMTSimAlg_python_makefile) PMTSimAlg_python; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PMTSimAlg_python_makefile) : $(PMTSimAlg_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building PMTSimAlg_python.make"; \
	  $(cmtexe) -f=$(bin)PMTSimAlg_python.in -tag=$(tags) $(PMTSimAlg_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PMTSimAlg_python_makefile) PMTSimAlg_python
else
$(cmt_local_PMTSimAlg_python_makefile) : $(PMTSimAlg_python_dependencies) $(cmt_build_library_linksstamp) $(bin)PMTSimAlg_python.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PMTSimAlg_python) ] || \
	  [ ! -f $(cmt_final_setup_PMTSimAlg_python) ] || \
	  $(not_PMTSimAlg_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PMTSimAlg_python.make"; \
	  $(cmtexe) -f=$(bin)PMTSimAlg_python.in -tag=$(tags) $(PMTSimAlg_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PMTSimAlg_python_makefile) PMTSimAlg_python; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PMTSimAlg_python_extratags) build constituent_makefile -out=$(cmt_local_PMTSimAlg_python_makefile) PMTSimAlg_python

PMTSimAlg_python :: $(PMTSimAlg_python_dependencies) $(cmt_local_PMTSimAlg_python_makefile) dirs PMTSimAlg_pythondirs
	$(echo) "(constituents.make) Starting PMTSimAlg_python"
	@if test -f $(cmt_local_PMTSimAlg_python_makefile); then \
	  $(MAKE) -f $(cmt_local_PMTSimAlg_python_makefile) PMTSimAlg_python; \
	  fi
#	@$(MAKE) -f $(cmt_local_PMTSimAlg_python_makefile) PMTSimAlg_python
	$(echo) "(constituents.make) PMTSimAlg_python done"

clean :: PMTSimAlg_pythonclean ;

PMTSimAlg_pythonclean :: $(PMTSimAlg_pythonclean_dependencies) ##$(cmt_local_PMTSimAlg_python_makefile)
	$(echo) "(constituents.make) Starting PMTSimAlg_pythonclean"
	@-if test -f $(cmt_local_PMTSimAlg_python_makefile); then \
	  $(MAKE) -f $(cmt_local_PMTSimAlg_python_makefile) PMTSimAlg_pythonclean; \
	fi
	$(echo) "(constituents.make) PMTSimAlg_pythonclean done"
#	@-$(MAKE) -f $(cmt_local_PMTSimAlg_python_makefile) PMTSimAlg_pythonclean

##	  /bin/rm -f $(cmt_local_PMTSimAlg_python_makefile) $(bin)PMTSimAlg_python_dependencies.make

install :: PMTSimAlg_pythoninstall ;

PMTSimAlg_pythoninstall :: $(PMTSimAlg_python_dependencies) $(cmt_local_PMTSimAlg_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PMTSimAlg_python_makefile); then \
	  $(MAKE) -f $(cmt_local_PMTSimAlg_python_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_PMTSimAlg_python_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : PMTSimAlg_pythonuninstall

$(foreach d,$(PMTSimAlg_python_dependencies),$(eval $(d)uninstall_dependencies += PMTSimAlg_pythonuninstall))

PMTSimAlg_pythonuninstall : $(PMTSimAlg_pythonuninstall_dependencies) ##$(cmt_local_PMTSimAlg_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PMTSimAlg_python_makefile); then \
	  $(MAKE) -f $(cmt_local_PMTSimAlg_python_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PMTSimAlg_python_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PMTSimAlg_pythonuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PMTSimAlg_python"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PMTSimAlg_python done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(PMTSimAlg_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(PMTSimAlg_tag).make
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

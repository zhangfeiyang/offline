
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

Geometry_tag = $(tag)

#cmt_local_tagfile = $(Geometry_tag).make
cmt_local_tagfile = $(bin)$(Geometry_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)Geometrysetup.make
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

cmt_local_tagfile_install_more_includes = $(bin)$(Geometry_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(Geometry_tag).make
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

cmt_Geometry_has_no_target_tag = 1
cmt_Geometry_has_prototypes = 1

#--------------------------------------

ifdef cmt_Geometry_has_target_tag

cmt_local_tagfile_Geometry = $(bin)$(Geometry_tag)_Geometry.make
cmt_final_setup_Geometry = $(bin)setup_Geometry.make
cmt_local_Geometry_makefile = $(bin)Geometry.make

Geometry_extratags = -tag_add=target_Geometry

else

cmt_local_tagfile_Geometry = $(bin)$(Geometry_tag).make
cmt_final_setup_Geometry = $(bin)setup.make
cmt_local_Geometry_makefile = $(bin)Geometry.make

endif

not_Geometrycompile_dependencies = { n=0; for p in $?; do m=0; for d in $(Geometrycompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
Geometrydirs :
	@if test ! -d $(bin)Geometry; then $(mkdir) -p $(bin)Geometry; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)Geometry
else
Geometrydirs : ;
endif

ifdef cmt_Geometry_has_target_tag

ifndef QUICK
$(cmt_local_Geometry_makefile) : $(Geometrycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building Geometry.make"; \
	  $(cmtexe) -tag=$(tags) $(Geometry_extratags) build constituent_config -out=$(cmt_local_Geometry_makefile) Geometry
else
$(cmt_local_Geometry_makefile) : $(Geometrycompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Geometry) ] || \
	  [ ! -f $(cmt_final_setup_Geometry) ] || \
	  $(not_Geometrycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Geometry.make"; \
	  $(cmtexe) -tag=$(tags) $(Geometry_extratags) build constituent_config -out=$(cmt_local_Geometry_makefile) Geometry; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_Geometry_makefile) : $(Geometrycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building Geometry.make"; \
	  $(cmtexe) -f=$(bin)Geometry.in -tag=$(tags) $(Geometry_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Geometry_makefile) Geometry
else
$(cmt_local_Geometry_makefile) : $(Geometrycompile_dependencies) $(cmt_build_library_linksstamp) $(bin)Geometry.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Geometry) ] || \
	  [ ! -f $(cmt_final_setup_Geometry) ] || \
	  $(not_Geometrycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Geometry.make"; \
	  $(cmtexe) -f=$(bin)Geometry.in -tag=$(tags) $(Geometry_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Geometry_makefile) Geometry; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(Geometry_extratags) build constituent_makefile -out=$(cmt_local_Geometry_makefile) Geometry

Geometry :: Geometrycompile Geometryinstall ;

ifdef cmt_Geometry_has_prototypes

Geometryprototype : $(Geometryprototype_dependencies) $(cmt_local_Geometry_makefile) dirs Geometrydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Geometry_makefile); then \
	  $(MAKE) -f $(cmt_local_Geometry_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Geometry_makefile) $@
	$(echo) "(constituents.make) $@ done"

Geometrycompile : Geometryprototype

endif

Geometrycompile : $(Geometrycompile_dependencies) $(cmt_local_Geometry_makefile) dirs Geometrydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Geometry_makefile); then \
	  $(MAKE) -f $(cmt_local_Geometry_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Geometry_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: Geometryclean ;

Geometryclean :: $(Geometryclean_dependencies) ##$(cmt_local_Geometry_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_Geometry_makefile); then \
	  $(MAKE) -f $(cmt_local_Geometry_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_Geometry_makefile) Geometryclean

##	  /bin/rm -f $(cmt_local_Geometry_makefile) $(bin)Geometry_dependencies.make

install :: Geometryinstall ;

Geometryinstall :: Geometrycompile $(Geometry_dependencies) $(cmt_local_Geometry_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Geometry_makefile); then \
	  $(MAKE) -f $(cmt_local_Geometry_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Geometry_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : Geometryuninstall

$(foreach d,$(Geometry_dependencies),$(eval $(d)uninstall_dependencies += Geometryuninstall))

Geometryuninstall : $(Geometryuninstall_dependencies) ##$(cmt_local_Geometry_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_Geometry_makefile); then \
	  $(MAKE) -f $(cmt_local_Geometry_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_Geometry_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: Geometryuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ Geometry"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ Geometry done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_Geometry_python_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_Geometry_python_has_target_tag

cmt_local_tagfile_Geometry_python = $(bin)$(Geometry_tag)_Geometry_python.make
cmt_final_setup_Geometry_python = $(bin)setup_Geometry_python.make
cmt_local_Geometry_python_makefile = $(bin)Geometry_python.make

Geometry_python_extratags = -tag_add=target_Geometry_python

else

cmt_local_tagfile_Geometry_python = $(bin)$(Geometry_tag).make
cmt_final_setup_Geometry_python = $(bin)setup.make
cmt_local_Geometry_python_makefile = $(bin)Geometry_python.make

endif

not_Geometry_python_dependencies = { n=0; for p in $?; do m=0; for d in $(Geometry_python_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
Geometry_pythondirs :
	@if test ! -d $(bin)Geometry_python; then $(mkdir) -p $(bin)Geometry_python; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)Geometry_python
else
Geometry_pythondirs : ;
endif

ifdef cmt_Geometry_python_has_target_tag

ifndef QUICK
$(cmt_local_Geometry_python_makefile) : $(Geometry_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building Geometry_python.make"; \
	  $(cmtexe) -tag=$(tags) $(Geometry_python_extratags) build constituent_config -out=$(cmt_local_Geometry_python_makefile) Geometry_python
else
$(cmt_local_Geometry_python_makefile) : $(Geometry_python_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Geometry_python) ] || \
	  [ ! -f $(cmt_final_setup_Geometry_python) ] || \
	  $(not_Geometry_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Geometry_python.make"; \
	  $(cmtexe) -tag=$(tags) $(Geometry_python_extratags) build constituent_config -out=$(cmt_local_Geometry_python_makefile) Geometry_python; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_Geometry_python_makefile) : $(Geometry_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building Geometry_python.make"; \
	  $(cmtexe) -f=$(bin)Geometry_python.in -tag=$(tags) $(Geometry_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Geometry_python_makefile) Geometry_python
else
$(cmt_local_Geometry_python_makefile) : $(Geometry_python_dependencies) $(cmt_build_library_linksstamp) $(bin)Geometry_python.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Geometry_python) ] || \
	  [ ! -f $(cmt_final_setup_Geometry_python) ] || \
	  $(not_Geometry_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Geometry_python.make"; \
	  $(cmtexe) -f=$(bin)Geometry_python.in -tag=$(tags) $(Geometry_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Geometry_python_makefile) Geometry_python; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(Geometry_python_extratags) build constituent_makefile -out=$(cmt_local_Geometry_python_makefile) Geometry_python

Geometry_python :: $(Geometry_python_dependencies) $(cmt_local_Geometry_python_makefile) dirs Geometry_pythondirs
	$(echo) "(constituents.make) Starting Geometry_python"
	@if test -f $(cmt_local_Geometry_python_makefile); then \
	  $(MAKE) -f $(cmt_local_Geometry_python_makefile) Geometry_python; \
	  fi
#	@$(MAKE) -f $(cmt_local_Geometry_python_makefile) Geometry_python
	$(echo) "(constituents.make) Geometry_python done"

clean :: Geometry_pythonclean ;

Geometry_pythonclean :: $(Geometry_pythonclean_dependencies) ##$(cmt_local_Geometry_python_makefile)
	$(echo) "(constituents.make) Starting Geometry_pythonclean"
	@-if test -f $(cmt_local_Geometry_python_makefile); then \
	  $(MAKE) -f $(cmt_local_Geometry_python_makefile) Geometry_pythonclean; \
	fi
	$(echo) "(constituents.make) Geometry_pythonclean done"
#	@-$(MAKE) -f $(cmt_local_Geometry_python_makefile) Geometry_pythonclean

##	  /bin/rm -f $(cmt_local_Geometry_python_makefile) $(bin)Geometry_python_dependencies.make

install :: Geometry_pythoninstall ;

Geometry_pythoninstall :: $(Geometry_python_dependencies) $(cmt_local_Geometry_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Geometry_python_makefile); then \
	  $(MAKE) -f $(cmt_local_Geometry_python_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_Geometry_python_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : Geometry_pythonuninstall

$(foreach d,$(Geometry_python_dependencies),$(eval $(d)uninstall_dependencies += Geometry_pythonuninstall))

Geometry_pythonuninstall : $(Geometry_pythonuninstall_dependencies) ##$(cmt_local_Geometry_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_Geometry_python_makefile); then \
	  $(MAKE) -f $(cmt_local_Geometry_python_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_Geometry_python_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: Geometry_pythonuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ Geometry_python"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ Geometry_python done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(Geometry_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(Geometry_tag).make
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

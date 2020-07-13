#-- start of make_header -----------------

#====================================
#  Library Identifier
#
#   Generated Fri Jul 10 19:15:21 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Identifier_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Identifier_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Identifier

Identifier_tag = $(tag)

#cmt_local_tagfile_Identifier = $(Identifier_tag)_Identifier.make
cmt_local_tagfile_Identifier = $(bin)$(Identifier_tag)_Identifier.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Identifier_tag = $(tag)

#cmt_local_tagfile_Identifier = $(Identifier_tag).make
cmt_local_tagfile_Identifier = $(bin)$(Identifier_tag).make

endif

include $(cmt_local_tagfile_Identifier)
#-include $(cmt_local_tagfile_Identifier)

ifdef cmt_Identifier_has_target_tag

cmt_final_setup_Identifier = $(bin)setup_Identifier.make
cmt_dependencies_in_Identifier = $(bin)dependencies_Identifier.in
#cmt_final_setup_Identifier = $(bin)Identifier_Identifiersetup.make
cmt_local_Identifier_makefile = $(bin)Identifier.make

else

cmt_final_setup_Identifier = $(bin)setup.make
cmt_dependencies_in_Identifier = $(bin)dependencies.in
#cmt_final_setup_Identifier = $(bin)Identifiersetup.make
cmt_local_Identifier_makefile = $(bin)Identifier.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Identifiersetup.make

#Identifier :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'Identifier'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Identifier/
#Identifier::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

Identifierlibname   = $(bin)$(library_prefix)Identifier$(library_suffix)
Identifierlib       = $(Identifierlibname).a
Identifierstamp     = $(bin)Identifier.stamp
Identifiershstamp   = $(bin)Identifier.shstamp

Identifier :: dirs  IdentifierLIB
	$(echo) "Identifier ok"

cmt_Identifier_has_prototypes = 1

#--------------------------------------

ifdef cmt_Identifier_has_prototypes

Identifierprototype :  ;

endif

Identifiercompile : $(bin)Identifier.o $(bin)CdID.o $(bin)TtID.o $(bin)JunoDetectorID.o $(bin)WpID.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

IdentifierLIB :: $(Identifierlib) $(Identifiershstamp)
	$(echo) "Identifier : library ok"

$(Identifierlib) :: $(bin)Identifier.o $(bin)CdID.o $(bin)TtID.o $(bin)JunoDetectorID.o $(bin)WpID.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(Identifierlib) $(bin)Identifier.o $(bin)CdID.o $(bin)TtID.o $(bin)JunoDetectorID.o $(bin)WpID.o
	$(lib_silent) $(ranlib) $(Identifierlib)
	$(lib_silent) cat /dev/null >$(Identifierstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

#
# We add one level of dependency upon the true shared library 
# (rather than simply upon the stamp file)
# this is for cases where the shared library has not been built
# while the stamp was created (error??) 
#

$(Identifierlibname).$(shlibsuffix) :: $(Identifierlib) requirements $(use_requirements) $(Identifierstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" Identifier $(Identifier_shlibflags)
	$(lib_silent) cat /dev/null >$(Identifiershstamp)

$(Identifiershstamp) :: $(Identifierlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(Identifierlibname).$(shlibsuffix) ; then cat /dev/null >$(Identifiershstamp) ; fi

Identifierclean ::
	$(cleanup_echo) objects Identifier
	$(cleanup_silent) /bin/rm -f $(bin)Identifier.o $(bin)CdID.o $(bin)TtID.o $(bin)JunoDetectorID.o $(bin)WpID.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)Identifier.o $(bin)CdID.o $(bin)TtID.o $(bin)JunoDetectorID.o $(bin)WpID.o) $(patsubst %.o,%.dep,$(bin)Identifier.o $(bin)CdID.o $(bin)TtID.o $(bin)JunoDetectorID.o $(bin)WpID.o) $(patsubst %.o,%.d.stamp,$(bin)Identifier.o $(bin)CdID.o $(bin)TtID.o $(bin)JunoDetectorID.o $(bin)WpID.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf Identifier_deps Identifier_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
Identifierinstallname = $(library_prefix)Identifier$(library_suffix).$(shlibsuffix)

Identifier :: Identifierinstall ;

install :: Identifierinstall ;

Identifierinstall :: $(install_dir)/$(Identifierinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(Identifierinstallname) :: $(bin)$(Identifierinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Identifierinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##Identifierclean :: Identifieruninstall

uninstall :: Identifieruninstall ;

Identifieruninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Identifierinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),Identifierclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),Identifierprototype)

$(bin)Identifier_dependencies.make : $(use_requirements) $(cmt_final_setup_Identifier)
	$(echo) "(Identifier.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)Identifier.cc $(src)CdID.cc $(src)TtID.cc $(src)JunoDetectorID.cc $(src)WpID.cc -end_all $(includes) $(app_Identifier_cppflags) $(lib_Identifier_cppflags) -name=Identifier $? -f=$(cmt_dependencies_in_Identifier) -without_cmt

-include $(bin)Identifier_dependencies.make

endif
endif
endif

Identifierclean ::
	$(cleanup_silent) \rm -rf $(bin)Identifier_deps $(bin)Identifier_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Identifierclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Identifier.d

$(bin)$(binobj)Identifier.d :

$(bin)$(binobj)Identifier.o : $(cmt_final_setup_Identifier)

$(bin)$(binobj)Identifier.o : $(src)Identifier.cc
	$(cpp_echo) $(src)Identifier.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Identifier_pp_cppflags) $(lib_Identifier_pp_cppflags) $(Identifier_pp_cppflags) $(use_cppflags) $(Identifier_cppflags) $(lib_Identifier_cppflags) $(Identifier_cppflags) $(Identifier_cc_cppflags)  $(src)Identifier.cc
endif
endif

else
$(bin)Identifier_dependencies.make : $(Identifier_cc_dependencies)

$(bin)Identifier_dependencies.make : $(src)Identifier.cc

$(bin)$(binobj)Identifier.o : $(Identifier_cc_dependencies)
	$(cpp_echo) $(src)Identifier.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Identifier_pp_cppflags) $(lib_Identifier_pp_cppflags) $(Identifier_pp_cppflags) $(use_cppflags) $(Identifier_cppflags) $(lib_Identifier_cppflags) $(Identifier_cppflags) $(Identifier_cc_cppflags)  $(src)Identifier.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Identifierclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CdID.d

$(bin)$(binobj)CdID.d :

$(bin)$(binobj)CdID.o : $(cmt_final_setup_Identifier)

$(bin)$(binobj)CdID.o : $(src)CdID.cc
	$(cpp_echo) $(src)CdID.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Identifier_pp_cppflags) $(lib_Identifier_pp_cppflags) $(CdID_pp_cppflags) $(use_cppflags) $(Identifier_cppflags) $(lib_Identifier_cppflags) $(CdID_cppflags) $(CdID_cc_cppflags)  $(src)CdID.cc
endif
endif

else
$(bin)Identifier_dependencies.make : $(CdID_cc_dependencies)

$(bin)Identifier_dependencies.make : $(src)CdID.cc

$(bin)$(binobj)CdID.o : $(CdID_cc_dependencies)
	$(cpp_echo) $(src)CdID.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Identifier_pp_cppflags) $(lib_Identifier_pp_cppflags) $(CdID_pp_cppflags) $(use_cppflags) $(Identifier_cppflags) $(lib_Identifier_cppflags) $(CdID_cppflags) $(CdID_cc_cppflags)  $(src)CdID.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Identifierclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TtID.d

$(bin)$(binobj)TtID.d :

$(bin)$(binobj)TtID.o : $(cmt_final_setup_Identifier)

$(bin)$(binobj)TtID.o : $(src)TtID.cc
	$(cpp_echo) $(src)TtID.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Identifier_pp_cppflags) $(lib_Identifier_pp_cppflags) $(TtID_pp_cppflags) $(use_cppflags) $(Identifier_cppflags) $(lib_Identifier_cppflags) $(TtID_cppflags) $(TtID_cc_cppflags)  $(src)TtID.cc
endif
endif

else
$(bin)Identifier_dependencies.make : $(TtID_cc_dependencies)

$(bin)Identifier_dependencies.make : $(src)TtID.cc

$(bin)$(binobj)TtID.o : $(TtID_cc_dependencies)
	$(cpp_echo) $(src)TtID.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Identifier_pp_cppflags) $(lib_Identifier_pp_cppflags) $(TtID_pp_cppflags) $(use_cppflags) $(Identifier_cppflags) $(lib_Identifier_cppflags) $(TtID_cppflags) $(TtID_cc_cppflags)  $(src)TtID.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Identifierclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JunoDetectorID.d

$(bin)$(binobj)JunoDetectorID.d :

$(bin)$(binobj)JunoDetectorID.o : $(cmt_final_setup_Identifier)

$(bin)$(binobj)JunoDetectorID.o : $(src)JunoDetectorID.cc
	$(cpp_echo) $(src)JunoDetectorID.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Identifier_pp_cppflags) $(lib_Identifier_pp_cppflags) $(JunoDetectorID_pp_cppflags) $(use_cppflags) $(Identifier_cppflags) $(lib_Identifier_cppflags) $(JunoDetectorID_cppflags) $(JunoDetectorID_cc_cppflags)  $(src)JunoDetectorID.cc
endif
endif

else
$(bin)Identifier_dependencies.make : $(JunoDetectorID_cc_dependencies)

$(bin)Identifier_dependencies.make : $(src)JunoDetectorID.cc

$(bin)$(binobj)JunoDetectorID.o : $(JunoDetectorID_cc_dependencies)
	$(cpp_echo) $(src)JunoDetectorID.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Identifier_pp_cppflags) $(lib_Identifier_pp_cppflags) $(JunoDetectorID_pp_cppflags) $(use_cppflags) $(Identifier_cppflags) $(lib_Identifier_cppflags) $(JunoDetectorID_cppflags) $(JunoDetectorID_cc_cppflags)  $(src)JunoDetectorID.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Identifierclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)WpID.d

$(bin)$(binobj)WpID.d :

$(bin)$(binobj)WpID.o : $(cmt_final_setup_Identifier)

$(bin)$(binobj)WpID.o : $(src)WpID.cc
	$(cpp_echo) $(src)WpID.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Identifier_pp_cppflags) $(lib_Identifier_pp_cppflags) $(WpID_pp_cppflags) $(use_cppflags) $(Identifier_cppflags) $(lib_Identifier_cppflags) $(WpID_cppflags) $(WpID_cc_cppflags)  $(src)WpID.cc
endif
endif

else
$(bin)Identifier_dependencies.make : $(WpID_cc_dependencies)

$(bin)Identifier_dependencies.make : $(src)WpID.cc

$(bin)$(binobj)WpID.o : $(WpID_cc_dependencies)
	$(cpp_echo) $(src)WpID.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Identifier_pp_cppflags) $(lib_Identifier_pp_cppflags) $(WpID_pp_cppflags) $(use_cppflags) $(Identifier_cppflags) $(lib_Identifier_cppflags) $(WpID_cppflags) $(WpID_cc_cppflags)  $(src)WpID.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: Identifierclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Identifier.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

Identifierclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library Identifier
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)Identifier$(library_suffix).a $(library_prefix)Identifier$(library_suffix).$(shlibsuffix) Identifier.stamp Identifier.shstamp
#-- end of cleanup_library ---------------

#-- start of make_header -----------------

#====================================
#  Library CLHEPDict
#
#   Generated Fri Jul 10 19:17:32 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_CLHEPDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_CLHEPDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_CLHEPDict

CLHEPDict_tag = $(tag)

#cmt_local_tagfile_CLHEPDict = $(CLHEPDict_tag)_CLHEPDict.make
cmt_local_tagfile_CLHEPDict = $(bin)$(CLHEPDict_tag)_CLHEPDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CLHEPDict_tag = $(tag)

#cmt_local_tagfile_CLHEPDict = $(CLHEPDict_tag).make
cmt_local_tagfile_CLHEPDict = $(bin)$(CLHEPDict_tag).make

endif

include $(cmt_local_tagfile_CLHEPDict)
#-include $(cmt_local_tagfile_CLHEPDict)

ifdef cmt_CLHEPDict_has_target_tag

cmt_final_setup_CLHEPDict = $(bin)setup_CLHEPDict.make
cmt_dependencies_in_CLHEPDict = $(bin)dependencies_CLHEPDict.in
#cmt_final_setup_CLHEPDict = $(bin)CLHEPDict_CLHEPDictsetup.make
cmt_local_CLHEPDict_makefile = $(bin)CLHEPDict.make

else

cmt_final_setup_CLHEPDict = $(bin)setup.make
cmt_dependencies_in_CLHEPDict = $(bin)dependencies.in
#cmt_final_setup_CLHEPDict = $(bin)CLHEPDictsetup.make
cmt_local_CLHEPDict_makefile = $(bin)CLHEPDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CLHEPDictsetup.make

#CLHEPDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'CLHEPDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = CLHEPDict/
#CLHEPDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

CLHEPDictlibname   = $(bin)$(library_prefix)CLHEPDict$(library_suffix)
CLHEPDictlib       = $(CLHEPDictlibname).a
CLHEPDictstamp     = $(bin)CLHEPDict.stamp
CLHEPDictshstamp   = $(bin)CLHEPDict.shstamp

CLHEPDict :: dirs  CLHEPDictLIB
	$(echo) "CLHEPDict ok"

cmt_CLHEPDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_CLHEPDict_has_prototypes

CLHEPDictprototype :  ;

endif

CLHEPDictcompile : $(bin)CLHEPIncDict.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

CLHEPDictLIB :: $(CLHEPDictlib) $(CLHEPDictshstamp)
	$(echo) "CLHEPDict : library ok"

$(CLHEPDictlib) :: $(bin)CLHEPIncDict.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(CLHEPDictlib) $(bin)CLHEPIncDict.o
	$(lib_silent) $(ranlib) $(CLHEPDictlib)
	$(lib_silent) cat /dev/null >$(CLHEPDictstamp)

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

$(CLHEPDictlibname).$(shlibsuffix) :: $(CLHEPDictlib) requirements $(use_requirements) $(CLHEPDictstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" CLHEPDict $(CLHEPDict_shlibflags)
	$(lib_silent) cat /dev/null >$(CLHEPDictshstamp)

$(CLHEPDictshstamp) :: $(CLHEPDictlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(CLHEPDictlibname).$(shlibsuffix) ; then cat /dev/null >$(CLHEPDictshstamp) ; fi

CLHEPDictclean ::
	$(cleanup_echo) objects CLHEPDict
	$(cleanup_silent) /bin/rm -f $(bin)CLHEPIncDict.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)CLHEPIncDict.o) $(patsubst %.o,%.dep,$(bin)CLHEPIncDict.o) $(patsubst %.o,%.d.stamp,$(bin)CLHEPIncDict.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf CLHEPDict_deps CLHEPDict_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
CLHEPDictinstallname = $(library_prefix)CLHEPDict$(library_suffix).$(shlibsuffix)

CLHEPDict :: CLHEPDictinstall ;

install :: CLHEPDictinstall ;

CLHEPDictinstall :: $(install_dir)/$(CLHEPDictinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(CLHEPDictinstallname) :: $(bin)$(CLHEPDictinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(CLHEPDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##CLHEPDictclean :: CLHEPDictuninstall

uninstall :: CLHEPDictuninstall ;

CLHEPDictuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(CLHEPDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),CLHEPDictclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),CLHEPDictprototype)

$(bin)CLHEPDict_dependencies.make : $(use_requirements) $(cmt_final_setup_CLHEPDict)
	$(echo) "(CLHEPDict.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)CLHEPIncDict.cc -end_all $(includes) $(app_CLHEPDict_cppflags) $(lib_CLHEPDict_cppflags) -name=CLHEPDict $? -f=$(cmt_dependencies_in_CLHEPDict) -without_cmt

-include $(bin)CLHEPDict_dependencies.make

endif
endif
endif

CLHEPDictclean ::
	$(cleanup_silent) \rm -rf $(bin)CLHEPDict_deps $(bin)CLHEPDict_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),CLHEPDictclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CLHEPIncDict.d

$(bin)$(binobj)CLHEPIncDict.d :

$(bin)$(binobj)CLHEPIncDict.o : $(cmt_final_setup_CLHEPDict)

$(bin)$(binobj)CLHEPIncDict.o : $(src)CLHEPIncDict.cc
	$(cpp_echo) $(src)CLHEPIncDict.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(CLHEPDict_pp_cppflags) $(lib_CLHEPDict_pp_cppflags) $(CLHEPIncDict_pp_cppflags) $(use_cppflags) $(CLHEPDict_cppflags) $(lib_CLHEPDict_cppflags) $(CLHEPIncDict_cppflags) $(CLHEPIncDict_cc_cppflags)  $(src)CLHEPIncDict.cc
endif
endif

else
$(bin)CLHEPDict_dependencies.make : $(CLHEPIncDict_cc_dependencies)

$(bin)CLHEPDict_dependencies.make : $(src)CLHEPIncDict.cc

$(bin)$(binobj)CLHEPIncDict.o : $(CLHEPIncDict_cc_dependencies)
	$(cpp_echo) $(src)CLHEPIncDict.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(CLHEPDict_pp_cppflags) $(lib_CLHEPDict_pp_cppflags) $(CLHEPIncDict_pp_cppflags) $(use_cppflags) $(CLHEPDict_cppflags) $(lib_CLHEPDict_cppflags) $(CLHEPIncDict_cppflags) $(CLHEPIncDict_cc_cppflags)  $(src)CLHEPIncDict.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: CLHEPDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(CLHEPDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

CLHEPDictclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library CLHEPDict
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)CLHEPDict$(library_suffix).a $(library_prefix)CLHEPDict$(library_suffix).$(shlibsuffix) CLHEPDict.stamp CLHEPDict.shstamp
#-- end of cleanup_library ---------------

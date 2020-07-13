#-- start of make_header -----------------

#====================================
#  Library BufferMemMgr
#
#   Generated Fri Jul 10 19:18:24 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_BufferMemMgr_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_BufferMemMgr_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_BufferMemMgr

BufferMemMgr_tag = $(tag)

#cmt_local_tagfile_BufferMemMgr = $(BufferMemMgr_tag)_BufferMemMgr.make
cmt_local_tagfile_BufferMemMgr = $(bin)$(BufferMemMgr_tag)_BufferMemMgr.make

else

tags      = $(tag),$(CMTEXTRATAGS)

BufferMemMgr_tag = $(tag)

#cmt_local_tagfile_BufferMemMgr = $(BufferMemMgr_tag).make
cmt_local_tagfile_BufferMemMgr = $(bin)$(BufferMemMgr_tag).make

endif

include $(cmt_local_tagfile_BufferMemMgr)
#-include $(cmt_local_tagfile_BufferMemMgr)

ifdef cmt_BufferMemMgr_has_target_tag

cmt_final_setup_BufferMemMgr = $(bin)setup_BufferMemMgr.make
cmt_dependencies_in_BufferMemMgr = $(bin)dependencies_BufferMemMgr.in
#cmt_final_setup_BufferMemMgr = $(bin)BufferMemMgr_BufferMemMgrsetup.make
cmt_local_BufferMemMgr_makefile = $(bin)BufferMemMgr.make

else

cmt_final_setup_BufferMemMgr = $(bin)setup.make
cmt_dependencies_in_BufferMemMgr = $(bin)dependencies.in
#cmt_final_setup_BufferMemMgr = $(bin)BufferMemMgrsetup.make
cmt_local_BufferMemMgr_makefile = $(bin)BufferMemMgr.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)BufferMemMgrsetup.make

#BufferMemMgr :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'BufferMemMgr'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = BufferMemMgr/
#BufferMemMgr::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

BufferMemMgrlibname   = $(bin)$(library_prefix)BufferMemMgr$(library_suffix)
BufferMemMgrlib       = $(BufferMemMgrlibname).a
BufferMemMgrstamp     = $(bin)BufferMemMgr.stamp
BufferMemMgrshstamp   = $(bin)BufferMemMgr.shstamp

BufferMemMgr :: dirs  BufferMemMgrLIB
	$(echo) "BufferMemMgr ok"

cmt_BufferMemMgr_has_prototypes = 1

#--------------------------------------

ifdef cmt_BufferMemMgr_has_prototypes

BufferMemMgrprototype :  ;

endif

BufferMemMgrcompile : $(bin)EndEvtHdl.o $(bin)BeginEvtHdl.o $(bin)BufferMemMgr.o $(bin)FullStateNavBuf.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

BufferMemMgrLIB :: $(BufferMemMgrlib) $(BufferMemMgrshstamp)
	$(echo) "BufferMemMgr : library ok"

$(BufferMemMgrlib) :: $(bin)EndEvtHdl.o $(bin)BeginEvtHdl.o $(bin)BufferMemMgr.o $(bin)FullStateNavBuf.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(BufferMemMgrlib) $(bin)EndEvtHdl.o $(bin)BeginEvtHdl.o $(bin)BufferMemMgr.o $(bin)FullStateNavBuf.o
	$(lib_silent) $(ranlib) $(BufferMemMgrlib)
	$(lib_silent) cat /dev/null >$(BufferMemMgrstamp)

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

$(BufferMemMgrlibname).$(shlibsuffix) :: $(BufferMemMgrlib) requirements $(use_requirements) $(BufferMemMgrstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" BufferMemMgr $(BufferMemMgr_shlibflags)
	$(lib_silent) cat /dev/null >$(BufferMemMgrshstamp)

$(BufferMemMgrshstamp) :: $(BufferMemMgrlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(BufferMemMgrlibname).$(shlibsuffix) ; then cat /dev/null >$(BufferMemMgrshstamp) ; fi

BufferMemMgrclean ::
	$(cleanup_echo) objects BufferMemMgr
	$(cleanup_silent) /bin/rm -f $(bin)EndEvtHdl.o $(bin)BeginEvtHdl.o $(bin)BufferMemMgr.o $(bin)FullStateNavBuf.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)EndEvtHdl.o $(bin)BeginEvtHdl.o $(bin)BufferMemMgr.o $(bin)FullStateNavBuf.o) $(patsubst %.o,%.dep,$(bin)EndEvtHdl.o $(bin)BeginEvtHdl.o $(bin)BufferMemMgr.o $(bin)FullStateNavBuf.o) $(patsubst %.o,%.d.stamp,$(bin)EndEvtHdl.o $(bin)BeginEvtHdl.o $(bin)BufferMemMgr.o $(bin)FullStateNavBuf.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf BufferMemMgr_deps BufferMemMgr_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
BufferMemMgrinstallname = $(library_prefix)BufferMemMgr$(library_suffix).$(shlibsuffix)

BufferMemMgr :: BufferMemMgrinstall ;

install :: BufferMemMgrinstall ;

BufferMemMgrinstall :: $(install_dir)/$(BufferMemMgrinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(BufferMemMgrinstallname) :: $(bin)$(BufferMemMgrinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(BufferMemMgrinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##BufferMemMgrclean :: BufferMemMgruninstall

uninstall :: BufferMemMgruninstall ;

BufferMemMgruninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(BufferMemMgrinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),BufferMemMgrclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),BufferMemMgrprototype)

$(bin)BufferMemMgr_dependencies.make : $(use_requirements) $(cmt_final_setup_BufferMemMgr)
	$(echo) "(BufferMemMgr.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)EndEvtHdl.cc $(src)BeginEvtHdl.cc $(src)BufferMemMgr.cc $(src)FullStateNavBuf.cc -end_all $(includes) $(app_BufferMemMgr_cppflags) $(lib_BufferMemMgr_cppflags) -name=BufferMemMgr $? -f=$(cmt_dependencies_in_BufferMemMgr) -without_cmt

-include $(bin)BufferMemMgr_dependencies.make

endif
endif
endif

BufferMemMgrclean ::
	$(cleanup_silent) \rm -rf $(bin)BufferMemMgr_deps $(bin)BufferMemMgr_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),BufferMemMgrclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EndEvtHdl.d

$(bin)$(binobj)EndEvtHdl.d :

$(bin)$(binobj)EndEvtHdl.o : $(cmt_final_setup_BufferMemMgr)

$(bin)$(binobj)EndEvtHdl.o : $(src)EndEvtHdl.cc
	$(cpp_echo) $(src)EndEvtHdl.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(BufferMemMgr_pp_cppflags) $(lib_BufferMemMgr_pp_cppflags) $(EndEvtHdl_pp_cppflags) $(use_cppflags) $(BufferMemMgr_cppflags) $(lib_BufferMemMgr_cppflags) $(EndEvtHdl_cppflags) $(EndEvtHdl_cc_cppflags)  $(src)EndEvtHdl.cc
endif
endif

else
$(bin)BufferMemMgr_dependencies.make : $(EndEvtHdl_cc_dependencies)

$(bin)BufferMemMgr_dependencies.make : $(src)EndEvtHdl.cc

$(bin)$(binobj)EndEvtHdl.o : $(EndEvtHdl_cc_dependencies)
	$(cpp_echo) $(src)EndEvtHdl.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BufferMemMgr_pp_cppflags) $(lib_BufferMemMgr_pp_cppflags) $(EndEvtHdl_pp_cppflags) $(use_cppflags) $(BufferMemMgr_cppflags) $(lib_BufferMemMgr_cppflags) $(EndEvtHdl_cppflags) $(EndEvtHdl_cc_cppflags)  $(src)EndEvtHdl.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),BufferMemMgrclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BeginEvtHdl.d

$(bin)$(binobj)BeginEvtHdl.d :

$(bin)$(binobj)BeginEvtHdl.o : $(cmt_final_setup_BufferMemMgr)

$(bin)$(binobj)BeginEvtHdl.o : $(src)BeginEvtHdl.cc
	$(cpp_echo) $(src)BeginEvtHdl.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(BufferMemMgr_pp_cppflags) $(lib_BufferMemMgr_pp_cppflags) $(BeginEvtHdl_pp_cppflags) $(use_cppflags) $(BufferMemMgr_cppflags) $(lib_BufferMemMgr_cppflags) $(BeginEvtHdl_cppflags) $(BeginEvtHdl_cc_cppflags)  $(src)BeginEvtHdl.cc
endif
endif

else
$(bin)BufferMemMgr_dependencies.make : $(BeginEvtHdl_cc_dependencies)

$(bin)BufferMemMgr_dependencies.make : $(src)BeginEvtHdl.cc

$(bin)$(binobj)BeginEvtHdl.o : $(BeginEvtHdl_cc_dependencies)
	$(cpp_echo) $(src)BeginEvtHdl.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BufferMemMgr_pp_cppflags) $(lib_BufferMemMgr_pp_cppflags) $(BeginEvtHdl_pp_cppflags) $(use_cppflags) $(BufferMemMgr_cppflags) $(lib_BufferMemMgr_cppflags) $(BeginEvtHdl_cppflags) $(BeginEvtHdl_cc_cppflags)  $(src)BeginEvtHdl.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),BufferMemMgrclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BufferMemMgr.d

$(bin)$(binobj)BufferMemMgr.d :

$(bin)$(binobj)BufferMemMgr.o : $(cmt_final_setup_BufferMemMgr)

$(bin)$(binobj)BufferMemMgr.o : $(src)BufferMemMgr.cc
	$(cpp_echo) $(src)BufferMemMgr.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(BufferMemMgr_pp_cppflags) $(lib_BufferMemMgr_pp_cppflags) $(BufferMemMgr_pp_cppflags) $(use_cppflags) $(BufferMemMgr_cppflags) $(lib_BufferMemMgr_cppflags) $(BufferMemMgr_cppflags) $(BufferMemMgr_cc_cppflags)  $(src)BufferMemMgr.cc
endif
endif

else
$(bin)BufferMemMgr_dependencies.make : $(BufferMemMgr_cc_dependencies)

$(bin)BufferMemMgr_dependencies.make : $(src)BufferMemMgr.cc

$(bin)$(binobj)BufferMemMgr.o : $(BufferMemMgr_cc_dependencies)
	$(cpp_echo) $(src)BufferMemMgr.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BufferMemMgr_pp_cppflags) $(lib_BufferMemMgr_pp_cppflags) $(BufferMemMgr_pp_cppflags) $(use_cppflags) $(BufferMemMgr_cppflags) $(lib_BufferMemMgr_cppflags) $(BufferMemMgr_cppflags) $(BufferMemMgr_cc_cppflags)  $(src)BufferMemMgr.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),BufferMemMgrclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FullStateNavBuf.d

$(bin)$(binobj)FullStateNavBuf.d :

$(bin)$(binobj)FullStateNavBuf.o : $(cmt_final_setup_BufferMemMgr)

$(bin)$(binobj)FullStateNavBuf.o : $(src)FullStateNavBuf.cc
	$(cpp_echo) $(src)FullStateNavBuf.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(BufferMemMgr_pp_cppflags) $(lib_BufferMemMgr_pp_cppflags) $(FullStateNavBuf_pp_cppflags) $(use_cppflags) $(BufferMemMgr_cppflags) $(lib_BufferMemMgr_cppflags) $(FullStateNavBuf_cppflags) $(FullStateNavBuf_cc_cppflags)  $(src)FullStateNavBuf.cc
endif
endif

else
$(bin)BufferMemMgr_dependencies.make : $(FullStateNavBuf_cc_dependencies)

$(bin)BufferMemMgr_dependencies.make : $(src)FullStateNavBuf.cc

$(bin)$(binobj)FullStateNavBuf.o : $(FullStateNavBuf_cc_dependencies)
	$(cpp_echo) $(src)FullStateNavBuf.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BufferMemMgr_pp_cppflags) $(lib_BufferMemMgr_pp_cppflags) $(FullStateNavBuf_pp_cppflags) $(use_cppflags) $(BufferMemMgr_cppflags) $(lib_BufferMemMgr_cppflags) $(FullStateNavBuf_cppflags) $(FullStateNavBuf_cc_cppflags)  $(src)FullStateNavBuf.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: BufferMemMgrclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(BufferMemMgr.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

BufferMemMgrclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library BufferMemMgr
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)BufferMemMgr$(library_suffix).a $(library_prefix)BufferMemMgr$(library_suffix).$(shlibsuffix) BufferMemMgr.stamp BufferMemMgr.shstamp
#-- end of cleanup_library ---------------

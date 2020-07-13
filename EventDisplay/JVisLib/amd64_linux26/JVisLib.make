#-- start of make_header -----------------

#====================================
#  Library JVisLib
#
#   Generated Fri Jul 10 19:21:36 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_JVisLib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_JVisLib_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_JVisLib

JVisLib_tag = $(tag)

#cmt_local_tagfile_JVisLib = $(JVisLib_tag)_JVisLib.make
cmt_local_tagfile_JVisLib = $(bin)$(JVisLib_tag)_JVisLib.make

else

tags      = $(tag),$(CMTEXTRATAGS)

JVisLib_tag = $(tag)

#cmt_local_tagfile_JVisLib = $(JVisLib_tag).make
cmt_local_tagfile_JVisLib = $(bin)$(JVisLib_tag).make

endif

include $(cmt_local_tagfile_JVisLib)
#-include $(cmt_local_tagfile_JVisLib)

ifdef cmt_JVisLib_has_target_tag

cmt_final_setup_JVisLib = $(bin)setup_JVisLib.make
cmt_dependencies_in_JVisLib = $(bin)dependencies_JVisLib.in
#cmt_final_setup_JVisLib = $(bin)JVisLib_JVisLibsetup.make
cmt_local_JVisLib_makefile = $(bin)JVisLib.make

else

cmt_final_setup_JVisLib = $(bin)setup.make
cmt_dependencies_in_JVisLib = $(bin)dependencies.in
#cmt_final_setup_JVisLib = $(bin)JVisLibsetup.make
cmt_local_JVisLib_makefile = $(bin)JVisLib.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)JVisLibsetup.make

#JVisLib :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'JVisLib'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = JVisLib/
#JVisLib::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

JVisLiblibname   = $(bin)$(library_prefix)JVisLib$(library_suffix)
JVisLiblib       = $(JVisLiblibname).a
JVisLibstamp     = $(bin)JVisLib.stamp
JVisLibshstamp   = $(bin)JVisLib.shstamp

JVisLib :: dirs  JVisLibLIB
	$(echo) "JVisLib ok"

cmt_JVisLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_JVisLib_has_prototypes

JVisLibprototype :  ;

endif

JVisLibcompile : $(bin)JVisOpTrack.o $(bin)JVisTop.o $(bin)JVisEvtMgr.o $(bin)JVisGeom.o $(bin)JVisOpMgr.o $(bin)JVisTimer.o $(bin)JVisStatus.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

JVisLibLIB :: $(JVisLiblib) $(JVisLibshstamp)
	$(echo) "JVisLib : library ok"

$(JVisLiblib) :: $(bin)JVisOpTrack.o $(bin)JVisTop.o $(bin)JVisEvtMgr.o $(bin)JVisGeom.o $(bin)JVisOpMgr.o $(bin)JVisTimer.o $(bin)JVisStatus.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(JVisLiblib) $(bin)JVisOpTrack.o $(bin)JVisTop.o $(bin)JVisEvtMgr.o $(bin)JVisGeom.o $(bin)JVisOpMgr.o $(bin)JVisTimer.o $(bin)JVisStatus.o
	$(lib_silent) $(ranlib) $(JVisLiblib)
	$(lib_silent) cat /dev/null >$(JVisLibstamp)

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

$(JVisLiblibname).$(shlibsuffix) :: $(JVisLiblib) requirements $(use_requirements) $(JVisLibstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" JVisLib $(JVisLib_shlibflags)
	$(lib_silent) cat /dev/null >$(JVisLibshstamp)

$(JVisLibshstamp) :: $(JVisLiblibname).$(shlibsuffix)
	$(lib_silent) if test -f $(JVisLiblibname).$(shlibsuffix) ; then cat /dev/null >$(JVisLibshstamp) ; fi

JVisLibclean ::
	$(cleanup_echo) objects JVisLib
	$(cleanup_silent) /bin/rm -f $(bin)JVisOpTrack.o $(bin)JVisTop.o $(bin)JVisEvtMgr.o $(bin)JVisGeom.o $(bin)JVisOpMgr.o $(bin)JVisTimer.o $(bin)JVisStatus.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)JVisOpTrack.o $(bin)JVisTop.o $(bin)JVisEvtMgr.o $(bin)JVisGeom.o $(bin)JVisOpMgr.o $(bin)JVisTimer.o $(bin)JVisStatus.o) $(patsubst %.o,%.dep,$(bin)JVisOpTrack.o $(bin)JVisTop.o $(bin)JVisEvtMgr.o $(bin)JVisGeom.o $(bin)JVisOpMgr.o $(bin)JVisTimer.o $(bin)JVisStatus.o) $(patsubst %.o,%.d.stamp,$(bin)JVisOpTrack.o $(bin)JVisTop.o $(bin)JVisEvtMgr.o $(bin)JVisGeom.o $(bin)JVisOpMgr.o $(bin)JVisTimer.o $(bin)JVisStatus.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf JVisLib_deps JVisLib_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
JVisLibinstallname = $(library_prefix)JVisLib$(library_suffix).$(shlibsuffix)

JVisLib :: JVisLibinstall ;

install :: JVisLibinstall ;

JVisLibinstall :: $(install_dir)/$(JVisLibinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(JVisLibinstallname) :: $(bin)$(JVisLibinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(JVisLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##JVisLibclean :: JVisLibuninstall

uninstall :: JVisLibuninstall ;

JVisLibuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(JVisLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),JVisLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),JVisLibprototype)

$(bin)JVisLib_dependencies.make : $(use_requirements) $(cmt_final_setup_JVisLib)
	$(echo) "(JVisLib.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)JVisOpTrack.cc $(src)JVisTop.cc $(src)JVisEvtMgr.cc $(src)JVisGeom.cc $(src)JVisOpMgr.cc $(src)JVisTimer.cc $(src)JVisStatus.cc -end_all $(includes) $(app_JVisLib_cppflags) $(lib_JVisLib_cppflags) -name=JVisLib $? -f=$(cmt_dependencies_in_JVisLib) -without_cmt

-include $(bin)JVisLib_dependencies.make

endif
endif
endif

JVisLibclean ::
	$(cleanup_silent) \rm -rf $(bin)JVisLib_deps $(bin)JVisLib_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),JVisLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JVisOpTrack.d

$(bin)$(binobj)JVisOpTrack.d :

$(bin)$(binobj)JVisOpTrack.o : $(cmt_final_setup_JVisLib)

$(bin)$(binobj)JVisOpTrack.o : $(src)JVisOpTrack.cc
	$(cpp_echo) $(src)JVisOpTrack.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisOpTrack_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisOpTrack_cppflags) $(JVisOpTrack_cc_cppflags)  $(src)JVisOpTrack.cc
endif
endif

else
$(bin)JVisLib_dependencies.make : $(JVisOpTrack_cc_dependencies)

$(bin)JVisLib_dependencies.make : $(src)JVisOpTrack.cc

$(bin)$(binobj)JVisOpTrack.o : $(JVisOpTrack_cc_dependencies)
	$(cpp_echo) $(src)JVisOpTrack.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisOpTrack_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisOpTrack_cppflags) $(JVisOpTrack_cc_cppflags)  $(src)JVisOpTrack.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),JVisLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JVisTop.d

$(bin)$(binobj)JVisTop.d :

$(bin)$(binobj)JVisTop.o : $(cmt_final_setup_JVisLib)

$(bin)$(binobj)JVisTop.o : $(src)JVisTop.cc
	$(cpp_echo) $(src)JVisTop.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisTop_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisTop_cppflags) $(JVisTop_cc_cppflags)  $(src)JVisTop.cc
endif
endif

else
$(bin)JVisLib_dependencies.make : $(JVisTop_cc_dependencies)

$(bin)JVisLib_dependencies.make : $(src)JVisTop.cc

$(bin)$(binobj)JVisTop.o : $(JVisTop_cc_dependencies)
	$(cpp_echo) $(src)JVisTop.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisTop_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisTop_cppflags) $(JVisTop_cc_cppflags)  $(src)JVisTop.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),JVisLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JVisEvtMgr.d

$(bin)$(binobj)JVisEvtMgr.d :

$(bin)$(binobj)JVisEvtMgr.o : $(cmt_final_setup_JVisLib)

$(bin)$(binobj)JVisEvtMgr.o : $(src)JVisEvtMgr.cc
	$(cpp_echo) $(src)JVisEvtMgr.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisEvtMgr_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisEvtMgr_cppflags) $(JVisEvtMgr_cc_cppflags)  $(src)JVisEvtMgr.cc
endif
endif

else
$(bin)JVisLib_dependencies.make : $(JVisEvtMgr_cc_dependencies)

$(bin)JVisLib_dependencies.make : $(src)JVisEvtMgr.cc

$(bin)$(binobj)JVisEvtMgr.o : $(JVisEvtMgr_cc_dependencies)
	$(cpp_echo) $(src)JVisEvtMgr.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisEvtMgr_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisEvtMgr_cppflags) $(JVisEvtMgr_cc_cppflags)  $(src)JVisEvtMgr.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),JVisLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JVisGeom.d

$(bin)$(binobj)JVisGeom.d :

$(bin)$(binobj)JVisGeom.o : $(cmt_final_setup_JVisLib)

$(bin)$(binobj)JVisGeom.o : $(src)JVisGeom.cc
	$(cpp_echo) $(src)JVisGeom.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisGeom_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisGeom_cppflags) $(JVisGeom_cc_cppflags)  $(src)JVisGeom.cc
endif
endif

else
$(bin)JVisLib_dependencies.make : $(JVisGeom_cc_dependencies)

$(bin)JVisLib_dependencies.make : $(src)JVisGeom.cc

$(bin)$(binobj)JVisGeom.o : $(JVisGeom_cc_dependencies)
	$(cpp_echo) $(src)JVisGeom.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisGeom_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisGeom_cppflags) $(JVisGeom_cc_cppflags)  $(src)JVisGeom.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),JVisLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JVisOpMgr.d

$(bin)$(binobj)JVisOpMgr.d :

$(bin)$(binobj)JVisOpMgr.o : $(cmt_final_setup_JVisLib)

$(bin)$(binobj)JVisOpMgr.o : $(src)JVisOpMgr.cc
	$(cpp_echo) $(src)JVisOpMgr.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisOpMgr_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisOpMgr_cppflags) $(JVisOpMgr_cc_cppflags)  $(src)JVisOpMgr.cc
endif
endif

else
$(bin)JVisLib_dependencies.make : $(JVisOpMgr_cc_dependencies)

$(bin)JVisLib_dependencies.make : $(src)JVisOpMgr.cc

$(bin)$(binobj)JVisOpMgr.o : $(JVisOpMgr_cc_dependencies)
	$(cpp_echo) $(src)JVisOpMgr.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisOpMgr_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisOpMgr_cppflags) $(JVisOpMgr_cc_cppflags)  $(src)JVisOpMgr.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),JVisLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JVisTimer.d

$(bin)$(binobj)JVisTimer.d :

$(bin)$(binobj)JVisTimer.o : $(cmt_final_setup_JVisLib)

$(bin)$(binobj)JVisTimer.o : $(src)JVisTimer.cc
	$(cpp_echo) $(src)JVisTimer.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisTimer_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisTimer_cppflags) $(JVisTimer_cc_cppflags)  $(src)JVisTimer.cc
endif
endif

else
$(bin)JVisLib_dependencies.make : $(JVisTimer_cc_dependencies)

$(bin)JVisLib_dependencies.make : $(src)JVisTimer.cc

$(bin)$(binobj)JVisTimer.o : $(JVisTimer_cc_dependencies)
	$(cpp_echo) $(src)JVisTimer.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisTimer_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisTimer_cppflags) $(JVisTimer_cc_cppflags)  $(src)JVisTimer.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),JVisLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JVisStatus.d

$(bin)$(binobj)JVisStatus.d :

$(bin)$(binobj)JVisStatus.o : $(cmt_final_setup_JVisLib)

$(bin)$(binobj)JVisStatus.o : $(src)JVisStatus.cc
	$(cpp_echo) $(src)JVisStatus.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisStatus_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisStatus_cppflags) $(JVisStatus_cc_cppflags)  $(src)JVisStatus.cc
endif
endif

else
$(bin)JVisLib_dependencies.make : $(JVisStatus_cc_dependencies)

$(bin)JVisLib_dependencies.make : $(src)JVisStatus.cc

$(bin)$(binobj)JVisStatus.o : $(JVisStatus_cc_dependencies)
	$(cpp_echo) $(src)JVisStatus.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(JVisLib_pp_cppflags) $(lib_JVisLib_pp_cppflags) $(JVisStatus_pp_cppflags) $(use_cppflags) $(JVisLib_cppflags) $(lib_JVisLib_cppflags) $(JVisStatus_cppflags) $(JVisStatus_cc_cppflags)  $(src)JVisStatus.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: JVisLibclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(JVisLib.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

JVisLibclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library JVisLib
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)JVisLib$(library_suffix).a $(library_prefix)JVisLib$(library_suffix).$(shlibsuffix) JVisLib.stamp JVisLib.shstamp
#-- end of cleanup_library ---------------

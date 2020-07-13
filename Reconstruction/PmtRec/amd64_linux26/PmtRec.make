#-- start of make_header -----------------

#====================================
#  Library PmtRec
#
#   Generated Fri Jul 10 19:22:43 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PmtRec_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PmtRec_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PmtRec

PmtRec_tag = $(tag)

#cmt_local_tagfile_PmtRec = $(PmtRec_tag)_PmtRec.make
cmt_local_tagfile_PmtRec = $(bin)$(PmtRec_tag)_PmtRec.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PmtRec_tag = $(tag)

#cmt_local_tagfile_PmtRec = $(PmtRec_tag).make
cmt_local_tagfile_PmtRec = $(bin)$(PmtRec_tag).make

endif

include $(cmt_local_tagfile_PmtRec)
#-include $(cmt_local_tagfile_PmtRec)

ifdef cmt_PmtRec_has_target_tag

cmt_final_setup_PmtRec = $(bin)setup_PmtRec.make
cmt_dependencies_in_PmtRec = $(bin)dependencies_PmtRec.in
#cmt_final_setup_PmtRec = $(bin)PmtRec_PmtRecsetup.make
cmt_local_PmtRec_makefile = $(bin)PmtRec.make

else

cmt_final_setup_PmtRec = $(bin)setup.make
cmt_dependencies_in_PmtRec = $(bin)dependencies.in
#cmt_final_setup_PmtRec = $(bin)PmtRecsetup.make
cmt_local_PmtRec_makefile = $(bin)PmtRec.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PmtRecsetup.make

#PmtRec :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PmtRec'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PmtRec/
#PmtRec::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

PmtReclibname   = $(bin)$(library_prefix)PmtRec$(library_suffix)
PmtReclib       = $(PmtReclibname).a
PmtRecstamp     = $(bin)PmtRec.stamp
PmtRecshstamp   = $(bin)PmtRec.shstamp

PmtRec :: dirs  PmtRecLIB
	$(echo) "PmtRec ok"

cmt_PmtRec_has_prototypes = 1

#--------------------------------------

ifdef cmt_PmtRec_has_prototypes

PmtRecprototype :  ;

endif

PmtReccompile : $(bin)PackSplitEventAlg.o $(bin)DummySplitByTimeAlg.o $(bin)PullSimHeaderAlg.o $(bin)MergeSimEventAlg.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

PmtRecLIB :: $(PmtReclib) $(PmtRecshstamp)
	$(echo) "PmtRec : library ok"

$(PmtReclib) :: $(bin)PackSplitEventAlg.o $(bin)DummySplitByTimeAlg.o $(bin)PullSimHeaderAlg.o $(bin)MergeSimEventAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(PmtReclib) $(bin)PackSplitEventAlg.o $(bin)DummySplitByTimeAlg.o $(bin)PullSimHeaderAlg.o $(bin)MergeSimEventAlg.o
	$(lib_silent) $(ranlib) $(PmtReclib)
	$(lib_silent) cat /dev/null >$(PmtRecstamp)

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

$(PmtReclibname).$(shlibsuffix) :: $(PmtReclib) requirements $(use_requirements) $(PmtRecstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" PmtRec $(PmtRec_shlibflags)
	$(lib_silent) cat /dev/null >$(PmtRecshstamp)

$(PmtRecshstamp) :: $(PmtReclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(PmtReclibname).$(shlibsuffix) ; then cat /dev/null >$(PmtRecshstamp) ; fi

PmtRecclean ::
	$(cleanup_echo) objects PmtRec
	$(cleanup_silent) /bin/rm -f $(bin)PackSplitEventAlg.o $(bin)DummySplitByTimeAlg.o $(bin)PullSimHeaderAlg.o $(bin)MergeSimEventAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PackSplitEventAlg.o $(bin)DummySplitByTimeAlg.o $(bin)PullSimHeaderAlg.o $(bin)MergeSimEventAlg.o) $(patsubst %.o,%.dep,$(bin)PackSplitEventAlg.o $(bin)DummySplitByTimeAlg.o $(bin)PullSimHeaderAlg.o $(bin)MergeSimEventAlg.o) $(patsubst %.o,%.d.stamp,$(bin)PackSplitEventAlg.o $(bin)DummySplitByTimeAlg.o $(bin)PullSimHeaderAlg.o $(bin)MergeSimEventAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf PmtRec_deps PmtRec_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
PmtRecinstallname = $(library_prefix)PmtRec$(library_suffix).$(shlibsuffix)

PmtRec :: PmtRecinstall ;

install :: PmtRecinstall ;

PmtRecinstall :: $(install_dir)/$(PmtRecinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(PmtRecinstallname) :: $(bin)$(PmtRecinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PmtRecinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##PmtRecclean :: PmtRecuninstall

uninstall :: PmtRecuninstall ;

PmtRecuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PmtRecinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),PmtRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),PmtRecprototype)

$(bin)PmtRec_dependencies.make : $(use_requirements) $(cmt_final_setup_PmtRec)
	$(echo) "(PmtRec.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)PackSplitEventAlg.cc $(src)DummySplitByTimeAlg.cc $(src)PullSimHeaderAlg.cc $(src)MergeSimEventAlg.cc -end_all $(includes) $(app_PmtRec_cppflags) $(lib_PmtRec_cppflags) -name=PmtRec $? -f=$(cmt_dependencies_in_PmtRec) -without_cmt

-include $(bin)PmtRec_dependencies.make

endif
endif
endif

PmtRecclean ::
	$(cleanup_silent) \rm -rf $(bin)PmtRec_deps $(bin)PmtRec_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PmtRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PackSplitEventAlg.d

$(bin)$(binobj)PackSplitEventAlg.d :

$(bin)$(binobj)PackSplitEventAlg.o : $(cmt_final_setup_PmtRec)

$(bin)$(binobj)PackSplitEventAlg.o : $(src)PackSplitEventAlg.cc
	$(cpp_echo) $(src)PackSplitEventAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PmtRec_pp_cppflags) $(lib_PmtRec_pp_cppflags) $(PackSplitEventAlg_pp_cppflags) $(use_cppflags) $(PmtRec_cppflags) $(lib_PmtRec_cppflags) $(PackSplitEventAlg_cppflags) $(PackSplitEventAlg_cc_cppflags)  $(src)PackSplitEventAlg.cc
endif
endif

else
$(bin)PmtRec_dependencies.make : $(PackSplitEventAlg_cc_dependencies)

$(bin)PmtRec_dependencies.make : $(src)PackSplitEventAlg.cc

$(bin)$(binobj)PackSplitEventAlg.o : $(PackSplitEventAlg_cc_dependencies)
	$(cpp_echo) $(src)PackSplitEventAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PmtRec_pp_cppflags) $(lib_PmtRec_pp_cppflags) $(PackSplitEventAlg_pp_cppflags) $(use_cppflags) $(PmtRec_cppflags) $(lib_PmtRec_cppflags) $(PackSplitEventAlg_cppflags) $(PackSplitEventAlg_cc_cppflags)  $(src)PackSplitEventAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PmtRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummySplitByTimeAlg.d

$(bin)$(binobj)DummySplitByTimeAlg.d :

$(bin)$(binobj)DummySplitByTimeAlg.o : $(cmt_final_setup_PmtRec)

$(bin)$(binobj)DummySplitByTimeAlg.o : $(src)DummySplitByTimeAlg.cc
	$(cpp_echo) $(src)DummySplitByTimeAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PmtRec_pp_cppflags) $(lib_PmtRec_pp_cppflags) $(DummySplitByTimeAlg_pp_cppflags) $(use_cppflags) $(PmtRec_cppflags) $(lib_PmtRec_cppflags) $(DummySplitByTimeAlg_cppflags) $(DummySplitByTimeAlg_cc_cppflags)  $(src)DummySplitByTimeAlg.cc
endif
endif

else
$(bin)PmtRec_dependencies.make : $(DummySplitByTimeAlg_cc_dependencies)

$(bin)PmtRec_dependencies.make : $(src)DummySplitByTimeAlg.cc

$(bin)$(binobj)DummySplitByTimeAlg.o : $(DummySplitByTimeAlg_cc_dependencies)
	$(cpp_echo) $(src)DummySplitByTimeAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PmtRec_pp_cppflags) $(lib_PmtRec_pp_cppflags) $(DummySplitByTimeAlg_pp_cppflags) $(use_cppflags) $(PmtRec_cppflags) $(lib_PmtRec_cppflags) $(DummySplitByTimeAlg_cppflags) $(DummySplitByTimeAlg_cc_cppflags)  $(src)DummySplitByTimeAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PmtRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PullSimHeaderAlg.d

$(bin)$(binobj)PullSimHeaderAlg.d :

$(bin)$(binobj)PullSimHeaderAlg.o : $(cmt_final_setup_PmtRec)

$(bin)$(binobj)PullSimHeaderAlg.o : $(src)PullSimHeaderAlg.cc
	$(cpp_echo) $(src)PullSimHeaderAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PmtRec_pp_cppflags) $(lib_PmtRec_pp_cppflags) $(PullSimHeaderAlg_pp_cppflags) $(use_cppflags) $(PmtRec_cppflags) $(lib_PmtRec_cppflags) $(PullSimHeaderAlg_cppflags) $(PullSimHeaderAlg_cc_cppflags)  $(src)PullSimHeaderAlg.cc
endif
endif

else
$(bin)PmtRec_dependencies.make : $(PullSimHeaderAlg_cc_dependencies)

$(bin)PmtRec_dependencies.make : $(src)PullSimHeaderAlg.cc

$(bin)$(binobj)PullSimHeaderAlg.o : $(PullSimHeaderAlg_cc_dependencies)
	$(cpp_echo) $(src)PullSimHeaderAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PmtRec_pp_cppflags) $(lib_PmtRec_pp_cppflags) $(PullSimHeaderAlg_pp_cppflags) $(use_cppflags) $(PmtRec_cppflags) $(lib_PmtRec_cppflags) $(PullSimHeaderAlg_cppflags) $(PullSimHeaderAlg_cc_cppflags)  $(src)PullSimHeaderAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PmtRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MergeSimEventAlg.d

$(bin)$(binobj)MergeSimEventAlg.d :

$(bin)$(binobj)MergeSimEventAlg.o : $(cmt_final_setup_PmtRec)

$(bin)$(binobj)MergeSimEventAlg.o : $(src)MergeSimEventAlg.cc
	$(cpp_echo) $(src)MergeSimEventAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PmtRec_pp_cppflags) $(lib_PmtRec_pp_cppflags) $(MergeSimEventAlg_pp_cppflags) $(use_cppflags) $(PmtRec_cppflags) $(lib_PmtRec_cppflags) $(MergeSimEventAlg_cppflags) $(MergeSimEventAlg_cc_cppflags)  $(src)MergeSimEventAlg.cc
endif
endif

else
$(bin)PmtRec_dependencies.make : $(MergeSimEventAlg_cc_dependencies)

$(bin)PmtRec_dependencies.make : $(src)MergeSimEventAlg.cc

$(bin)$(binobj)MergeSimEventAlg.o : $(MergeSimEventAlg_cc_dependencies)
	$(cpp_echo) $(src)MergeSimEventAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PmtRec_pp_cppflags) $(lib_PmtRec_pp_cppflags) $(MergeSimEventAlg_pp_cppflags) $(use_cppflags) $(PmtRec_cppflags) $(lib_PmtRec_cppflags) $(MergeSimEventAlg_cppflags) $(MergeSimEventAlg_cc_cppflags)  $(src)MergeSimEventAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: PmtRecclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PmtRec.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PmtRecclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library PmtRec
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)PmtRec$(library_suffix).a $(library_prefix)PmtRec$(library_suffix).$(shlibsuffix) PmtRec.stamp PmtRec.shstamp
#-- end of cleanup_library ---------------

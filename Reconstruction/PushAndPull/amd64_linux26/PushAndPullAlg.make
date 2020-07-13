#-- start of make_header -----------------

#====================================
#  Library PushAndPullAlg
#
#   Generated Fri Jul 10 19:22:32 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PushAndPullAlg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PushAndPullAlg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PushAndPullAlg

PushAndPull_tag = $(tag)

#cmt_local_tagfile_PushAndPullAlg = $(PushAndPull_tag)_PushAndPullAlg.make
cmt_local_tagfile_PushAndPullAlg = $(bin)$(PushAndPull_tag)_PushAndPullAlg.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PushAndPull_tag = $(tag)

#cmt_local_tagfile_PushAndPullAlg = $(PushAndPull_tag).make
cmt_local_tagfile_PushAndPullAlg = $(bin)$(PushAndPull_tag).make

endif

include $(cmt_local_tagfile_PushAndPullAlg)
#-include $(cmt_local_tagfile_PushAndPullAlg)

ifdef cmt_PushAndPullAlg_has_target_tag

cmt_final_setup_PushAndPullAlg = $(bin)setup_PushAndPullAlg.make
cmt_dependencies_in_PushAndPullAlg = $(bin)dependencies_PushAndPullAlg.in
#cmt_final_setup_PushAndPullAlg = $(bin)PushAndPull_PushAndPullAlgsetup.make
cmt_local_PushAndPullAlg_makefile = $(bin)PushAndPullAlg.make

else

cmt_final_setup_PushAndPullAlg = $(bin)setup.make
cmt_dependencies_in_PushAndPullAlg = $(bin)dependencies.in
#cmt_final_setup_PushAndPullAlg = $(bin)PushAndPullsetup.make
cmt_local_PushAndPullAlg_makefile = $(bin)PushAndPullAlg.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PushAndPullsetup.make

#PushAndPullAlg :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PushAndPullAlg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PushAndPullAlg/
#PushAndPullAlg::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

PushAndPullAlglibname   = $(bin)$(library_prefix)PushAndPullAlg$(library_suffix)
PushAndPullAlglib       = $(PushAndPullAlglibname).a
PushAndPullAlgstamp     = $(bin)PushAndPullAlg.stamp
PushAndPullAlgshstamp   = $(bin)PushAndPullAlg.shstamp

PushAndPullAlg :: dirs  PushAndPullAlgLIB
	$(echo) "PushAndPullAlg ok"

cmt_PushAndPullAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_PushAndPullAlg_has_prototypes

PushAndPullAlgprototype :  ;

endif

PushAndPullAlgcompile : $(bin)PushAndPullAlg.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

PushAndPullAlgLIB :: $(PushAndPullAlglib) $(PushAndPullAlgshstamp)
	$(echo) "PushAndPullAlg : library ok"

$(PushAndPullAlglib) :: $(bin)PushAndPullAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(PushAndPullAlglib) $(bin)PushAndPullAlg.o
	$(lib_silent) $(ranlib) $(PushAndPullAlglib)
	$(lib_silent) cat /dev/null >$(PushAndPullAlgstamp)

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

$(PushAndPullAlglibname).$(shlibsuffix) :: $(PushAndPullAlglib) requirements $(use_requirements) $(PushAndPullAlgstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" PushAndPullAlg $(PushAndPullAlg_shlibflags)
	$(lib_silent) cat /dev/null >$(PushAndPullAlgshstamp)

$(PushAndPullAlgshstamp) :: $(PushAndPullAlglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(PushAndPullAlglibname).$(shlibsuffix) ; then cat /dev/null >$(PushAndPullAlgshstamp) ; fi

PushAndPullAlgclean ::
	$(cleanup_echo) objects PushAndPullAlg
	$(cleanup_silent) /bin/rm -f $(bin)PushAndPullAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PushAndPullAlg.o) $(patsubst %.o,%.dep,$(bin)PushAndPullAlg.o) $(patsubst %.o,%.d.stamp,$(bin)PushAndPullAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf PushAndPullAlg_deps PushAndPullAlg_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
PushAndPullAlginstallname = $(library_prefix)PushAndPullAlg$(library_suffix).$(shlibsuffix)

PushAndPullAlg :: PushAndPullAlginstall ;

install :: PushAndPullAlginstall ;

PushAndPullAlginstall :: $(install_dir)/$(PushAndPullAlginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(PushAndPullAlginstallname) :: $(bin)$(PushAndPullAlginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PushAndPullAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##PushAndPullAlgclean :: PushAndPullAlguninstall

uninstall :: PushAndPullAlguninstall ;

PushAndPullAlguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PushAndPullAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),PushAndPullAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),PushAndPullAlgprototype)

$(bin)PushAndPullAlg_dependencies.make : $(use_requirements) $(cmt_final_setup_PushAndPullAlg)
	$(echo) "(PushAndPullAlg.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)PushAndPullAlg.cpp -end_all $(includes) $(app_PushAndPullAlg_cppflags) $(lib_PushAndPullAlg_cppflags) -name=PushAndPullAlg $? -f=$(cmt_dependencies_in_PushAndPullAlg) -without_cmt

-include $(bin)PushAndPullAlg_dependencies.make

endif
endif
endif

PushAndPullAlgclean ::
	$(cleanup_silent) \rm -rf $(bin)PushAndPullAlg_deps $(bin)PushAndPullAlg_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),PushAndPullAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PushAndPullAlg.d

$(bin)$(binobj)PushAndPullAlg.d :

$(bin)$(binobj)PushAndPullAlg.o : $(cmt_final_setup_PushAndPullAlg)

$(bin)$(binobj)PushAndPullAlg.o : $(src)PushAndPullAlg.cpp
	$(cpp_echo) $(src)PushAndPullAlg.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(PushAndPullAlg_pp_cppflags) $(lib_PushAndPullAlg_pp_cppflags) $(PushAndPullAlg_pp_cppflags) $(use_cppflags) $(PushAndPullAlg_cppflags) $(lib_PushAndPullAlg_cppflags) $(PushAndPullAlg_cppflags) $(PushAndPullAlg_cpp_cppflags)  $(src)PushAndPullAlg.cpp
endif
endif

else
$(bin)PushAndPullAlg_dependencies.make : $(PushAndPullAlg_cpp_dependencies)

$(bin)PushAndPullAlg_dependencies.make : $(src)PushAndPullAlg.cpp

$(bin)$(binobj)PushAndPullAlg.o : $(PushAndPullAlg_cpp_dependencies)
	$(cpp_echo) $(src)PushAndPullAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PushAndPullAlg_pp_cppflags) $(lib_PushAndPullAlg_pp_cppflags) $(PushAndPullAlg_pp_cppflags) $(use_cppflags) $(PushAndPullAlg_cppflags) $(lib_PushAndPullAlg_cppflags) $(PushAndPullAlg_cppflags) $(PushAndPullAlg_cpp_cppflags)  $(src)PushAndPullAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: PushAndPullAlgclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PushAndPullAlg.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PushAndPullAlgclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library PushAndPullAlg
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)PushAndPullAlg$(library_suffix).a $(library_prefix)PushAndPullAlg$(library_suffix).$(shlibsuffix) PushAndPullAlg.stamp PushAndPullAlg.shstamp
#-- end of cleanup_library ---------------

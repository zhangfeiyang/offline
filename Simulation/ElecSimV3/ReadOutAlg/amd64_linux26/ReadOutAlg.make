#-- start of make_header -----------------

#====================================
#  Library ReadOutAlg
#
#   Generated Fri Jul 10 19:24:08 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_ReadOutAlg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ReadOutAlg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ReadOutAlg

ReadOutAlg_tag = $(tag)

#cmt_local_tagfile_ReadOutAlg = $(ReadOutAlg_tag)_ReadOutAlg.make
cmt_local_tagfile_ReadOutAlg = $(bin)$(ReadOutAlg_tag)_ReadOutAlg.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ReadOutAlg_tag = $(tag)

#cmt_local_tagfile_ReadOutAlg = $(ReadOutAlg_tag).make
cmt_local_tagfile_ReadOutAlg = $(bin)$(ReadOutAlg_tag).make

endif

include $(cmt_local_tagfile_ReadOutAlg)
#-include $(cmt_local_tagfile_ReadOutAlg)

ifdef cmt_ReadOutAlg_has_target_tag

cmt_final_setup_ReadOutAlg = $(bin)setup_ReadOutAlg.make
cmt_dependencies_in_ReadOutAlg = $(bin)dependencies_ReadOutAlg.in
#cmt_final_setup_ReadOutAlg = $(bin)ReadOutAlg_ReadOutAlgsetup.make
cmt_local_ReadOutAlg_makefile = $(bin)ReadOutAlg.make

else

cmt_final_setup_ReadOutAlg = $(bin)setup.make
cmt_dependencies_in_ReadOutAlg = $(bin)dependencies.in
#cmt_final_setup_ReadOutAlg = $(bin)ReadOutAlgsetup.make
cmt_local_ReadOutAlg_makefile = $(bin)ReadOutAlg.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ReadOutAlgsetup.make

#ReadOutAlg :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ReadOutAlg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ReadOutAlg/
#ReadOutAlg::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

ReadOutAlglibname   = $(bin)$(library_prefix)ReadOutAlg$(library_suffix)
ReadOutAlglib       = $(ReadOutAlglibname).a
ReadOutAlgstamp     = $(bin)ReadOutAlg.stamp
ReadOutAlgshstamp   = $(bin)ReadOutAlg.shstamp

ReadOutAlg :: dirs  ReadOutAlgLIB
	$(echo) "ReadOutAlg ok"

cmt_ReadOutAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_ReadOutAlg_has_prototypes

ReadOutAlgprototype :  ;

endif

ReadOutAlgcompile : $(bin)ReadOutAlg.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

ReadOutAlgLIB :: $(ReadOutAlglib) $(ReadOutAlgshstamp)
	$(echo) "ReadOutAlg : library ok"

$(ReadOutAlglib) :: $(bin)ReadOutAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(ReadOutAlglib) $(bin)ReadOutAlg.o
	$(lib_silent) $(ranlib) $(ReadOutAlglib)
	$(lib_silent) cat /dev/null >$(ReadOutAlgstamp)

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

$(ReadOutAlglibname).$(shlibsuffix) :: $(ReadOutAlglib) requirements $(use_requirements) $(ReadOutAlgstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" ReadOutAlg $(ReadOutAlg_shlibflags)
	$(lib_silent) cat /dev/null >$(ReadOutAlgshstamp)

$(ReadOutAlgshstamp) :: $(ReadOutAlglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(ReadOutAlglibname).$(shlibsuffix) ; then cat /dev/null >$(ReadOutAlgshstamp) ; fi

ReadOutAlgclean ::
	$(cleanup_echo) objects ReadOutAlg
	$(cleanup_silent) /bin/rm -f $(bin)ReadOutAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)ReadOutAlg.o) $(patsubst %.o,%.dep,$(bin)ReadOutAlg.o) $(patsubst %.o,%.d.stamp,$(bin)ReadOutAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf ReadOutAlg_deps ReadOutAlg_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
ReadOutAlginstallname = $(library_prefix)ReadOutAlg$(library_suffix).$(shlibsuffix)

ReadOutAlg :: ReadOutAlginstall ;

install :: ReadOutAlginstall ;

ReadOutAlginstall :: $(install_dir)/$(ReadOutAlginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(ReadOutAlginstallname) :: $(bin)$(ReadOutAlginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(ReadOutAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##ReadOutAlgclean :: ReadOutAlguninstall

uninstall :: ReadOutAlguninstall ;

ReadOutAlguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(ReadOutAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),ReadOutAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),ReadOutAlgprototype)

$(bin)ReadOutAlg_dependencies.make : $(use_requirements) $(cmt_final_setup_ReadOutAlg)
	$(echo) "(ReadOutAlg.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)ReadOutAlg.cc -end_all $(includes) $(app_ReadOutAlg_cppflags) $(lib_ReadOutAlg_cppflags) -name=ReadOutAlg $? -f=$(cmt_dependencies_in_ReadOutAlg) -without_cmt

-include $(bin)ReadOutAlg_dependencies.make

endif
endif
endif

ReadOutAlgclean ::
	$(cleanup_silent) \rm -rf $(bin)ReadOutAlg_deps $(bin)ReadOutAlg_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),ReadOutAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ReadOutAlg.d

$(bin)$(binobj)ReadOutAlg.d :

$(bin)$(binobj)ReadOutAlg.o : $(cmt_final_setup_ReadOutAlg)

$(bin)$(binobj)ReadOutAlg.o : $(src)ReadOutAlg.cc
	$(cpp_echo) $(src)ReadOutAlg.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(ReadOutAlg_pp_cppflags) $(lib_ReadOutAlg_pp_cppflags) $(ReadOutAlg_pp_cppflags) $(use_cppflags) $(ReadOutAlg_cppflags) $(lib_ReadOutAlg_cppflags) $(ReadOutAlg_cppflags) $(ReadOutAlg_cc_cppflags)  $(src)ReadOutAlg.cc
endif
endif

else
$(bin)ReadOutAlg_dependencies.make : $(ReadOutAlg_cc_dependencies)

$(bin)ReadOutAlg_dependencies.make : $(src)ReadOutAlg.cc

$(bin)$(binobj)ReadOutAlg.o : $(ReadOutAlg_cc_dependencies)
	$(cpp_echo) $(src)ReadOutAlg.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ReadOutAlg_pp_cppflags) $(lib_ReadOutAlg_pp_cppflags) $(ReadOutAlg_pp_cppflags) $(use_cppflags) $(ReadOutAlg_cppflags) $(lib_ReadOutAlg_cppflags) $(ReadOutAlg_cppflags) $(ReadOutAlg_cc_cppflags)  $(src)ReadOutAlg.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: ReadOutAlgclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ReadOutAlg.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ReadOutAlgclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library ReadOutAlg
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)ReadOutAlg$(library_suffix).a $(library_prefix)ReadOutAlg$(library_suffix).$(shlibsuffix) ReadOutAlg.stamp ReadOutAlg.shstamp
#-- end of cleanup_library ---------------

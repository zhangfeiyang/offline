#-- start of make_header -----------------

#====================================
#  Library MuonWaveRec
#
#   Generated Fri Jul 10 19:20:44 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_MuonWaveRec_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_MuonWaveRec_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_MuonWaveRec

MuonWaveRec_tag = $(tag)

#cmt_local_tagfile_MuonWaveRec = $(MuonWaveRec_tag)_MuonWaveRec.make
cmt_local_tagfile_MuonWaveRec = $(bin)$(MuonWaveRec_tag)_MuonWaveRec.make

else

tags      = $(tag),$(CMTEXTRATAGS)

MuonWaveRec_tag = $(tag)

#cmt_local_tagfile_MuonWaveRec = $(MuonWaveRec_tag).make
cmt_local_tagfile_MuonWaveRec = $(bin)$(MuonWaveRec_tag).make

endif

include $(cmt_local_tagfile_MuonWaveRec)
#-include $(cmt_local_tagfile_MuonWaveRec)

ifdef cmt_MuonWaveRec_has_target_tag

cmt_final_setup_MuonWaveRec = $(bin)setup_MuonWaveRec.make
cmt_dependencies_in_MuonWaveRec = $(bin)dependencies_MuonWaveRec.in
#cmt_final_setup_MuonWaveRec = $(bin)MuonWaveRec_MuonWaveRecsetup.make
cmt_local_MuonWaveRec_makefile = $(bin)MuonWaveRec.make

else

cmt_final_setup_MuonWaveRec = $(bin)setup.make
cmt_dependencies_in_MuonWaveRec = $(bin)dependencies.in
#cmt_final_setup_MuonWaveRec = $(bin)MuonWaveRecsetup.make
cmt_local_MuonWaveRec_makefile = $(bin)MuonWaveRec.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)MuonWaveRecsetup.make

#MuonWaveRec :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'MuonWaveRec'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = MuonWaveRec/
#MuonWaveRec::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

MuonWaveReclibname   = $(bin)$(library_prefix)MuonWaveRec$(library_suffix)
MuonWaveReclib       = $(MuonWaveReclibname).a
MuonWaveRecstamp     = $(bin)MuonWaveRec.stamp
MuonWaveRecshstamp   = $(bin)MuonWaveRec.shstamp

MuonWaveRec :: dirs  MuonWaveRecLIB
	$(echo) "MuonWaveRec ok"

cmt_MuonWaveRec_has_prototypes = 1

#--------------------------------------

ifdef cmt_MuonWaveRec_has_prototypes

MuonWaveRecprototype :  ;

endif

MuonWaveReccompile : $(bin)MuonWaveRec.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

MuonWaveRecLIB :: $(MuonWaveReclib) $(MuonWaveRecshstamp)
	$(echo) "MuonWaveRec : library ok"

$(MuonWaveReclib) :: $(bin)MuonWaveRec.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(MuonWaveReclib) $(bin)MuonWaveRec.o
	$(lib_silent) $(ranlib) $(MuonWaveReclib)
	$(lib_silent) cat /dev/null >$(MuonWaveRecstamp)

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

$(MuonWaveReclibname).$(shlibsuffix) :: $(MuonWaveReclib) requirements $(use_requirements) $(MuonWaveRecstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" MuonWaveRec $(MuonWaveRec_shlibflags)
	$(lib_silent) cat /dev/null >$(MuonWaveRecshstamp)

$(MuonWaveRecshstamp) :: $(MuonWaveReclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(MuonWaveReclibname).$(shlibsuffix) ; then cat /dev/null >$(MuonWaveRecshstamp) ; fi

MuonWaveRecclean ::
	$(cleanup_echo) objects MuonWaveRec
	$(cleanup_silent) /bin/rm -f $(bin)MuonWaveRec.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)MuonWaveRec.o) $(patsubst %.o,%.dep,$(bin)MuonWaveRec.o) $(patsubst %.o,%.d.stamp,$(bin)MuonWaveRec.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf MuonWaveRec_deps MuonWaveRec_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
MuonWaveRecinstallname = $(library_prefix)MuonWaveRec$(library_suffix).$(shlibsuffix)

MuonWaveRec :: MuonWaveRecinstall ;

install :: MuonWaveRecinstall ;

MuonWaveRecinstall :: $(install_dir)/$(MuonWaveRecinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(MuonWaveRecinstallname) :: $(bin)$(MuonWaveRecinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(MuonWaveRecinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##MuonWaveRecclean :: MuonWaveRecuninstall

uninstall :: MuonWaveRecuninstall ;

MuonWaveRecuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(MuonWaveRecinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),MuonWaveRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),MuonWaveRecprototype)

$(bin)MuonWaveRec_dependencies.make : $(use_requirements) $(cmt_final_setup_MuonWaveRec)
	$(echo) "(MuonWaveRec.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)MuonWaveRec.cc -end_all $(includes) $(app_MuonWaveRec_cppflags) $(lib_MuonWaveRec_cppflags) -name=MuonWaveRec $? -f=$(cmt_dependencies_in_MuonWaveRec) -without_cmt

-include $(bin)MuonWaveRec_dependencies.make

endif
endif
endif

MuonWaveRecclean ::
	$(cleanup_silent) \rm -rf $(bin)MuonWaveRec_deps $(bin)MuonWaveRec_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MuonWaveRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MuonWaveRec.d

$(bin)$(binobj)MuonWaveRec.d :

$(bin)$(binobj)MuonWaveRec.o : $(cmt_final_setup_MuonWaveRec)

$(bin)$(binobj)MuonWaveRec.o : $(src)MuonWaveRec.cc
	$(cpp_echo) $(src)MuonWaveRec.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MuonWaveRec_pp_cppflags) $(lib_MuonWaveRec_pp_cppflags) $(MuonWaveRec_pp_cppflags) $(use_cppflags) $(MuonWaveRec_cppflags) $(lib_MuonWaveRec_cppflags) $(MuonWaveRec_cppflags) $(MuonWaveRec_cc_cppflags)  $(src)MuonWaveRec.cc
endif
endif

else
$(bin)MuonWaveRec_dependencies.make : $(MuonWaveRec_cc_dependencies)

$(bin)MuonWaveRec_dependencies.make : $(src)MuonWaveRec.cc

$(bin)$(binobj)MuonWaveRec.o : $(MuonWaveRec_cc_dependencies)
	$(cpp_echo) $(src)MuonWaveRec.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MuonWaveRec_pp_cppflags) $(lib_MuonWaveRec_pp_cppflags) $(MuonWaveRec_pp_cppflags) $(use_cppflags) $(MuonWaveRec_cppflags) $(lib_MuonWaveRec_cppflags) $(MuonWaveRec_cppflags) $(MuonWaveRec_cc_cppflags)  $(src)MuonWaveRec.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: MuonWaveRecclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(MuonWaveRec.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

MuonWaveRecclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library MuonWaveRec
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)MuonWaveRec$(library_suffix).a $(library_prefix)MuonWaveRec$(library_suffix).$(shlibsuffix) MuonWaveRec.stamp MuonWaveRec.shstamp
#-- end of cleanup_library ---------------

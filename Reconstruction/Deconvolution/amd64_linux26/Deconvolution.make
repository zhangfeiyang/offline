#-- start of make_header -----------------

#====================================
#  Library Deconvolution
#
#   Generated Fri Jul 10 19:20:54 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Deconvolution_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Deconvolution_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Deconvolution

Deconvolution_tag = $(tag)

#cmt_local_tagfile_Deconvolution = $(Deconvolution_tag)_Deconvolution.make
cmt_local_tagfile_Deconvolution = $(bin)$(Deconvolution_tag)_Deconvolution.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Deconvolution_tag = $(tag)

#cmt_local_tagfile_Deconvolution = $(Deconvolution_tag).make
cmt_local_tagfile_Deconvolution = $(bin)$(Deconvolution_tag).make

endif

include $(cmt_local_tagfile_Deconvolution)
#-include $(cmt_local_tagfile_Deconvolution)

ifdef cmt_Deconvolution_has_target_tag

cmt_final_setup_Deconvolution = $(bin)setup_Deconvolution.make
cmt_dependencies_in_Deconvolution = $(bin)dependencies_Deconvolution.in
#cmt_final_setup_Deconvolution = $(bin)Deconvolution_Deconvolutionsetup.make
cmt_local_Deconvolution_makefile = $(bin)Deconvolution.make

else

cmt_final_setup_Deconvolution = $(bin)setup.make
cmt_dependencies_in_Deconvolution = $(bin)dependencies.in
#cmt_final_setup_Deconvolution = $(bin)Deconvolutionsetup.make
cmt_local_Deconvolution_makefile = $(bin)Deconvolution.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Deconvolutionsetup.make

#Deconvolution :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'Deconvolution'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Deconvolution/
#Deconvolution::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

Deconvolutionlibname   = $(bin)$(library_prefix)Deconvolution$(library_suffix)
Deconvolutionlib       = $(Deconvolutionlibname).a
Deconvolutionstamp     = $(bin)Deconvolution.stamp
Deconvolutionshstamp   = $(bin)Deconvolution.shstamp

Deconvolution :: dirs  DeconvolutionLIB
	$(echo) "Deconvolution ok"

cmt_Deconvolution_has_prototypes = 1

#--------------------------------------

ifdef cmt_Deconvolution_has_prototypes

Deconvolutionprototype :  ;

endif

Deconvolutioncompile : $(bin)Deconvolution.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

DeconvolutionLIB :: $(Deconvolutionlib) $(Deconvolutionshstamp)
	$(echo) "Deconvolution : library ok"

$(Deconvolutionlib) :: $(bin)Deconvolution.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(Deconvolutionlib) $(bin)Deconvolution.o
	$(lib_silent) $(ranlib) $(Deconvolutionlib)
	$(lib_silent) cat /dev/null >$(Deconvolutionstamp)

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

$(Deconvolutionlibname).$(shlibsuffix) :: $(Deconvolutionlib) requirements $(use_requirements) $(Deconvolutionstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" Deconvolution $(Deconvolution_shlibflags)
	$(lib_silent) cat /dev/null >$(Deconvolutionshstamp)

$(Deconvolutionshstamp) :: $(Deconvolutionlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(Deconvolutionlibname).$(shlibsuffix) ; then cat /dev/null >$(Deconvolutionshstamp) ; fi

Deconvolutionclean ::
	$(cleanup_echo) objects Deconvolution
	$(cleanup_silent) /bin/rm -f $(bin)Deconvolution.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)Deconvolution.o) $(patsubst %.o,%.dep,$(bin)Deconvolution.o) $(patsubst %.o,%.d.stamp,$(bin)Deconvolution.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf Deconvolution_deps Deconvolution_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
Deconvolutioninstallname = $(library_prefix)Deconvolution$(library_suffix).$(shlibsuffix)

Deconvolution :: Deconvolutioninstall ;

install :: Deconvolutioninstall ;

Deconvolutioninstall :: $(install_dir)/$(Deconvolutioninstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(Deconvolutioninstallname) :: $(bin)$(Deconvolutioninstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Deconvolutioninstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##Deconvolutionclean :: Deconvolutionuninstall

uninstall :: Deconvolutionuninstall ;

Deconvolutionuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Deconvolutioninstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),Deconvolutionclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),Deconvolutionprototype)

$(bin)Deconvolution_dependencies.make : $(use_requirements) $(cmt_final_setup_Deconvolution)
	$(echo) "(Deconvolution.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)Deconvolution.cc -end_all $(includes) $(app_Deconvolution_cppflags) $(lib_Deconvolution_cppflags) -name=Deconvolution $? -f=$(cmt_dependencies_in_Deconvolution) -without_cmt

-include $(bin)Deconvolution_dependencies.make

endif
endif
endif

Deconvolutionclean ::
	$(cleanup_silent) \rm -rf $(bin)Deconvolution_deps $(bin)Deconvolution_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Deconvolutionclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Deconvolution.d

$(bin)$(binobj)Deconvolution.d :

$(bin)$(binobj)Deconvolution.o : $(cmt_final_setup_Deconvolution)

$(bin)$(binobj)Deconvolution.o : $(src)Deconvolution.cc
	$(cpp_echo) $(src)Deconvolution.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Deconvolution_pp_cppflags) $(lib_Deconvolution_pp_cppflags) $(Deconvolution_pp_cppflags) $(use_cppflags) $(Deconvolution_cppflags) $(lib_Deconvolution_cppflags) $(Deconvolution_cppflags) $(Deconvolution_cc_cppflags)  $(src)Deconvolution.cc
endif
endif

else
$(bin)Deconvolution_dependencies.make : $(Deconvolution_cc_dependencies)

$(bin)Deconvolution_dependencies.make : $(src)Deconvolution.cc

$(bin)$(binobj)Deconvolution.o : $(Deconvolution_cc_dependencies)
	$(cpp_echo) $(src)Deconvolution.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Deconvolution_pp_cppflags) $(lib_Deconvolution_pp_cppflags) $(Deconvolution_pp_cppflags) $(use_cppflags) $(Deconvolution_cppflags) $(lib_Deconvolution_cppflags) $(Deconvolution_cppflags) $(Deconvolution_cc_cppflags)  $(src)Deconvolution.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: Deconvolutionclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Deconvolution.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

Deconvolutionclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library Deconvolution
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)Deconvolution$(library_suffix).a $(library_prefix)Deconvolution$(library_suffix).$(shlibsuffix) Deconvolution.stamp Deconvolution.shstamp
#-- end of cleanup_library ---------------

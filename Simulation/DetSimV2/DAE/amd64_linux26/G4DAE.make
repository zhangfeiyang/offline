#-- start of make_header -----------------

#====================================
#  Library G4DAE
#
#   Generated Fri Jul 10 19:15:02 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_G4DAE_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_G4DAE_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_G4DAE

DAE_tag = $(tag)

#cmt_local_tagfile_G4DAE = $(DAE_tag)_G4DAE.make
cmt_local_tagfile_G4DAE = $(bin)$(DAE_tag)_G4DAE.make

else

tags      = $(tag),$(CMTEXTRATAGS)

DAE_tag = $(tag)

#cmt_local_tagfile_G4DAE = $(DAE_tag).make
cmt_local_tagfile_G4DAE = $(bin)$(DAE_tag).make

endif

include $(cmt_local_tagfile_G4DAE)
#-include $(cmt_local_tagfile_G4DAE)

ifdef cmt_G4DAE_has_target_tag

cmt_final_setup_G4DAE = $(bin)setup_G4DAE.make
cmt_dependencies_in_G4DAE = $(bin)dependencies_G4DAE.in
#cmt_final_setup_G4DAE = $(bin)DAE_G4DAEsetup.make
cmt_local_G4DAE_makefile = $(bin)G4DAE.make

else

cmt_final_setup_G4DAE = $(bin)setup.make
cmt_dependencies_in_G4DAE = $(bin)dependencies.in
#cmt_final_setup_G4DAE = $(bin)DAEsetup.make
cmt_local_G4DAE_makefile = $(bin)G4DAE.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)DAEsetup.make

#G4DAE :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'G4DAE'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = G4DAE/
#G4DAE::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

G4DAElibname   = $(bin)$(library_prefix)G4DAE$(library_suffix)
G4DAElib       = $(G4DAElibname).a
G4DAEstamp     = $(bin)G4DAE.stamp
G4DAEshstamp   = $(bin)G4DAE.shstamp

G4DAE :: dirs  G4DAELIB
	$(echo) "G4DAE ok"

cmt_G4DAE_has_prototypes = 1

#--------------------------------------

ifdef cmt_G4DAE_has_prototypes

G4DAEprototype :  ;

endif

G4DAEcompile : $(bin)G4DAEReadSetup.o $(bin)G4DAEPolyhedron.o $(bin)G4DAEWriteSolids.o $(bin)G4STRead.o $(bin)G4DAEReadDefine.o $(bin)G4DAEWriteAsset.o $(bin)G4DAEParameterisation.o $(bin)G4DAEWriteMaterials.o $(bin)G4DAEReadParamvol.o $(bin)G4DAEWrite.o $(bin)G4DAEEvaluator.o $(bin)G4DAEParser.o $(bin)G4DAEReadStructure.o $(bin)G4DAEUtil.o $(bin)G4DAEWriteStructure.o $(bin)G4DAEWriteParamvol.o $(bin)G4DAEWriteSetup.o $(bin)G4DAEReadSolids.o $(bin)G4DAEReadMaterials.o $(bin)G4DAEWriteEffects.o $(bin)G4DAERead.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

G4DAELIB :: $(G4DAElib) $(G4DAEshstamp)
	$(echo) "G4DAE : library ok"

$(G4DAElib) :: $(bin)G4DAEReadSetup.o $(bin)G4DAEPolyhedron.o $(bin)G4DAEWriteSolids.o $(bin)G4STRead.o $(bin)G4DAEReadDefine.o $(bin)G4DAEWriteAsset.o $(bin)G4DAEParameterisation.o $(bin)G4DAEWriteMaterials.o $(bin)G4DAEReadParamvol.o $(bin)G4DAEWrite.o $(bin)G4DAEEvaluator.o $(bin)G4DAEParser.o $(bin)G4DAEReadStructure.o $(bin)G4DAEUtil.o $(bin)G4DAEWriteStructure.o $(bin)G4DAEWriteParamvol.o $(bin)G4DAEWriteSetup.o $(bin)G4DAEReadSolids.o $(bin)G4DAEReadMaterials.o $(bin)G4DAEWriteEffects.o $(bin)G4DAERead.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(G4DAElib) $(bin)G4DAEReadSetup.o $(bin)G4DAEPolyhedron.o $(bin)G4DAEWriteSolids.o $(bin)G4STRead.o $(bin)G4DAEReadDefine.o $(bin)G4DAEWriteAsset.o $(bin)G4DAEParameterisation.o $(bin)G4DAEWriteMaterials.o $(bin)G4DAEReadParamvol.o $(bin)G4DAEWrite.o $(bin)G4DAEEvaluator.o $(bin)G4DAEParser.o $(bin)G4DAEReadStructure.o $(bin)G4DAEUtil.o $(bin)G4DAEWriteStructure.o $(bin)G4DAEWriteParamvol.o $(bin)G4DAEWriteSetup.o $(bin)G4DAEReadSolids.o $(bin)G4DAEReadMaterials.o $(bin)G4DAEWriteEffects.o $(bin)G4DAERead.o
	$(lib_silent) $(ranlib) $(G4DAElib)
	$(lib_silent) cat /dev/null >$(G4DAEstamp)

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

$(G4DAElibname).$(shlibsuffix) :: $(G4DAElib) requirements $(use_requirements) $(G4DAEstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" G4DAE $(G4DAE_shlibflags)
	$(lib_silent) cat /dev/null >$(G4DAEshstamp)

$(G4DAEshstamp) :: $(G4DAElibname).$(shlibsuffix)
	$(lib_silent) if test -f $(G4DAElibname).$(shlibsuffix) ; then cat /dev/null >$(G4DAEshstamp) ; fi

G4DAEclean ::
	$(cleanup_echo) objects G4DAE
	$(cleanup_silent) /bin/rm -f $(bin)G4DAEReadSetup.o $(bin)G4DAEPolyhedron.o $(bin)G4DAEWriteSolids.o $(bin)G4STRead.o $(bin)G4DAEReadDefine.o $(bin)G4DAEWriteAsset.o $(bin)G4DAEParameterisation.o $(bin)G4DAEWriteMaterials.o $(bin)G4DAEReadParamvol.o $(bin)G4DAEWrite.o $(bin)G4DAEEvaluator.o $(bin)G4DAEParser.o $(bin)G4DAEReadStructure.o $(bin)G4DAEUtil.o $(bin)G4DAEWriteStructure.o $(bin)G4DAEWriteParamvol.o $(bin)G4DAEWriteSetup.o $(bin)G4DAEReadSolids.o $(bin)G4DAEReadMaterials.o $(bin)G4DAEWriteEffects.o $(bin)G4DAERead.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)G4DAEReadSetup.o $(bin)G4DAEPolyhedron.o $(bin)G4DAEWriteSolids.o $(bin)G4STRead.o $(bin)G4DAEReadDefine.o $(bin)G4DAEWriteAsset.o $(bin)G4DAEParameterisation.o $(bin)G4DAEWriteMaterials.o $(bin)G4DAEReadParamvol.o $(bin)G4DAEWrite.o $(bin)G4DAEEvaluator.o $(bin)G4DAEParser.o $(bin)G4DAEReadStructure.o $(bin)G4DAEUtil.o $(bin)G4DAEWriteStructure.o $(bin)G4DAEWriteParamvol.o $(bin)G4DAEWriteSetup.o $(bin)G4DAEReadSolids.o $(bin)G4DAEReadMaterials.o $(bin)G4DAEWriteEffects.o $(bin)G4DAERead.o) $(patsubst %.o,%.dep,$(bin)G4DAEReadSetup.o $(bin)G4DAEPolyhedron.o $(bin)G4DAEWriteSolids.o $(bin)G4STRead.o $(bin)G4DAEReadDefine.o $(bin)G4DAEWriteAsset.o $(bin)G4DAEParameterisation.o $(bin)G4DAEWriteMaterials.o $(bin)G4DAEReadParamvol.o $(bin)G4DAEWrite.o $(bin)G4DAEEvaluator.o $(bin)G4DAEParser.o $(bin)G4DAEReadStructure.o $(bin)G4DAEUtil.o $(bin)G4DAEWriteStructure.o $(bin)G4DAEWriteParamvol.o $(bin)G4DAEWriteSetup.o $(bin)G4DAEReadSolids.o $(bin)G4DAEReadMaterials.o $(bin)G4DAEWriteEffects.o $(bin)G4DAERead.o) $(patsubst %.o,%.d.stamp,$(bin)G4DAEReadSetup.o $(bin)G4DAEPolyhedron.o $(bin)G4DAEWriteSolids.o $(bin)G4STRead.o $(bin)G4DAEReadDefine.o $(bin)G4DAEWriteAsset.o $(bin)G4DAEParameterisation.o $(bin)G4DAEWriteMaterials.o $(bin)G4DAEReadParamvol.o $(bin)G4DAEWrite.o $(bin)G4DAEEvaluator.o $(bin)G4DAEParser.o $(bin)G4DAEReadStructure.o $(bin)G4DAEUtil.o $(bin)G4DAEWriteStructure.o $(bin)G4DAEWriteParamvol.o $(bin)G4DAEWriteSetup.o $(bin)G4DAEReadSolids.o $(bin)G4DAEReadMaterials.o $(bin)G4DAEWriteEffects.o $(bin)G4DAERead.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf G4DAE_deps G4DAE_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
G4DAEinstallname = $(library_prefix)G4DAE$(library_suffix).$(shlibsuffix)

G4DAE :: G4DAEinstall ;

install :: G4DAEinstall ;

G4DAEinstall :: $(install_dir)/$(G4DAEinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(G4DAEinstallname) :: $(bin)$(G4DAEinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(G4DAEinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##G4DAEclean :: G4DAEuninstall

uninstall :: G4DAEuninstall ;

G4DAEuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(G4DAEinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),G4DAEprototype)

$(bin)G4DAE_dependencies.make : $(use_requirements) $(cmt_final_setup_G4DAE)
	$(echo) "(G4DAE.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)G4DAEReadSetup.cc $(src)G4DAEPolyhedron.cc $(src)G4DAEWriteSolids.cc $(src)G4STRead.cc $(src)G4DAEReadDefine.cc $(src)G4DAEWriteAsset.cc $(src)G4DAEParameterisation.cc $(src)G4DAEWriteMaterials.cc $(src)G4DAEReadParamvol.cc $(src)G4DAEWrite.cc $(src)G4DAEEvaluator.cc $(src)G4DAEParser.cc $(src)G4DAEReadStructure.cc $(src)G4DAEUtil.cc $(src)G4DAEWriteStructure.cc $(src)G4DAEWriteParamvol.cc $(src)G4DAEWriteSetup.cc $(src)G4DAEReadSolids.cc $(src)G4DAEReadMaterials.cc $(src)G4DAEWriteEffects.cc $(src)G4DAERead.cc -end_all $(includes) $(app_G4DAE_cppflags) $(lib_G4DAE_cppflags) -name=G4DAE $? -f=$(cmt_dependencies_in_G4DAE) -without_cmt

-include $(bin)G4DAE_dependencies.make

endif
endif
endif

G4DAEclean ::
	$(cleanup_silent) \rm -rf $(bin)G4DAE_deps $(bin)G4DAE_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEReadSetup.d

$(bin)$(binobj)G4DAEReadSetup.d :

$(bin)$(binobj)G4DAEReadSetup.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEReadSetup.o : $(src)G4DAEReadSetup.cc
	$(cpp_echo) $(src)G4DAEReadSetup.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEReadSetup_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEReadSetup_cppflags) $(G4DAEReadSetup_cc_cppflags)  $(src)G4DAEReadSetup.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEReadSetup_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEReadSetup.cc

$(bin)$(binobj)G4DAEReadSetup.o : $(G4DAEReadSetup_cc_dependencies)
	$(cpp_echo) $(src)G4DAEReadSetup.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEReadSetup_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEReadSetup_cppflags) $(G4DAEReadSetup_cc_cppflags)  $(src)G4DAEReadSetup.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEPolyhedron.d

$(bin)$(binobj)G4DAEPolyhedron.d :

$(bin)$(binobj)G4DAEPolyhedron.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEPolyhedron.o : $(src)G4DAEPolyhedron.cc
	$(cpp_echo) $(src)G4DAEPolyhedron.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEPolyhedron_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEPolyhedron_cppflags) $(G4DAEPolyhedron_cc_cppflags)  $(src)G4DAEPolyhedron.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEPolyhedron_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEPolyhedron.cc

$(bin)$(binobj)G4DAEPolyhedron.o : $(G4DAEPolyhedron_cc_dependencies)
	$(cpp_echo) $(src)G4DAEPolyhedron.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEPolyhedron_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEPolyhedron_cppflags) $(G4DAEPolyhedron_cc_cppflags)  $(src)G4DAEPolyhedron.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEWriteSolids.d

$(bin)$(binobj)G4DAEWriteSolids.d :

$(bin)$(binobj)G4DAEWriteSolids.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEWriteSolids.o : $(src)G4DAEWriteSolids.cc
	$(cpp_echo) $(src)G4DAEWriteSolids.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteSolids_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteSolids_cppflags) $(G4DAEWriteSolids_cc_cppflags)  $(src)G4DAEWriteSolids.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEWriteSolids_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEWriteSolids.cc

$(bin)$(binobj)G4DAEWriteSolids.o : $(G4DAEWriteSolids_cc_dependencies)
	$(cpp_echo) $(src)G4DAEWriteSolids.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteSolids_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteSolids_cppflags) $(G4DAEWriteSolids_cc_cppflags)  $(src)G4DAEWriteSolids.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4STRead.d

$(bin)$(binobj)G4STRead.d :

$(bin)$(binobj)G4STRead.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4STRead.o : $(src)G4STRead.cc
	$(cpp_echo) $(src)G4STRead.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4STRead_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4STRead_cppflags) $(G4STRead_cc_cppflags)  $(src)G4STRead.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4STRead_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4STRead.cc

$(bin)$(binobj)G4STRead.o : $(G4STRead_cc_dependencies)
	$(cpp_echo) $(src)G4STRead.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4STRead_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4STRead_cppflags) $(G4STRead_cc_cppflags)  $(src)G4STRead.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEReadDefine.d

$(bin)$(binobj)G4DAEReadDefine.d :

$(bin)$(binobj)G4DAEReadDefine.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEReadDefine.o : $(src)G4DAEReadDefine.cc
	$(cpp_echo) $(src)G4DAEReadDefine.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEReadDefine_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEReadDefine_cppflags) $(G4DAEReadDefine_cc_cppflags)  $(src)G4DAEReadDefine.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEReadDefine_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEReadDefine.cc

$(bin)$(binobj)G4DAEReadDefine.o : $(G4DAEReadDefine_cc_dependencies)
	$(cpp_echo) $(src)G4DAEReadDefine.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEReadDefine_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEReadDefine_cppflags) $(G4DAEReadDefine_cc_cppflags)  $(src)G4DAEReadDefine.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEWriteAsset.d

$(bin)$(binobj)G4DAEWriteAsset.d :

$(bin)$(binobj)G4DAEWriteAsset.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEWriteAsset.o : $(src)G4DAEWriteAsset.cc
	$(cpp_echo) $(src)G4DAEWriteAsset.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteAsset_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteAsset_cppflags) $(G4DAEWriteAsset_cc_cppflags)  $(src)G4DAEWriteAsset.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEWriteAsset_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEWriteAsset.cc

$(bin)$(binobj)G4DAEWriteAsset.o : $(G4DAEWriteAsset_cc_dependencies)
	$(cpp_echo) $(src)G4DAEWriteAsset.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteAsset_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteAsset_cppflags) $(G4DAEWriteAsset_cc_cppflags)  $(src)G4DAEWriteAsset.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEParameterisation.d

$(bin)$(binobj)G4DAEParameterisation.d :

$(bin)$(binobj)G4DAEParameterisation.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEParameterisation.o : $(src)G4DAEParameterisation.cc
	$(cpp_echo) $(src)G4DAEParameterisation.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEParameterisation_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEParameterisation_cppflags) $(G4DAEParameterisation_cc_cppflags)  $(src)G4DAEParameterisation.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEParameterisation_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEParameterisation.cc

$(bin)$(binobj)G4DAEParameterisation.o : $(G4DAEParameterisation_cc_dependencies)
	$(cpp_echo) $(src)G4DAEParameterisation.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEParameterisation_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEParameterisation_cppflags) $(G4DAEParameterisation_cc_cppflags)  $(src)G4DAEParameterisation.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEWriteMaterials.d

$(bin)$(binobj)G4DAEWriteMaterials.d :

$(bin)$(binobj)G4DAEWriteMaterials.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEWriteMaterials.o : $(src)G4DAEWriteMaterials.cc
	$(cpp_echo) $(src)G4DAEWriteMaterials.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteMaterials_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteMaterials_cppflags) $(G4DAEWriteMaterials_cc_cppflags)  $(src)G4DAEWriteMaterials.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEWriteMaterials_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEWriteMaterials.cc

$(bin)$(binobj)G4DAEWriteMaterials.o : $(G4DAEWriteMaterials_cc_dependencies)
	$(cpp_echo) $(src)G4DAEWriteMaterials.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteMaterials_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteMaterials_cppflags) $(G4DAEWriteMaterials_cc_cppflags)  $(src)G4DAEWriteMaterials.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEReadParamvol.d

$(bin)$(binobj)G4DAEReadParamvol.d :

$(bin)$(binobj)G4DAEReadParamvol.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEReadParamvol.o : $(src)G4DAEReadParamvol.cc
	$(cpp_echo) $(src)G4DAEReadParamvol.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEReadParamvol_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEReadParamvol_cppflags) $(G4DAEReadParamvol_cc_cppflags)  $(src)G4DAEReadParamvol.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEReadParamvol_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEReadParamvol.cc

$(bin)$(binobj)G4DAEReadParamvol.o : $(G4DAEReadParamvol_cc_dependencies)
	$(cpp_echo) $(src)G4DAEReadParamvol.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEReadParamvol_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEReadParamvol_cppflags) $(G4DAEReadParamvol_cc_cppflags)  $(src)G4DAEReadParamvol.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEWrite.d

$(bin)$(binobj)G4DAEWrite.d :

$(bin)$(binobj)G4DAEWrite.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEWrite.o : $(src)G4DAEWrite.cc
	$(cpp_echo) $(src)G4DAEWrite.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWrite_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWrite_cppflags) $(G4DAEWrite_cc_cppflags)  $(src)G4DAEWrite.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEWrite_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEWrite.cc

$(bin)$(binobj)G4DAEWrite.o : $(G4DAEWrite_cc_dependencies)
	$(cpp_echo) $(src)G4DAEWrite.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWrite_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWrite_cppflags) $(G4DAEWrite_cc_cppflags)  $(src)G4DAEWrite.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEEvaluator.d

$(bin)$(binobj)G4DAEEvaluator.d :

$(bin)$(binobj)G4DAEEvaluator.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEEvaluator.o : $(src)G4DAEEvaluator.cc
	$(cpp_echo) $(src)G4DAEEvaluator.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEEvaluator_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEEvaluator_cppflags) $(G4DAEEvaluator_cc_cppflags)  $(src)G4DAEEvaluator.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEEvaluator_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEEvaluator.cc

$(bin)$(binobj)G4DAEEvaluator.o : $(G4DAEEvaluator_cc_dependencies)
	$(cpp_echo) $(src)G4DAEEvaluator.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEEvaluator_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEEvaluator_cppflags) $(G4DAEEvaluator_cc_cppflags)  $(src)G4DAEEvaluator.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEParser.d

$(bin)$(binobj)G4DAEParser.d :

$(bin)$(binobj)G4DAEParser.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEParser.o : $(src)G4DAEParser.cc
	$(cpp_echo) $(src)G4DAEParser.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEParser_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEParser_cppflags) $(G4DAEParser_cc_cppflags)  $(src)G4DAEParser.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEParser_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEParser.cc

$(bin)$(binobj)G4DAEParser.o : $(G4DAEParser_cc_dependencies)
	$(cpp_echo) $(src)G4DAEParser.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEParser_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEParser_cppflags) $(G4DAEParser_cc_cppflags)  $(src)G4DAEParser.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEReadStructure.d

$(bin)$(binobj)G4DAEReadStructure.d :

$(bin)$(binobj)G4DAEReadStructure.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEReadStructure.o : $(src)G4DAEReadStructure.cc
	$(cpp_echo) $(src)G4DAEReadStructure.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEReadStructure_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEReadStructure_cppflags) $(G4DAEReadStructure_cc_cppflags)  $(src)G4DAEReadStructure.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEReadStructure_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEReadStructure.cc

$(bin)$(binobj)G4DAEReadStructure.o : $(G4DAEReadStructure_cc_dependencies)
	$(cpp_echo) $(src)G4DAEReadStructure.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEReadStructure_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEReadStructure_cppflags) $(G4DAEReadStructure_cc_cppflags)  $(src)G4DAEReadStructure.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEUtil.d

$(bin)$(binobj)G4DAEUtil.d :

$(bin)$(binobj)G4DAEUtil.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEUtil.o : $(src)G4DAEUtil.cc
	$(cpp_echo) $(src)G4DAEUtil.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEUtil_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEUtil_cppflags) $(G4DAEUtil_cc_cppflags)  $(src)G4DAEUtil.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEUtil_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEUtil.cc

$(bin)$(binobj)G4DAEUtil.o : $(G4DAEUtil_cc_dependencies)
	$(cpp_echo) $(src)G4DAEUtil.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEUtil_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEUtil_cppflags) $(G4DAEUtil_cc_cppflags)  $(src)G4DAEUtil.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEWriteStructure.d

$(bin)$(binobj)G4DAEWriteStructure.d :

$(bin)$(binobj)G4DAEWriteStructure.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEWriteStructure.o : $(src)G4DAEWriteStructure.cc
	$(cpp_echo) $(src)G4DAEWriteStructure.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteStructure_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteStructure_cppflags) $(G4DAEWriteStructure_cc_cppflags)  $(src)G4DAEWriteStructure.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEWriteStructure_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEWriteStructure.cc

$(bin)$(binobj)G4DAEWriteStructure.o : $(G4DAEWriteStructure_cc_dependencies)
	$(cpp_echo) $(src)G4DAEWriteStructure.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteStructure_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteStructure_cppflags) $(G4DAEWriteStructure_cc_cppflags)  $(src)G4DAEWriteStructure.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEWriteParamvol.d

$(bin)$(binobj)G4DAEWriteParamvol.d :

$(bin)$(binobj)G4DAEWriteParamvol.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEWriteParamvol.o : $(src)G4DAEWriteParamvol.cc
	$(cpp_echo) $(src)G4DAEWriteParamvol.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteParamvol_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteParamvol_cppflags) $(G4DAEWriteParamvol_cc_cppflags)  $(src)G4DAEWriteParamvol.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEWriteParamvol_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEWriteParamvol.cc

$(bin)$(binobj)G4DAEWriteParamvol.o : $(G4DAEWriteParamvol_cc_dependencies)
	$(cpp_echo) $(src)G4DAEWriteParamvol.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteParamvol_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteParamvol_cppflags) $(G4DAEWriteParamvol_cc_cppflags)  $(src)G4DAEWriteParamvol.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEWriteSetup.d

$(bin)$(binobj)G4DAEWriteSetup.d :

$(bin)$(binobj)G4DAEWriteSetup.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEWriteSetup.o : $(src)G4DAEWriteSetup.cc
	$(cpp_echo) $(src)G4DAEWriteSetup.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteSetup_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteSetup_cppflags) $(G4DAEWriteSetup_cc_cppflags)  $(src)G4DAEWriteSetup.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEWriteSetup_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEWriteSetup.cc

$(bin)$(binobj)G4DAEWriteSetup.o : $(G4DAEWriteSetup_cc_dependencies)
	$(cpp_echo) $(src)G4DAEWriteSetup.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteSetup_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteSetup_cppflags) $(G4DAEWriteSetup_cc_cppflags)  $(src)G4DAEWriteSetup.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEReadSolids.d

$(bin)$(binobj)G4DAEReadSolids.d :

$(bin)$(binobj)G4DAEReadSolids.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEReadSolids.o : $(src)G4DAEReadSolids.cc
	$(cpp_echo) $(src)G4DAEReadSolids.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEReadSolids_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEReadSolids_cppflags) $(G4DAEReadSolids_cc_cppflags)  $(src)G4DAEReadSolids.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEReadSolids_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEReadSolids.cc

$(bin)$(binobj)G4DAEReadSolids.o : $(G4DAEReadSolids_cc_dependencies)
	$(cpp_echo) $(src)G4DAEReadSolids.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEReadSolids_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEReadSolids_cppflags) $(G4DAEReadSolids_cc_cppflags)  $(src)G4DAEReadSolids.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEReadMaterials.d

$(bin)$(binobj)G4DAEReadMaterials.d :

$(bin)$(binobj)G4DAEReadMaterials.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEReadMaterials.o : $(src)G4DAEReadMaterials.cc
	$(cpp_echo) $(src)G4DAEReadMaterials.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEReadMaterials_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEReadMaterials_cppflags) $(G4DAEReadMaterials_cc_cppflags)  $(src)G4DAEReadMaterials.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEReadMaterials_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEReadMaterials.cc

$(bin)$(binobj)G4DAEReadMaterials.o : $(G4DAEReadMaterials_cc_dependencies)
	$(cpp_echo) $(src)G4DAEReadMaterials.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEReadMaterials_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEReadMaterials_cppflags) $(G4DAEReadMaterials_cc_cppflags)  $(src)G4DAEReadMaterials.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAEWriteEffects.d

$(bin)$(binobj)G4DAEWriteEffects.d :

$(bin)$(binobj)G4DAEWriteEffects.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAEWriteEffects.o : $(src)G4DAEWriteEffects.cc
	$(cpp_echo) $(src)G4DAEWriteEffects.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteEffects_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteEffects_cppflags) $(G4DAEWriteEffects_cc_cppflags)  $(src)G4DAEWriteEffects.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAEWriteEffects_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAEWriteEffects.cc

$(bin)$(binobj)G4DAEWriteEffects.o : $(G4DAEWriteEffects_cc_dependencies)
	$(cpp_echo) $(src)G4DAEWriteEffects.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAEWriteEffects_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAEWriteEffects_cppflags) $(G4DAEWriteEffects_cc_cppflags)  $(src)G4DAEWriteEffects.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),G4DAEclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4DAERead.d

$(bin)$(binobj)G4DAERead.d :

$(bin)$(binobj)G4DAERead.o : $(cmt_final_setup_G4DAE)

$(bin)$(binobj)G4DAERead.o : $(src)G4DAERead.cc
	$(cpp_echo) $(src)G4DAERead.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAERead_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAERead_cppflags) $(G4DAERead_cc_cppflags)  $(src)G4DAERead.cc
endif
endif

else
$(bin)G4DAE_dependencies.make : $(G4DAERead_cc_dependencies)

$(bin)G4DAE_dependencies.make : $(src)G4DAERead.cc

$(bin)$(binobj)G4DAERead.o : $(G4DAERead_cc_dependencies)
	$(cpp_echo) $(src)G4DAERead.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(G4DAE_pp_cppflags) $(lib_G4DAE_pp_cppflags) $(G4DAERead_pp_cppflags) $(use_cppflags) $(G4DAE_cppflags) $(lib_G4DAE_cppflags) $(G4DAERead_cppflags) $(G4DAERead_cc_cppflags)  $(src)G4DAERead.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: G4DAEclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(G4DAE.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

G4DAEclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library G4DAE
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)G4DAE$(library_suffix).a $(library_prefix)G4DAE$(library_suffix).$(shlibsuffix) G4DAE.stamp G4DAE.shstamp
#-- end of cleanup_library ---------------

#-- start of make_header -----------------

#====================================
#  Library Geometry
#
#   Generated Fri Jul 10 19:15:23 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Geometry_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Geometry_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Geometry

Geometry_tag = $(tag)

#cmt_local_tagfile_Geometry = $(Geometry_tag)_Geometry.make
cmt_local_tagfile_Geometry = $(bin)$(Geometry_tag)_Geometry.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Geometry_tag = $(tag)

#cmt_local_tagfile_Geometry = $(Geometry_tag).make
cmt_local_tagfile_Geometry = $(bin)$(Geometry_tag).make

endif

include $(cmt_local_tagfile_Geometry)
#-include $(cmt_local_tagfile_Geometry)

ifdef cmt_Geometry_has_target_tag

cmt_final_setup_Geometry = $(bin)setup_Geometry.make
cmt_dependencies_in_Geometry = $(bin)dependencies_Geometry.in
#cmt_final_setup_Geometry = $(bin)Geometry_Geometrysetup.make
cmt_local_Geometry_makefile = $(bin)Geometry.make

else

cmt_final_setup_Geometry = $(bin)setup.make
cmt_dependencies_in_Geometry = $(bin)dependencies.in
#cmt_final_setup_Geometry = $(bin)Geometrysetup.make
cmt_local_Geometry_makefile = $(bin)Geometry.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Geometrysetup.make

#Geometry :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'Geometry'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Geometry/
#Geometry::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

Geometrylibname   = $(bin)$(library_prefix)Geometry$(library_suffix)
Geometrylib       = $(Geometrylibname).a
Geometrystamp     = $(bin)Geometry.stamp
Geometryshstamp   = $(bin)Geometry.shstamp

Geometry :: dirs  GeometryLIB
	$(echo) "Geometry ok"

cmt_Geometry_has_prototypes = 1

#--------------------------------------

ifdef cmt_Geometry_has_prototypes

Geometryprototype :  ;

endif

Geometrycompile : $(bin)PmtGeom.o $(bin)CdGeom.o $(bin)TtGeom.o $(bin)GeoUtil.o $(bin)RecGeomSvc.o $(bin)TTGeomSvc.o $(bin)PMTParamSvc.o $(bin)WpGeom.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

GeometryLIB :: $(Geometrylib) $(Geometryshstamp)
	$(echo) "Geometry : library ok"

$(Geometrylib) :: $(bin)PmtGeom.o $(bin)CdGeom.o $(bin)TtGeom.o $(bin)GeoUtil.o $(bin)RecGeomSvc.o $(bin)TTGeomSvc.o $(bin)PMTParamSvc.o $(bin)WpGeom.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(Geometrylib) $(bin)PmtGeom.o $(bin)CdGeom.o $(bin)TtGeom.o $(bin)GeoUtil.o $(bin)RecGeomSvc.o $(bin)TTGeomSvc.o $(bin)PMTParamSvc.o $(bin)WpGeom.o
	$(lib_silent) $(ranlib) $(Geometrylib)
	$(lib_silent) cat /dev/null >$(Geometrystamp)

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

$(Geometrylibname).$(shlibsuffix) :: $(Geometrylib) requirements $(use_requirements) $(Geometrystamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" Geometry $(Geometry_shlibflags)
	$(lib_silent) cat /dev/null >$(Geometryshstamp)

$(Geometryshstamp) :: $(Geometrylibname).$(shlibsuffix)
	$(lib_silent) if test -f $(Geometrylibname).$(shlibsuffix) ; then cat /dev/null >$(Geometryshstamp) ; fi

Geometryclean ::
	$(cleanup_echo) objects Geometry
	$(cleanup_silent) /bin/rm -f $(bin)PmtGeom.o $(bin)CdGeom.o $(bin)TtGeom.o $(bin)GeoUtil.o $(bin)RecGeomSvc.o $(bin)TTGeomSvc.o $(bin)PMTParamSvc.o $(bin)WpGeom.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PmtGeom.o $(bin)CdGeom.o $(bin)TtGeom.o $(bin)GeoUtil.o $(bin)RecGeomSvc.o $(bin)TTGeomSvc.o $(bin)PMTParamSvc.o $(bin)WpGeom.o) $(patsubst %.o,%.dep,$(bin)PmtGeom.o $(bin)CdGeom.o $(bin)TtGeom.o $(bin)GeoUtil.o $(bin)RecGeomSvc.o $(bin)TTGeomSvc.o $(bin)PMTParamSvc.o $(bin)WpGeom.o) $(patsubst %.o,%.d.stamp,$(bin)PmtGeom.o $(bin)CdGeom.o $(bin)TtGeom.o $(bin)GeoUtil.o $(bin)RecGeomSvc.o $(bin)TTGeomSvc.o $(bin)PMTParamSvc.o $(bin)WpGeom.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf Geometry_deps Geometry_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
Geometryinstallname = $(library_prefix)Geometry$(library_suffix).$(shlibsuffix)

Geometry :: Geometryinstall ;

install :: Geometryinstall ;

Geometryinstall :: $(install_dir)/$(Geometryinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(Geometryinstallname) :: $(bin)$(Geometryinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Geometryinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##Geometryclean :: Geometryuninstall

uninstall :: Geometryuninstall ;

Geometryuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Geometryinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),Geometryclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),Geometryprototype)

$(bin)Geometry_dependencies.make : $(use_requirements) $(cmt_final_setup_Geometry)
	$(echo) "(Geometry.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)PmtGeom.cc $(src)CdGeom.cc $(src)TtGeom.cc $(src)GeoUtil.cc $(src)RecGeomSvc.cc $(src)TTGeomSvc.cc $(src)PMTParamSvc.cc $(src)WpGeom.cc -end_all $(includes) $(app_Geometry_cppflags) $(lib_Geometry_cppflags) -name=Geometry $? -f=$(cmt_dependencies_in_Geometry) -without_cmt

-include $(bin)Geometry_dependencies.make

endif
endif
endif

Geometryclean ::
	$(cleanup_silent) \rm -rf $(bin)Geometry_deps $(bin)Geometry_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Geometryclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PmtGeom.d

$(bin)$(binobj)PmtGeom.d :

$(bin)$(binobj)PmtGeom.o : $(cmt_final_setup_Geometry)

$(bin)$(binobj)PmtGeom.o : $(src)PmtGeom.cc
	$(cpp_echo) $(src)PmtGeom.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(PmtGeom_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(PmtGeom_cppflags) $(PmtGeom_cc_cppflags)  $(src)PmtGeom.cc
endif
endif

else
$(bin)Geometry_dependencies.make : $(PmtGeom_cc_dependencies)

$(bin)Geometry_dependencies.make : $(src)PmtGeom.cc

$(bin)$(binobj)PmtGeom.o : $(PmtGeom_cc_dependencies)
	$(cpp_echo) $(src)PmtGeom.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(PmtGeom_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(PmtGeom_cppflags) $(PmtGeom_cc_cppflags)  $(src)PmtGeom.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Geometryclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CdGeom.d

$(bin)$(binobj)CdGeom.d :

$(bin)$(binobj)CdGeom.o : $(cmt_final_setup_Geometry)

$(bin)$(binobj)CdGeom.o : $(src)CdGeom.cc
	$(cpp_echo) $(src)CdGeom.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(CdGeom_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(CdGeom_cppflags) $(CdGeom_cc_cppflags)  $(src)CdGeom.cc
endif
endif

else
$(bin)Geometry_dependencies.make : $(CdGeom_cc_dependencies)

$(bin)Geometry_dependencies.make : $(src)CdGeom.cc

$(bin)$(binobj)CdGeom.o : $(CdGeom_cc_dependencies)
	$(cpp_echo) $(src)CdGeom.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(CdGeom_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(CdGeom_cppflags) $(CdGeom_cc_cppflags)  $(src)CdGeom.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Geometryclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TtGeom.d

$(bin)$(binobj)TtGeom.d :

$(bin)$(binobj)TtGeom.o : $(cmt_final_setup_Geometry)

$(bin)$(binobj)TtGeom.o : $(src)TtGeom.cc
	$(cpp_echo) $(src)TtGeom.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(TtGeom_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(TtGeom_cppflags) $(TtGeom_cc_cppflags)  $(src)TtGeom.cc
endif
endif

else
$(bin)Geometry_dependencies.make : $(TtGeom_cc_dependencies)

$(bin)Geometry_dependencies.make : $(src)TtGeom.cc

$(bin)$(binobj)TtGeom.o : $(TtGeom_cc_dependencies)
	$(cpp_echo) $(src)TtGeom.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(TtGeom_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(TtGeom_cppflags) $(TtGeom_cc_cppflags)  $(src)TtGeom.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Geometryclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GeoUtil.d

$(bin)$(binobj)GeoUtil.d :

$(bin)$(binobj)GeoUtil.o : $(cmt_final_setup_Geometry)

$(bin)$(binobj)GeoUtil.o : $(src)GeoUtil.cc
	$(cpp_echo) $(src)GeoUtil.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(GeoUtil_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(GeoUtil_cppflags) $(GeoUtil_cc_cppflags)  $(src)GeoUtil.cc
endif
endif

else
$(bin)Geometry_dependencies.make : $(GeoUtil_cc_dependencies)

$(bin)Geometry_dependencies.make : $(src)GeoUtil.cc

$(bin)$(binobj)GeoUtil.o : $(GeoUtil_cc_dependencies)
	$(cpp_echo) $(src)GeoUtil.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(GeoUtil_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(GeoUtil_cppflags) $(GeoUtil_cc_cppflags)  $(src)GeoUtil.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Geometryclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecGeomSvc.d

$(bin)$(binobj)RecGeomSvc.d :

$(bin)$(binobj)RecGeomSvc.o : $(cmt_final_setup_Geometry)

$(bin)$(binobj)RecGeomSvc.o : $(src)RecGeomSvc.cc
	$(cpp_echo) $(src)RecGeomSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(RecGeomSvc_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(RecGeomSvc_cppflags) $(RecGeomSvc_cc_cppflags)  $(src)RecGeomSvc.cc
endif
endif

else
$(bin)Geometry_dependencies.make : $(RecGeomSvc_cc_dependencies)

$(bin)Geometry_dependencies.make : $(src)RecGeomSvc.cc

$(bin)$(binobj)RecGeomSvc.o : $(RecGeomSvc_cc_dependencies)
	$(cpp_echo) $(src)RecGeomSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(RecGeomSvc_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(RecGeomSvc_cppflags) $(RecGeomSvc_cc_cppflags)  $(src)RecGeomSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Geometryclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TTGeomSvc.d

$(bin)$(binobj)TTGeomSvc.d :

$(bin)$(binobj)TTGeomSvc.o : $(cmt_final_setup_Geometry)

$(bin)$(binobj)TTGeomSvc.o : $(src)TTGeomSvc.cc
	$(cpp_echo) $(src)TTGeomSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(TTGeomSvc_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(TTGeomSvc_cppflags) $(TTGeomSvc_cc_cppflags)  $(src)TTGeomSvc.cc
endif
endif

else
$(bin)Geometry_dependencies.make : $(TTGeomSvc_cc_dependencies)

$(bin)Geometry_dependencies.make : $(src)TTGeomSvc.cc

$(bin)$(binobj)TTGeomSvc.o : $(TTGeomSvc_cc_dependencies)
	$(cpp_echo) $(src)TTGeomSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(TTGeomSvc_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(TTGeomSvc_cppflags) $(TTGeomSvc_cc_cppflags)  $(src)TTGeomSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Geometryclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PMTParamSvc.d

$(bin)$(binobj)PMTParamSvc.d :

$(bin)$(binobj)PMTParamSvc.o : $(cmt_final_setup_Geometry)

$(bin)$(binobj)PMTParamSvc.o : $(src)PMTParamSvc.cc
	$(cpp_echo) $(src)PMTParamSvc.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(PMTParamSvc_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(PMTParamSvc_cppflags) $(PMTParamSvc_cc_cppflags)  $(src)PMTParamSvc.cc
endif
endif

else
$(bin)Geometry_dependencies.make : $(PMTParamSvc_cc_dependencies)

$(bin)Geometry_dependencies.make : $(src)PMTParamSvc.cc

$(bin)$(binobj)PMTParamSvc.o : $(PMTParamSvc_cc_dependencies)
	$(cpp_echo) $(src)PMTParamSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(PMTParamSvc_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(PMTParamSvc_cppflags) $(PMTParamSvc_cc_cppflags)  $(src)PMTParamSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),Geometryclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)WpGeom.d

$(bin)$(binobj)WpGeom.d :

$(bin)$(binobj)WpGeom.o : $(cmt_final_setup_Geometry)

$(bin)$(binobj)WpGeom.o : $(src)WpGeom.cc
	$(cpp_echo) $(src)WpGeom.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(WpGeom_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(WpGeom_cppflags) $(WpGeom_cc_cppflags)  $(src)WpGeom.cc
endif
endif

else
$(bin)Geometry_dependencies.make : $(WpGeom_cc_dependencies)

$(bin)Geometry_dependencies.make : $(src)WpGeom.cc

$(bin)$(binobj)WpGeom.o : $(WpGeom_cc_dependencies)
	$(cpp_echo) $(src)WpGeom.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Geometry_pp_cppflags) $(lib_Geometry_pp_cppflags) $(WpGeom_pp_cppflags) $(use_cppflags) $(Geometry_cppflags) $(lib_Geometry_cppflags) $(WpGeom_cppflags) $(WpGeom_cc_cppflags)  $(src)WpGeom.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: Geometryclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Geometry.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

Geometryclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library Geometry
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)Geometry$(library_suffix).a $(library_prefix)Geometry$(library_suffix).$(shlibsuffix) Geometry.stamp Geometry.shstamp
#-- end of cleanup_library ---------------

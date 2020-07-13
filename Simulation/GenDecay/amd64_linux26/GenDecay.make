#-- start of make_header -----------------

#====================================
#  Library GenDecay
#
#   Generated Fri Jul 10 19:26:37 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GenDecay_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GenDecay_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GenDecay

GenDecay_tag = $(tag)

#cmt_local_tagfile_GenDecay = $(GenDecay_tag)_GenDecay.make
cmt_local_tagfile_GenDecay = $(bin)$(GenDecay_tag)_GenDecay.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GenDecay_tag = $(tag)

#cmt_local_tagfile_GenDecay = $(GenDecay_tag).make
cmt_local_tagfile_GenDecay = $(bin)$(GenDecay_tag).make

endif

include $(cmt_local_tagfile_GenDecay)
#-include $(cmt_local_tagfile_GenDecay)

ifdef cmt_GenDecay_has_target_tag

cmt_final_setup_GenDecay = $(bin)setup_GenDecay.make
cmt_dependencies_in_GenDecay = $(bin)dependencies_GenDecay.in
#cmt_final_setup_GenDecay = $(bin)GenDecay_GenDecaysetup.make
cmt_local_GenDecay_makefile = $(bin)GenDecay.make

else

cmt_final_setup_GenDecay = $(bin)setup.make
cmt_dependencies_in_GenDecay = $(bin)dependencies.in
#cmt_final_setup_GenDecay = $(bin)GenDecaysetup.make
cmt_local_GenDecay_makefile = $(bin)GenDecay.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GenDecaysetup.make

#GenDecay :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GenDecay'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GenDecay/
#GenDecay::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GenDecaylibname   = $(bin)$(library_prefix)GenDecay$(library_suffix)
GenDecaylib       = $(GenDecaylibname).a
GenDecaystamp     = $(bin)GenDecay.stamp
GenDecayshstamp   = $(bin)GenDecay.shstamp

GenDecay :: dirs  GenDecayLIB
	$(echo) "GenDecay ok"

cmt_GenDecay_has_prototypes = 1

#--------------------------------------

ifdef cmt_GenDecay_has_prototypes

GenDecayprototype :  ;

endif

GenDecaycompile : $(bin)NucState.o $(bin)DecayRates.o $(bin)NucUtil.o $(bin)Radiation.o $(bin)GtDecayerator.o $(bin)NucDecay.o $(bin)NucVisitor.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

GenDecayLIB :: $(GenDecaylib) $(GenDecayshstamp)
	$(echo) "GenDecay : library ok"

$(GenDecaylib) :: $(bin)NucState.o $(bin)DecayRates.o $(bin)NucUtil.o $(bin)Radiation.o $(bin)GtDecayerator.o $(bin)NucDecay.o $(bin)NucVisitor.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(GenDecaylib) $(bin)NucState.o $(bin)DecayRates.o $(bin)NucUtil.o $(bin)Radiation.o $(bin)GtDecayerator.o $(bin)NucDecay.o $(bin)NucVisitor.o
	$(lib_silent) $(ranlib) $(GenDecaylib)
	$(lib_silent) cat /dev/null >$(GenDecaystamp)

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

$(GenDecaylibname).$(shlibsuffix) :: $(GenDecaylib) requirements $(use_requirements) $(GenDecaystamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" GenDecay $(GenDecay_shlibflags)
	$(lib_silent) cat /dev/null >$(GenDecayshstamp)

$(GenDecayshstamp) :: $(GenDecaylibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GenDecaylibname).$(shlibsuffix) ; then cat /dev/null >$(GenDecayshstamp) ; fi

GenDecayclean ::
	$(cleanup_echo) objects GenDecay
	$(cleanup_silent) /bin/rm -f $(bin)NucState.o $(bin)DecayRates.o $(bin)NucUtil.o $(bin)Radiation.o $(bin)GtDecayerator.o $(bin)NucDecay.o $(bin)NucVisitor.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)NucState.o $(bin)DecayRates.o $(bin)NucUtil.o $(bin)Radiation.o $(bin)GtDecayerator.o $(bin)NucDecay.o $(bin)NucVisitor.o) $(patsubst %.o,%.dep,$(bin)NucState.o $(bin)DecayRates.o $(bin)NucUtil.o $(bin)Radiation.o $(bin)GtDecayerator.o $(bin)NucDecay.o $(bin)NucVisitor.o) $(patsubst %.o,%.d.stamp,$(bin)NucState.o $(bin)DecayRates.o $(bin)NucUtil.o $(bin)Radiation.o $(bin)GtDecayerator.o $(bin)NucDecay.o $(bin)NucVisitor.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GenDecay_deps GenDecay_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GenDecayinstallname = $(library_prefix)GenDecay$(library_suffix).$(shlibsuffix)

GenDecay :: GenDecayinstall ;

install :: GenDecayinstall ;

GenDecayinstall :: $(install_dir)/$(GenDecayinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GenDecayinstallname) :: $(bin)$(GenDecayinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GenDecayinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GenDecayclean :: GenDecayuninstall

uninstall :: GenDecayuninstall ;

GenDecayuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GenDecayinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),GenDecayclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),GenDecayprototype)

$(bin)GenDecay_dependencies.make : $(use_requirements) $(cmt_final_setup_GenDecay)
	$(echo) "(GenDecay.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)NucState.cpp $(src)DecayRates.cpp $(src)NucUtil.cpp $(src)Radiation.cpp $(src)GtDecayerator.cpp $(src)NucDecay.cpp $(src)NucVisitor.cpp -end_all $(includes) $(app_GenDecay_cppflags) $(lib_GenDecay_cppflags) -name=GenDecay $? -f=$(cmt_dependencies_in_GenDecay) -without_cmt

-include $(bin)GenDecay_dependencies.make

endif
endif
endif

GenDecayclean ::
	$(cleanup_silent) \rm -rf $(bin)GenDecay_deps $(bin)GenDecay_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenDecayclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NucState.d

$(bin)$(binobj)NucState.d :

$(bin)$(binobj)NucState.o : $(cmt_final_setup_GenDecay)

$(bin)$(binobj)NucState.o : $(src)NucState.cpp
	$(cpp_echo) $(src)NucState.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(NucState_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(NucState_cppflags) $(NucState_cpp_cppflags)  $(src)NucState.cpp
endif
endif

else
$(bin)GenDecay_dependencies.make : $(NucState_cpp_dependencies)

$(bin)GenDecay_dependencies.make : $(src)NucState.cpp

$(bin)$(binobj)NucState.o : $(NucState_cpp_dependencies)
	$(cpp_echo) $(src)NucState.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(NucState_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(NucState_cppflags) $(NucState_cpp_cppflags)  $(src)NucState.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenDecayclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DecayRates.d

$(bin)$(binobj)DecayRates.d :

$(bin)$(binobj)DecayRates.o : $(cmt_final_setup_GenDecay)

$(bin)$(binobj)DecayRates.o : $(src)DecayRates.cpp
	$(cpp_echo) $(src)DecayRates.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(DecayRates_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(DecayRates_cppflags) $(DecayRates_cpp_cppflags)  $(src)DecayRates.cpp
endif
endif

else
$(bin)GenDecay_dependencies.make : $(DecayRates_cpp_dependencies)

$(bin)GenDecay_dependencies.make : $(src)DecayRates.cpp

$(bin)$(binobj)DecayRates.o : $(DecayRates_cpp_dependencies)
	$(cpp_echo) $(src)DecayRates.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(DecayRates_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(DecayRates_cppflags) $(DecayRates_cpp_cppflags)  $(src)DecayRates.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenDecayclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NucUtil.d

$(bin)$(binobj)NucUtil.d :

$(bin)$(binobj)NucUtil.o : $(cmt_final_setup_GenDecay)

$(bin)$(binobj)NucUtil.o : $(src)NucUtil.cpp
	$(cpp_echo) $(src)NucUtil.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(NucUtil_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(NucUtil_cppflags) $(NucUtil_cpp_cppflags)  $(src)NucUtil.cpp
endif
endif

else
$(bin)GenDecay_dependencies.make : $(NucUtil_cpp_dependencies)

$(bin)GenDecay_dependencies.make : $(src)NucUtil.cpp

$(bin)$(binobj)NucUtil.o : $(NucUtil_cpp_dependencies)
	$(cpp_echo) $(src)NucUtil.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(NucUtil_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(NucUtil_cppflags) $(NucUtil_cpp_cppflags)  $(src)NucUtil.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenDecayclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Radiation.d

$(bin)$(binobj)Radiation.d :

$(bin)$(binobj)Radiation.o : $(cmt_final_setup_GenDecay)

$(bin)$(binobj)Radiation.o : $(src)Radiation.cpp
	$(cpp_echo) $(src)Radiation.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(Radiation_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(Radiation_cppflags) $(Radiation_cpp_cppflags)  $(src)Radiation.cpp
endif
endif

else
$(bin)GenDecay_dependencies.make : $(Radiation_cpp_dependencies)

$(bin)GenDecay_dependencies.make : $(src)Radiation.cpp

$(bin)$(binobj)Radiation.o : $(Radiation_cpp_dependencies)
	$(cpp_echo) $(src)Radiation.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(Radiation_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(Radiation_cppflags) $(Radiation_cpp_cppflags)  $(src)Radiation.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenDecayclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GtDecayerator.d

$(bin)$(binobj)GtDecayerator.d :

$(bin)$(binobj)GtDecayerator.o : $(cmt_final_setup_GenDecay)

$(bin)$(binobj)GtDecayerator.o : $(src)GtDecayerator.cpp
	$(cpp_echo) $(src)GtDecayerator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(GtDecayerator_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(GtDecayerator_cppflags) $(GtDecayerator_cpp_cppflags)  $(src)GtDecayerator.cpp
endif
endif

else
$(bin)GenDecay_dependencies.make : $(GtDecayerator_cpp_dependencies)

$(bin)GenDecay_dependencies.make : $(src)GtDecayerator.cpp

$(bin)$(binobj)GtDecayerator.o : $(GtDecayerator_cpp_dependencies)
	$(cpp_echo) $(src)GtDecayerator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(GtDecayerator_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(GtDecayerator_cppflags) $(GtDecayerator_cpp_cppflags)  $(src)GtDecayerator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenDecayclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NucDecay.d

$(bin)$(binobj)NucDecay.d :

$(bin)$(binobj)NucDecay.o : $(cmt_final_setup_GenDecay)

$(bin)$(binobj)NucDecay.o : $(src)NucDecay.cpp
	$(cpp_echo) $(src)NucDecay.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(NucDecay_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(NucDecay_cppflags) $(NucDecay_cpp_cppflags)  $(src)NucDecay.cpp
endif
endif

else
$(bin)GenDecay_dependencies.make : $(NucDecay_cpp_dependencies)

$(bin)GenDecay_dependencies.make : $(src)NucDecay.cpp

$(bin)$(binobj)NucDecay.o : $(NucDecay_cpp_dependencies)
	$(cpp_echo) $(src)NucDecay.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(NucDecay_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(NucDecay_cppflags) $(NucDecay_cpp_cppflags)  $(src)NucDecay.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),GenDecayclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NucVisitor.d

$(bin)$(binobj)NucVisitor.d :

$(bin)$(binobj)NucVisitor.o : $(cmt_final_setup_GenDecay)

$(bin)$(binobj)NucVisitor.o : $(src)NucVisitor.cpp
	$(cpp_echo) $(src)NucVisitor.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(NucVisitor_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(NucVisitor_cppflags) $(NucVisitor_cpp_cppflags)  $(src)NucVisitor.cpp
endif
endif

else
$(bin)GenDecay_dependencies.make : $(NucVisitor_cpp_dependencies)

$(bin)GenDecay_dependencies.make : $(src)NucVisitor.cpp

$(bin)$(binobj)NucVisitor.o : $(NucVisitor_cpp_dependencies)
	$(cpp_echo) $(src)NucVisitor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GenDecay_pp_cppflags) $(lib_GenDecay_pp_cppflags) $(NucVisitor_pp_cppflags) $(use_cppflags) $(GenDecay_cppflags) $(lib_GenDecay_cppflags) $(NucVisitor_cppflags) $(NucVisitor_cpp_cppflags)  $(src)NucVisitor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GenDecayclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GenDecay.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GenDecayclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GenDecay
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GenDecay$(library_suffix).a $(library_prefix)GenDecay$(library_suffix).$(shlibsuffix) GenDecay.stamp GenDecay.shstamp
#-- end of cleanup_library ---------------

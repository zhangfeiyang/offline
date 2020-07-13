#-- start of make_header -----------------

#====================================
#  Application test_ElecData_CircularBuffer
#
#   Generated Fri Jul 10 19:22:55 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_test_ElecData_CircularBuffer_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_test_ElecData_CircularBuffer_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_test_ElecData_CircularBuffer

ElecDataStruct_tag = $(tag)

#cmt_local_tagfile_test_ElecData_CircularBuffer = $(ElecDataStruct_tag)_test_ElecData_CircularBuffer.make
cmt_local_tagfile_test_ElecData_CircularBuffer = $(bin)$(ElecDataStruct_tag)_test_ElecData_CircularBuffer.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ElecDataStruct_tag = $(tag)

#cmt_local_tagfile_test_ElecData_CircularBuffer = $(ElecDataStruct_tag).make
cmt_local_tagfile_test_ElecData_CircularBuffer = $(bin)$(ElecDataStruct_tag).make

endif

include $(cmt_local_tagfile_test_ElecData_CircularBuffer)
#-include $(cmt_local_tagfile_test_ElecData_CircularBuffer)

ifdef cmt_test_ElecData_CircularBuffer_has_target_tag

cmt_final_setup_test_ElecData_CircularBuffer = $(bin)setup_test_ElecData_CircularBuffer.make
cmt_dependencies_in_test_ElecData_CircularBuffer = $(bin)dependencies_test_ElecData_CircularBuffer.in
#cmt_final_setup_test_ElecData_CircularBuffer = $(bin)ElecDataStruct_test_ElecData_CircularBuffersetup.make
cmt_local_test_ElecData_CircularBuffer_makefile = $(bin)test_ElecData_CircularBuffer.make

else

cmt_final_setup_test_ElecData_CircularBuffer = $(bin)setup.make
cmt_dependencies_in_test_ElecData_CircularBuffer = $(bin)dependencies.in
#cmt_final_setup_test_ElecData_CircularBuffer = $(bin)ElecDataStructsetup.make
cmt_local_test_ElecData_CircularBuffer_makefile = $(bin)test_ElecData_CircularBuffer.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ElecDataStructsetup.make

#test_ElecData_CircularBuffer :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'test_ElecData_CircularBuffer'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = test_ElecData_CircularBuffer/
#test_ElecData_CircularBuffer::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

test_ElecData_CircularBuffer :: dirs  $(bin)test_ElecData_CircularBuffer${application_suffix}
	$(echo) "test_ElecData_CircularBuffer ok"

cmt_test_ElecData_CircularBuffer_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_ElecData_CircularBuffer_has_prototypes

test_ElecData_CircularBufferprototype :  ;

endif

test_ElecData_CircularBuffercompile : $(bin)test_CircularBuffer.o ;

#-- end of application_header
#-- start of application

$(bin)test_ElecData_CircularBuffer${application_suffix} :: $(bin)test_CircularBuffer.o $(use_stamps) $(test_ElecData_CircularBuffer_stamps) $(test_ElecData_CircularBufferstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)test_CircularBuffer.o $(cmt_installarea_linkopts) $(test_ElecData_CircularBuffer_use_linkopts) $(test_ElecData_CircularBufferlinkopts) && mv -f $(@).new $(@)

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
test_ElecData_CircularBufferinstallname = test_ElecData_CircularBuffer${application_suffix}

test_ElecData_CircularBuffer :: test_ElecData_CircularBufferinstall ;

install :: test_ElecData_CircularBufferinstall ;

test_ElecData_CircularBufferinstall :: $(install_dir)/$(test_ElecData_CircularBufferinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(test_ElecData_CircularBufferinstallname) :: $(bin)$(test_ElecData_CircularBufferinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(test_ElecData_CircularBufferinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##test_ElecData_CircularBufferclean :: test_ElecData_CircularBufferuninstall

uninstall :: test_ElecData_CircularBufferuninstall ;

test_ElecData_CircularBufferuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(test_ElecData_CircularBufferinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (test_ElecData_CircularBuffer.make) Removing installed files"
#-- end of application
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),test_ElecData_CircularBufferclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),test_ElecData_CircularBufferprototype)

$(bin)test_ElecData_CircularBuffer_dependencies.make : $(use_requirements) $(cmt_final_setup_test_ElecData_CircularBuffer)
	$(echo) "(test_ElecData_CircularBuffer.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all ../test/test_CircularBuffer.cc -end_all $(includes) $(app_test_ElecData_CircularBuffer_cppflags) $(lib_test_ElecData_CircularBuffer_cppflags) -name=test_ElecData_CircularBuffer $? -f=$(cmt_dependencies_in_test_ElecData_CircularBuffer) -without_cmt

-include $(bin)test_ElecData_CircularBuffer_dependencies.make

endif
endif
endif

test_ElecData_CircularBufferclean ::
	$(cleanup_silent) \rm -rf $(bin)test_ElecData_CircularBuffer_deps $(bin)test_ElecData_CircularBuffer_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp ------

ifneq (,)

ifneq ($(MAKECMDGOALS),test_ElecData_CircularBufferclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)test_CircularBuffer.d

$(bin)$(binobj)test_CircularBuffer.d :

$(bin)$(binobj)test_CircularBuffer.o : $(cmt_final_setup_test_ElecData_CircularBuffer)

$(bin)$(binobj)test_CircularBuffer.o : ../test/test_CircularBuffer.cc
	$(cpp_echo) ../test/test_CircularBuffer.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(test_ElecData_CircularBuffer_pp_cppflags) $(app_test_ElecData_CircularBuffer_pp_cppflags) $(test_CircularBuffer_pp_cppflags) $(use_cppflags) $(test_ElecData_CircularBuffer_cppflags) $(app_test_ElecData_CircularBuffer_cppflags) $(test_CircularBuffer_cppflags) $(test_CircularBuffer_cc_cppflags) -I../test ../test/test_CircularBuffer.cc
endif
endif

else
$(bin)test_ElecData_CircularBuffer_dependencies.make : $(test_CircularBuffer_cc_dependencies)

$(bin)test_ElecData_CircularBuffer_dependencies.make : ../test/test_CircularBuffer.cc

$(bin)$(binobj)test_CircularBuffer.o : $(test_CircularBuffer_cc_dependencies)
	$(cpp_echo) ../test/test_CircularBuffer.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(test_ElecData_CircularBuffer_pp_cppflags) $(app_test_ElecData_CircularBuffer_pp_cppflags) $(test_CircularBuffer_pp_cppflags) $(use_cppflags) $(test_ElecData_CircularBuffer_cppflags) $(app_test_ElecData_CircularBuffer_cppflags) $(test_CircularBuffer_cppflags) $(test_CircularBuffer_cc_cppflags) -I../test ../test/test_CircularBuffer.cc

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: test_ElecData_CircularBufferclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(test_ElecData_CircularBuffer.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

test_ElecData_CircularBufferclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application test_ElecData_CircularBuffer
	-$(cleanup_silent) cd $(bin); /bin/rm -f test_ElecData_CircularBuffer${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects test_ElecData_CircularBuffer
	-$(cleanup_silent) /bin/rm -f $(bin)test_CircularBuffer.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)test_CircularBuffer.o) $(patsubst %.o,%.dep,$(bin)test_CircularBuffer.o) $(patsubst %.o,%.d.stamp,$(bin)test_CircularBuffer.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf test_ElecData_CircularBuffer_deps test_ElecData_CircularBuffer_dependencies.make
#-- end of cleanup_objects ------

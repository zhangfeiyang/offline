#-- start of make_header -----------------

#====================================
#  Document CalibEventxodsrc
#
#   Generated Fri Jul 10 19:18:49 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_CalibEventxodsrc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_CalibEventxodsrc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_CalibEventxodsrc

CalibEvent_tag = $(tag)

#cmt_local_tagfile_CalibEventxodsrc = $(CalibEvent_tag)_CalibEventxodsrc.make
cmt_local_tagfile_CalibEventxodsrc = $(bin)$(CalibEvent_tag)_CalibEventxodsrc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CalibEvent_tag = $(tag)

#cmt_local_tagfile_CalibEventxodsrc = $(CalibEvent_tag).make
cmt_local_tagfile_CalibEventxodsrc = $(bin)$(CalibEvent_tag).make

endif

include $(cmt_local_tagfile_CalibEventxodsrc)
#-include $(cmt_local_tagfile_CalibEventxodsrc)

ifdef cmt_CalibEventxodsrc_has_target_tag

cmt_final_setup_CalibEventxodsrc = $(bin)setup_CalibEventxodsrc.make
cmt_dependencies_in_CalibEventxodsrc = $(bin)dependencies_CalibEventxodsrc.in
#cmt_final_setup_CalibEventxodsrc = $(bin)CalibEvent_CalibEventxodsrcsetup.make
cmt_local_CalibEventxodsrc_makefile = $(bin)CalibEventxodsrc.make

else

cmt_final_setup_CalibEventxodsrc = $(bin)setup.make
cmt_dependencies_in_CalibEventxodsrc = $(bin)dependencies.in
#cmt_final_setup_CalibEventxodsrc = $(bin)CalibEventsetup.make
cmt_local_CalibEventxodsrc_makefile = $(bin)CalibEventxodsrc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CalibEventsetup.make

#CalibEventxodsrc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'CalibEventxodsrc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = CalibEventxodsrc/
#CalibEventxodsrc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
pythonexe     = python
parsetool     = $(XMLOBJDESCROOT)/scripts/genSrc.py
dest          = ../src/

CalibEventxodsrc_cleanuplist =
CalibTTChannel_h_dependencies = ../Event/CalibTTChannel.h
CalibEvent_h_dependencies = ../Event/CalibEvent.h
CalibHeader_h_dependencies = ../Event/CalibHeader.h
TTCalibEvent_h_dependencies = ../Event/TTCalibEvent.h
CalibPMTChannel_h_dependencies = ../Event/CalibPMTChannel.h
CalibEventxodsrc :: $(dest)CalibTTChannel.cc

$(dest)CalibTTChannel.cc : ../Event/CalibTTChannel.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/CalibTTChannel.h


CalibEventxodsrc :: $(dest)CalibEvent.cc

$(dest)CalibEvent.cc : ../Event/CalibEvent.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/CalibEvent.h


CalibEventxodsrc :: $(dest)CalibHeader.cc

$(dest)CalibHeader.cc : ../Event/CalibHeader.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/CalibHeader.h


CalibEventxodsrc :: $(dest)TTCalibEvent.cc

$(dest)TTCalibEvent.cc : ../Event/TTCalibEvent.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/TTCalibEvent.h


CalibEventxodsrc :: $(dest)CalibPMTChannel.cc

$(dest)CalibPMTChannel.cc : ../Event/CalibPMTChannel.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/CalibPMTChannel.h


clean :: CalibEventxodsrcclean
	@cd .



CalibEventxodsrcclean ::
	$(cleanup_echo) .cc files:
	-$(cleanup_silent) rm -f $(CalibEventxodsrc_cleanuplist)
#-- start of cleanup_header --------------

clean :: CalibEventxodsrcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(CalibEventxodsrc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

CalibEventxodsrcclean ::
#-- end of cleanup_header ---------------

#-- start of make_header -----------------

#====================================
#  Document RecEventxodsrc
#
#   Generated Fri Jul 10 19:18:55 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RecEventxodsrc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RecEventxodsrc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RecEventxodsrc

RecEvent_tag = $(tag)

#cmt_local_tagfile_RecEventxodsrc = $(RecEvent_tag)_RecEventxodsrc.make
cmt_local_tagfile_RecEventxodsrc = $(bin)$(RecEvent_tag)_RecEventxodsrc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RecEvent_tag = $(tag)

#cmt_local_tagfile_RecEventxodsrc = $(RecEvent_tag).make
cmt_local_tagfile_RecEventxodsrc = $(bin)$(RecEvent_tag).make

endif

include $(cmt_local_tagfile_RecEventxodsrc)
#-include $(cmt_local_tagfile_RecEventxodsrc)

ifdef cmt_RecEventxodsrc_has_target_tag

cmt_final_setup_RecEventxodsrc = $(bin)setup_RecEventxodsrc.make
cmt_dependencies_in_RecEventxodsrc = $(bin)dependencies_RecEventxodsrc.in
#cmt_final_setup_RecEventxodsrc = $(bin)RecEvent_RecEventxodsrcsetup.make
cmt_local_RecEventxodsrc_makefile = $(bin)RecEventxodsrc.make

else

cmt_final_setup_RecEventxodsrc = $(bin)setup.make
cmt_dependencies_in_RecEventxodsrc = $(bin)dependencies.in
#cmt_final_setup_RecEventxodsrc = $(bin)RecEventsetup.make
cmt_local_RecEventxodsrc_makefile = $(bin)RecEventxodsrc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RecEventsetup.make

#RecEventxodsrc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RecEventxodsrc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RecEventxodsrc/
#RecEventxodsrc::
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

RecEventxodsrc_cleanuplist =
TTRecEvent_h_dependencies = ../Event/TTRecEvent.h
WPRecEvent_h_dependencies = ../Event/WPRecEvent.h
RecTrack_h_dependencies = ../Event/RecTrack.h
RecHeader_h_dependencies = ../Event/RecHeader.h
CDRecEvent_h_dependencies = ../Event/CDRecEvent.h
CDTrackRecEvent_h_dependencies = ../Event/CDTrackRecEvent.h
RecEventxodsrc :: $(dest)TTRecEvent.cc

$(dest)TTRecEvent.cc : ../Event/TTRecEvent.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/TTRecEvent.h


RecEventxodsrc :: $(dest)WPRecEvent.cc

$(dest)WPRecEvent.cc : ../Event/WPRecEvent.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/WPRecEvent.h


RecEventxodsrc :: $(dest)RecTrack.cc

$(dest)RecTrack.cc : ../Event/RecTrack.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/RecTrack.h


RecEventxodsrc :: $(dest)RecHeader.cc

$(dest)RecHeader.cc : ../Event/RecHeader.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/RecHeader.h


RecEventxodsrc :: $(dest)CDRecEvent.cc

$(dest)CDRecEvent.cc : ../Event/CDRecEvent.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/CDRecEvent.h


RecEventxodsrc :: $(dest)CDTrackRecEvent.cc

$(dest)CDTrackRecEvent.cc : ../Event/CDTrackRecEvent.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/CDTrackRecEvent.h


clean :: RecEventxodsrcclean
	@cd .



RecEventxodsrcclean ::
	$(cleanup_echo) .cc files:
	-$(cleanup_silent) rm -f $(RecEventxodsrc_cleanuplist)
#-- start of cleanup_header --------------

clean :: RecEventxodsrcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RecEventxodsrc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RecEventxodsrcclean ::
#-- end of cleanup_header ---------------

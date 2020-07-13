#-- start of make_header -----------------

#====================================
#  Document BaseEventxodsrc
#
#   Generated Fri Jul 10 19:17:34 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_BaseEventxodsrc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_BaseEventxodsrc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_BaseEventxodsrc

BaseEvent_tag = $(tag)

#cmt_local_tagfile_BaseEventxodsrc = $(BaseEvent_tag)_BaseEventxodsrc.make
cmt_local_tagfile_BaseEventxodsrc = $(bin)$(BaseEvent_tag)_BaseEventxodsrc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

BaseEvent_tag = $(tag)

#cmt_local_tagfile_BaseEventxodsrc = $(BaseEvent_tag).make
cmt_local_tagfile_BaseEventxodsrc = $(bin)$(BaseEvent_tag).make

endif

include $(cmt_local_tagfile_BaseEventxodsrc)
#-include $(cmt_local_tagfile_BaseEventxodsrc)

ifdef cmt_BaseEventxodsrc_has_target_tag

cmt_final_setup_BaseEventxodsrc = $(bin)setup_BaseEventxodsrc.make
cmt_dependencies_in_BaseEventxodsrc = $(bin)dependencies_BaseEventxodsrc.in
#cmt_final_setup_BaseEventxodsrc = $(bin)BaseEvent_BaseEventxodsrcsetup.make
cmt_local_BaseEventxodsrc_makefile = $(bin)BaseEventxodsrc.make

else

cmt_final_setup_BaseEventxodsrc = $(bin)setup.make
cmt_dependencies_in_BaseEventxodsrc = $(bin)dependencies.in
#cmt_final_setup_BaseEventxodsrc = $(bin)BaseEventsetup.make
cmt_local_BaseEventxodsrc_makefile = $(bin)BaseEventxodsrc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)BaseEventsetup.make

#BaseEventxodsrc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'BaseEventxodsrc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = BaseEventxodsrc/
#BaseEventxodsrc::
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

BaseEventxodsrc_cleanuplist =
HeaderObject_h_dependencies = ../Event/HeaderObject.h
EventObject_h_dependencies = ../Event/EventObject.h
BaseEventxodsrc :: $(dest)HeaderObject.cc

$(dest)HeaderObject.cc : ../Event/HeaderObject.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/HeaderObject.h


BaseEventxodsrc :: $(dest)EventObject.cc

$(dest)EventObject.cc : ../Event/EventObject.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/EventObject.h


clean :: BaseEventxodsrcclean
	@cd .



BaseEventxodsrcclean ::
	$(cleanup_echo) .cc files:
	-$(cleanup_silent) rm -f $(BaseEventxodsrc_cleanuplist)
#-- start of cleanup_header --------------

clean :: BaseEventxodsrcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(BaseEventxodsrc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

BaseEventxodsrcclean ::
#-- end of cleanup_header ---------------

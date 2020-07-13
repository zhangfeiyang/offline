#-- start of make_header -----------------

#====================================
#  Document PhyEventxodsrc
#
#   Generated Fri Jul 10 19:18:44 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PhyEventxodsrc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PhyEventxodsrc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PhyEventxodsrc

PhyEvent_tag = $(tag)

#cmt_local_tagfile_PhyEventxodsrc = $(PhyEvent_tag)_PhyEventxodsrc.make
cmt_local_tagfile_PhyEventxodsrc = $(bin)$(PhyEvent_tag)_PhyEventxodsrc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PhyEvent_tag = $(tag)

#cmt_local_tagfile_PhyEventxodsrc = $(PhyEvent_tag).make
cmt_local_tagfile_PhyEventxodsrc = $(bin)$(PhyEvent_tag).make

endif

include $(cmt_local_tagfile_PhyEventxodsrc)
#-include $(cmt_local_tagfile_PhyEventxodsrc)

ifdef cmt_PhyEventxodsrc_has_target_tag

cmt_final_setup_PhyEventxodsrc = $(bin)setup_PhyEventxodsrc.make
cmt_dependencies_in_PhyEventxodsrc = $(bin)dependencies_PhyEventxodsrc.in
#cmt_final_setup_PhyEventxodsrc = $(bin)PhyEvent_PhyEventxodsrcsetup.make
cmt_local_PhyEventxodsrc_makefile = $(bin)PhyEventxodsrc.make

else

cmt_final_setup_PhyEventxodsrc = $(bin)setup.make
cmt_dependencies_in_PhyEventxodsrc = $(bin)dependencies.in
#cmt_final_setup_PhyEventxodsrc = $(bin)PhyEventsetup.make
cmt_local_PhyEventxodsrc_makefile = $(bin)PhyEventxodsrc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PhyEventsetup.make

#PhyEventxodsrc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PhyEventxodsrc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PhyEventxodsrc/
#PhyEventxodsrc::
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

PhyEventxodsrc_cleanuplist =
PhyEvent_h_dependencies = ../Event/PhyEvent.h
PhyHeader_h_dependencies = ../Event/PhyHeader.h
PhyEventxodsrc :: $(dest)PhyEvent.cc

$(dest)PhyEvent.cc : ../Event/PhyEvent.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/PhyEvent.h


PhyEventxodsrc :: $(dest)PhyHeader.cc

$(dest)PhyHeader.cc : ../Event/PhyHeader.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/PhyHeader.h


clean :: PhyEventxodsrcclean
	@cd .



PhyEventxodsrcclean ::
	$(cleanup_echo) .cc files:
	-$(cleanup_silent) rm -f $(PhyEventxodsrc_cleanuplist)
#-- start of cleanup_header --------------

clean :: PhyEventxodsrcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PhyEventxodsrc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PhyEventxodsrcclean ::
#-- end of cleanup_header ---------------

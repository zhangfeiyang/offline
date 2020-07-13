#-- start of make_header -----------------

#====================================
#  Document ElecEventxodsrc
#
#   Generated Fri Jul 10 19:20:28 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_ElecEventxodsrc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ElecEventxodsrc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ElecEventxodsrc

ElecEvent_tag = $(tag)

#cmt_local_tagfile_ElecEventxodsrc = $(ElecEvent_tag)_ElecEventxodsrc.make
cmt_local_tagfile_ElecEventxodsrc = $(bin)$(ElecEvent_tag)_ElecEventxodsrc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ElecEvent_tag = $(tag)

#cmt_local_tagfile_ElecEventxodsrc = $(ElecEvent_tag).make
cmt_local_tagfile_ElecEventxodsrc = $(bin)$(ElecEvent_tag).make

endif

include $(cmt_local_tagfile_ElecEventxodsrc)
#-include $(cmt_local_tagfile_ElecEventxodsrc)

ifdef cmt_ElecEventxodsrc_has_target_tag

cmt_final_setup_ElecEventxodsrc = $(bin)setup_ElecEventxodsrc.make
cmt_dependencies_in_ElecEventxodsrc = $(bin)dependencies_ElecEventxodsrc.in
#cmt_final_setup_ElecEventxodsrc = $(bin)ElecEvent_ElecEventxodsrcsetup.make
cmt_local_ElecEventxodsrc_makefile = $(bin)ElecEventxodsrc.make

else

cmt_final_setup_ElecEventxodsrc = $(bin)setup.make
cmt_dependencies_in_ElecEventxodsrc = $(bin)dependencies.in
#cmt_final_setup_ElecEventxodsrc = $(bin)ElecEventsetup.make
cmt_local_ElecEventxodsrc_makefile = $(bin)ElecEventxodsrc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ElecEventsetup.make

#ElecEventxodsrc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ElecEventxodsrc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ElecEventxodsrc/
#ElecEventxodsrc::
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

ElecEventxodsrc_cleanuplist =
ElecEvent_h_dependencies = ../Event/ElecEvent.h
SpmtElecAbcBlock_h_dependencies = ../Event/SpmtElecAbcBlock.h
ElecFeeCrate_h_dependencies = ../Event/ElecFeeCrate.h
SpmtElecEvent_h_dependencies = ../Event/SpmtElecEvent.h
ElecFeeChannel_h_dependencies = ../Event/ElecFeeChannel.h
ElecHeader_h_dependencies = ../Event/ElecHeader.h
ElecEventxodsrc :: $(dest)ElecEvent.cc

$(dest)ElecEvent.cc : ../Event/ElecEvent.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/ElecEvent.h


ElecEventxodsrc :: $(dest)SpmtElecAbcBlock.cc

$(dest)SpmtElecAbcBlock.cc : ../Event/SpmtElecAbcBlock.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/SpmtElecAbcBlock.h


ElecEventxodsrc :: $(dest)ElecFeeCrate.cc

$(dest)ElecFeeCrate.cc : ../Event/ElecFeeCrate.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/ElecFeeCrate.h


ElecEventxodsrc :: $(dest)SpmtElecEvent.cc

$(dest)SpmtElecEvent.cc : ../Event/SpmtElecEvent.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/SpmtElecEvent.h


ElecEventxodsrc :: $(dest)ElecFeeChannel.cc

$(dest)ElecFeeChannel.cc : ../Event/ElecFeeChannel.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/ElecFeeChannel.h


ElecEventxodsrc :: $(dest)ElecHeader.cc

$(dest)ElecHeader.cc : ../Event/ElecHeader.h
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) ../Event/ElecHeader.h


clean :: ElecEventxodsrcclean
	@cd .



ElecEventxodsrcclean ::
	$(cleanup_echo) .cc files:
	-$(cleanup_silent) rm -f $(ElecEventxodsrc_cleanuplist)
#-- start of cleanup_header --------------

clean :: ElecEventxodsrcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ElecEventxodsrc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ElecEventxodsrcclean ::
#-- end of cleanup_header ---------------

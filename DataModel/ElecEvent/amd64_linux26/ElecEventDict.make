#-- start of make_header -----------------

#====================================
#  Document ElecEventDict
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

cmt_ElecEventDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ElecEventDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ElecEventDict

ElecEvent_tag = $(tag)

#cmt_local_tagfile_ElecEventDict = $(ElecEvent_tag)_ElecEventDict.make
cmt_local_tagfile_ElecEventDict = $(bin)$(ElecEvent_tag)_ElecEventDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ElecEvent_tag = $(tag)

#cmt_local_tagfile_ElecEventDict = $(ElecEvent_tag).make
cmt_local_tagfile_ElecEventDict = $(bin)$(ElecEvent_tag).make

endif

include $(cmt_local_tagfile_ElecEventDict)
#-include $(cmt_local_tagfile_ElecEventDict)

ifdef cmt_ElecEventDict_has_target_tag

cmt_final_setup_ElecEventDict = $(bin)setup_ElecEventDict.make
cmt_dependencies_in_ElecEventDict = $(bin)dependencies_ElecEventDict.in
#cmt_final_setup_ElecEventDict = $(bin)ElecEvent_ElecEventDictsetup.make
cmt_local_ElecEventDict_makefile = $(bin)ElecEventDict.make

else

cmt_final_setup_ElecEventDict = $(bin)setup.make
cmt_dependencies_in_ElecEventDict = $(bin)dependencies.in
#cmt_final_setup_ElecEventDict = $(bin)ElecEventsetup.make
cmt_local_ElecEventDict_makefile = $(bin)ElecEventDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ElecEventsetup.make

#ElecEventDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ElecEventDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ElecEventDict/
#ElecEventDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
ElecEventDict_output = ${src}
ElecEventDict_dict_lists = 

ElecEventDict :: $(ElecEventDict_output)ElecEvent.rootcint $(ElecEventDict_output)SpmtElecAbcBlock.rootcint $(ElecEventDict_output)ElecFeeCrate.rootcint $(ElecEventDict_output)SpmtElecEvent.rootcint $(ElecEventDict_output)ElecFeeChannel.rootcint $(ElecEventDict_output)ElecHeader.rootcint
	@echo "------> ElecEventDict ok"
ElecEvent_h_dependencies = ../Event/ElecEvent.h
SpmtElecAbcBlock_h_dependencies = ../Event/SpmtElecAbcBlock.h
ElecFeeCrate_h_dependencies = ../Event/ElecFeeCrate.h
SpmtElecEvent_h_dependencies = ../Event/SpmtElecEvent.h
ElecFeeChannel_h_dependencies = ../Event/ElecFeeChannel.h
ElecHeader_h_dependencies = ../Event/ElecHeader.h
${src}ElecEvent.rootcint : ${src}ElecEventDict.cc
	@echo $@

${src}ElecEventDict.cc : ../Event/ElecEvent.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}ElecEventDict.cc -c ${ElecEvent_cintflags} ElecEvent.h $(src)ElecEventLinkDef.h

ElecEventDict_dict_lists += ${src}ElecEventDict.h
ElecEventDict_dict_lists += ${src}ElecEventDict.cc
${src}SpmtElecAbcBlock.rootcint : ${src}SpmtElecAbcBlockDict.cc
	@echo $@

${src}SpmtElecAbcBlockDict.cc : ../Event/SpmtElecAbcBlock.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}SpmtElecAbcBlockDict.cc -c ${SpmtElecAbcBlock_cintflags} SpmtElecAbcBlock.h $(src)SpmtElecAbcBlockLinkDef.h

ElecEventDict_dict_lists += ${src}SpmtElecAbcBlockDict.h
ElecEventDict_dict_lists += ${src}SpmtElecAbcBlockDict.cc
${src}ElecFeeCrate.rootcint : ${src}ElecFeeCrateDict.cc
	@echo $@

${src}ElecFeeCrateDict.cc : ../Event/ElecFeeCrate.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}ElecFeeCrateDict.cc -c ${ElecFeeCrate_cintflags} ElecFeeCrate.h $(src)ElecFeeCrateLinkDef.h

ElecEventDict_dict_lists += ${src}ElecFeeCrateDict.h
ElecEventDict_dict_lists += ${src}ElecFeeCrateDict.cc
${src}SpmtElecEvent.rootcint : ${src}SpmtElecEventDict.cc
	@echo $@

${src}SpmtElecEventDict.cc : ../Event/SpmtElecEvent.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}SpmtElecEventDict.cc -c ${SpmtElecEvent_cintflags} SpmtElecEvent.h $(src)SpmtElecEventLinkDef.h

ElecEventDict_dict_lists += ${src}SpmtElecEventDict.h
ElecEventDict_dict_lists += ${src}SpmtElecEventDict.cc
${src}ElecFeeChannel.rootcint : ${src}ElecFeeChannelDict.cc
	@echo $@

${src}ElecFeeChannelDict.cc : ../Event/ElecFeeChannel.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}ElecFeeChannelDict.cc -c ${ElecFeeChannel_cintflags} ElecFeeChannel.h $(src)ElecFeeChannelLinkDef.h

ElecEventDict_dict_lists += ${src}ElecFeeChannelDict.h
ElecEventDict_dict_lists += ${src}ElecFeeChannelDict.cc
${src}ElecHeader.rootcint : ${src}ElecHeaderDict.cc
	@echo $@

${src}ElecHeaderDict.cc : ../Event/ElecHeader.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}ElecHeaderDict.cc -c ${ElecHeader_cintflags} ElecHeader.h $(src)ElecHeaderLinkDef.h

ElecEventDict_dict_lists += ${src}ElecHeaderDict.h
ElecEventDict_dict_lists += ${src}ElecHeaderDict.cc
clean :: ElecEventDictclean
	@cd .

ElecEventDictclean ::
	$(cleanup_echo) ROOT dictionary
	-$(cleanup_silent) rm -f $(dict)*~;\
	rm -f $(dict)ElecEventDict.*;\
	rm -f $(bin)ElecEventDict.*
	rm -f $(ElecEventDict_dict_lists)

#-- start of cleanup_header --------------

clean :: ElecEventDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ElecEventDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ElecEventDictclean ::
#-- end of cleanup_header ---------------

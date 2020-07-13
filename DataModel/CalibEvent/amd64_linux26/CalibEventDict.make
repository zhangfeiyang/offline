#-- start of make_header -----------------

#====================================
#  Document CalibEventDict
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

cmt_CalibEventDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_CalibEventDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_CalibEventDict

CalibEvent_tag = $(tag)

#cmt_local_tagfile_CalibEventDict = $(CalibEvent_tag)_CalibEventDict.make
cmt_local_tagfile_CalibEventDict = $(bin)$(CalibEvent_tag)_CalibEventDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CalibEvent_tag = $(tag)

#cmt_local_tagfile_CalibEventDict = $(CalibEvent_tag).make
cmt_local_tagfile_CalibEventDict = $(bin)$(CalibEvent_tag).make

endif

include $(cmt_local_tagfile_CalibEventDict)
#-include $(cmt_local_tagfile_CalibEventDict)

ifdef cmt_CalibEventDict_has_target_tag

cmt_final_setup_CalibEventDict = $(bin)setup_CalibEventDict.make
cmt_dependencies_in_CalibEventDict = $(bin)dependencies_CalibEventDict.in
#cmt_final_setup_CalibEventDict = $(bin)CalibEvent_CalibEventDictsetup.make
cmt_local_CalibEventDict_makefile = $(bin)CalibEventDict.make

else

cmt_final_setup_CalibEventDict = $(bin)setup.make
cmt_dependencies_in_CalibEventDict = $(bin)dependencies.in
#cmt_final_setup_CalibEventDict = $(bin)CalibEventsetup.make
cmt_local_CalibEventDict_makefile = $(bin)CalibEventDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CalibEventsetup.make

#CalibEventDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'CalibEventDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = CalibEventDict/
#CalibEventDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
CalibEventDict_output = ${src}
CalibEventDict_dict_lists = 

CalibEventDict :: $(CalibEventDict_output)CalibTTChannel.rootcint $(CalibEventDict_output)CalibEvent.rootcint $(CalibEventDict_output)CalibHeader.rootcint $(CalibEventDict_output)TTCalibEvent.rootcint $(CalibEventDict_output)CalibPMTChannel.rootcint
	@echo "------> CalibEventDict ok"
CalibTTChannel_h_dependencies = ../Event/CalibTTChannel.h
CalibEvent_h_dependencies = ../Event/CalibEvent.h
CalibHeader_h_dependencies = ../Event/CalibHeader.h
TTCalibEvent_h_dependencies = ../Event/TTCalibEvent.h
CalibPMTChannel_h_dependencies = ../Event/CalibPMTChannel.h
${src}CalibTTChannel.rootcint : ${src}CalibTTChannelDict.cc
	@echo $@

${src}CalibTTChannelDict.cc : ../Event/CalibTTChannel.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}CalibTTChannelDict.cc -c ${CalibTTChannel_cintflags} CalibTTChannel.h $(src)CalibTTChannelLinkDef.h

CalibEventDict_dict_lists += ${src}CalibTTChannelDict.h
CalibEventDict_dict_lists += ${src}CalibTTChannelDict.cc
${src}CalibEvent.rootcint : ${src}CalibEventDict.cc
	@echo $@

${src}CalibEventDict.cc : ../Event/CalibEvent.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}CalibEventDict.cc -c ${CalibEvent_cintflags} CalibEvent.h $(src)CalibEventLinkDef.h

CalibEventDict_dict_lists += ${src}CalibEventDict.h
CalibEventDict_dict_lists += ${src}CalibEventDict.cc
${src}CalibHeader.rootcint : ${src}CalibHeaderDict.cc
	@echo $@

${src}CalibHeaderDict.cc : ../Event/CalibHeader.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}CalibHeaderDict.cc -c ${CalibHeader_cintflags} CalibHeader.h $(src)CalibHeaderLinkDef.h

CalibEventDict_dict_lists += ${src}CalibHeaderDict.h
CalibEventDict_dict_lists += ${src}CalibHeaderDict.cc
${src}TTCalibEvent.rootcint : ${src}TTCalibEventDict.cc
	@echo $@

${src}TTCalibEventDict.cc : ../Event/TTCalibEvent.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}TTCalibEventDict.cc -c ${TTCalibEvent_cintflags} TTCalibEvent.h $(src)TTCalibEventLinkDef.h

CalibEventDict_dict_lists += ${src}TTCalibEventDict.h
CalibEventDict_dict_lists += ${src}TTCalibEventDict.cc
${src}CalibPMTChannel.rootcint : ${src}CalibPMTChannelDict.cc
	@echo $@

${src}CalibPMTChannelDict.cc : ../Event/CalibPMTChannel.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}CalibPMTChannelDict.cc -c ${CalibPMTChannel_cintflags} CalibPMTChannel.h $(src)CalibPMTChannelLinkDef.h

CalibEventDict_dict_lists += ${src}CalibPMTChannelDict.h
CalibEventDict_dict_lists += ${src}CalibPMTChannelDict.cc
clean :: CalibEventDictclean
	@cd .

CalibEventDictclean ::
	$(cleanup_echo) ROOT dictionary
	-$(cleanup_silent) rm -f $(dict)*~;\
	rm -f $(dict)CalibEventDict.*;\
	rm -f $(bin)CalibEventDict.*
	rm -f $(CalibEventDict_dict_lists)

#-- start of cleanup_header --------------

clean :: CalibEventDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(CalibEventDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

CalibEventDictclean ::
#-- end of cleanup_header ---------------

#-- start of make_header -----------------

#====================================
#  Document RecEventDict
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

cmt_RecEventDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RecEventDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RecEventDict

RecEvent_tag = $(tag)

#cmt_local_tagfile_RecEventDict = $(RecEvent_tag)_RecEventDict.make
cmt_local_tagfile_RecEventDict = $(bin)$(RecEvent_tag)_RecEventDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RecEvent_tag = $(tag)

#cmt_local_tagfile_RecEventDict = $(RecEvent_tag).make
cmt_local_tagfile_RecEventDict = $(bin)$(RecEvent_tag).make

endif

include $(cmt_local_tagfile_RecEventDict)
#-include $(cmt_local_tagfile_RecEventDict)

ifdef cmt_RecEventDict_has_target_tag

cmt_final_setup_RecEventDict = $(bin)setup_RecEventDict.make
cmt_dependencies_in_RecEventDict = $(bin)dependencies_RecEventDict.in
#cmt_final_setup_RecEventDict = $(bin)RecEvent_RecEventDictsetup.make
cmt_local_RecEventDict_makefile = $(bin)RecEventDict.make

else

cmt_final_setup_RecEventDict = $(bin)setup.make
cmt_dependencies_in_RecEventDict = $(bin)dependencies.in
#cmt_final_setup_RecEventDict = $(bin)RecEventsetup.make
cmt_local_RecEventDict_makefile = $(bin)RecEventDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RecEventsetup.make

#RecEventDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RecEventDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RecEventDict/
#RecEventDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
RecEventDict_output = ${src}
RecEventDict_dict_lists = 

RecEventDict :: $(RecEventDict_output)TTRecEvent.rootcint $(RecEventDict_output)WPRecEvent.rootcint $(RecEventDict_output)RecTrack.rootcint $(RecEventDict_output)RecHeader.rootcint $(RecEventDict_output)CDRecEvent.rootcint $(RecEventDict_output)CDTrackRecEvent.rootcint
	@echo "------> RecEventDict ok"
TTRecEvent_h_dependencies = ../Event/TTRecEvent.h
WPRecEvent_h_dependencies = ../Event/WPRecEvent.h
RecTrack_h_dependencies = ../Event/RecTrack.h
RecHeader_h_dependencies = ../Event/RecHeader.h
CDRecEvent_h_dependencies = ../Event/CDRecEvent.h
CDTrackRecEvent_h_dependencies = ../Event/CDTrackRecEvent.h
${src}TTRecEvent.rootcint : ${src}TTRecEventDict.cc
	@echo $@

${src}TTRecEventDict.cc : ../Event/TTRecEvent.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}TTRecEventDict.cc -c ${TTRecEvent_cintflags} TTRecEvent.h $(src)TTRecEventLinkDef.h

RecEventDict_dict_lists += ${src}TTRecEventDict.h
RecEventDict_dict_lists += ${src}TTRecEventDict.cc
${src}WPRecEvent.rootcint : ${src}WPRecEventDict.cc
	@echo $@

${src}WPRecEventDict.cc : ../Event/WPRecEvent.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}WPRecEventDict.cc -c ${WPRecEvent_cintflags} WPRecEvent.h $(src)WPRecEventLinkDef.h

RecEventDict_dict_lists += ${src}WPRecEventDict.h
RecEventDict_dict_lists += ${src}WPRecEventDict.cc
${src}RecTrack.rootcint : ${src}RecTrackDict.cc
	@echo $@

${src}RecTrackDict.cc : ../Event/RecTrack.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}RecTrackDict.cc -c ${RecTrack_cintflags} RecTrack.h $(src)RecTrackLinkDef.h

RecEventDict_dict_lists += ${src}RecTrackDict.h
RecEventDict_dict_lists += ${src}RecTrackDict.cc
${src}RecHeader.rootcint : ${src}RecHeaderDict.cc
	@echo $@

${src}RecHeaderDict.cc : ../Event/RecHeader.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}RecHeaderDict.cc -c ${RecHeader_cintflags} RecHeader.h $(src)RecHeaderLinkDef.h

RecEventDict_dict_lists += ${src}RecHeaderDict.h
RecEventDict_dict_lists += ${src}RecHeaderDict.cc
${src}CDRecEvent.rootcint : ${src}CDRecEventDict.cc
	@echo $@

${src}CDRecEventDict.cc : ../Event/CDRecEvent.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}CDRecEventDict.cc -c ${CDRecEvent_cintflags} CDRecEvent.h $(src)CDRecEventLinkDef.h

RecEventDict_dict_lists += ${src}CDRecEventDict.h
RecEventDict_dict_lists += ${src}CDRecEventDict.cc
${src}CDTrackRecEvent.rootcint : ${src}CDTrackRecEventDict.cc
	@echo $@

${src}CDTrackRecEventDict.cc : ../Event/CDTrackRecEvent.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}CDTrackRecEventDict.cc -c ${CDTrackRecEvent_cintflags} CDTrackRecEvent.h $(src)CDTrackRecEventLinkDef.h

RecEventDict_dict_lists += ${src}CDTrackRecEventDict.h
RecEventDict_dict_lists += ${src}CDTrackRecEventDict.cc
clean :: RecEventDictclean
	@cd .

RecEventDictclean ::
	$(cleanup_echo) ROOT dictionary
	-$(cleanup_silent) rm -f $(dict)*~;\
	rm -f $(dict)RecEventDict.*;\
	rm -f $(bin)RecEventDict.*
	rm -f $(RecEventDict_dict_lists)

#-- start of cleanup_header --------------

clean :: RecEventDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RecEventDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RecEventDictclean ::
#-- end of cleanup_header ---------------

#-- start of make_header -----------------

#====================================
#  Document RootIOTestDict
#
#   Generated Fri Jul 10 19:24:32 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootIOTestDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootIOTestDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootIOTestDict

RootIOTest_tag = $(tag)

#cmt_local_tagfile_RootIOTestDict = $(RootIOTest_tag)_RootIOTestDict.make
cmt_local_tagfile_RootIOTestDict = $(bin)$(RootIOTest_tag)_RootIOTestDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootIOTest_tag = $(tag)

#cmt_local_tagfile_RootIOTestDict = $(RootIOTest_tag).make
cmt_local_tagfile_RootIOTestDict = $(bin)$(RootIOTest_tag).make

endif

include $(cmt_local_tagfile_RootIOTestDict)
#-include $(cmt_local_tagfile_RootIOTestDict)

ifdef cmt_RootIOTestDict_has_target_tag

cmt_final_setup_RootIOTestDict = $(bin)setup_RootIOTestDict.make
cmt_dependencies_in_RootIOTestDict = $(bin)dependencies_RootIOTestDict.in
#cmt_final_setup_RootIOTestDict = $(bin)RootIOTest_RootIOTestDictsetup.make
cmt_local_RootIOTestDict_makefile = $(bin)RootIOTestDict.make

else

cmt_final_setup_RootIOTestDict = $(bin)setup.make
cmt_dependencies_in_RootIOTestDict = $(bin)dependencies.in
#cmt_final_setup_RootIOTestDict = $(bin)RootIOTestsetup.make
cmt_local_RootIOTestDict_makefile = $(bin)RootIOTestDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootIOTestsetup.make

#RootIOTestDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootIOTestDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootIOTestDict/
#RootIOTestDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
RootIOTestDict_output = ${src}
RootIOTestDict_dict_lists = 

RootIOTestDict :: $(RootIOTestDict_output)DummyTrack.rootcint $(RootIOTestDict_output)DummyHeader.rootcint $(RootIOTestDict_output)DummyPMTHit.rootcint $(RootIOTestDict_output)DummyTTHit.rootcint $(RootIOTestDict_output)DummyEvent.rootcint
	@echo "------> RootIOTestDict ok"
DummyTrack_h_dependencies = ../Event/DummyTrack.h
DummyHeader_h_dependencies = ../Event/DummyHeader.h
DummyPMTHit_h_dependencies = ../Event/DummyPMTHit.h
DummyTTHit_h_dependencies = ../Event/DummyTTHit.h
DummyEvent_h_dependencies = ../Event/DummyEvent.h
${src}DummyTrack.rootcint : ${src}DummyTrackDict.cc
	@echo $@

${src}DummyTrackDict.cc : ../Event/DummyTrack.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}DummyTrackDict.cc -c ${DummyTrack_cintflags} DummyTrack.h $(src)DummyTrackLinkDef.h

RootIOTestDict_dict_lists += ${src}DummyTrackDict.h
RootIOTestDict_dict_lists += ${src}DummyTrackDict.cc
${src}DummyHeader.rootcint : ${src}DummyHeaderDict.cc
	@echo $@

${src}DummyHeaderDict.cc : ../Event/DummyHeader.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}DummyHeaderDict.cc -c ${DummyHeader_cintflags} DummyHeader.h $(src)DummyHeaderLinkDef.h

RootIOTestDict_dict_lists += ${src}DummyHeaderDict.h
RootIOTestDict_dict_lists += ${src}DummyHeaderDict.cc
${src}DummyPMTHit.rootcint : ${src}DummyPMTHitDict.cc
	@echo $@

${src}DummyPMTHitDict.cc : ../Event/DummyPMTHit.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}DummyPMTHitDict.cc -c ${DummyPMTHit_cintflags} DummyPMTHit.h $(src)DummyPMTHitLinkDef.h

RootIOTestDict_dict_lists += ${src}DummyPMTHitDict.h
RootIOTestDict_dict_lists += ${src}DummyPMTHitDict.cc
${src}DummyTTHit.rootcint : ${src}DummyTTHitDict.cc
	@echo $@

${src}DummyTTHitDict.cc : ../Event/DummyTTHit.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}DummyTTHitDict.cc -c ${DummyTTHit_cintflags} DummyTTHit.h $(src)DummyTTHitLinkDef.h

RootIOTestDict_dict_lists += ${src}DummyTTHitDict.h
RootIOTestDict_dict_lists += ${src}DummyTTHitDict.cc
${src}DummyEvent.rootcint : ${src}DummyEventDict.cc
	@echo $@

${src}DummyEventDict.cc : ../Event/DummyEvent.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}DummyEventDict.cc -c ${DummyEvent_cintflags} DummyEvent.h $(src)DummyEventLinkDef.h

RootIOTestDict_dict_lists += ${src}DummyEventDict.h
RootIOTestDict_dict_lists += ${src}DummyEventDict.cc
clean :: RootIOTestDictclean
	@cd .

RootIOTestDictclean ::
	$(cleanup_echo) ROOT dictionary
	-$(cleanup_silent) rm -f $(dict)*~;\
	rm -f $(dict)RootIOTestDict.*;\
	rm -f $(bin)RootIOTestDict.*
	rm -f $(RootIOTestDict_dict_lists)

#-- start of cleanup_header --------------

clean :: RootIOTestDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootIOTestDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootIOTestDictclean ::
#-- end of cleanup_header ---------------

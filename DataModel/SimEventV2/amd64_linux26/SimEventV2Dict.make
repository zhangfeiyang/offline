#-- start of make_header -----------------

#====================================
#  Document SimEventV2Dict
#
#   Generated Fri Jul 10 19:21:28 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_SimEventV2Dict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_SimEventV2Dict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_SimEventV2Dict

SimEventV2_tag = $(tag)

#cmt_local_tagfile_SimEventV2Dict = $(SimEventV2_tag)_SimEventV2Dict.make
cmt_local_tagfile_SimEventV2Dict = $(bin)$(SimEventV2_tag)_SimEventV2Dict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

SimEventV2_tag = $(tag)

#cmt_local_tagfile_SimEventV2Dict = $(SimEventV2_tag).make
cmt_local_tagfile_SimEventV2Dict = $(bin)$(SimEventV2_tag).make

endif

include $(cmt_local_tagfile_SimEventV2Dict)
#-include $(cmt_local_tagfile_SimEventV2Dict)

ifdef cmt_SimEventV2Dict_has_target_tag

cmt_final_setup_SimEventV2Dict = $(bin)setup_SimEventV2Dict.make
cmt_dependencies_in_SimEventV2Dict = $(bin)dependencies_SimEventV2Dict.in
#cmt_final_setup_SimEventV2Dict = $(bin)SimEventV2_SimEventV2Dictsetup.make
cmt_local_SimEventV2Dict_makefile = $(bin)SimEventV2Dict.make

else

cmt_final_setup_SimEventV2Dict = $(bin)setup.make
cmt_dependencies_in_SimEventV2Dict = $(bin)dependencies.in
#cmt_final_setup_SimEventV2Dict = $(bin)SimEventV2setup.make
cmt_local_SimEventV2Dict_makefile = $(bin)SimEventV2Dict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)SimEventV2setup.make

#SimEventV2Dict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'SimEventV2Dict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = SimEventV2Dict/
#SimEventV2Dict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
SimEventV2Dict_output = ${src}
SimEventV2Dict_dict_lists = 

SimEventV2Dict :: $(SimEventV2Dict_output)SimHeader.rootcint $(SimEventV2Dict_output)SimPMTHit.rootcint $(SimEventV2Dict_output)SimTrack.rootcint $(SimEventV2Dict_output)SimEvent.rootcint $(SimEventV2Dict_output)SimTTHit.rootcint
	@echo "------> SimEventV2Dict ok"
SimHeader_h_dependencies = ../Event/SimHeader.h
SimPMTHit_h_dependencies = ../Event/SimPMTHit.h
SimTrack_h_dependencies = ../Event/SimTrack.h
SimEvent_h_dependencies = ../Event/SimEvent.h
SimTTHit_h_dependencies = ../Event/SimTTHit.h
${src}SimHeader.rootcint : ${src}SimHeaderDict.cc
	@echo $@

${src}SimHeaderDict.cc : ../Event/SimHeader.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}SimHeaderDict.cc -c ${SimHeader_cintflags} SimHeader.h $(src)SimHeaderLinkDef.h

SimEventV2Dict_dict_lists += ${src}SimHeaderDict.h
SimEventV2Dict_dict_lists += ${src}SimHeaderDict.cc
${src}SimPMTHit.rootcint : ${src}SimPMTHitDict.cc
	@echo $@

${src}SimPMTHitDict.cc : ../Event/SimPMTHit.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}SimPMTHitDict.cc -c ${SimPMTHit_cintflags} SimPMTHit.h $(src)SimPMTHitLinkDef.h

SimEventV2Dict_dict_lists += ${src}SimPMTHitDict.h
SimEventV2Dict_dict_lists += ${src}SimPMTHitDict.cc
${src}SimTrack.rootcint : ${src}SimTrackDict.cc
	@echo $@

${src}SimTrackDict.cc : ../Event/SimTrack.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}SimTrackDict.cc -c ${SimTrack_cintflags} SimTrack.h $(src)SimTrackLinkDef.h

SimEventV2Dict_dict_lists += ${src}SimTrackDict.h
SimEventV2Dict_dict_lists += ${src}SimTrackDict.cc
${src}SimEvent.rootcint : ${src}SimEventDict.cc
	@echo $@

${src}SimEventDict.cc : ../Event/SimEvent.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}SimEventDict.cc -c ${SimEvent_cintflags} SimEvent.h $(src)SimEventLinkDef.h

SimEventV2Dict_dict_lists += ${src}SimEventDict.h
SimEventV2Dict_dict_lists += ${src}SimEventDict.cc
${src}SimTTHit.rootcint : ${src}SimTTHitDict.cc
	@echo $@

${src}SimTTHitDict.cc : ../Event/SimTTHit.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}SimTTHitDict.cc -c ${SimTTHit_cintflags} SimTTHit.h $(src)SimTTHitLinkDef.h

SimEventV2Dict_dict_lists += ${src}SimTTHitDict.h
SimEventV2Dict_dict_lists += ${src}SimTTHitDict.cc
clean :: SimEventV2Dictclean
	@cd .

SimEventV2Dictclean ::
	$(cleanup_echo) ROOT dictionary
	-$(cleanup_silent) rm -f $(dict)*~;\
	rm -f $(dict)SimEventV2Dict.*;\
	rm -f $(bin)SimEventV2Dict.*
	rm -f $(SimEventV2Dict_dict_lists)

#-- start of cleanup_header --------------

clean :: SimEventV2Dictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(SimEventV2Dict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

SimEventV2Dictclean ::
#-- end of cleanup_header ---------------

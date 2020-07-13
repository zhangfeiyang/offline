#-- start of make_header -----------------

#====================================
#  Document BaseEventDict
#
#   Generated Fri Jul 10 19:17:35 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_BaseEventDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_BaseEventDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_BaseEventDict

BaseEvent_tag = $(tag)

#cmt_local_tagfile_BaseEventDict = $(BaseEvent_tag)_BaseEventDict.make
cmt_local_tagfile_BaseEventDict = $(bin)$(BaseEvent_tag)_BaseEventDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

BaseEvent_tag = $(tag)

#cmt_local_tagfile_BaseEventDict = $(BaseEvent_tag).make
cmt_local_tagfile_BaseEventDict = $(bin)$(BaseEvent_tag).make

endif

include $(cmt_local_tagfile_BaseEventDict)
#-include $(cmt_local_tagfile_BaseEventDict)

ifdef cmt_BaseEventDict_has_target_tag

cmt_final_setup_BaseEventDict = $(bin)setup_BaseEventDict.make
cmt_dependencies_in_BaseEventDict = $(bin)dependencies_BaseEventDict.in
#cmt_final_setup_BaseEventDict = $(bin)BaseEvent_BaseEventDictsetup.make
cmt_local_BaseEventDict_makefile = $(bin)BaseEventDict.make

else

cmt_final_setup_BaseEventDict = $(bin)setup.make
cmt_dependencies_in_BaseEventDict = $(bin)dependencies.in
#cmt_final_setup_BaseEventDict = $(bin)BaseEventsetup.make
cmt_local_BaseEventDict_makefile = $(bin)BaseEventDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)BaseEventsetup.make

#BaseEventDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'BaseEventDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = BaseEventDict/
#BaseEventDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
BaseEventDict_output = ${src}
BaseEventDict_dict_lists = 

BaseEventDict :: $(BaseEventDict_output)HeaderObject.rootcint $(BaseEventDict_output)EventObject.rootcint
	@echo "------> BaseEventDict ok"
HeaderObject_h_dependencies = ../Event/HeaderObject.h
EventObject_h_dependencies = ../Event/EventObject.h
${src}HeaderObject.rootcint : ${src}HeaderObjectDict.cc
	@echo $@

${src}HeaderObjectDict.cc : ../Event/HeaderObject.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}HeaderObjectDict.cc -c ${HeaderObject_cintflags} HeaderObject.h $(src)HeaderObjectLinkDef.h

BaseEventDict_dict_lists += ${src}HeaderObjectDict.h
BaseEventDict_dict_lists += ${src}HeaderObjectDict.cc
${src}EventObject.rootcint : ${src}EventObjectDict.cc
	@echo $@

${src}EventObjectDict.cc : ../Event/EventObject.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}EventObjectDict.cc -c ${EventObject_cintflags} EventObject.h $(src)EventObjectLinkDef.h

BaseEventDict_dict_lists += ${src}EventObjectDict.h
BaseEventDict_dict_lists += ${src}EventObjectDict.cc
clean :: BaseEventDictclean
	@cd .

BaseEventDictclean ::
	$(cleanup_echo) ROOT dictionary
	-$(cleanup_silent) rm -f $(dict)*~;\
	rm -f $(dict)BaseEventDict.*;\
	rm -f $(bin)BaseEventDict.*
	rm -f $(BaseEventDict_dict_lists)

#-- start of cleanup_header --------------

clean :: BaseEventDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(BaseEventDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

BaseEventDictclean ::
#-- end of cleanup_header ---------------

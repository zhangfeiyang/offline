#-- start of make_header -----------------

#====================================
#  Document PhyEventDict
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

cmt_PhyEventDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PhyEventDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PhyEventDict

PhyEvent_tag = $(tag)

#cmt_local_tagfile_PhyEventDict = $(PhyEvent_tag)_PhyEventDict.make
cmt_local_tagfile_PhyEventDict = $(bin)$(PhyEvent_tag)_PhyEventDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PhyEvent_tag = $(tag)

#cmt_local_tagfile_PhyEventDict = $(PhyEvent_tag).make
cmt_local_tagfile_PhyEventDict = $(bin)$(PhyEvent_tag).make

endif

include $(cmt_local_tagfile_PhyEventDict)
#-include $(cmt_local_tagfile_PhyEventDict)

ifdef cmt_PhyEventDict_has_target_tag

cmt_final_setup_PhyEventDict = $(bin)setup_PhyEventDict.make
cmt_dependencies_in_PhyEventDict = $(bin)dependencies_PhyEventDict.in
#cmt_final_setup_PhyEventDict = $(bin)PhyEvent_PhyEventDictsetup.make
cmt_local_PhyEventDict_makefile = $(bin)PhyEventDict.make

else

cmt_final_setup_PhyEventDict = $(bin)setup.make
cmt_dependencies_in_PhyEventDict = $(bin)dependencies.in
#cmt_final_setup_PhyEventDict = $(bin)PhyEventsetup.make
cmt_local_PhyEventDict_makefile = $(bin)PhyEventDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PhyEventsetup.make

#PhyEventDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PhyEventDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PhyEventDict/
#PhyEventDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
PhyEventDict_output = ${src}
PhyEventDict_dict_lists = 

PhyEventDict :: $(PhyEventDict_output)PhyEvent.rootcint $(PhyEventDict_output)PhyHeader.rootcint
	@echo "------> PhyEventDict ok"
PhyEvent_h_dependencies = ../Event/PhyEvent.h
PhyHeader_h_dependencies = ../Event/PhyHeader.h
${src}PhyEvent.rootcint : ${src}PhyEventDict.cc
	@echo $@

${src}PhyEventDict.cc : ../Event/PhyEvent.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}PhyEventDict.cc -c ${PhyEvent_cintflags} PhyEvent.h $(src)PhyEventLinkDef.h

PhyEventDict_dict_lists += ${src}PhyEventDict.h
PhyEventDict_dict_lists += ${src}PhyEventDict.cc
${src}PhyHeader.rootcint : ${src}PhyHeaderDict.cc
	@echo $@

${src}PhyHeaderDict.cc : ../Event/PhyHeader.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}PhyHeaderDict.cc -c ${PhyHeader_cintflags} PhyHeader.h $(src)PhyHeaderLinkDef.h

PhyEventDict_dict_lists += ${src}PhyHeaderDict.h
PhyEventDict_dict_lists += ${src}PhyHeaderDict.cc
clean :: PhyEventDictclean
	@cd .

PhyEventDictclean ::
	$(cleanup_echo) ROOT dictionary
	-$(cleanup_silent) rm -f $(dict)*~;\
	rm -f $(dict)PhyEventDict.*;\
	rm -f $(bin)PhyEventDict.*
	rm -f $(PhyEventDict_dict_lists)

#-- start of cleanup_header --------------

clean :: PhyEventDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PhyEventDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PhyEventDictclean ::
#-- end of cleanup_header ---------------

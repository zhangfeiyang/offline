#-- start of make_header -----------------

#====================================
#  Document GenEventV2Dict
#
#   Generated Fri Jul 10 19:24:47 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GenEventV2Dict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GenEventV2Dict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GenEventV2Dict

GenEventV2_tag = $(tag)

#cmt_local_tagfile_GenEventV2Dict = $(GenEventV2_tag)_GenEventV2Dict.make
cmt_local_tagfile_GenEventV2Dict = $(bin)$(GenEventV2_tag)_GenEventV2Dict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GenEventV2_tag = $(tag)

#cmt_local_tagfile_GenEventV2Dict = $(GenEventV2_tag).make
cmt_local_tagfile_GenEventV2Dict = $(bin)$(GenEventV2_tag).make

endif

include $(cmt_local_tagfile_GenEventV2Dict)
#-include $(cmt_local_tagfile_GenEventV2Dict)

ifdef cmt_GenEventV2Dict_has_target_tag

cmt_final_setup_GenEventV2Dict = $(bin)setup_GenEventV2Dict.make
cmt_dependencies_in_GenEventV2Dict = $(bin)dependencies_GenEventV2Dict.in
#cmt_final_setup_GenEventV2Dict = $(bin)GenEventV2_GenEventV2Dictsetup.make
cmt_local_GenEventV2Dict_makefile = $(bin)GenEventV2Dict.make

else

cmt_final_setup_GenEventV2Dict = $(bin)setup.make
cmt_dependencies_in_GenEventV2Dict = $(bin)dependencies.in
#cmt_final_setup_GenEventV2Dict = $(bin)GenEventV2setup.make
cmt_local_GenEventV2Dict_makefile = $(bin)GenEventV2Dict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GenEventV2setup.make

#GenEventV2Dict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GenEventV2Dict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GenEventV2Dict/
#GenEventV2Dict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
GenEventV2Dict_output = ${src}
GenEventV2Dict_dict_lists = 

GenEventV2Dict :: $(GenEventV2Dict_output)GenHeader.rootcint $(GenEventV2Dict_output)GenEvent.rootcint
	@echo "------> GenEventV2Dict ok"
GenHeader_h_dependencies = ../Event/GenHeader.h
GenEvent_h_dependencies = ../Event/GenEvent.h
${src}GenHeader.rootcint : ${src}GenHeaderDict.cc
	@echo $@

${src}GenHeaderDict.cc : ../Event/GenHeader.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}GenHeaderDict.cc -c ${GenHeader_cintflags} GenHeader.h $(src)GenHeaderLinkDef.h

GenEventV2Dict_dict_lists += ${src}GenHeaderDict.h
GenEventV2Dict_dict_lists += ${src}GenHeaderDict.cc
${src}GenEvent.rootcint : ${src}GenEventDict.cc
	@echo $@

${src}GenEventDict.cc : ../Event/GenEvent.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Event/;$(rootcint) -f ${src}GenEventDict.cc -c ${GenEvent_cintflags} GenEvent.h $(src)GenEventLinkDef.h

GenEventV2Dict_dict_lists += ${src}GenEventDict.h
GenEventV2Dict_dict_lists += ${src}GenEventDict.cc
clean :: GenEventV2Dictclean
	@cd .

GenEventV2Dictclean ::
	$(cleanup_echo) ROOT dictionary
	-$(cleanup_silent) rm -f $(dict)*~;\
	rm -f $(dict)GenEventV2Dict.*;\
	rm -f $(bin)GenEventV2Dict.*
	rm -f $(GenEventV2Dict_dict_lists)

#-- start of cleanup_header --------------

clean :: GenEventV2Dictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GenEventV2Dict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GenEventV2Dictclean ::
#-- end of cleanup_header ---------------

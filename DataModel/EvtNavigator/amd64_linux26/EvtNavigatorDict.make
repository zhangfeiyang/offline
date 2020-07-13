#-- start of make_header -----------------

#====================================
#  Document EvtNavigatorDict
#
#   Generated Fri Jul 10 19:17:56 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_EvtNavigatorDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_EvtNavigatorDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_EvtNavigatorDict

EvtNavigator_tag = $(tag)

#cmt_local_tagfile_EvtNavigatorDict = $(EvtNavigator_tag)_EvtNavigatorDict.make
cmt_local_tagfile_EvtNavigatorDict = $(bin)$(EvtNavigator_tag)_EvtNavigatorDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

EvtNavigator_tag = $(tag)

#cmt_local_tagfile_EvtNavigatorDict = $(EvtNavigator_tag).make
cmt_local_tagfile_EvtNavigatorDict = $(bin)$(EvtNavigator_tag).make

endif

include $(cmt_local_tagfile_EvtNavigatorDict)
#-include $(cmt_local_tagfile_EvtNavigatorDict)

ifdef cmt_EvtNavigatorDict_has_target_tag

cmt_final_setup_EvtNavigatorDict = $(bin)setup_EvtNavigatorDict.make
cmt_dependencies_in_EvtNavigatorDict = $(bin)dependencies_EvtNavigatorDict.in
#cmt_final_setup_EvtNavigatorDict = $(bin)EvtNavigator_EvtNavigatorDictsetup.make
cmt_local_EvtNavigatorDict_makefile = $(bin)EvtNavigatorDict.make

else

cmt_final_setup_EvtNavigatorDict = $(bin)setup.make
cmt_dependencies_in_EvtNavigatorDict = $(bin)dependencies.in
#cmt_final_setup_EvtNavigatorDict = $(bin)EvtNavigatorsetup.make
cmt_local_EvtNavigatorDict_makefile = $(bin)EvtNavigatorDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)EvtNavigatorsetup.make

#EvtNavigatorDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'EvtNavigatorDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = EvtNavigatorDict/
#EvtNavigatorDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
EvtNavigatorDict_output = ${src}
EvtNavigatorDict_dict_lists = 

EvtNavigatorDict :: $(EvtNavigatorDict_output)EvtNavigator.rootcint
	@echo "------> EvtNavigatorDict ok"
EvtNavigator_h_dependencies = ../EvtNavigator/EvtNavigator.h
${src}EvtNavigator.rootcint : ${src}EvtNavigatorDict.cc
	@echo $@

${src}EvtNavigatorDict.cc : ../EvtNavigator/EvtNavigator.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../EvtNavigator/;$(rootcint) -f ${src}EvtNavigatorDict.cc -c ${EvtNavigator_cintflags} EvtNavigator.h $(src)EvtNavigatorLinkDef.h

EvtNavigatorDict_dict_lists += ${src}EvtNavigatorDict.h
EvtNavigatorDict_dict_lists += ${src}EvtNavigatorDict.cc
clean :: EvtNavigatorDictclean
	@cd .

EvtNavigatorDictclean ::
	$(cleanup_echo) ROOT dictionary
	-$(cleanup_silent) rm -f $(dict)*~;\
	rm -f $(dict)EvtNavigatorDict.*;\
	rm -f $(bin)EvtNavigatorDict.*
	rm -f $(EvtNavigatorDict_dict_lists)

#-- start of cleanup_header --------------

clean :: EvtNavigatorDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(EvtNavigatorDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

EvtNavigatorDictclean ::
#-- end of cleanup_header ---------------

#-- start of make_header -----------------

#====================================
#  Document CLHEPDictDict
#
#   Generated Fri Jul 10 19:17:32 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_CLHEPDictDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_CLHEPDictDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_CLHEPDictDict

CLHEPDict_tag = $(tag)

#cmt_local_tagfile_CLHEPDictDict = $(CLHEPDict_tag)_CLHEPDictDict.make
cmt_local_tagfile_CLHEPDictDict = $(bin)$(CLHEPDict_tag)_CLHEPDictDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CLHEPDict_tag = $(tag)

#cmt_local_tagfile_CLHEPDictDict = $(CLHEPDict_tag).make
cmt_local_tagfile_CLHEPDictDict = $(bin)$(CLHEPDict_tag).make

endif

include $(cmt_local_tagfile_CLHEPDictDict)
#-include $(cmt_local_tagfile_CLHEPDictDict)

ifdef cmt_CLHEPDictDict_has_target_tag

cmt_final_setup_CLHEPDictDict = $(bin)setup_CLHEPDictDict.make
cmt_dependencies_in_CLHEPDictDict = $(bin)dependencies_CLHEPDictDict.in
#cmt_final_setup_CLHEPDictDict = $(bin)CLHEPDict_CLHEPDictDictsetup.make
cmt_local_CLHEPDictDict_makefile = $(bin)CLHEPDictDict.make

else

cmt_final_setup_CLHEPDictDict = $(bin)setup.make
cmt_dependencies_in_CLHEPDictDict = $(bin)dependencies.in
#cmt_final_setup_CLHEPDictDict = $(bin)CLHEPDictsetup.make
cmt_local_CLHEPDictDict_makefile = $(bin)CLHEPDictDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CLHEPDictsetup.make

#CLHEPDictDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'CLHEPDictDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = CLHEPDictDict/
#CLHEPDictDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
CLHEPDictDict_output = ${src}
CLHEPDictDict_dict_lists = 

CLHEPDictDict :: $(CLHEPDictDict_output)CLHEPInc.rootcint
	@echo "------> CLHEPDictDict ok"
CLHEPInc_h_dependencies = ../src/CLHEPInc.h
${src}CLHEPInc.rootcint : ${src}CLHEPIncDict.cc
	@echo $@

${src}CLHEPIncDict.cc : $(src)CLHEPInc.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd $(src);$(rootcint) -f ${src}CLHEPIncDict.cc -c ${CLHEPInc_cintflags} CLHEPInc.h $(src)CLHEPIncLinkDef.h

CLHEPDictDict_dict_lists += ${src}CLHEPIncDict.h
CLHEPDictDict_dict_lists += ${src}CLHEPIncDict.cc
clean :: CLHEPDictDictclean
	@cd .

CLHEPDictDictclean ::
	$(cleanup_echo) ROOT dictionary
	-$(cleanup_silent) rm -f $(dict)*~;\
	rm -f $(dict)CLHEPDictDict.*;\
	rm -f $(bin)CLHEPDictDict.*
	rm -f $(CLHEPDictDict_dict_lists)

#-- start of cleanup_header --------------

clean :: CLHEPDictDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(CLHEPDictDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

CLHEPDictDictclean ::
#-- end of cleanup_header ---------------

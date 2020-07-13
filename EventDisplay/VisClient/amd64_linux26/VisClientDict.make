#-- start of make_header -----------------

#====================================
#  Document VisClientDict
#
#   Generated Fri Jul 10 19:21:46 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_VisClientDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_VisClientDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_VisClientDict

VisClient_tag = $(tag)

#cmt_local_tagfile_VisClientDict = $(VisClient_tag)_VisClientDict.make
cmt_local_tagfile_VisClientDict = $(bin)$(VisClient_tag)_VisClientDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

VisClient_tag = $(tag)

#cmt_local_tagfile_VisClientDict = $(VisClient_tag).make
cmt_local_tagfile_VisClientDict = $(bin)$(VisClient_tag).make

endif

include $(cmt_local_tagfile_VisClientDict)
#-include $(cmt_local_tagfile_VisClientDict)

ifdef cmt_VisClientDict_has_target_tag

cmt_final_setup_VisClientDict = $(bin)setup_VisClientDict.make
cmt_dependencies_in_VisClientDict = $(bin)dependencies_VisClientDict.in
#cmt_final_setup_VisClientDict = $(bin)VisClient_VisClientDictsetup.make
cmt_local_VisClientDict_makefile = $(bin)VisClientDict.make

else

cmt_final_setup_VisClientDict = $(bin)setup.make
cmt_dependencies_in_VisClientDict = $(bin)dependencies.in
#cmt_final_setup_VisClientDict = $(bin)VisClientsetup.make
cmt_local_VisClientDict_makefile = $(bin)VisClientDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)VisClientsetup.make

#VisClientDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'VisClientDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = VisClientDict/
#VisClientDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
VisClientDict_output = ${src}
VisClientDict_dict_lists = 

VisClientDict :: $(VisClientDict_output)VisClient.rootcint
	@echo "------> VisClientDict ok"
VisClient_h_dependencies = ../VisClient/VisClient.h
${src}VisClient.rootcint : ${src}VisClientDict.cc
	@echo $@

${src}VisClientDict.cc : ../VisClient/VisClient.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../VisClient/;$(rootcint) -f ${src}VisClientDict.cc -c ${VisClient_cintflags} VisClient.h $(src)VisClientLinkDef.h

VisClientDict_dict_lists += ${src}VisClientDict.h
VisClientDict_dict_lists += ${src}VisClientDict.cc
clean :: VisClientDictclean
	@cd .

VisClientDictclean ::
	$(cleanup_echo) ROOT dictionary
	-$(cleanup_silent) rm -f $(dict)*~;\
	rm -f $(dict)VisClientDict.*;\
	rm -f $(bin)VisClientDict.*
	rm -f $(VisClientDict_dict_lists)

#-- start of cleanup_header --------------

clean :: VisClientDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(VisClientDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

VisClientDictclean ::
#-- end of cleanup_header ---------------

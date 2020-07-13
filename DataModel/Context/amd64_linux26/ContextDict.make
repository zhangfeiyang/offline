#-- start of make_header -----------------

#====================================
#  Document ContextDict
#
#   Generated Fri Jul 10 19:15:08 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_ContextDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ContextDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ContextDict

Context_tag = $(tag)

#cmt_local_tagfile_ContextDict = $(Context_tag)_ContextDict.make
cmt_local_tagfile_ContextDict = $(bin)$(Context_tag)_ContextDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Context_tag = $(tag)

#cmt_local_tagfile_ContextDict = $(Context_tag).make
cmt_local_tagfile_ContextDict = $(bin)$(Context_tag).make

endif

include $(cmt_local_tagfile_ContextDict)
#-include $(cmt_local_tagfile_ContextDict)

ifdef cmt_ContextDict_has_target_tag

cmt_final_setup_ContextDict = $(bin)setup_ContextDict.make
cmt_dependencies_in_ContextDict = $(bin)dependencies_ContextDict.in
#cmt_final_setup_ContextDict = $(bin)Context_ContextDictsetup.make
cmt_local_ContextDict_makefile = $(bin)ContextDict.make

else

cmt_final_setup_ContextDict = $(bin)setup.make
cmt_dependencies_in_ContextDict = $(bin)dependencies.in
#cmt_final_setup_ContextDict = $(bin)Contextsetup.make
cmt_local_ContextDict_makefile = $(bin)ContextDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Contextsetup.make

#ContextDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ContextDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ContextDict/
#ContextDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
ContextDict_output = ${src}
ContextDict_dict_lists = 

ContextDict :: $(ContextDict_output)TimeStamp.rootcint
	@echo "------> ContextDict ok"
TimeStamp_h_dependencies = ../Context/TimeStamp.h
${src}TimeStamp.rootcint : ${src}TimeStampDict.cc
	@echo $@

${src}TimeStampDict.cc : ../Context/TimeStamp.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../Context/;$(rootcint) -f ${src}TimeStampDict.cc -c ${TimeStamp_cintflags} TimeStamp.h $(src)TimeStampLinkDef.h

ContextDict_dict_lists += ${src}TimeStampDict.h
ContextDict_dict_lists += ${src}TimeStampDict.cc
clean :: ContextDictclean
	@cd .

ContextDictclean ::
	$(cleanup_echo) ROOT dictionary
	-$(cleanup_silent) rm -f $(dict)*~;\
	rm -f $(dict)ContextDict.*;\
	rm -f $(bin)ContextDict.*
	rm -f $(ContextDict_dict_lists)

#-- start of cleanup_header --------------

clean :: ContextDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ContextDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ContextDictclean ::
#-- end of cleanup_header ---------------

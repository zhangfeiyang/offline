#-- start of make_header -----------------

#====================================
#  Document EDMUtilDict
#
#   Generated Fri Jul 10 19:17:39 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_EDMUtilDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_EDMUtilDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_EDMUtilDict

EDMUtil_tag = $(tag)

#cmt_local_tagfile_EDMUtilDict = $(EDMUtil_tag)_EDMUtilDict.make
cmt_local_tagfile_EDMUtilDict = $(bin)$(EDMUtil_tag)_EDMUtilDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

EDMUtil_tag = $(tag)

#cmt_local_tagfile_EDMUtilDict = $(EDMUtil_tag).make
cmt_local_tagfile_EDMUtilDict = $(bin)$(EDMUtil_tag).make

endif

include $(cmt_local_tagfile_EDMUtilDict)
#-include $(cmt_local_tagfile_EDMUtilDict)

ifdef cmt_EDMUtilDict_has_target_tag

cmt_final_setup_EDMUtilDict = $(bin)setup_EDMUtilDict.make
cmt_dependencies_in_EDMUtilDict = $(bin)dependencies_EDMUtilDict.in
#cmt_final_setup_EDMUtilDict = $(bin)EDMUtil_EDMUtilDictsetup.make
cmt_local_EDMUtilDict_makefile = $(bin)EDMUtilDict.make

else

cmt_final_setup_EDMUtilDict = $(bin)setup.make
cmt_dependencies_in_EDMUtilDict = $(bin)dependencies.in
#cmt_final_setup_EDMUtilDict = $(bin)EDMUtilsetup.make
cmt_local_EDMUtilDict_makefile = $(bin)EDMUtilDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)EDMUtilsetup.make

#EDMUtilDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'EDMUtilDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = EDMUtilDict/
#EDMUtilDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
EDMUtilDict_output = ${src}
EDMUtilDict_dict_lists = 

EDMUtilDict :: $(EDMUtilDict_output)JobInfo.rootcint $(EDMUtilDict_output)FileMetaData.rootcint $(EDMUtilDict_output)UniqueIDTable.rootcint $(EDMUtilDict_output)SmartRef.rootcint
	@echo "------> EDMUtilDict ok"
JobInfo_h_dependencies = ../include/JobInfo.h
FileMetaData_h_dependencies = ../include/FileMetaData.h
UniqueIDTable_h_dependencies = ../include/UniqueIDTable.h
SmartRef_h_dependencies = ../EDMUtil/SmartRef.h
${src}JobInfo.rootcint : ${src}JobInfoDict.cc
	@echo $@

${src}JobInfoDict.cc : ../include/JobInfo.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../include/;$(rootcint) -f ${src}JobInfoDict.cc -c ${JobInfo_cintflags} JobInfo.h $(src)JobInfoLinkDef.h

EDMUtilDict_dict_lists += ${src}JobInfoDict.h
EDMUtilDict_dict_lists += ${src}JobInfoDict.cc
${src}FileMetaData.rootcint : ${src}FileMetaDataDict.cc
	@echo $@

${src}FileMetaDataDict.cc : ../include/FileMetaData.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../include/;$(rootcint) -f ${src}FileMetaDataDict.cc -c ${FileMetaData_cintflags} FileMetaData.h $(src)FileMetaDataLinkDef.h

EDMUtilDict_dict_lists += ${src}FileMetaDataDict.h
EDMUtilDict_dict_lists += ${src}FileMetaDataDict.cc
${src}UniqueIDTable.rootcint : ${src}UniqueIDTableDict.cc
	@echo $@

${src}UniqueIDTableDict.cc : ../include/UniqueIDTable.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../include/;$(rootcint) -f ${src}UniqueIDTableDict.cc -c ${UniqueIDTable_cintflags} UniqueIDTable.h $(src)UniqueIDTableLinkDef.h

EDMUtilDict_dict_lists += ${src}UniqueIDTableDict.h
EDMUtilDict_dict_lists += ${src}UniqueIDTableDict.cc
${src}SmartRef.rootcint : ${src}SmartRefDict.cc
	@echo $@

${src}SmartRefDict.cc : ../EDMUtil/SmartRef.h
	@echo Generating ROOT Dictionary $@ 
	@-mkdir -p ${src} 
	cd ../EDMUtil/;$(rootcint) -f ${src}SmartRefDict.cc -c ${SmartRef_cintflags} SmartRef.h $(src)SmartRefLinkDef.h

EDMUtilDict_dict_lists += ${src}SmartRefDict.h
EDMUtilDict_dict_lists += ${src}SmartRefDict.cc
clean :: EDMUtilDictclean
	@cd .

EDMUtilDictclean ::
	$(cleanup_echo) ROOT dictionary
	-$(cleanup_silent) rm -f $(dict)*~;\
	rm -f $(dict)EDMUtilDict.*;\
	rm -f $(bin)EDMUtilDict.*
	rm -f $(EDMUtilDict_dict_lists)

#-- start of cleanup_header --------------

clean :: EDMUtilDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(EDMUtilDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

EDMUtilDictclean ::
#-- end of cleanup_header ---------------

#-- start of make_header -----------------

#====================================
#  Document ElecEventObj2Doth
#
#   Generated Fri Jul 10 19:20:28 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_ElecEventObj2Doth_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ElecEventObj2Doth_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ElecEventObj2Doth

ElecEvent_tag = $(tag)

#cmt_local_tagfile_ElecEventObj2Doth = $(ElecEvent_tag)_ElecEventObj2Doth.make
cmt_local_tagfile_ElecEventObj2Doth = $(bin)$(ElecEvent_tag)_ElecEventObj2Doth.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ElecEvent_tag = $(tag)

#cmt_local_tagfile_ElecEventObj2Doth = $(ElecEvent_tag).make
cmt_local_tagfile_ElecEventObj2Doth = $(bin)$(ElecEvent_tag).make

endif

include $(cmt_local_tagfile_ElecEventObj2Doth)
#-include $(cmt_local_tagfile_ElecEventObj2Doth)

ifdef cmt_ElecEventObj2Doth_has_target_tag

cmt_final_setup_ElecEventObj2Doth = $(bin)setup_ElecEventObj2Doth.make
cmt_dependencies_in_ElecEventObj2Doth = $(bin)dependencies_ElecEventObj2Doth.in
#cmt_final_setup_ElecEventObj2Doth = $(bin)ElecEvent_ElecEventObj2Dothsetup.make
cmt_local_ElecEventObj2Doth_makefile = $(bin)ElecEventObj2Doth.make

else

cmt_final_setup_ElecEventObj2Doth = $(bin)setup.make
cmt_dependencies_in_ElecEventObj2Doth = $(bin)dependencies.in
#cmt_final_setup_ElecEventObj2Doth = $(bin)ElecEventsetup.make
cmt_local_ElecEventObj2Doth_makefile = $(bin)ElecEventObj2Doth.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ElecEventsetup.make

#ElecEventObj2Doth :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ElecEventObj2Doth'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ElecEventObj2Doth/
#ElecEventObj2Doth::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------

pythonexe     = python
parsetool     = $(XMLOBJDESCROOT)/scripts/godII.py
dest          = ../Event/
dtdfile       = ../$(xmlsrc)/xdd.dtd 

ElecEventObj2Doth_output = $(dest)


ElecEventObj2Doth :: $(dtdfile)
	@echo "-----> ElecEventObj2Doth ok"



$(dtdfile) : $(XMLOBJDESCROOT)/xml_files/xdd.dtd
	@echo "Copying global DTD to current package"
	@cp $(XMLOBJDESCROOT)/xml_files/xdd.dtd $(dtdfile)

ElecEventObj2Doth_headerlist = 
ElecEventObj2Doth_obj2dothlist = 
ElecEventObj2Doth_cleanuplist =


ElecFeeCrate_xml_dependencies = ../xml/ElecFeeCrate.xml
SpmtElecAbcBlock_xml_dependencies = ../xml/SpmtElecAbcBlock.xml
ElecHeader_xml_dependencies = ../xml/ElecHeader.xml
ElecEvent_xml_dependencies = ../xml/ElecEvent.xml
SpmtElecEvent_xml_dependencies = ../xml/SpmtElecEvent.xml
ElecFeeChannel_xml_dependencies = ../xml/ElecFeeChannel.xml
ElecEventObj2Doth :: $(dest)ElecFeeCrate.h

ElecEventObj2Doth_headerlist += $(dest)ElecFeeCrate.h
ElecEventObj2Doth_obj2dothlist += $(dest)ElecFeeCrate.obj2doth

$(dest)ElecFeeCrate.h : $(dest)ElecFeeCrate.obj2doth

$(dest)ElecFeeCrate.obj2doth : ../xml/ElecFeeCrate.xml
	@echo Producing Header files from ../xml/ElecFeeCrate.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(ElecEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/ElecFeeCrate.xml
	@echo /dev/null > $(dest)ElecFeeCrate.obj2doth


ElecEventObj2Doth_cleanuplist += $(dest)ElecFeeCrate.obj2doth
ElecEventObj2Doth_cleanuplist += $(dest)ElecFeeCrate.h
ElecEventObj2Doth_cleanuplist += $(src)ElecFeeCrateLinkDef.h
ElecEventObj2Doth :: $(dest)SpmtElecAbcBlock.h

ElecEventObj2Doth_headerlist += $(dest)SpmtElecAbcBlock.h
ElecEventObj2Doth_obj2dothlist += $(dest)SpmtElecAbcBlock.obj2doth

$(dest)SpmtElecAbcBlock.h : $(dest)SpmtElecAbcBlock.obj2doth

$(dest)SpmtElecAbcBlock.obj2doth : ../xml/SpmtElecAbcBlock.xml
	@echo Producing Header files from ../xml/SpmtElecAbcBlock.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(ElecEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/SpmtElecAbcBlock.xml
	@echo /dev/null > $(dest)SpmtElecAbcBlock.obj2doth


ElecEventObj2Doth_cleanuplist += $(dest)SpmtElecAbcBlock.obj2doth
ElecEventObj2Doth_cleanuplist += $(dest)SpmtElecAbcBlock.h
ElecEventObj2Doth_cleanuplist += $(src)SpmtElecAbcBlockLinkDef.h
ElecEventObj2Doth :: $(dest)ElecHeader.h

ElecEventObj2Doth_headerlist += $(dest)ElecHeader.h
ElecEventObj2Doth_obj2dothlist += $(dest)ElecHeader.obj2doth

$(dest)ElecHeader.h : $(dest)ElecHeader.obj2doth

$(dest)ElecHeader.obj2doth : ../xml/ElecHeader.xml
	@echo Producing Header files from ../xml/ElecHeader.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(ElecEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/ElecHeader.xml
	@echo /dev/null > $(dest)ElecHeader.obj2doth


ElecEventObj2Doth_cleanuplist += $(dest)ElecHeader.obj2doth
ElecEventObj2Doth_cleanuplist += $(dest)ElecHeader.h
ElecEventObj2Doth_cleanuplist += $(src)ElecHeaderLinkDef.h
ElecEventObj2Doth :: $(dest)ElecEvent.h

ElecEventObj2Doth_headerlist += $(dest)ElecEvent.h
ElecEventObj2Doth_obj2dothlist += $(dest)ElecEvent.obj2doth

$(dest)ElecEvent.h : $(dest)ElecEvent.obj2doth

$(dest)ElecEvent.obj2doth : ../xml/ElecEvent.xml
	@echo Producing Header files from ../xml/ElecEvent.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(ElecEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/ElecEvent.xml
	@echo /dev/null > $(dest)ElecEvent.obj2doth


ElecEventObj2Doth_cleanuplist += $(dest)ElecEvent.obj2doth
ElecEventObj2Doth_cleanuplist += $(dest)ElecEvent.h
ElecEventObj2Doth_cleanuplist += $(src)ElecEventLinkDef.h
ElecEventObj2Doth :: $(dest)SpmtElecEvent.h

ElecEventObj2Doth_headerlist += $(dest)SpmtElecEvent.h
ElecEventObj2Doth_obj2dothlist += $(dest)SpmtElecEvent.obj2doth

$(dest)SpmtElecEvent.h : $(dest)SpmtElecEvent.obj2doth

$(dest)SpmtElecEvent.obj2doth : ../xml/SpmtElecEvent.xml
	@echo Producing Header files from ../xml/SpmtElecEvent.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(ElecEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/SpmtElecEvent.xml
	@echo /dev/null > $(dest)SpmtElecEvent.obj2doth


ElecEventObj2Doth_cleanuplist += $(dest)SpmtElecEvent.obj2doth
ElecEventObj2Doth_cleanuplist += $(dest)SpmtElecEvent.h
ElecEventObj2Doth_cleanuplist += $(src)SpmtElecEventLinkDef.h
ElecEventObj2Doth :: $(dest)ElecFeeChannel.h

ElecEventObj2Doth_headerlist += $(dest)ElecFeeChannel.h
ElecEventObj2Doth_obj2dothlist += $(dest)ElecFeeChannel.obj2doth

$(dest)ElecFeeChannel.h : $(dest)ElecFeeChannel.obj2doth

$(dest)ElecFeeChannel.obj2doth : ../xml/ElecFeeChannel.xml
	@echo Producing Header files from ../xml/ElecFeeChannel.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(ElecEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/ElecFeeChannel.xml
	@echo /dev/null > $(dest)ElecFeeChannel.obj2doth


ElecEventObj2Doth_cleanuplist += $(dest)ElecFeeChannel.obj2doth
ElecEventObj2Doth_cleanuplist += $(dest)ElecFeeChannel.h
ElecEventObj2Doth_cleanuplist += $(src)ElecFeeChannelLinkDef.h

ElecEventObj2Doth_cleanuplist += $(ElecEventObj2Doth_headerlist)
ElecEventObj2Doth_cleanuplist += $(ElecEventObj2Doth_obj2dothlist)
 
clean :: ElecEventObj2Dothclean
	@cd .



ElecEventObj2Dothclean ::
	echo $(listof2h)
	$(cleanup_echo) .obj2doth files:
	-$(cleanup_silent) rm -f $(ElecEventObj2Doth_cleanuplist)
	-$(cleanup_silent) rm -f $(dtdfile)


#-- start of cleanup_header --------------

clean :: ElecEventObj2Dothclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ElecEventObj2Doth.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ElecEventObj2Dothclean ::
#-- end of cleanup_header ---------------

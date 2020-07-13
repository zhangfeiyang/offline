#-- start of make_header -----------------

#====================================
#  Document CalibEventObj2Doth
#
#   Generated Fri Jul 10 19:18:49 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_CalibEventObj2Doth_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_CalibEventObj2Doth_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_CalibEventObj2Doth

CalibEvent_tag = $(tag)

#cmt_local_tagfile_CalibEventObj2Doth = $(CalibEvent_tag)_CalibEventObj2Doth.make
cmt_local_tagfile_CalibEventObj2Doth = $(bin)$(CalibEvent_tag)_CalibEventObj2Doth.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CalibEvent_tag = $(tag)

#cmt_local_tagfile_CalibEventObj2Doth = $(CalibEvent_tag).make
cmt_local_tagfile_CalibEventObj2Doth = $(bin)$(CalibEvent_tag).make

endif

include $(cmt_local_tagfile_CalibEventObj2Doth)
#-include $(cmt_local_tagfile_CalibEventObj2Doth)

ifdef cmt_CalibEventObj2Doth_has_target_tag

cmt_final_setup_CalibEventObj2Doth = $(bin)setup_CalibEventObj2Doth.make
cmt_dependencies_in_CalibEventObj2Doth = $(bin)dependencies_CalibEventObj2Doth.in
#cmt_final_setup_CalibEventObj2Doth = $(bin)CalibEvent_CalibEventObj2Dothsetup.make
cmt_local_CalibEventObj2Doth_makefile = $(bin)CalibEventObj2Doth.make

else

cmt_final_setup_CalibEventObj2Doth = $(bin)setup.make
cmt_dependencies_in_CalibEventObj2Doth = $(bin)dependencies.in
#cmt_final_setup_CalibEventObj2Doth = $(bin)CalibEventsetup.make
cmt_local_CalibEventObj2Doth_makefile = $(bin)CalibEventObj2Doth.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CalibEventsetup.make

#CalibEventObj2Doth :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'CalibEventObj2Doth'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = CalibEventObj2Doth/
#CalibEventObj2Doth::
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

CalibEventObj2Doth_output = $(dest)


CalibEventObj2Doth :: $(dtdfile)
	@echo "-----> CalibEventObj2Doth ok"



$(dtdfile) : $(XMLOBJDESCROOT)/xml_files/xdd.dtd
	@echo "Copying global DTD to current package"
	@cp $(XMLOBJDESCROOT)/xml_files/xdd.dtd $(dtdfile)

CalibEventObj2Doth_headerlist = 
CalibEventObj2Doth_obj2dothlist = 
CalibEventObj2Doth_cleanuplist =


TTCalibEvent_xml_dependencies = ../xml/TTCalibEvent.xml
CalibEvent_xml_dependencies = ../xml/CalibEvent.xml
CalibTTChannel_xml_dependencies = ../xml/CalibTTChannel.xml
CalibHeader_xml_dependencies = ../xml/CalibHeader.xml
CalibPMTChannel_xml_dependencies = ../xml/CalibPMTChannel.xml
CalibEventObj2Doth :: $(dest)TTCalibEvent.h

CalibEventObj2Doth_headerlist += $(dest)TTCalibEvent.h
CalibEventObj2Doth_obj2dothlist += $(dest)TTCalibEvent.obj2doth

$(dest)TTCalibEvent.h : $(dest)TTCalibEvent.obj2doth

$(dest)TTCalibEvent.obj2doth : ../xml/TTCalibEvent.xml
	@echo Producing Header files from ../xml/TTCalibEvent.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(CalibEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/TTCalibEvent.xml
	@echo /dev/null > $(dest)TTCalibEvent.obj2doth


CalibEventObj2Doth_cleanuplist += $(dest)TTCalibEvent.obj2doth
CalibEventObj2Doth_cleanuplist += $(dest)TTCalibEvent.h
CalibEventObj2Doth_cleanuplist += $(src)TTCalibEventLinkDef.h
CalibEventObj2Doth :: $(dest)CalibEvent.h

CalibEventObj2Doth_headerlist += $(dest)CalibEvent.h
CalibEventObj2Doth_obj2dothlist += $(dest)CalibEvent.obj2doth

$(dest)CalibEvent.h : $(dest)CalibEvent.obj2doth

$(dest)CalibEvent.obj2doth : ../xml/CalibEvent.xml
	@echo Producing Header files from ../xml/CalibEvent.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(CalibEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/CalibEvent.xml
	@echo /dev/null > $(dest)CalibEvent.obj2doth


CalibEventObj2Doth_cleanuplist += $(dest)CalibEvent.obj2doth
CalibEventObj2Doth_cleanuplist += $(dest)CalibEvent.h
CalibEventObj2Doth_cleanuplist += $(src)CalibEventLinkDef.h
CalibEventObj2Doth :: $(dest)CalibTTChannel.h

CalibEventObj2Doth_headerlist += $(dest)CalibTTChannel.h
CalibEventObj2Doth_obj2dothlist += $(dest)CalibTTChannel.obj2doth

$(dest)CalibTTChannel.h : $(dest)CalibTTChannel.obj2doth

$(dest)CalibTTChannel.obj2doth : ../xml/CalibTTChannel.xml
	@echo Producing Header files from ../xml/CalibTTChannel.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(CalibEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/CalibTTChannel.xml
	@echo /dev/null > $(dest)CalibTTChannel.obj2doth


CalibEventObj2Doth_cleanuplist += $(dest)CalibTTChannel.obj2doth
CalibEventObj2Doth_cleanuplist += $(dest)CalibTTChannel.h
CalibEventObj2Doth_cleanuplist += $(src)CalibTTChannelLinkDef.h
CalibEventObj2Doth :: $(dest)CalibHeader.h

CalibEventObj2Doth_headerlist += $(dest)CalibHeader.h
CalibEventObj2Doth_obj2dothlist += $(dest)CalibHeader.obj2doth

$(dest)CalibHeader.h : $(dest)CalibHeader.obj2doth

$(dest)CalibHeader.obj2doth : ../xml/CalibHeader.xml
	@echo Producing Header files from ../xml/CalibHeader.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(CalibEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/CalibHeader.xml
	@echo /dev/null > $(dest)CalibHeader.obj2doth


CalibEventObj2Doth_cleanuplist += $(dest)CalibHeader.obj2doth
CalibEventObj2Doth_cleanuplist += $(dest)CalibHeader.h
CalibEventObj2Doth_cleanuplist += $(src)CalibHeaderLinkDef.h
CalibEventObj2Doth :: $(dest)CalibPMTChannel.h

CalibEventObj2Doth_headerlist += $(dest)CalibPMTChannel.h
CalibEventObj2Doth_obj2dothlist += $(dest)CalibPMTChannel.obj2doth

$(dest)CalibPMTChannel.h : $(dest)CalibPMTChannel.obj2doth

$(dest)CalibPMTChannel.obj2doth : ../xml/CalibPMTChannel.xml
	@echo Producing Header files from ../xml/CalibPMTChannel.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(CalibEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/CalibPMTChannel.xml
	@echo /dev/null > $(dest)CalibPMTChannel.obj2doth


CalibEventObj2Doth_cleanuplist += $(dest)CalibPMTChannel.obj2doth
CalibEventObj2Doth_cleanuplist += $(dest)CalibPMTChannel.h
CalibEventObj2Doth_cleanuplist += $(src)CalibPMTChannelLinkDef.h

CalibEventObj2Doth_cleanuplist += $(CalibEventObj2Doth_headerlist)
CalibEventObj2Doth_cleanuplist += $(CalibEventObj2Doth_obj2dothlist)
 
clean :: CalibEventObj2Dothclean
	@cd .



CalibEventObj2Dothclean ::
	echo $(listof2h)
	$(cleanup_echo) .obj2doth files:
	-$(cleanup_silent) rm -f $(CalibEventObj2Doth_cleanuplist)
	-$(cleanup_silent) rm -f $(dtdfile)


#-- start of cleanup_header --------------

clean :: CalibEventObj2Dothclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(CalibEventObj2Doth.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

CalibEventObj2Dothclean ::
#-- end of cleanup_header ---------------

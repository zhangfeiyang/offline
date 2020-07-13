#-- start of make_header -----------------

#====================================
#  Document RecEventObj2Doth
#
#   Generated Fri Jul 10 19:18:55 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RecEventObj2Doth_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RecEventObj2Doth_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RecEventObj2Doth

RecEvent_tag = $(tag)

#cmt_local_tagfile_RecEventObj2Doth = $(RecEvent_tag)_RecEventObj2Doth.make
cmt_local_tagfile_RecEventObj2Doth = $(bin)$(RecEvent_tag)_RecEventObj2Doth.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RecEvent_tag = $(tag)

#cmt_local_tagfile_RecEventObj2Doth = $(RecEvent_tag).make
cmt_local_tagfile_RecEventObj2Doth = $(bin)$(RecEvent_tag).make

endif

include $(cmt_local_tagfile_RecEventObj2Doth)
#-include $(cmt_local_tagfile_RecEventObj2Doth)

ifdef cmt_RecEventObj2Doth_has_target_tag

cmt_final_setup_RecEventObj2Doth = $(bin)setup_RecEventObj2Doth.make
cmt_dependencies_in_RecEventObj2Doth = $(bin)dependencies_RecEventObj2Doth.in
#cmt_final_setup_RecEventObj2Doth = $(bin)RecEvent_RecEventObj2Dothsetup.make
cmt_local_RecEventObj2Doth_makefile = $(bin)RecEventObj2Doth.make

else

cmt_final_setup_RecEventObj2Doth = $(bin)setup.make
cmt_dependencies_in_RecEventObj2Doth = $(bin)dependencies.in
#cmt_final_setup_RecEventObj2Doth = $(bin)RecEventsetup.make
cmt_local_RecEventObj2Doth_makefile = $(bin)RecEventObj2Doth.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RecEventsetup.make

#RecEventObj2Doth :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RecEventObj2Doth'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RecEventObj2Doth/
#RecEventObj2Doth::
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

RecEventObj2Doth_output = $(dest)


RecEventObj2Doth :: $(dtdfile)
	@echo "-----> RecEventObj2Doth ok"



$(dtdfile) : $(XMLOBJDESCROOT)/xml_files/xdd.dtd
	@echo "Copying global DTD to current package"
	@cp $(XMLOBJDESCROOT)/xml_files/xdd.dtd $(dtdfile)

RecEventObj2Doth_headerlist = 
RecEventObj2Doth_obj2dothlist = 
RecEventObj2Doth_cleanuplist =


WPRecEvent_xml_dependencies = ../xml/WPRecEvent.xml
RecHeader_xml_dependencies = ../xml/RecHeader.xml
TTRecEvent_xml_dependencies = ../xml/TTRecEvent.xml
CDTrackRecEvent_xml_dependencies = ../xml/CDTrackRecEvent.xml
CDRecEvent_xml_dependencies = ../xml/CDRecEvent.xml
RecTrack_xml_dependencies = ../xml/RecTrack.xml
RecEventObj2Doth :: $(dest)WPRecEvent.h

RecEventObj2Doth_headerlist += $(dest)WPRecEvent.h
RecEventObj2Doth_obj2dothlist += $(dest)WPRecEvent.obj2doth

$(dest)WPRecEvent.h : $(dest)WPRecEvent.obj2doth

$(dest)WPRecEvent.obj2doth : ../xml/WPRecEvent.xml
	@echo Producing Header files from ../xml/WPRecEvent.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(RecEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/WPRecEvent.xml
	@echo /dev/null > $(dest)WPRecEvent.obj2doth


RecEventObj2Doth_cleanuplist += $(dest)WPRecEvent.obj2doth
RecEventObj2Doth_cleanuplist += $(dest)WPRecEvent.h
RecEventObj2Doth_cleanuplist += $(src)WPRecEventLinkDef.h
RecEventObj2Doth :: $(dest)RecHeader.h

RecEventObj2Doth_headerlist += $(dest)RecHeader.h
RecEventObj2Doth_obj2dothlist += $(dest)RecHeader.obj2doth

$(dest)RecHeader.h : $(dest)RecHeader.obj2doth

$(dest)RecHeader.obj2doth : ../xml/RecHeader.xml
	@echo Producing Header files from ../xml/RecHeader.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(RecEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/RecHeader.xml
	@echo /dev/null > $(dest)RecHeader.obj2doth


RecEventObj2Doth_cleanuplist += $(dest)RecHeader.obj2doth
RecEventObj2Doth_cleanuplist += $(dest)RecHeader.h
RecEventObj2Doth_cleanuplist += $(src)RecHeaderLinkDef.h
RecEventObj2Doth :: $(dest)TTRecEvent.h

RecEventObj2Doth_headerlist += $(dest)TTRecEvent.h
RecEventObj2Doth_obj2dothlist += $(dest)TTRecEvent.obj2doth

$(dest)TTRecEvent.h : $(dest)TTRecEvent.obj2doth

$(dest)TTRecEvent.obj2doth : ../xml/TTRecEvent.xml
	@echo Producing Header files from ../xml/TTRecEvent.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(RecEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/TTRecEvent.xml
	@echo /dev/null > $(dest)TTRecEvent.obj2doth


RecEventObj2Doth_cleanuplist += $(dest)TTRecEvent.obj2doth
RecEventObj2Doth_cleanuplist += $(dest)TTRecEvent.h
RecEventObj2Doth_cleanuplist += $(src)TTRecEventLinkDef.h
RecEventObj2Doth :: $(dest)CDTrackRecEvent.h

RecEventObj2Doth_headerlist += $(dest)CDTrackRecEvent.h
RecEventObj2Doth_obj2dothlist += $(dest)CDTrackRecEvent.obj2doth

$(dest)CDTrackRecEvent.h : $(dest)CDTrackRecEvent.obj2doth

$(dest)CDTrackRecEvent.obj2doth : ../xml/CDTrackRecEvent.xml
	@echo Producing Header files from ../xml/CDTrackRecEvent.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(RecEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/CDTrackRecEvent.xml
	@echo /dev/null > $(dest)CDTrackRecEvent.obj2doth


RecEventObj2Doth_cleanuplist += $(dest)CDTrackRecEvent.obj2doth
RecEventObj2Doth_cleanuplist += $(dest)CDTrackRecEvent.h
RecEventObj2Doth_cleanuplist += $(src)CDTrackRecEventLinkDef.h
RecEventObj2Doth :: $(dest)CDRecEvent.h

RecEventObj2Doth_headerlist += $(dest)CDRecEvent.h
RecEventObj2Doth_obj2dothlist += $(dest)CDRecEvent.obj2doth

$(dest)CDRecEvent.h : $(dest)CDRecEvent.obj2doth

$(dest)CDRecEvent.obj2doth : ../xml/CDRecEvent.xml
	@echo Producing Header files from ../xml/CDRecEvent.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(RecEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/CDRecEvent.xml
	@echo /dev/null > $(dest)CDRecEvent.obj2doth


RecEventObj2Doth_cleanuplist += $(dest)CDRecEvent.obj2doth
RecEventObj2Doth_cleanuplist += $(dest)CDRecEvent.h
RecEventObj2Doth_cleanuplist += $(src)CDRecEventLinkDef.h
RecEventObj2Doth :: $(dest)RecTrack.h

RecEventObj2Doth_headerlist += $(dest)RecTrack.h
RecEventObj2Doth_obj2dothlist += $(dest)RecTrack.obj2doth

$(dest)RecTrack.h : $(dest)RecTrack.obj2doth

$(dest)RecTrack.obj2doth : ../xml/RecTrack.xml
	@echo Producing Header files from ../xml/RecTrack.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(RecEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/RecTrack.xml
	@echo /dev/null > $(dest)RecTrack.obj2doth


RecEventObj2Doth_cleanuplist += $(dest)RecTrack.obj2doth
RecEventObj2Doth_cleanuplist += $(dest)RecTrack.h
RecEventObj2Doth_cleanuplist += $(src)RecTrackLinkDef.h

RecEventObj2Doth_cleanuplist += $(RecEventObj2Doth_headerlist)
RecEventObj2Doth_cleanuplist += $(RecEventObj2Doth_obj2dothlist)
 
clean :: RecEventObj2Dothclean
	@cd .



RecEventObj2Dothclean ::
	echo $(listof2h)
	$(cleanup_echo) .obj2doth files:
	-$(cleanup_silent) rm -f $(RecEventObj2Doth_cleanuplist)
	-$(cleanup_silent) rm -f $(dtdfile)


#-- start of cleanup_header --------------

clean :: RecEventObj2Dothclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RecEventObj2Doth.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RecEventObj2Dothclean ::
#-- end of cleanup_header ---------------

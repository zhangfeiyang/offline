#-- start of make_header -----------------

#====================================
#  Document BaseEventObj2Doth
#
#   Generated Fri Jul 10 19:17:34 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_BaseEventObj2Doth_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_BaseEventObj2Doth_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_BaseEventObj2Doth

BaseEvent_tag = $(tag)

#cmt_local_tagfile_BaseEventObj2Doth = $(BaseEvent_tag)_BaseEventObj2Doth.make
cmt_local_tagfile_BaseEventObj2Doth = $(bin)$(BaseEvent_tag)_BaseEventObj2Doth.make

else

tags      = $(tag),$(CMTEXTRATAGS)

BaseEvent_tag = $(tag)

#cmt_local_tagfile_BaseEventObj2Doth = $(BaseEvent_tag).make
cmt_local_tagfile_BaseEventObj2Doth = $(bin)$(BaseEvent_tag).make

endif

include $(cmt_local_tagfile_BaseEventObj2Doth)
#-include $(cmt_local_tagfile_BaseEventObj2Doth)

ifdef cmt_BaseEventObj2Doth_has_target_tag

cmt_final_setup_BaseEventObj2Doth = $(bin)setup_BaseEventObj2Doth.make
cmt_dependencies_in_BaseEventObj2Doth = $(bin)dependencies_BaseEventObj2Doth.in
#cmt_final_setup_BaseEventObj2Doth = $(bin)BaseEvent_BaseEventObj2Dothsetup.make
cmt_local_BaseEventObj2Doth_makefile = $(bin)BaseEventObj2Doth.make

else

cmt_final_setup_BaseEventObj2Doth = $(bin)setup.make
cmt_dependencies_in_BaseEventObj2Doth = $(bin)dependencies.in
#cmt_final_setup_BaseEventObj2Doth = $(bin)BaseEventsetup.make
cmt_local_BaseEventObj2Doth_makefile = $(bin)BaseEventObj2Doth.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)BaseEventsetup.make

#BaseEventObj2Doth :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'BaseEventObj2Doth'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = BaseEventObj2Doth/
#BaseEventObj2Doth::
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

BaseEventObj2Doth_output = $(dest)


BaseEventObj2Doth :: $(dtdfile)
	@echo "-----> BaseEventObj2Doth ok"



$(dtdfile) : $(XMLOBJDESCROOT)/xml_files/xdd.dtd
	@echo "Copying global DTD to current package"
	@cp $(XMLOBJDESCROOT)/xml_files/xdd.dtd $(dtdfile)

BaseEventObj2Doth_headerlist = 
BaseEventObj2Doth_obj2dothlist = 
BaseEventObj2Doth_cleanuplist =


HeaderObject_xml_dependencies = ../xml/HeaderObject.xml
EventObject_xml_dependencies = ../xml/EventObject.xml
BaseEventObj2Doth :: $(dest)HeaderObject.h

BaseEventObj2Doth_headerlist += $(dest)HeaderObject.h
BaseEventObj2Doth_obj2dothlist += $(dest)HeaderObject.obj2doth

$(dest)HeaderObject.h : $(dest)HeaderObject.obj2doth

$(dest)HeaderObject.obj2doth : ../xml/HeaderObject.xml
	@echo Producing Header files from ../xml/HeaderObject.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(BaseEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/HeaderObject.xml
	@echo /dev/null > $(dest)HeaderObject.obj2doth


BaseEventObj2Doth_cleanuplist += $(dest)HeaderObject.obj2doth
BaseEventObj2Doth_cleanuplist += $(dest)HeaderObject.h
BaseEventObj2Doth_cleanuplist += $(src)HeaderObjectLinkDef.h
BaseEventObj2Doth :: $(dest)EventObject.h

BaseEventObj2Doth_headerlist += $(dest)EventObject.h
BaseEventObj2Doth_obj2dothlist += $(dest)EventObject.obj2doth

$(dest)EventObject.h : $(dest)EventObject.obj2doth

$(dest)EventObject.obj2doth : ../xml/EventObject.xml
	@echo Producing Header files from ../xml/EventObject.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(BaseEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/EventObject.xml
	@echo /dev/null > $(dest)EventObject.obj2doth


BaseEventObj2Doth_cleanuplist += $(dest)EventObject.obj2doth
BaseEventObj2Doth_cleanuplist += $(dest)EventObject.h
BaseEventObj2Doth_cleanuplist += $(src)EventObjectLinkDef.h

BaseEventObj2Doth_cleanuplist += $(BaseEventObj2Doth_headerlist)
BaseEventObj2Doth_cleanuplist += $(BaseEventObj2Doth_obj2dothlist)
 
clean :: BaseEventObj2Dothclean
	@cd .



BaseEventObj2Dothclean ::
	echo $(listof2h)
	$(cleanup_echo) .obj2doth files:
	-$(cleanup_silent) rm -f $(BaseEventObj2Doth_cleanuplist)
	-$(cleanup_silent) rm -f $(dtdfile)


#-- start of cleanup_header --------------

clean :: BaseEventObj2Dothclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(BaseEventObj2Doth.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

BaseEventObj2Dothclean ::
#-- end of cleanup_header ---------------

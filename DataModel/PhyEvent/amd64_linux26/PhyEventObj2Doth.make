#-- start of make_header -----------------

#====================================
#  Document PhyEventObj2Doth
#
#   Generated Fri Jul 10 19:18:44 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PhyEventObj2Doth_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PhyEventObj2Doth_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PhyEventObj2Doth

PhyEvent_tag = $(tag)

#cmt_local_tagfile_PhyEventObj2Doth = $(PhyEvent_tag)_PhyEventObj2Doth.make
cmt_local_tagfile_PhyEventObj2Doth = $(bin)$(PhyEvent_tag)_PhyEventObj2Doth.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PhyEvent_tag = $(tag)

#cmt_local_tagfile_PhyEventObj2Doth = $(PhyEvent_tag).make
cmt_local_tagfile_PhyEventObj2Doth = $(bin)$(PhyEvent_tag).make

endif

include $(cmt_local_tagfile_PhyEventObj2Doth)
#-include $(cmt_local_tagfile_PhyEventObj2Doth)

ifdef cmt_PhyEventObj2Doth_has_target_tag

cmt_final_setup_PhyEventObj2Doth = $(bin)setup_PhyEventObj2Doth.make
cmt_dependencies_in_PhyEventObj2Doth = $(bin)dependencies_PhyEventObj2Doth.in
#cmt_final_setup_PhyEventObj2Doth = $(bin)PhyEvent_PhyEventObj2Dothsetup.make
cmt_local_PhyEventObj2Doth_makefile = $(bin)PhyEventObj2Doth.make

else

cmt_final_setup_PhyEventObj2Doth = $(bin)setup.make
cmt_dependencies_in_PhyEventObj2Doth = $(bin)dependencies.in
#cmt_final_setup_PhyEventObj2Doth = $(bin)PhyEventsetup.make
cmt_local_PhyEventObj2Doth_makefile = $(bin)PhyEventObj2Doth.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PhyEventsetup.make

#PhyEventObj2Doth :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PhyEventObj2Doth'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PhyEventObj2Doth/
#PhyEventObj2Doth::
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

PhyEventObj2Doth_output = $(dest)


PhyEventObj2Doth :: $(dtdfile)
	@echo "-----> PhyEventObj2Doth ok"



$(dtdfile) : $(XMLOBJDESCROOT)/xml_files/xdd.dtd
	@echo "Copying global DTD to current package"
	@cp $(XMLOBJDESCROOT)/xml_files/xdd.dtd $(dtdfile)

PhyEventObj2Doth_headerlist = 
PhyEventObj2Doth_obj2dothlist = 
PhyEventObj2Doth_cleanuplist =


PhyEvent_xml_dependencies = ../xml/PhyEvent.xml
PhyHeader_xml_dependencies = ../xml/PhyHeader.xml
PhyEventObj2Doth :: $(dest)PhyEvent.h

PhyEventObj2Doth_headerlist += $(dest)PhyEvent.h
PhyEventObj2Doth_obj2dothlist += $(dest)PhyEvent.obj2doth

$(dest)PhyEvent.h : $(dest)PhyEvent.obj2doth

$(dest)PhyEvent.obj2doth : ../xml/PhyEvent.xml
	@echo Producing Header files from ../xml/PhyEvent.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(PhyEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/PhyEvent.xml
	@echo /dev/null > $(dest)PhyEvent.obj2doth


PhyEventObj2Doth_cleanuplist += $(dest)PhyEvent.obj2doth
PhyEventObj2Doth_cleanuplist += $(dest)PhyEvent.h
PhyEventObj2Doth_cleanuplist += $(src)PhyEventLinkDef.h
PhyEventObj2Doth :: $(dest)PhyHeader.h

PhyEventObj2Doth_headerlist += $(dest)PhyHeader.h
PhyEventObj2Doth_obj2dothlist += $(dest)PhyHeader.obj2doth

$(dest)PhyHeader.h : $(dest)PhyHeader.obj2doth

$(dest)PhyHeader.obj2doth : ../xml/PhyHeader.xml
	@echo Producing Header files from ../xml/PhyHeader.xml
	@-mkdir -p $(dest)
	cd $(dest); $(pythonexe) $(parsetool) $(XODflags) $(PhyEventObj2Doth_XODflags) -f -b $(src) -g src -r $(XMLOBJDESCROOT) ../xml/PhyHeader.xml
	@echo /dev/null > $(dest)PhyHeader.obj2doth


PhyEventObj2Doth_cleanuplist += $(dest)PhyHeader.obj2doth
PhyEventObj2Doth_cleanuplist += $(dest)PhyHeader.h
PhyEventObj2Doth_cleanuplist += $(src)PhyHeaderLinkDef.h

PhyEventObj2Doth_cleanuplist += $(PhyEventObj2Doth_headerlist)
PhyEventObj2Doth_cleanuplist += $(PhyEventObj2Doth_obj2dothlist)
 
clean :: PhyEventObj2Dothclean
	@cd .



PhyEventObj2Dothclean ::
	echo $(listof2h)
	$(cleanup_echo) .obj2doth files:
	-$(cleanup_silent) rm -f $(PhyEventObj2Doth_cleanuplist)
	-$(cleanup_silent) rm -f $(dtdfile)


#-- start of cleanup_header --------------

clean :: PhyEventObj2Dothclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PhyEventObj2Doth.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PhyEventObj2Dothclean ::
#-- end of cleanup_header ---------------

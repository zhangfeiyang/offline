#-- start of make_header -----------------

#====================================
#  Document RootIOTools_python
#
#   Generated Fri Jul 10 19:27:02 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootIOTools_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootIOTools_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootIOTools_python

RootIOTools_tag = $(tag)

#cmt_local_tagfile_RootIOTools_python = $(RootIOTools_tag)_RootIOTools_python.make
cmt_local_tagfile_RootIOTools_python = $(bin)$(RootIOTools_tag)_RootIOTools_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootIOTools_tag = $(tag)

#cmt_local_tagfile_RootIOTools_python = $(RootIOTools_tag).make
cmt_local_tagfile_RootIOTools_python = $(bin)$(RootIOTools_tag).make

endif

include $(cmt_local_tagfile_RootIOTools_python)
#-include $(cmt_local_tagfile_RootIOTools_python)

ifdef cmt_RootIOTools_python_has_target_tag

cmt_final_setup_RootIOTools_python = $(bin)setup_RootIOTools_python.make
cmt_dependencies_in_RootIOTools_python = $(bin)dependencies_RootIOTools_python.in
#cmt_final_setup_RootIOTools_python = $(bin)RootIOTools_RootIOTools_pythonsetup.make
cmt_local_RootIOTools_python_makefile = $(bin)RootIOTools_python.make

else

cmt_final_setup_RootIOTools_python = $(bin)setup.make
cmt_dependencies_in_RootIOTools_python = $(bin)dependencies.in
#cmt_final_setup_RootIOTools_python = $(bin)RootIOToolssetup.make
cmt_local_RootIOTools_python_makefile = $(bin)RootIOTools_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootIOToolssetup.make

#RootIOTools_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootIOTools_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootIOTools_python/
#RootIOTools_python::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of install_python_header ------


installarea = ${CMTINSTALLAREA}
install_python_dir = $(installarea)

ifneq ($(strip "$(source)"),"")
src = ../$(source)
dest = $(install_python_dir)/python
else
src = ../python
dest = $(install_python_dir)
endif

ifneq ($(strip "$(offset)"),"")
dest = $(install_python_dir)/python
endif

RootIOTools_python :: RootIOTools_pythoninstall

install :: RootIOTools_pythoninstall

RootIOTools_pythoninstall :: $(install_python_dir)
	@if [ ! "$(installarea)" = "" ] ; then\
	  echo "installation done"; \
	fi

$(install_python_dir) ::
	@if [ "$(installarea)" = "" ] ; then \
	  echo "Cannot install header files, no installation source specified"; \
	else \
	  if [ -d $(src) ] ; then \
	    echo "Installing files from $(src) to $(dest)" ; \
	    if [ "$(offset)" = "" ] ; then \
	      $(install_command) --exclude="*.py?" $(src) $(dest) ; \
	    else \
	      $(install_command) --exclude="*.py?" $(src) $(dest) --destname $(offset); \
	    fi ; \
	  else \
	    echo "no source  $(src)"; \
	  fi; \
	fi

RootIOTools_pythonclean :: RootIOTools_pythonuninstall

uninstall :: RootIOTools_pythonuninstall

RootIOTools_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: RootIOTools_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootIOTools_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootIOTools_pythonclean ::
#-- end of cleanup_header ---------------

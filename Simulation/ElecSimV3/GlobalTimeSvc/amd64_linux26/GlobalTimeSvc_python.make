#-- start of make_header -----------------

#====================================
#  Document GlobalTimeSvc_python
#
#   Generated Fri Jul 10 19:15:14 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GlobalTimeSvc_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GlobalTimeSvc_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GlobalTimeSvc_python

GlobalTimeSvc_tag = $(tag)

#cmt_local_tagfile_GlobalTimeSvc_python = $(GlobalTimeSvc_tag)_GlobalTimeSvc_python.make
cmt_local_tagfile_GlobalTimeSvc_python = $(bin)$(GlobalTimeSvc_tag)_GlobalTimeSvc_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GlobalTimeSvc_tag = $(tag)

#cmt_local_tagfile_GlobalTimeSvc_python = $(GlobalTimeSvc_tag).make
cmt_local_tagfile_GlobalTimeSvc_python = $(bin)$(GlobalTimeSvc_tag).make

endif

include $(cmt_local_tagfile_GlobalTimeSvc_python)
#-include $(cmt_local_tagfile_GlobalTimeSvc_python)

ifdef cmt_GlobalTimeSvc_python_has_target_tag

cmt_final_setup_GlobalTimeSvc_python = $(bin)setup_GlobalTimeSvc_python.make
cmt_dependencies_in_GlobalTimeSvc_python = $(bin)dependencies_GlobalTimeSvc_python.in
#cmt_final_setup_GlobalTimeSvc_python = $(bin)GlobalTimeSvc_GlobalTimeSvc_pythonsetup.make
cmt_local_GlobalTimeSvc_python_makefile = $(bin)GlobalTimeSvc_python.make

else

cmt_final_setup_GlobalTimeSvc_python = $(bin)setup.make
cmt_dependencies_in_GlobalTimeSvc_python = $(bin)dependencies.in
#cmt_final_setup_GlobalTimeSvc_python = $(bin)GlobalTimeSvcsetup.make
cmt_local_GlobalTimeSvc_python_makefile = $(bin)GlobalTimeSvc_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GlobalTimeSvcsetup.make

#GlobalTimeSvc_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GlobalTimeSvc_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GlobalTimeSvc_python/
#GlobalTimeSvc_python::
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

GlobalTimeSvc_python :: GlobalTimeSvc_pythoninstall

install :: GlobalTimeSvc_pythoninstall

GlobalTimeSvc_pythoninstall :: $(install_python_dir)
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

GlobalTimeSvc_pythonclean :: GlobalTimeSvc_pythonuninstall

uninstall :: GlobalTimeSvc_pythonuninstall

GlobalTimeSvc_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: GlobalTimeSvc_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GlobalTimeSvc_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GlobalTimeSvc_pythonclean ::
#-- end of cleanup_header ---------------

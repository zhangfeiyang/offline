#-- start of make_header -----------------

#====================================
#  Document TTCalib_python
#
#   Generated Fri Jul 10 19:22:08 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_TTCalib_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TTCalib_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_TTCalib_python

TTCalib_tag = $(tag)

#cmt_local_tagfile_TTCalib_python = $(TTCalib_tag)_TTCalib_python.make
cmt_local_tagfile_TTCalib_python = $(bin)$(TTCalib_tag)_TTCalib_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

TTCalib_tag = $(tag)

#cmt_local_tagfile_TTCalib_python = $(TTCalib_tag).make
cmt_local_tagfile_TTCalib_python = $(bin)$(TTCalib_tag).make

endif

include $(cmt_local_tagfile_TTCalib_python)
#-include $(cmt_local_tagfile_TTCalib_python)

ifdef cmt_TTCalib_python_has_target_tag

cmt_final_setup_TTCalib_python = $(bin)setup_TTCalib_python.make
cmt_dependencies_in_TTCalib_python = $(bin)dependencies_TTCalib_python.in
#cmt_final_setup_TTCalib_python = $(bin)TTCalib_TTCalib_pythonsetup.make
cmt_local_TTCalib_python_makefile = $(bin)TTCalib_python.make

else

cmt_final_setup_TTCalib_python = $(bin)setup.make
cmt_dependencies_in_TTCalib_python = $(bin)dependencies.in
#cmt_final_setup_TTCalib_python = $(bin)TTCalibsetup.make
cmt_local_TTCalib_python_makefile = $(bin)TTCalib_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)TTCalibsetup.make

#TTCalib_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'TTCalib_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = TTCalib_python/
#TTCalib_python::
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

TTCalib_python :: TTCalib_pythoninstall

install :: TTCalib_pythoninstall

TTCalib_pythoninstall :: $(install_python_dir)
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

TTCalib_pythonclean :: TTCalib_pythonuninstall

uninstall :: TTCalib_pythonuninstall

TTCalib_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: TTCalib_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(TTCalib_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

TTCalib_pythonclean ::
#-- end of cleanup_header ---------------

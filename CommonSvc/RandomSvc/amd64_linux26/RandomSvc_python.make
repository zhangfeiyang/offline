#-- start of make_header -----------------

#====================================
#  Document RandomSvc_python
#
#   Generated Fri Jul 10 19:17:20 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RandomSvc_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RandomSvc_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RandomSvc_python

RandomSvc_tag = $(tag)

#cmt_local_tagfile_RandomSvc_python = $(RandomSvc_tag)_RandomSvc_python.make
cmt_local_tagfile_RandomSvc_python = $(bin)$(RandomSvc_tag)_RandomSvc_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RandomSvc_tag = $(tag)

#cmt_local_tagfile_RandomSvc_python = $(RandomSvc_tag).make
cmt_local_tagfile_RandomSvc_python = $(bin)$(RandomSvc_tag).make

endif

include $(cmt_local_tagfile_RandomSvc_python)
#-include $(cmt_local_tagfile_RandomSvc_python)

ifdef cmt_RandomSvc_python_has_target_tag

cmt_final_setup_RandomSvc_python = $(bin)setup_RandomSvc_python.make
cmt_dependencies_in_RandomSvc_python = $(bin)dependencies_RandomSvc_python.in
#cmt_final_setup_RandomSvc_python = $(bin)RandomSvc_RandomSvc_pythonsetup.make
cmt_local_RandomSvc_python_makefile = $(bin)RandomSvc_python.make

else

cmt_final_setup_RandomSvc_python = $(bin)setup.make
cmt_dependencies_in_RandomSvc_python = $(bin)dependencies.in
#cmt_final_setup_RandomSvc_python = $(bin)RandomSvcsetup.make
cmt_local_RandomSvc_python_makefile = $(bin)RandomSvc_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RandomSvcsetup.make

#RandomSvc_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RandomSvc_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RandomSvc_python/
#RandomSvc_python::
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

RandomSvc_python :: RandomSvc_pythoninstall

install :: RandomSvc_pythoninstall

RandomSvc_pythoninstall :: $(install_python_dir)
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

RandomSvc_pythonclean :: RandomSvc_pythonuninstall

uninstall :: RandomSvc_pythonuninstall

RandomSvc_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: RandomSvc_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RandomSvc_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RandomSvc_pythonclean ::
#-- end of cleanup_header ---------------

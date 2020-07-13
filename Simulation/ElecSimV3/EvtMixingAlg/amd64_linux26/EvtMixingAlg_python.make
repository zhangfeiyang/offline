#-- start of make_header -----------------

#====================================
#  Document EvtMixingAlg_python
#
#   Generated Fri Jul 10 19:23:01 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_EvtMixingAlg_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_EvtMixingAlg_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_EvtMixingAlg_python

EvtMixingAlg_tag = $(tag)

#cmt_local_tagfile_EvtMixingAlg_python = $(EvtMixingAlg_tag)_EvtMixingAlg_python.make
cmt_local_tagfile_EvtMixingAlg_python = $(bin)$(EvtMixingAlg_tag)_EvtMixingAlg_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

EvtMixingAlg_tag = $(tag)

#cmt_local_tagfile_EvtMixingAlg_python = $(EvtMixingAlg_tag).make
cmt_local_tagfile_EvtMixingAlg_python = $(bin)$(EvtMixingAlg_tag).make

endif

include $(cmt_local_tagfile_EvtMixingAlg_python)
#-include $(cmt_local_tagfile_EvtMixingAlg_python)

ifdef cmt_EvtMixingAlg_python_has_target_tag

cmt_final_setup_EvtMixingAlg_python = $(bin)setup_EvtMixingAlg_python.make
cmt_dependencies_in_EvtMixingAlg_python = $(bin)dependencies_EvtMixingAlg_python.in
#cmt_final_setup_EvtMixingAlg_python = $(bin)EvtMixingAlg_EvtMixingAlg_pythonsetup.make
cmt_local_EvtMixingAlg_python_makefile = $(bin)EvtMixingAlg_python.make

else

cmt_final_setup_EvtMixingAlg_python = $(bin)setup.make
cmt_dependencies_in_EvtMixingAlg_python = $(bin)dependencies.in
#cmt_final_setup_EvtMixingAlg_python = $(bin)EvtMixingAlgsetup.make
cmt_local_EvtMixingAlg_python_makefile = $(bin)EvtMixingAlg_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)EvtMixingAlgsetup.make

#EvtMixingAlg_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'EvtMixingAlg_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = EvtMixingAlg_python/
#EvtMixingAlg_python::
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

EvtMixingAlg_python :: EvtMixingAlg_pythoninstall

install :: EvtMixingAlg_pythoninstall

EvtMixingAlg_pythoninstall :: $(install_python_dir)
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

EvtMixingAlg_pythonclean :: EvtMixingAlg_pythonuninstall

uninstall :: EvtMixingAlg_pythonuninstall

EvtMixingAlg_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: EvtMixingAlg_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(EvtMixingAlg_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

EvtMixingAlg_pythonclean ::
#-- end of cleanup_header ---------------

#-- start of make_header -----------------

#====================================
#  Document UnpackingAlg_python
#
#   Generated Fri Jul 10 19:23:22 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_UnpackingAlg_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_UnpackingAlg_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_UnpackingAlg_python

UnpackingAlg_tag = $(tag)

#cmt_local_tagfile_UnpackingAlg_python = $(UnpackingAlg_tag)_UnpackingAlg_python.make
cmt_local_tagfile_UnpackingAlg_python = $(bin)$(UnpackingAlg_tag)_UnpackingAlg_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

UnpackingAlg_tag = $(tag)

#cmt_local_tagfile_UnpackingAlg_python = $(UnpackingAlg_tag).make
cmt_local_tagfile_UnpackingAlg_python = $(bin)$(UnpackingAlg_tag).make

endif

include $(cmt_local_tagfile_UnpackingAlg_python)
#-include $(cmt_local_tagfile_UnpackingAlg_python)

ifdef cmt_UnpackingAlg_python_has_target_tag

cmt_final_setup_UnpackingAlg_python = $(bin)setup_UnpackingAlg_python.make
cmt_dependencies_in_UnpackingAlg_python = $(bin)dependencies_UnpackingAlg_python.in
#cmt_final_setup_UnpackingAlg_python = $(bin)UnpackingAlg_UnpackingAlg_pythonsetup.make
cmt_local_UnpackingAlg_python_makefile = $(bin)UnpackingAlg_python.make

else

cmt_final_setup_UnpackingAlg_python = $(bin)setup.make
cmt_dependencies_in_UnpackingAlg_python = $(bin)dependencies.in
#cmt_final_setup_UnpackingAlg_python = $(bin)UnpackingAlgsetup.make
cmt_local_UnpackingAlg_python_makefile = $(bin)UnpackingAlg_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)UnpackingAlgsetup.make

#UnpackingAlg_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'UnpackingAlg_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = UnpackingAlg_python/
#UnpackingAlg_python::
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

UnpackingAlg_python :: UnpackingAlg_pythoninstall

install :: UnpackingAlg_pythoninstall

UnpackingAlg_pythoninstall :: $(install_python_dir)
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

UnpackingAlg_pythonclean :: UnpackingAlg_pythonuninstall

uninstall :: UnpackingAlg_pythonuninstall

UnpackingAlg_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: UnpackingAlg_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(UnpackingAlg_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

UnpackingAlg_pythonclean ::
#-- end of cleanup_header ---------------

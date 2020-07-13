#-- start of make_header -----------------

#====================================
#  Document PMTSimAlg_python
#
#   Generated Fri Jul 10 19:23:32 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PMTSimAlg_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PMTSimAlg_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PMTSimAlg_python

PMTSimAlg_tag = $(tag)

#cmt_local_tagfile_PMTSimAlg_python = $(PMTSimAlg_tag)_PMTSimAlg_python.make
cmt_local_tagfile_PMTSimAlg_python = $(bin)$(PMTSimAlg_tag)_PMTSimAlg_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PMTSimAlg_tag = $(tag)

#cmt_local_tagfile_PMTSimAlg_python = $(PMTSimAlg_tag).make
cmt_local_tagfile_PMTSimAlg_python = $(bin)$(PMTSimAlg_tag).make

endif

include $(cmt_local_tagfile_PMTSimAlg_python)
#-include $(cmt_local_tagfile_PMTSimAlg_python)

ifdef cmt_PMTSimAlg_python_has_target_tag

cmt_final_setup_PMTSimAlg_python = $(bin)setup_PMTSimAlg_python.make
cmt_dependencies_in_PMTSimAlg_python = $(bin)dependencies_PMTSimAlg_python.in
#cmt_final_setup_PMTSimAlg_python = $(bin)PMTSimAlg_PMTSimAlg_pythonsetup.make
cmt_local_PMTSimAlg_python_makefile = $(bin)PMTSimAlg_python.make

else

cmt_final_setup_PMTSimAlg_python = $(bin)setup.make
cmt_dependencies_in_PMTSimAlg_python = $(bin)dependencies.in
#cmt_final_setup_PMTSimAlg_python = $(bin)PMTSimAlgsetup.make
cmt_local_PMTSimAlg_python_makefile = $(bin)PMTSimAlg_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PMTSimAlgsetup.make

#PMTSimAlg_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PMTSimAlg_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PMTSimAlg_python/
#PMTSimAlg_python::
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

PMTSimAlg_python :: PMTSimAlg_pythoninstall

install :: PMTSimAlg_pythoninstall

PMTSimAlg_pythoninstall :: $(install_python_dir)
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

PMTSimAlg_pythonclean :: PMTSimAlg_pythonuninstall

uninstall :: PMTSimAlg_pythonuninstall

PMTSimAlg_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: PMTSimAlg_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PMTSimAlg_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PMTSimAlg_pythonclean ::
#-- end of cleanup_header ---------------

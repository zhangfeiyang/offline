#-- start of make_header -----------------

#====================================
#  Document WaveformSimAlg_python
#
#   Generated Fri Jul 10 19:23:43 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_WaveformSimAlg_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_WaveformSimAlg_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_WaveformSimAlg_python

WaveformSimAlg_tag = $(tag)

#cmt_local_tagfile_WaveformSimAlg_python = $(WaveformSimAlg_tag)_WaveformSimAlg_python.make
cmt_local_tagfile_WaveformSimAlg_python = $(bin)$(WaveformSimAlg_tag)_WaveformSimAlg_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

WaveformSimAlg_tag = $(tag)

#cmt_local_tagfile_WaveformSimAlg_python = $(WaveformSimAlg_tag).make
cmt_local_tagfile_WaveformSimAlg_python = $(bin)$(WaveformSimAlg_tag).make

endif

include $(cmt_local_tagfile_WaveformSimAlg_python)
#-include $(cmt_local_tagfile_WaveformSimAlg_python)

ifdef cmt_WaveformSimAlg_python_has_target_tag

cmt_final_setup_WaveformSimAlg_python = $(bin)setup_WaveformSimAlg_python.make
cmt_dependencies_in_WaveformSimAlg_python = $(bin)dependencies_WaveformSimAlg_python.in
#cmt_final_setup_WaveformSimAlg_python = $(bin)WaveformSimAlg_WaveformSimAlg_pythonsetup.make
cmt_local_WaveformSimAlg_python_makefile = $(bin)WaveformSimAlg_python.make

else

cmt_final_setup_WaveformSimAlg_python = $(bin)setup.make
cmt_dependencies_in_WaveformSimAlg_python = $(bin)dependencies.in
#cmt_final_setup_WaveformSimAlg_python = $(bin)WaveformSimAlgsetup.make
cmt_local_WaveformSimAlg_python_makefile = $(bin)WaveformSimAlg_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)WaveformSimAlgsetup.make

#WaveformSimAlg_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'WaveformSimAlg_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = WaveformSimAlg_python/
#WaveformSimAlg_python::
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

WaveformSimAlg_python :: WaveformSimAlg_pythoninstall

install :: WaveformSimAlg_pythoninstall

WaveformSimAlg_pythoninstall :: $(install_python_dir)
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

WaveformSimAlg_pythonclean :: WaveformSimAlg_pythonuninstall

uninstall :: WaveformSimAlg_pythonuninstall

WaveformSimAlg_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: WaveformSimAlg_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(WaveformSimAlg_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

WaveformSimAlg_pythonclean ::
#-- end of cleanup_header ---------------

#-- start of make_header -----------------

#====================================
#  Document PushAndPull_python
#
#   Generated Fri Jul 10 19:22:32 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PushAndPull_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PushAndPull_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PushAndPull_python

PushAndPull_tag = $(tag)

#cmt_local_tagfile_PushAndPull_python = $(PushAndPull_tag)_PushAndPull_python.make
cmt_local_tagfile_PushAndPull_python = $(bin)$(PushAndPull_tag)_PushAndPull_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PushAndPull_tag = $(tag)

#cmt_local_tagfile_PushAndPull_python = $(PushAndPull_tag).make
cmt_local_tagfile_PushAndPull_python = $(bin)$(PushAndPull_tag).make

endif

include $(cmt_local_tagfile_PushAndPull_python)
#-include $(cmt_local_tagfile_PushAndPull_python)

ifdef cmt_PushAndPull_python_has_target_tag

cmt_final_setup_PushAndPull_python = $(bin)setup_PushAndPull_python.make
cmt_dependencies_in_PushAndPull_python = $(bin)dependencies_PushAndPull_python.in
#cmt_final_setup_PushAndPull_python = $(bin)PushAndPull_PushAndPull_pythonsetup.make
cmt_local_PushAndPull_python_makefile = $(bin)PushAndPull_python.make

else

cmt_final_setup_PushAndPull_python = $(bin)setup.make
cmt_dependencies_in_PushAndPull_python = $(bin)dependencies.in
#cmt_final_setup_PushAndPull_python = $(bin)PushAndPullsetup.make
cmt_local_PushAndPull_python_makefile = $(bin)PushAndPull_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PushAndPullsetup.make

#PushAndPull_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PushAndPull_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PushAndPull_python/
#PushAndPull_python::
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

PushAndPull_python :: PushAndPull_pythoninstall

install :: PushAndPull_pythoninstall

PushAndPull_pythoninstall :: $(install_python_dir)
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

PushAndPull_pythonclean :: PushAndPull_pythonuninstall

uninstall :: PushAndPull_pythonuninstall

PushAndPull_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: PushAndPull_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PushAndPull_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PushAndPull_pythonclean ::
#-- end of cleanup_header ---------------

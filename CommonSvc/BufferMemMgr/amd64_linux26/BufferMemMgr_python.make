#-- start of make_header -----------------

#====================================
#  Document BufferMemMgr_python
#
#   Generated Fri Jul 10 19:18:24 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_BufferMemMgr_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_BufferMemMgr_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_BufferMemMgr_python

BufferMemMgr_tag = $(tag)

#cmt_local_tagfile_BufferMemMgr_python = $(BufferMemMgr_tag)_BufferMemMgr_python.make
cmt_local_tagfile_BufferMemMgr_python = $(bin)$(BufferMemMgr_tag)_BufferMemMgr_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

BufferMemMgr_tag = $(tag)

#cmt_local_tagfile_BufferMemMgr_python = $(BufferMemMgr_tag).make
cmt_local_tagfile_BufferMemMgr_python = $(bin)$(BufferMemMgr_tag).make

endif

include $(cmt_local_tagfile_BufferMemMgr_python)
#-include $(cmt_local_tagfile_BufferMemMgr_python)

ifdef cmt_BufferMemMgr_python_has_target_tag

cmt_final_setup_BufferMemMgr_python = $(bin)setup_BufferMemMgr_python.make
cmt_dependencies_in_BufferMemMgr_python = $(bin)dependencies_BufferMemMgr_python.in
#cmt_final_setup_BufferMemMgr_python = $(bin)BufferMemMgr_BufferMemMgr_pythonsetup.make
cmt_local_BufferMemMgr_python_makefile = $(bin)BufferMemMgr_python.make

else

cmt_final_setup_BufferMemMgr_python = $(bin)setup.make
cmt_dependencies_in_BufferMemMgr_python = $(bin)dependencies.in
#cmt_final_setup_BufferMemMgr_python = $(bin)BufferMemMgrsetup.make
cmt_local_BufferMemMgr_python_makefile = $(bin)BufferMemMgr_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)BufferMemMgrsetup.make

#BufferMemMgr_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'BufferMemMgr_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = BufferMemMgr_python/
#BufferMemMgr_python::
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

BufferMemMgr_python :: BufferMemMgr_pythoninstall

install :: BufferMemMgr_pythoninstall

BufferMemMgr_pythoninstall :: $(install_python_dir)
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

BufferMemMgr_pythonclean :: BufferMemMgr_pythonuninstall

uninstall :: BufferMemMgr_pythonuninstall

BufferMemMgr_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: BufferMemMgr_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(BufferMemMgr_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

BufferMemMgr_pythonclean ::
#-- end of cleanup_header ---------------

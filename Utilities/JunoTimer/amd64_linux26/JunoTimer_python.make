#-- start of make_header -----------------

#====================================
#  Document JunoTimer_python
#
#   Generated Fri Jul 10 19:15:35 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_JunoTimer_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_JunoTimer_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_JunoTimer_python

JunoTimer_tag = $(tag)

#cmt_local_tagfile_JunoTimer_python = $(JunoTimer_tag)_JunoTimer_python.make
cmt_local_tagfile_JunoTimer_python = $(bin)$(JunoTimer_tag)_JunoTimer_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

JunoTimer_tag = $(tag)

#cmt_local_tagfile_JunoTimer_python = $(JunoTimer_tag).make
cmt_local_tagfile_JunoTimer_python = $(bin)$(JunoTimer_tag).make

endif

include $(cmt_local_tagfile_JunoTimer_python)
#-include $(cmt_local_tagfile_JunoTimer_python)

ifdef cmt_JunoTimer_python_has_target_tag

cmt_final_setup_JunoTimer_python = $(bin)setup_JunoTimer_python.make
cmt_dependencies_in_JunoTimer_python = $(bin)dependencies_JunoTimer_python.in
#cmt_final_setup_JunoTimer_python = $(bin)JunoTimer_JunoTimer_pythonsetup.make
cmt_local_JunoTimer_python_makefile = $(bin)JunoTimer_python.make

else

cmt_final_setup_JunoTimer_python = $(bin)setup.make
cmt_dependencies_in_JunoTimer_python = $(bin)dependencies.in
#cmt_final_setup_JunoTimer_python = $(bin)JunoTimersetup.make
cmt_local_JunoTimer_python_makefile = $(bin)JunoTimer_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)JunoTimersetup.make

#JunoTimer_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'JunoTimer_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = JunoTimer_python/
#JunoTimer_python::
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

JunoTimer_python :: JunoTimer_pythoninstall

install :: JunoTimer_pythoninstall

JunoTimer_pythoninstall :: $(install_python_dir)
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

JunoTimer_pythonclean :: JunoTimer_pythonuninstall

uninstall :: JunoTimer_pythonuninstall

JunoTimer_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: JunoTimer_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(JunoTimer_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

JunoTimer_pythonclean ::
#-- end of cleanup_header ---------------

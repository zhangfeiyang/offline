#-- start of make_header -----------------

#====================================
#  Document LsqMuonRecTool_python
#
#   Generated Fri Jul 10 19:19:52 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_LsqMuonRecTool_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_LsqMuonRecTool_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_LsqMuonRecTool_python

LsqMuonRecTool_tag = $(tag)

#cmt_local_tagfile_LsqMuonRecTool_python = $(LsqMuonRecTool_tag)_LsqMuonRecTool_python.make
cmt_local_tagfile_LsqMuonRecTool_python = $(bin)$(LsqMuonRecTool_tag)_LsqMuonRecTool_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

LsqMuonRecTool_tag = $(tag)

#cmt_local_tagfile_LsqMuonRecTool_python = $(LsqMuonRecTool_tag).make
cmt_local_tagfile_LsqMuonRecTool_python = $(bin)$(LsqMuonRecTool_tag).make

endif

include $(cmt_local_tagfile_LsqMuonRecTool_python)
#-include $(cmt_local_tagfile_LsqMuonRecTool_python)

ifdef cmt_LsqMuonRecTool_python_has_target_tag

cmt_final_setup_LsqMuonRecTool_python = $(bin)setup_LsqMuonRecTool_python.make
cmt_dependencies_in_LsqMuonRecTool_python = $(bin)dependencies_LsqMuonRecTool_python.in
#cmt_final_setup_LsqMuonRecTool_python = $(bin)LsqMuonRecTool_LsqMuonRecTool_pythonsetup.make
cmt_local_LsqMuonRecTool_python_makefile = $(bin)LsqMuonRecTool_python.make

else

cmt_final_setup_LsqMuonRecTool_python = $(bin)setup.make
cmt_dependencies_in_LsqMuonRecTool_python = $(bin)dependencies.in
#cmt_final_setup_LsqMuonRecTool_python = $(bin)LsqMuonRecToolsetup.make
cmt_local_LsqMuonRecTool_python_makefile = $(bin)LsqMuonRecTool_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)LsqMuonRecToolsetup.make

#LsqMuonRecTool_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'LsqMuonRecTool_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = LsqMuonRecTool_python/
#LsqMuonRecTool_python::
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

LsqMuonRecTool_python :: LsqMuonRecTool_pythoninstall

install :: LsqMuonRecTool_pythoninstall

LsqMuonRecTool_pythoninstall :: $(install_python_dir)
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

LsqMuonRecTool_pythonclean :: LsqMuonRecTool_pythonuninstall

uninstall :: LsqMuonRecTool_pythonuninstall

LsqMuonRecTool_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: LsqMuonRecTool_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(LsqMuonRecTool_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

LsqMuonRecTool_pythonclean ::
#-- end of cleanup_header ---------------

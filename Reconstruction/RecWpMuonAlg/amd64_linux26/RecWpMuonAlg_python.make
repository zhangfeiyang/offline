#-- start of make_header -----------------

#====================================
#  Document RecWpMuonAlg_python
#
#   Generated Fri Jul 10 19:19:01 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RecWpMuonAlg_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RecWpMuonAlg_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RecWpMuonAlg_python

RecWpMuonAlg_tag = $(tag)

#cmt_local_tagfile_RecWpMuonAlg_python = $(RecWpMuonAlg_tag)_RecWpMuonAlg_python.make
cmt_local_tagfile_RecWpMuonAlg_python = $(bin)$(RecWpMuonAlg_tag)_RecWpMuonAlg_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RecWpMuonAlg_tag = $(tag)

#cmt_local_tagfile_RecWpMuonAlg_python = $(RecWpMuonAlg_tag).make
cmt_local_tagfile_RecWpMuonAlg_python = $(bin)$(RecWpMuonAlg_tag).make

endif

include $(cmt_local_tagfile_RecWpMuonAlg_python)
#-include $(cmt_local_tagfile_RecWpMuonAlg_python)

ifdef cmt_RecWpMuonAlg_python_has_target_tag

cmt_final_setup_RecWpMuonAlg_python = $(bin)setup_RecWpMuonAlg_python.make
cmt_dependencies_in_RecWpMuonAlg_python = $(bin)dependencies_RecWpMuonAlg_python.in
#cmt_final_setup_RecWpMuonAlg_python = $(bin)RecWpMuonAlg_RecWpMuonAlg_pythonsetup.make
cmt_local_RecWpMuonAlg_python_makefile = $(bin)RecWpMuonAlg_python.make

else

cmt_final_setup_RecWpMuonAlg_python = $(bin)setup.make
cmt_dependencies_in_RecWpMuonAlg_python = $(bin)dependencies.in
#cmt_final_setup_RecWpMuonAlg_python = $(bin)RecWpMuonAlgsetup.make
cmt_local_RecWpMuonAlg_python_makefile = $(bin)RecWpMuonAlg_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RecWpMuonAlgsetup.make

#RecWpMuonAlg_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RecWpMuonAlg_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RecWpMuonAlg_python/
#RecWpMuonAlg_python::
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

RecWpMuonAlg_python :: RecWpMuonAlg_pythoninstall

install :: RecWpMuonAlg_pythoninstall

RecWpMuonAlg_pythoninstall :: $(install_python_dir)
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

RecWpMuonAlg_pythonclean :: RecWpMuonAlg_pythonuninstall

uninstall :: RecWpMuonAlg_pythonuninstall

RecWpMuonAlg_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: RecWpMuonAlg_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RecWpMuonAlg_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RecWpMuonAlg_pythonclean ::
#-- end of cleanup_header ---------------

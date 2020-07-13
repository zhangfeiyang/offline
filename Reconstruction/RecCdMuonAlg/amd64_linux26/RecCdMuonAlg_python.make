#-- start of make_header -----------------

#====================================
#  Document RecCdMuonAlg_python
#
#   Generated Fri Jul 10 19:19:25 2020  by zhangfy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RecCdMuonAlg_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RecCdMuonAlg_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RecCdMuonAlg_python

RecCdMuonAlg_tag = $(tag)

#cmt_local_tagfile_RecCdMuonAlg_python = $(RecCdMuonAlg_tag)_RecCdMuonAlg_python.make
cmt_local_tagfile_RecCdMuonAlg_python = $(bin)$(RecCdMuonAlg_tag)_RecCdMuonAlg_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RecCdMuonAlg_tag = $(tag)

#cmt_local_tagfile_RecCdMuonAlg_python = $(RecCdMuonAlg_tag).make
cmt_local_tagfile_RecCdMuonAlg_python = $(bin)$(RecCdMuonAlg_tag).make

endif

include $(cmt_local_tagfile_RecCdMuonAlg_python)
#-include $(cmt_local_tagfile_RecCdMuonAlg_python)

ifdef cmt_RecCdMuonAlg_python_has_target_tag

cmt_final_setup_RecCdMuonAlg_python = $(bin)setup_RecCdMuonAlg_python.make
cmt_dependencies_in_RecCdMuonAlg_python = $(bin)dependencies_RecCdMuonAlg_python.in
#cmt_final_setup_RecCdMuonAlg_python = $(bin)RecCdMuonAlg_RecCdMuonAlg_pythonsetup.make
cmt_local_RecCdMuonAlg_python_makefile = $(bin)RecCdMuonAlg_python.make

else

cmt_final_setup_RecCdMuonAlg_python = $(bin)setup.make
cmt_dependencies_in_RecCdMuonAlg_python = $(bin)dependencies.in
#cmt_final_setup_RecCdMuonAlg_python = $(bin)RecCdMuonAlgsetup.make
cmt_local_RecCdMuonAlg_python_makefile = $(bin)RecCdMuonAlg_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RecCdMuonAlgsetup.make

#RecCdMuonAlg_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RecCdMuonAlg_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RecCdMuonAlg_python/
#RecCdMuonAlg_python::
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

RecCdMuonAlg_python :: RecCdMuonAlg_pythoninstall

install :: RecCdMuonAlg_pythoninstall

RecCdMuonAlg_pythoninstall :: $(install_python_dir)
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

RecCdMuonAlg_pythonclean :: RecCdMuonAlg_pythonuninstall

uninstall :: RecCdMuonAlg_pythonuninstall

RecCdMuonAlg_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: RecCdMuonAlg_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RecCdMuonAlg_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RecCdMuonAlg_pythonclean ::
#-- end of cleanup_header ---------------

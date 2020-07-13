#!/bin/bash

# Binding for subversion
# dependencies
function juno-ext-libs-subversion-binding-dependencies-list {
    echo python swig subversion
}
function juno-ext-libs-subversion-binding-dependencies-setup {
    juno-ext-libs-dependencies-setup subversion-binding
}

# 
function juno-ext-libs-subversion-binding-tardst {
    echo $(juno-ext-libs-subversion-tardst)
}
function juno-ext-libs-subversion-binding-install-dir {
    echo $(juno-ext-libs-subversion-install-dir)
}

# interface
function juno-ext-libs-subversion-binding-get {
    local msg="==== $FUNCNAME: "
}

function juno-ext-libs-subversion-binding-conf {
    local msg="==== $FUNCNAME: "
    pushd $(juno-ext-libs-build-root) >& /dev/null
    local curpkg=subversion

    tarname=$(juno-ext-libs-${curpkg}-download-filename)
    juno-ext-libs-${curpkg}-file-check-exist $tarname
    # does not exist, so download
    if [ "$?" != "0" ]; then
        juno-ext-libs-${curpkg}-get
    fi
    tardst=$(juno-ext-libs-${curpkg}-tardst)
    if [ ! -d "$tardst" ]; then
        echo $msg Please Building subversion first.
        return 1
    fi
    popd >& /dev/null
}
function juno-ext-libs-subversion-binding-make {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-build-root-check || exit $?
    pushd $(juno-ext-libs-build-root) >& /dev/null

    local curpkg=subversion
    local tardst=$(juno-ext-libs-${curpkg}-tardst)
    cd $tardst/$tardst
    if [ "$?" != "0" ]; then
        echo $msg Please configure the package first.
        exit 1
    fi

    echo $msg make swig-py
    make swig-py
    echo $msg make swig-pl-lib
    make swig-pl-lib

    popd >& /dev/null
}

function juno-ext-libs-subversion-binding-install- {
    local msg="===== $FUNCNAME: "
    cd $(juno-ext-libs-subversion-tardst)
    echo $msg make install-swig-py
    make install-swig-py

    echo $msg make install-swig-pl-lib
    make install-swig-pl-lib
    cd subversion/bindings/swig/perl/native 
    perl Makefile.PL PREFIX=$(juno-ext-libs-subversion-install-dir)    
    make install
}

function juno-ext-libs-subversion-binding-install {
    juno-ext-libs-PKG-install subversion-binding  
}

function juno-ext-libs-subversion-binding-generate-sh {
local pkg=Subversion
local lib=lib
cat << EOF >> bashrc
export PYTHONPATH=\${JUNO_EXTLIB_${pkg}_HOME}/${lib}/svn-python:\${PYTHONPATH}
export LD_LIBRARY_PATH=\${JUNO_EXTLIB_${pkg}_HOME}/${lib}/svn-python/libsvn:\${LD_LIBRARY_PATH}
# TODO set perl lib
# only for slc5
export PERL5LIB=\${JUNO_EXTLIB_${pkg}_HOME}/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi:\$PERL5LIB
# only for slc6
export PERL5LIB=\${JUNO_EXTLIB_${pkg}_HOME}/lib64/perl5:\$PERL5LIB
EOF
}
function juno-ext-libs-subversion-binding-generate-csh {
local pkg=Subversion
local lib=lib
cat << EOF >> tcshrc
if ( \$?PYTHONPATH == 0 ) then
    setenv PYTHONPATH ""
endif
setenv PYTHONPATH \${JUNO_EXTLIB_${pkg}_HOME}/${lib}/svn-python:\${PYTHONPATH}
setenv LD_LIBRARY_PATH \${JUNO_EXTLIB_${pkg}_HOME}/${lib}/svn-python/libsvn:\${LD_LIBRARY_PATH}
# TODO set perl lib 
if ( \$?PERL5LIB == 0 ) then
    setenv PERL5LIB ""
endif
# only for slc5
setenv PERL5LIB \${JUNO_EXTLIB_${pkg}_HOME}/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi:\$PERL5LIB
# only for slc6
setenv PERL5LIB \${JUNO_EXTLIB_${pkg}_HOME}/lib64/perl5:\$PERL5LIB
EOF
}
function juno-ext-libs-subversion-binding-setup {
    local curpkg=subversion
    local msg="===== $FUNCNAME: "
    juno-ext-libs-install-root-check || exit $?
    pushd $(juno-ext-libs-install-root) >& /dev/null

    if [ ! -d "$(juno-ext-libs-${curpkg}-install-dir)" ]; then
        echo $msg Please install the Package first
        exit 1
    fi
    local install=$(juno-ext-libs-${curpkg}-install-dir)
    pushd $install
    juno-ext-libs-subversion-binding-generate-sh
    juno-ext-libs-subversion-binding-generate-csh
    popd
    popd >& /dev/null
}

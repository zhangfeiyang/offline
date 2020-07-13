#!/bin/bash

# meta data
function juno-ext-libs-ROOT-name {
    echo ROOT
}

function juno-ext-libs-ROOT-version-default {
    echo 5.34.11
}
function juno-ext-libs-ROOT-version {
    echo $(juno-ext-libs-PKG-version ROOT)
}

# dependencies
function juno-ext-libs-ROOT-dependencies-list {
    echo python boost cmake +git +gccxml xercesc +qt4 gsl fftw3
}
function juno-ext-libs-ROOT-dependencies-setup {
    juno-ext-libs-dependencies-setup ROOT
}
# install dir
function juno-ext-libs-ROOT-install-dir {
    local version=${1:-$(juno-ext-libs-ROOT-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-ROOT-name)/$version
}
# download info
function juno-ext-libs-ROOT-download-url {
    local msg="===== $FUNCNAME: "
    local version=${1:-$(juno-ext-libs-ROOT-version)}
    case $version in
        5.34.*)
            echo http://root.cern.ch/download/root_v${version}.source.tar.gz
            ;;
        *)
            echo $msg Unknown version $version, using the default one 1>&2
            echo http://root.cern.ch/download/root_v5.34.11.source.tar.gz
            ;;
    esac
}
function juno-ext-libs-ROOT-download-filename {
    local msg="===== $FUNCNAME: "
    local version=${1:-$(juno-ext-libs-ROOT-version)}
    case $version in
        5.34.*)
            echo root_v${version}.source.tar.gz
            ;;
        *)
            echo $msg Unknown version $version, using the default one 1>&2
            echo root_v5.34.11.source.tar.gz
            ;;
    esac
}

function juno-ext-libs-ROOT-tardst {
    # install in root of external libraries
    local version=${1:-$(juno-ext-libs-ROOT-version)}
    case $version in
        5.34.11)
            echo root-5.34.11
            ;;
        5.34.*)
            echo root-${version}
            ;;
        *)
            echo root-5.34.11
            ;;
    esac
}

function juno-ext-libs-ROOT-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface
function juno-ext-libs-ROOT-get {
    juno-ext-libs-PKG-get ROOT
}

function juno-ext-libs-ROOT-conf-uncompress {
    local msg="===== $FUNCNAME: "
    tardst=$1
    tarname=$2
    echo tar -C $tardst -zxvf $tarname
    if [ -d "$tardst" -a -d "$tardst/root" ]; then
        echo $msg $tardst already exist
        echo $msg will not invoke the uncompress command
        return
    else
        mkdir -p $tardst
    fi
    tar -C $tardst -zxvf $tarname || exit $?
    if [ ! -d "$tardst" ]; then
        echo $msg "After Uncompress, can't find $tardst"
        exit 1
    fi
}

function juno-ext-libs-ROOT-conf-env-setup {
    local msg="===== $FUNCNAME: "
    # GSL
    if [ -d "$(juno-ext-libs-gsl-install-dir)" ]; then
        export GSL=$(juno-ext-libs-gsl-install-dir)
        echo $msg GSL=${GSL}
    fi
    # FFTW3
    if [ -d "$(juno-ext-libs-fftw3-install-dir)" ]; then
        export FFTW3=$(juno-ext-libs-fftw3-install-dir)
        echo $msg FFTW3=${FFTW3}
    fi
    # QTDIR
    if [ -d "$(juno-ext-libs-qt4-install-dir)" ]; then
        export QTDIR=$(juno-ext-libs-qt4-install-dir)
        echo $msg QTDIR=${QTDIR}
    fi
}

function juno-ext-libs-ROOT-get-patch-name {
    echo $(juno-ext-libs-init-scripts-dir)/patches/root-5.34.patch
}

function juno-ext-libs-ROOT-apply-patch {
    local msg="===== $FUNCNAME: "
    # load patch file name
    local patchname=$(juno-ext-libs-ROOT-get-patch-name)
    echo $msg Apply Patch $patchname
    # apply patch
    patch -p0 < $patchname
}

function juno-ext-libs-ROOT-conf- {
    local msg="===== $FUNCNAME: "
    pushd root

    #apply patch
    juno-ext-libs-ROOT-apply-patch

    #echo $msg ./configure --prefix=$(juno-ext-libs-ROOT-install-dir) --etcdir=$(juno-ext-libs-ROOT-install-dir)/etc --all 
    #./configure --prefix=$(juno-ext-libs-ROOT-install-dir) --etcdir=$(juno-ext-libs-ROOT-install-dir)/etc --all

    export ROOTSYS=$(juno-ext-libs-ROOT-install-dir)
    # note, root uses several external Environment Variables
    juno-ext-libs-ROOT-conf-env-setup
    echo $msg ./configure  --all 
    ./configure --all
    popd
}
function juno-ext-libs-ROOT-conf {
    juno-ext-libs-PKG-conf ROOT
}
function juno-ext-libs-ROOT-make- {
    local msg="===== $FUNCNAME: "
    pushd root
    export ROOTSYS=$(juno-ext-libs-ROOT-install-dir)
    juno-ext-libs-ROOT-conf-env-setup
    echo $msg make $(juno-ext-libs-gen-cpu-num)
    make $(juno-ext-libs-gen-cpu-num)
    popd
}
function juno-ext-libs-ROOT-make {
    juno-ext-libs-PKG-make ROOT
}
function juno-ext-libs-ROOT-install- {
    local msg="===== $FUNCNAME: "
    pushd root
    export ROOTSYS=$(juno-ext-libs-ROOT-install-dir)
    juno-ext-libs-ROOT-conf-env-setup
    echo $msg make install
    make install
    popd
}

function juno-ext-libs-ROOT-install {
    juno-ext-libs-PKG-install ROOT
}

function juno-ext-libs-ROOT-generate-sh {
local pkg=$1
local install=$2
local lib=${3:-lib}
cat << EOF >> bashrc
source \${JUNO_EXTLIB_${pkg}_HOME}/bin/thisroot.sh
EOF
}
function juno-ext-libs-ROOT-generate-csh {
local pkg=$1
local install=$2
local lib=${3:-lib}
cat << EOF >> tcshrc
setenv ROOTSYS \${JUNO_EXTLIB_${pkg}_HOME}
setenv PATH \${JUNO_EXTLIB_${pkg}_HOME}/bin:\${PATH}
setenv LD_LIBRARY_PATH \${JUNO_EXTLIB_${pkg}_HOME}/${lib}:\${LD_LIBRARY_PATH}
setenv CPATH \${JUNO_EXTLIB_${pkg}_HOME}/include:\${CPATH}
if ( \$?PYTHONPATH == 0 ) then
    setenv PYTHONPATH ""
endif
setenv PYTHONPATH \${JUNO_EXTLIB_${pkg}_HOME}/${lib}:\${PYTHONPATH} 
EOF
}

function juno-ext-libs-ROOT-setup {
    juno-ext-libs-PKG-setup ROOT
}
# self check
function juno-ext-libs-ROOT-self-check-list {
    # check one file is enough
    echo bin/root

}
function juno-ext-libs-ROOT-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check ROOT
}

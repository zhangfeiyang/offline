#!/bin/bash

# meta data
function juno-ext-libs-cmt-name {
    echo CMT
}

function juno-ext-libs-cmt-version-default {
    echo v1r26
}
function juno-ext-libs-cmt-version {
    echo $(juno-ext-libs-PKG-version cmt)
}

# dependencies
function juno-ext-libs-cmt-dependencies-list {
    echo 
}
function juno-ext-libs-cmt-dependencies-setup {
    juno-ext-libs-dependencies-setup cmt
}

# install dir
function juno-ext-libs-cmt-install-dir {
    local version=${1:-$(juno-ext-libs-cmt-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-cmt-name)/$version
}
# download info
function juno-ext-libs-cmt-download-url {
    local version=${1:-$(juno-ext-libs-cmt-version)}
    case $version in
        v1r26)
            echo http://www.cmtsite.net/v1r26/CMTv1r26.tar.gz
            ;;
        *)
            echo http://www.cmtsite.net/v1r26/CMTv1r26.tar.gz
            ;;
    esac
}
function juno-ext-libs-cmt-download-filename {
    local version=${1:-$(juno-ext-libs-cmt-version)}
    case $version in
        v1r26)
            echo CMTv1r26.tar.gz
            ;;
        *)
            echo CMTv1r26.tar.gz
            ;;
    esac
}

function juno-ext-libs-cmt-tardst {
    # install in root of external libraries
    local version=${1:-$(juno-ext-libs-cmt-version)}
    case $version in
        4.5.3)
            echo $(juno-ext-libs-install-root)/$(juno-ext-libs-cmt-name)/$(juno-ext-libs-cmt-version)
            ;;
        *)
            echo $(juno-ext-libs-install-root)/$(juno-ext-libs-cmt-name)/$(juno-ext-libs-cmt-version)
            ;;
    esac
}

function juno-ext-libs-cmt-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface
function juno-ext-libs-cmt-get {
    juno-ext-libs-PKG-get cmt
}
function juno-ext-libs-cmt-conf-uncompress {
    local msg="===== $FUNCNAME: "
    tardst=$1
    tarname=$2
    echo $msg tar zxvf $tarname
    tar -C $(juno-ext-libs-install-root) -zxvf $tarname || exit $?
    if [ ! -d "$tardst" ]; then
        echo $msg "After Uncompress, can't find $tardst"
        exit 1
    fi
}

function juno-ext-libs-cmt-conf- {
    local msg="===== $FUNCNAME: "
    
    pushd mgr
    ./INSTALL
    source setup.sh
    popd


}
function juno-ext-libs-cmt-conf {
    juno-ext-libs-PKG-conf cmt
}

function juno-ext-libs-cmt-make- {
    pushd mgr
    source setup.sh
    make
    popd
}
function juno-ext-libs-cmt-make {
    juno-ext-libs-PKG-make cmt
}

function juno-ext-libs-cmt-install- {
    echo
}

function juno-ext-libs-cmt-install {
    juno-ext-libs-PKG-install cmt
}

function juno-ext-libs-cmt-generate-sh {
local pkg=$1
local install=$2
local lib=${3:-lib}
cat << EOF >> bashrc
source \${JUNO_EXTLIB_${pkg}_HOME}/mgr/setup.sh
EOF
}
function juno-ext-libs-cmt-generate-csh {
local pkg=$1
local install=$2
local lib=${3:-lib}
cat << EOF >> tcshrc
source \${JUNO_EXTLIB_${pkg}_HOME}/mgr/setup.csh
EOF
}

function juno-ext-libs-cmt-setup {
    #echo "Please use the script in CMT."
    juno-ext-libs-PKG-setup cmt
}
# self check
function juno-ext-libs-cmt-self-check-list {
    # check one file is enough
    echo mgr/setup.sh

}
function juno-ext-libs-cmt-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check cmt
}

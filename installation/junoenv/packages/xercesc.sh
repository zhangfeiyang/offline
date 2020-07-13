#!/bin/bash

# meta data
function juno-ext-libs-xercesc-name {
    echo Xercesc
}

function juno-ext-libs-xercesc-version-default {
    echo 3.1.1
}
function juno-ext-libs-xercesc-version {
    echo $(juno-ext-libs-PKG-version xercesc)
}
# dependencies
function juno-ext-libs-xercesc-dependencies-list {
    echo 
}

function juno-ext-libs-xercesc-dependencies-setup {
    juno-ext-libs-dependencies-setup xercesc
}
# install dir
function juno-ext-libs-xercesc-install-dir {
    local version=${1:-$(juno-ext-libs-xercesc-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-xercesc-name)/$version
}

# download info
function juno-ext-libs-xercesc-download-url {
    local version=${1:-$(juno-ext-libs-xercesc-version)}
    case $version in
        3.1.1)
            #echo http://www.apache.org/dist/xerces/c/3/sources/xerces-c-3.1.1.tar.gz
            #echo http://juno.ihep.ac.cn/software/offline/tarFiles/xerces-c-3.1.1.tar.gz
            echo http://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.1.1.tar.gz
            ;;
        3.1.2)
            echo http://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.1.2.tar.gz
            ;;
        *)
            echo http://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.1.1.tar.gz
            ;;
    esac
}
function juno-ext-libs-xercesc-download-filename {
    local version=${1:-$(juno-ext-libs-xercesc-version)}
    case $version in
        3.1.1)
            echo xerces-c-3.1.1.tar.gz
            ;;
        3.1.2)
            echo xerces-c-3.1.2.tar.gz
            ;;
        *)
            echo xerces-c-3.1.1.tar.gz
            ;;
    esac
}

# build info
function juno-ext-libs-xercesc-tardst {
    local version=${1:-$(juno-ext-libs-xercesc-version)}
    case $version in
        3.1.1)
            echo xerces-c-3.1.1
            ;;
        3.1.2)
            echo xerces-c-3.1.2
            ;;
        *)
            echo xerces-c-3.1.1
            ;;
    esac
}

function juno-ext-libs-xercesc-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface 
function juno-ext-libs-xercesc-get {
    juno-ext-libs-PKG-get xercesc
}

function juno-ext-libs-xercesc-conf- {
    local msg="===== $FUNCNAME: "

    echo $msg ./configure --prefix=$(juno-ext-libs-xercesc-install-dir)
    ./configure --prefix=$(juno-ext-libs-xercesc-install-dir) || exit $?

}
function juno-ext-libs-xercesc-conf {
    juno-ext-libs-PKG-conf xercesc
}

function juno-ext-libs-xercesc-make {
    juno-ext-libs-PKG-make xercesc
}

function juno-ext-libs-xercesc-install {
    juno-ext-libs-PKG-install xercesc
}

function juno-ext-libs-xercesc-generate-sh {
    local pkg=$1
    local install=$2
    local lib=${3:-lib}
cat << EOF >> bashrc
export XERCESC_ROOT_DIR=\${JUNO_EXTLIB_${pkg}_HOME}
EOF
}
function juno-ext-libs-xercesc-generate-csh {
    local pkg=$1
    local install=$2
    local lib=${3:-lib}
cat << EOF >> tcshrc
setenv XERCESC_ROOT_DIR \${JUNO_EXTLIB_${pkg}_HOME}
EOF
}

function juno-ext-libs-xercesc-setup {
    juno-ext-libs-PKG-setup xercesc
}
# self check
function juno-ext-libs-xercesc-self-check-list {
    # check one file is enough
    echo bin/DOMPrint

}
function juno-ext-libs-xercesc-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check xercesc
}

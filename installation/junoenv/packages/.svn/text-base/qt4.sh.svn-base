#!/bin/bash

# meta data
function juno-ext-libs-qt4-name {
    echo Qt4
}

function juno-ext-libs-qt4-version-default {
    # in lxslc5, we should use 4.5.3
    # otherwise, please use apt-get or yum?
    echo 4.5.3
}

function juno-ext-libs-qt4-version {
    echo $(juno-ext-libs-PKG-version qt4)
}

# dependencies
function juno-ext-libs-qt4-dependencies-list {
    echo python boost
}
function juno-ext-libs-qt4-dependencies-setup {
    juno-ext-libs-dependencies-setup qt4
}

# install dir
function juno-ext-libs-qt4-install-dir {
    local version=${1:-$(juno-ext-libs-qt4-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-qt4-name)/$version
}

# download info
function juno-ext-libs-qt4-download-url {
    local version=${1:-$(juno-ext-libs-qt4-version)}
    case $version in
        4.5.3)
            echo http://download.qt-project.org/archive/qt/4.5/qt-x11-opensource-src-4.5.3.tar.gz
            ;;
        *)
            echo http://download.qt-project.org/archive/qt/4.5/qt-x11-opensource-src-4.5.3.tar.gz
            ;;
    esac
}
function juno-ext-libs-qt4-download-filename {
    local version=${1:-$(juno-ext-libs-qt4-version)}
    case $version in
        4.5.3)
            echo qt-x11-opensource-src-4.5.3.tar.gz
            ;;
        *)
            echo qt-x11-opensource-src-4.5.3.tar.gz
            ;;
    esac
}

function juno-ext-libs-qt4-tardst {
    local version=${1:-$(juno-ext-libs-qt4-version)}
    case $version in
        4.5.3)
            echo qt-x11-opensource-src-4.5.3
            ;;
        *)
            echo qt-x11-opensource-src-4.5.3
            ;;
    esac
}

function juno-ext-libs-qt4-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface 
function juno-ext-libs-qt4-get {
    juno-ext-libs-PKG-get qt4
}
function juno-ext-libs-qt4-conf-uncompress {
    local msg="===== $FUNCNAME: "
    tardst=$1
    tarname=$2
    echo $msg tar zxvf $tarname
    tar zxvf $tarname || exit $?
    if [ ! -d "$tardst" ]; then
        echo $msg "After Uncompress, can't find $tardst"
        exit 1
    fi
}
function juno-ext-libs-qt4-conf- {
    local msg="===== $FUNCNAME: "

    echo $msg ./configure -no-separate-debug-info -release -prefix $(juno-ext-libs-qt4-install-dir) -confirm-license -opensource -nomake examples -nomake demos
    ./configure -no-separate-debug-info -release -prefix $(juno-ext-libs-qt4-install-dir) -confirm-license -opensource -nomake examples -nomake demos

}
function juno-ext-libs-qt4-conf {
    juno-ext-libs-PKG-conf qt4
}

function juno-ext-libs-qt4-make {
    juno-ext-libs-PKG-make qt4
}

function juno-ext-libs-qt4-install {
    juno-ext-libs-PKG-install qt4
}

# set QTHOME for geant4.
function juno-ext-libs-qt4-generate-sh {
local pkg=$1
local install=$2
local lib=${3:-lib}
cat << EOF >> bashrc
export QTHOME=\${JUNO_EXTLIB_${pkg}_HOME}
EOF
}
function juno-ext-libs-qt4-generate-csh {
local pkg=$1
local install=$2
local lib=${3:-lib}
cat << EOF >> tcshrc
setenv QTHOME \${JUNO_EXTLIB_${pkg}_HOME}
EOF
}
function juno-ext-libs-qt4-setup {
    juno-ext-libs-PKG-setup qt4
}
# self check
function juno-ext-libs-qt4-self-check-list {
    # check one file is enough
    echo bin/qtconfig

}
function juno-ext-libs-qt4-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check qt4
}

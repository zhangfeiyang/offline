#!/bin/bash

# meta data
function juno-ext-libs-cmake-name {
    echo Cmake
}

function juno-ext-libs-cmake-version-default {
    echo 2.8.12.1
}
function juno-ext-libs-cmake-version {
    echo $(juno-ext-libs-PKG-version cmake)
}

# dependencies
function juno-ext-libs-cmake-dependencies-list {
    echo
}
function juno-ext-libs-cmake-dependencies-setup {
    juno-ext-libs-dependencies-setup cmake
}

# install dir
function juno-ext-libs-cmake-install-dir {
    local version=${1:-$(juno-ext-libs-cmake-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-cmake-name)/$version
}

# download info
function juno-ext-libs-cmake-download-url {
    local version=${1:-$(juno-ext-libs-cmake-version)}
    case $version in
        2.8.12.1)
            echo http://www.cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz
            ;;
        *) 
            echo http://www.cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz
            ;;
    esac
}

function juno-ext-libs-cmake-download-filename {
    local version=${1:-$(juno-ext-libs-cmake-version)}
    case $version in
        2.8.12.1)
            echo cmake-2.8.12.1.tar.gz
            ;;
            *)
            echo cmake-2.8.12.1.tar.gz
            ;;
    esac

}

# build info
function juno-ext-libs-cmake-tardst {
    local version=${1:-$(juno-ext-libs-cmake-version)}
    case $version in
        2.8.12.1)
            echo cmake-2.8.12.1
            ;;
            *)
            echo cmake-2.8.12.1
            ;;
    esac

}

function juno-ext-libs-cmake-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface

function juno-ext-libs-cmake-get {
    juno-ext-libs-PKG-get cmake
}

function juno-ext-libs-cmake-conf- {
    local msg="===== $FUNCNAME: "
    # begin to configure
    echo $msg ./bootstrap --prefix=$(juno-ext-libs-cmake-install-dir)
    ./bootstrap --prefix=$(juno-ext-libs-cmake-install-dir)
}
function juno-ext-libs-cmake-conf {
    juno-ext-libs-PKG-conf cmake
}

function juno-ext-libs-cmake-make {
    juno-ext-libs-PKG-make cmake
}

function juno-ext-libs-cmake-install {
    juno-ext-libs-PKG-install cmake
}

function juno-ext-libs-cmake-setup {
    juno-ext-libs-PKG-setup cmake
}
# self check
function juno-ext-libs-cmake-self-check-list {
    # check one file is enough
    echo bin/cmake

}
function juno-ext-libs-cmake-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check cmake
}

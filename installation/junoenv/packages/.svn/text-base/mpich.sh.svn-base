#!/bin/bash

# meta data
function juno-ext-libs-mpich-name {
    echo mpich
}

function juno-ext-libs-mpich-version-default {
    echo 3.2
}

function juno-ext-libs-mpich-version {
    echo $(juno-ext-libs-PKG-version mpich)
}

# dependencies
function juno-ext-libs-mpich-dependencies-list {
    echo
}
function juno-ext-libs-mpich-dependencies-setup {
    juno-ext-libs-dependencies-setup mpich
}

# install dir
function juno-ext-libs-mpich-install-dir {
    local version=${1:-$(juno-ext-libs-mpich-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-mpich-name)/$version
}

# download info
function juno-ext-libs-mpich-download-url {
    local version=${1:-$(juno-ext-libs-mpich-version)}
    case $version in
        3.2)
            echo http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz
            ;;
        *) 
            echo http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz
            ;;
    esac
}

function juno-ext-libs-mpich-download-filename {
    local version=${1:-$(juno-ext-libs-mpich-version)}
    case $version in
        3.2)
            echo mpich-${version}.tar.gz
            ;;
        *) 
            echo mpich-${version}.tar.gz
            ;;
    esac
}

function juno-ext-libs-mpich-tardst {
    local version=${1:-$(juno-ext-libs-mpich-version)}
    case $version in
        3.2)
            echo mpich-${version}
            ;;
        *) 
            echo mpich-${version}
            ;;
    esac
}

function juno-ext-libs-mpich-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# get 
function juno-ext-libs-mpich-get {
    juno-ext-libs-PKG-get mpich
}

# conf

function juno-ext-libs-mpich-conf- {
    local msg="===== $FUNCNAME: "

    echo $msg ./configure --prefix=$(juno-ext-libs-mpich-install-dir) --enable-shared
    ./configure --prefix=$(juno-ext-libs-mpich-install-dir) --enable-shared || exit $?

}
function juno-ext-libs-mpich-conf {
    juno-ext-libs-PKG-conf mpich
}

# make 
function juno-ext-libs-mpich-make {
    juno-ext-libs-PKG-make mpich
}

# install
function juno-ext-libs-mpich-install {
    juno-ext-libs-PKG-install mpich
}

# setup


function juno-ext-libs-mpich-setup {
    juno-ext-libs-PKG-setup mpich
}

# self check
function juno-ext-libs-mpich-self-check-list {
    # check one file is enough
    echo 

}
function juno-ext-libs-mpich-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check mpich
}

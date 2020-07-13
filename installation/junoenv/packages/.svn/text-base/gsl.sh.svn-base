#!/bin/bash

# meta data
function juno-ext-libs-gsl-name {
    echo gsl
}

function juno-ext-libs-gsl-version-default {
    echo 1.16
}

function juno-ext-libs-gsl-version {
    echo $(juno-ext-libs-PKG-version gsl)
}

# dependencies
function juno-ext-libs-gsl-dependencies-list {
    echo
}
function juno-ext-libs-gsl-dependencies-setup {
    juno-ext-libs-dependencies-setup gsl
}

# install dir
function juno-ext-libs-gsl-install-dir {
    local version=${1:-$(juno-ext-libs-gsl-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-gsl-name)/$version
}

# download info
function juno-ext-libs-gsl-download-url {
    local version=${1:-$(juno-ext-libs-gsl-version)}
    case $version in
        1.16)
            echo ftp://ftp.gnu.org/gnu/gsl/gsl-1.16.tar.gz
            ;;
        *) 
            echo ftp://ftp.gnu.org/gnu/gsl/gsl-1.16.tar.gz
            ;;
    esac
}

function juno-ext-libs-gsl-download-filename {
    local version=${1:-$(juno-ext-libs-gsl-version)}
    case $version in
        1.16)
            echo gsl-1.16.tar.gz
            ;;
        *) 
            echo gsl-1.16.tar.gz
            ;;
    esac
}

function juno-ext-libs-gsl-tardst {
    local version=${1:-$(juno-ext-libs-gsl-version)}
    case $version in
        1.16)
            echo gsl-1.16
            ;;
        *) 
            echo gsl-1.16
            ;;
    esac
}

function juno-ext-libs-gsl-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# get 
function juno-ext-libs-gsl-get {
    juno-ext-libs-PKG-get gsl
}

# conf

function juno-ext-libs-gsl-conf- {
    local msg="===== $FUNCNAME: "

    echo $msg ./configure --prefix=$(juno-ext-libs-gsl-install-dir)
    ./configure --prefix=$(juno-ext-libs-gsl-install-dir) || exit $?

}
function juno-ext-libs-gsl-conf {
    juno-ext-libs-PKG-conf gsl
}

# make 
function juno-ext-libs-gsl-make {
    juno-ext-libs-PKG-make gsl
}

# install
function juno-ext-libs-gsl-install {
    juno-ext-libs-PKG-install gsl
}

# setup


function juno-ext-libs-gsl-setup {
    juno-ext-libs-PKG-setup gsl
}

# self check
function juno-ext-libs-gsl-self-check-list {
    # check one file is enough
    echo bin/gsl-config

}
function juno-ext-libs-gsl-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check gsl
}

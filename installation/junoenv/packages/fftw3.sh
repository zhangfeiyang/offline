#!/bin/bash

# meta data
function juno-ext-libs-fftw3-name {
    echo fftw3
}

function juno-ext-libs-fftw3-version-default {
    echo 3.2.1
}

function juno-ext-libs-fftw3-version {
    echo $(juno-ext-libs-PKG-version fftw3)
}

# dependencies
function juno-ext-libs-fftw3-dependencies-list {
    echo
}
function juno-ext-libs-fftw3-dependencies-setup {
    juno-ext-libs-dependencies-setup fftw3
}

# install dir
function juno-ext-libs-fftw3-install-dir {
    local version=${1:-$(juno-ext-libs-fftw3-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-fftw3-name)/$version
}

# download info
function juno-ext-libs-fftw3-download-url {
    local version=${1:-$(juno-ext-libs-fftw3-version)}
    case $version in
        3.2.1)
            echo ftp://ftp.fftw.org/pub/fftw/old/fftw-${version}.tar.gz
            ;;
        3.3.3)
            echo ftp://ftp.fftw.org/pub/fftw/fftw-${version}.tar.gz
            ;;
        *) 
            echo ftp://ftp.fftw.org/pub/fftw/old/fftw-${version}.tar.gz
            ;;
    esac
}

function juno-ext-libs-fftw3-download-filename {
    local version=${1:-$(juno-ext-libs-fftw3-version)}
    case $version in
        3.2.1)
            echo fftw-${version}.tar.gz
            ;;
        3.3.3)
            echo fftw-${version}.tar.gz
            ;;
        *) 
            echo fftw-${version}.tar.gz
            ;;
    esac
}

function juno-ext-libs-fftw3-tardst {
    local version=${1:-$(juno-ext-libs-fftw3-version)}
    case $version in
        3.2.1)
            echo fftw-${version}
            ;;
        3.3.3)
            echo fftw-${version}
            ;;
        *) 
            echo fftw-${version}
            ;;
    esac
}

function juno-ext-libs-fftw3-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# get 
function juno-ext-libs-fftw3-get {
    juno-ext-libs-PKG-get fftw3
}

# conf

function juno-ext-libs-fftw3-conf- {
    local msg="===== $FUNCNAME: "

    echo $msg ./configure --prefix=$(juno-ext-libs-fftw3-install-dir) --enable-shared
    #./configure --prefix=$(juno-ext-libs-fftw3-install-dir) --enable-shared || exit $?
    ./configure CFLAGS=-m64 --prefix=$(juno-ext-libs-fftw3-install-dir) --enable-shared --with-pic || exit $?

}
function juno-ext-libs-fftw3-conf {
    juno-ext-libs-PKG-conf fftw3
}

# make 
function juno-ext-libs-fftw3-make {
    juno-ext-libs-PKG-make fftw3
}

# install
function juno-ext-libs-fftw3-install {
    juno-ext-libs-PKG-install fftw3
}

# setup


function juno-ext-libs-fftw3-setup {
    juno-ext-libs-PKG-setup fftw3
}

# self check
function juno-ext-libs-fftw3-self-check-list {
    # check one file is enough
    echo bin/fftw-wisdom

}
function juno-ext-libs-fftw3-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check fftw3
}

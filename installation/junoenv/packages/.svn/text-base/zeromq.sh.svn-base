#!/bin/bash

# meta data
function juno-ext-libs-zeromq-name {
    echo zeromq
}

function juno-ext-libs-zeromq-version-default {
    echo 4.0.4
}

function juno-ext-libs-zeromq-version {
    echo $(juno-ext-libs-PKG-version zeromq)
}

# dependencies
function juno-ext-libs-zeromq-dependencies-list {
    echo
}
function juno-ext-libs-zeromq-dependencies-setup {
    juno-ext-libs-dependencies-setup zeromq
}

# install dir
function juno-ext-libs-zeromq-install-dir {
    local version=${1:-$(juno-ext-libs-zeromq-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-zeromq-name)/$version
}

# download info
function juno-ext-libs-zeromq-download-url {
    local version=${1:-$(juno-ext-libs-zeromq-version)}
    case $version in
        4.0.4)
            echo http://download.zeromq.org/zeromq-4.0.4.tar.gz
            ;;
        *) 
            echo http://download.zeromq.org/zeromq-4.0.4.tar.gz
            ;;
    esac
}

function juno-ext-libs-zeromq-download-filename {
    local version=${1:-$(juno-ext-libs-zeromq-version)}
    case $version in
        4.0.4)
            echo zeromq-4.0.4.tar.gz
            ;;
        *) 
            echo zeromq-4.0.4.tar.gz
            ;;
    esac
}

function juno-ext-libs-zeromq-tardst {
    local version=${1:-$(juno-ext-libs-zeromq-version)}
    case $version in
        4.0.4)
            echo zeromq-4.0.4
            ;;
        *) 
            echo zeromq-4.0.4
            ;;
    esac
}

function juno-ext-libs-zeromq-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# get 
function juno-ext-libs-zeromq-get {
    juno-ext-libs-PKG-get zeromq
}

# conf

function juno-ext-libs-zeromq-conf- {
    local msg="===== $FUNCNAME: "

    echo $msg ./configure --prefix=$(juno-ext-libs-zeromq-install-dir)
    ./configure --prefix=$(juno-ext-libs-zeromq-install-dir) || exit $?

}
function juno-ext-libs-zeromq-conf {
    juno-ext-libs-PKG-conf zeromq
}

# make 
function juno-ext-libs-zeromq-make {
    juno-ext-libs-PKG-make zeromq
}

# install
function juno-ext-libs-zeromq-install {
    juno-ext-libs-PKG-install zeromq
}

# setup


function juno-ext-libs-zeromq-setup {
    juno-ext-libs-PKG-setup zeromq
}

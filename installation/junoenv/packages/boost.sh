#!/bin/bash  

# meta data
function juno-ext-libs-boost-name {
    echo Boost
}

function juno-ext-libs-boost-version-default {
    echo 1.55.0
}
function juno-ext-libs-boost-version {
    echo $(juno-ext-libs-PKG-version boost)
}
function juno-ext-libs-boost-dependencies-list {
    echo python
}
function juno-ext-libs-boost-dependencies-setup {
    juno-ext-libs-dependencies-setup boost
}

function juno-ext-libs-boost-install-dir {
    local version=${1:-$(juno-ext-libs-boost-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-boost-name)/$version
}

function juno-ext-libs-boost-download-url {
    local version=${1:-$(juno-ext-libs-boost-version)}
    case $version in
        1.55.0)
            echo http://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.gz
            ;;
            *)
            echo http://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.gz
            ;;
    esac

}

function juno-ext-libs-boost-download-filename {
    local version=${1:-$(juno-ext-libs-boost-version)}
    case $version in
        1.55.0)
            echo boost_1_55_0.tar.gz
            ;;
            *)
            echo boost_1_55_0.tar.gz
            ;;
    esac
}

function juno-ext-libs-boost-tardst {
    local version=${1:-$(juno-ext-libs-boost-version)}
    case $version in
        1.55.0)
            echo boost_1_55_0
            ;;
            *)
            echo boost_1_55_0
            ;;
    esac

}

function juno-ext-libs-boost-file-check-exist {
    # if exists, return 0
    # else, return 1
    fn="$1"
    if [ -f "$fn" ]; then
        return 0
    else
        return 1
    fi
}

# interface

function juno-ext-libs-boost-get {
    juno-ext-libs-PKG-get boost
}

function juno-ext-libs-boost-conf- {
    local msg="===== $FUNCNAME: "

    # TODO: it will move to the top level function
    # we need setup the dependencies first
    juno-ext-libs-boost-dependencies-setup

    # begin to configure
    echo $msg ./bootstrap.sh --prefix=$(juno-ext-libs-boost-install-dir) 
    ./bootstrap.sh --prefix=$(juno-ext-libs-boost-install-dir) 
    if [ "$?" != "0" ]; then
        echo $msg Configure Failed.
        exit 1
    fi
}

function juno-ext-libs-boost-conf {
    juno-ext-libs-PKG-conf boost
}

function juno-ext-libs-boost-make- {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-boost-dependencies-setup

    echo $msg ./b2 install
    ./b2 install
}

function juno-ext-libs-boost-make {
    juno-ext-libs-PKG-make boost
}

function juno-ext-libs-boost-install- {
    echo $msg ./b2 install
    ./b2 install
}
function juno-ext-libs-boost-install {
    juno-ext-libs-PKG-install boost
}

function juno-ext-libs-boost-setup {
    juno-ext-libs-PKG-setup boost
}

# self check
function juno-ext-libs-boost-self-check-list {
    # check one file is enough
    echo include/boost/version.hpp

}
function juno-ext-libs-boost-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check boost
}

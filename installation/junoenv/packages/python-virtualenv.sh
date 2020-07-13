#!/bin/bash

# meta data
function juno-ext-libs-python-virtualenv-name {
    echo python-virtualenv
}

function juno-ext-libs-python-virtualenv-version-default {
    echo 1.11.6
}

function juno-ext-libs-python-virtualenv-version {
    echo $(juno-ext-libs-PKG-version python-virtualenv)
}

# dependencies
function juno-ext-libs-python-virtualenv-dependencies-list {
    echo python
}
function juno-ext-libs-python-virtualenv-dependencies-setup {
    juno-ext-libs-dependencies-setup python-virtualenv
}

# install dir
# the installation prefix is the python's default path.
# install dir
function juno-ext-libs-python-virtualenv-install-dir {
    local version=${1:-$(juno-ext-libs-python-virtualenv-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-python-virtualenv-name)/$version
}

# download info
function juno-ext-libs-python-virtualenv-download-url {
    local version=${1:-$(juno-ext-libs-python-virtualenv-version)}
    case $version in
        1.11.6)
            echo https://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.11.6.tar.gz
            ;;
        *) 
            echo https://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.11.6.tar.gz
            ;;
    esac
}
function juno-ext-libs-python-virtualenv-download-filename {
    local version=${1:-$(juno-ext-libs-python-virtualenv-version)}
    case $version in
        1.11.6)
            echo virtualenv-1.11.6.tar.gz
            ;;
        *) 
            echo virtualenv-1.11.6.tar.gz
            ;;
    esac
}

function juno-ext-libs-python-virtualenv-tardst {
    local version=${1:-$(juno-ext-libs-python-virtualenv-version)}
    case $version in
        1.11.6)
            echo virtualenv-1.11.6
            ;;
        *) 
            echo virtualenv-1.11.6
            ;;
    esac
}

function juno-ext-libs-python-virtualenv-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# get 
function juno-ext-libs-python-virtualenv-get {
    juno-ext-libs-PKG-get python-virtualenv
}

# conf

function juno-ext-libs-python-virtualenv-conf-uncompress {
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
function juno-ext-libs-python-virtualenv-conf- {
    local msg="===== $FUNCNAME: "

}
function juno-ext-libs-python-virtualenv-conf {
    juno-ext-libs-PKG-conf python-virtualenv
}

# make

function juno-ext-libs-python-virtualenv-make- {
    local msg="===== $FUNCNAME: "
    python setup.py build
}
function juno-ext-libs-python-virtualenv-make {
    juno-ext-libs-PKG-make python-virtualenv
}

# install

function juno-ext-libs-python-virtualenv-install- {
    local msg="===== $FUNCNAME: "
    python setup.py install
}
function juno-ext-libs-python-virtualenv-install {
    juno-ext-libs-PKG-install python-virtualenv
}

# setup


function juno-ext-libs-python-virtualenv-setup {
    local msg="===== $FUNCNAME: "
}

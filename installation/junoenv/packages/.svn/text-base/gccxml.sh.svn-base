#!/bin/bash

# meta data
function juno-ext-libs-gccxml-name {
    echo GCCXML
}

function juno-ext-libs-gccxml-version-default {
    # TODO
    # I don't know the version
    echo master
}
function juno-ext-libs-gccxml-version {
    echo $(juno-ext-libs-PKG-version gccxml)
}

# dependencies
function juno-ext-libs-gccxml-dependencies-list {
    echo cmake
}

function juno-ext-libs-gccxml-dependencies-setup {
    juno-ext-libs-dependencies-setup gccxml
}

# install dir
function juno-ext-libs-gccxml-install-dir {
    local version=${1:-$(juno-ext-libs-gccxml-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-gccxml-name)/$version
}

# download info
function juno-ext-libs-gccxml-download-url {
    local version=${1:-$(juno-ext-libs-gccxml-version)}
    case $version in
        master)
            echo https://github.com/gccxml/gccxml/archive/master.zip
            ;;
        *)
            echo https://github.com/gccxml/gccxml/archive/master.zip
            ;;
    esac

}
function juno-ext-libs-gccxml-download-filename {
    local version=${1:-$(juno-ext-libs-gccxml-version)}
    case $version in
        master)
            echo gccxml-master.zip
            ;;
        *)
            echo gccxml-master.zip
            ;;
    esac

}

# build info
function juno-ext-libs-gccxml-tardst {
    local version=${1:-$(juno-ext-libs-gccxml-version)}
    case $version in
        master)
            echo gccxml-master
            ;;
        *)
            echo gccxml-master
            ;;
    esac

}

function juno-ext-libs-gccxml-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface 
function juno-ext-libs-gccxml-get {
    juno-ext-libs-PKG-get gccxml
}

function juno-ext-libs-gccxml-conf- {
    local msg="===== $FUNCNAME: "
    # begin to configure
    if [ ! -d "gccxml-build" ]; then
        mkdir gccxml-build
    fi
    pushd gccxml-build
    cmake .. -DCMAKE_INSTALL_PREFIX:PATH=$(juno-ext-libs-gccxml-install-dir)
    popd
}

function juno-ext-libs-gccxml-conf {
    juno-ext-libs-PKG-conf gccxml
}

function juno-ext-libs-gccxml-make- {
    local msg="===== $FUNCNAME: "
    pushd gccxml-build
    echo $msg make $(juno-ext-libs-gen-cpu-num)
    make $(juno-ext-libs-gen-cpu-num)
    popd
}
function juno-ext-libs-gccxml-make {
    juno-ext-libs-PKG-make gccxml
}

function juno-ext-libs-gccxml-install- {
    local msg="===== $FUNCNAME: "
    pushd gccxml-build
    echo $msg make install
    make install
    popd
}
function juno-ext-libs-gccxml-install {
    juno-ext-libs-PKG-install gccxml
}

function juno-ext-libs-gccxml-setup {
    juno-ext-libs-PKG-setup gccxml
}
# self check
function juno-ext-libs-gccxml-self-check-list {
    # check one file is enough
    echo bin/gccxml

}
function juno-ext-libs-gccxml-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check gccxml
}

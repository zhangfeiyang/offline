#!/bin/bash

# meta data
function juno-ext-libs-clhep-name {
    echo CLHEP
}

function juno-ext-libs-clhep-version-default {
    echo 2.1.0.1
}
function juno-ext-libs-clhep-version {
    echo $(juno-ext-libs-PKG-version clhep)
}

# dependencies
function juno-ext-libs-clhep-dependencies-list {
    echo 
}
function juno-ext-libs-clhep-dependencies-setup {
    juno-ext-libs-dependencies-setup clhep
}
# install dir
function juno-ext-libs-clhep-install-dir {
    local version=${1:-$(juno-ext-libs-clhep-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-clhep-name)/$version
}
# download info
function juno-ext-libs-clhep-download-url {
    local version=${1:-$(juno-ext-libs-clhep-version)}
    case $version in
        2.1.0.1)
            echo http://proj-clhep.web.cern.ch/proj-clhep/DISTRIBUTION/tarFiles/clhep-2.1.0.1.tgz
            ;;
        *)
            echo http://proj-clhep.web.cern.ch/proj-clhep/DISTRIBUTION/tarFiles/clhep-2.1.0.1.tgz
            ;;
    esac
}
function juno-ext-libs-clhep-download-filename {
    local version=${1:-$(juno-ext-libs-clhep-version)}
    case $version in
        2.1.0.1)
            echo clhep-2.1.0.1.tgz
            ;;
        *)
            echo clhep-2.1.0.1.tgz
            ;;
    esac
}
function juno-ext-libs-clhep-tardst {
    # install in root of external libraries
    local version=${1:-$(juno-ext-libs-clhep-version)}
    case $version in
        2.1.0.1)
            echo clhep-2.1.0.1
            ;;
        *)
            echo clhep-2.1.0.1
            ;;
    esac
}

function juno-ext-libs-clhep-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface
function juno-ext-libs-clhep-get {
    juno-ext-libs-PKG-get clhep
}

function juno-ext-libs-clhep-conf-uncompress {
    local msg="===== $FUNCNAME: "
    tardst=$1
    tarname=$2
    echo tar -C $tardst -zxvf $tarname
    if [ -d "$tardst" ]; then
        echo $msg $tardst already exist
        echo $msg will not invoke the uncompress command
        return
    else
        mkdir -p $tardst
    fi
    tar -C $tardst -zxvf $tarname || exit $?
    if [ ! -d "$tardst" ]; then
        echo $msg "After Uncompress, can't find $tardst"
        exit 1
    fi
}

function juno-ext-libs-clhep-conf- {
    local msg="===== $FUNCNAME: "
    pushd $(juno-ext-libs-clhep-version)/CLHEP
    echo $msg ./configure --prefix=$(juno-ext-libs-clhep-install-dir) 
    ./configure --prefix=$(juno-ext-libs-clhep-install-dir) 
    popd
}
function juno-ext-libs-clhep-conf {
    juno-ext-libs-PKG-conf clhep
}
function juno-ext-libs-clhep-make- {
    local msg="===== $FUNCNAME: "
    pushd $(juno-ext-libs-clhep-version)/CLHEP
    echo $msg make $(juno-ext-libs-gen-cpu-num)
    make $(juno-ext-libs-gen-cpu-num)
    popd
}
function juno-ext-libs-clhep-make {
    juno-ext-libs-PKG-make clhep
}
function juno-ext-libs-clhep-install- {
    local msg="===== $FUNCNAME: "
    pushd $(juno-ext-libs-clhep-version)/CLHEP
    echo $msg make install
    make install
    popd
    # check the lib directory
    pushd $(juno-ext-libs-clhep-install-dir)
    if [ -d "lib64" -a ! -d "lib" ]; then
        ln -s lib64 lib
    fi
    popd
}

function juno-ext-libs-clhep-install {
    juno-ext-libs-PKG-install clhep
}
function juno-ext-libs-clhep-setup {
    juno-ext-libs-PKG-setup clhep
}
# self check
function juno-ext-libs-clhep-self-check-list {
    # check one file is enough
    echo bin/clhep-config

}
function juno-ext-libs-clhep-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check clhep
}

#!/bin/bash

function juno-ext-libs-libmore-name {
    echo libmore
}

function juno-ext-libs-libmore-version-default {
    echo 0.8.3
}

function juno-ext-libs-libmore-version {
    echo $(juno-ext-libs-PKG-version libmore)
}

# dependencies
function juno-ext-libs-libmore-dependencies-list {
    echo
}
function juno-ext-libs-libmore-dependencies-setup {
    juno-ext-libs-dependencies-setup libmore
}

# install dir
function juno-ext-libs-libmore-install-dir {
    local version=${1:-$(juno-ext-libs-libmore-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-libmore-name)/$version
}

# download info
function juno-ext-libs-libmore-download-url {
    local version=${1:-$(juno-ext-libs-libmore-version)}
    case $version in
        0.8.3)
            #echo http://heanet.dl.sourceforge.net/project/more/more/0.8.3/more-0.8.3.tar.bz2
            echo https://downloads.sourceforge.net/project/more/more/0.8.3/more-0.8.3.tar.bz2
            ;;
        *) 
            #echo http://heanet.dl.sourceforge.net/project/more/more/0.8.3/more-0.8.3.tar.bz2
            echo https://downloads.sourceforge.net/project/more/more/0.8.3/more-0.8.3.tar.bz2
            ;;
    esac
}

function juno-ext-libs-libmore-download-filename {
    local version=${1:-$(juno-ext-libs-libmore-version)}
    case $version in
        0.8.3)
            echo more-0.8.3.tar.bz2
            ;;
        *) 
            echo more-0.8.3.tar.bz2
            ;;
    esac
}

function juno-ext-libs-libmore-tardst {
    local version=${1:-$(juno-ext-libs-libmore-version)}
    case $version in
        0.8.3)
            echo more-0.8.3
            ;;
        *) 
            echo more-0.8.3
            ;;
    esac
}

function juno-ext-libs-libmore-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# get 
function juno-ext-libs-libmore-get {
    juno-ext-libs-PKG-get libmore
}

# conf

function juno-ext-libs-libmore-get-patch-name {
    echo $(juno-ext-libs-init-scripts-dir)/patches/$(juno-ext-libs-libmore-name)-$(juno-ext-libs-libmore-version).patch
}

function juno-ext-libs-libmore-apply-patch {
    local msg="===== $FUNCNAME: "
    # load patch file name
    local patchname=$(juno-ext-libs-libmore-get-patch-name)
    echo $msg Apply Patch $patchname
    # apply patch
    patch -p1 < $patchname
}
function juno-ext-libs-libmore-conf- {
    local msg="===== $FUNCNAME: "

    # load patch for libmore
    juno-ext-libs-libmore-apply-patch
    echo $msg ./configure --prefix=$(juno-ext-libs-libmore-install-dir)

    local tardst=$(juno-ext-libs-build-root)/$(juno-ext-libs-libmore-tardst)

    [ -d "temp-build" ] || mkdir temp-build
    pushd temp-build
    $tardst/configure --prefix=$(juno-ext-libs-libmore-install-dir) || exit $?
    popd

}
function juno-ext-libs-libmore-conf {
    juno-ext-libs-PKG-conf libmore
}

# make 
function juno-ext-libs-libmore-make- {
    pushd temp-build
    make
    popd
}
function juno-ext-libs-libmore-make {
    juno-ext-libs-PKG-make libmore
}

# install
function juno-ext-libs-libmore-install- {
    pushd temp-build
    make install
    popd
}
function juno-ext-libs-libmore-install {
    juno-ext-libs-PKG-install libmore
}

# setup


function juno-ext-libs-libmore-setup {
    juno-ext-libs-PKG-setup libmore
}
# self check
function juno-ext-libs-libmore-self-check-list {
    # check one file is enough
    echo bin/more-config

}
function juno-ext-libs-libmore-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check libmore
}

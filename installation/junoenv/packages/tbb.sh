#!/bin/bash

# meta data
function juno-ext-libs-tbb-name {
    echo tbb
}

function juno-ext-libs-tbb-version-default {
    echo 2017
}

function juno-ext-libs-tbb-version {
    echo $(juno-ext-libs-PKG-version tbb)
}

# dependencies
function juno-ext-libs-tbb-dependencies-list {
    echo
}
function juno-ext-libs-tbb-dependencies-setup {
    juno-ext-libs-dependencies-setup tbb
}

# install dir
function juno-ext-libs-tbb-install-dir {
    local version=${1:-$(juno-ext-libs-tbb-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-tbb-name)/$version
}

# download info
function juno-ext-libs-tbb-download-url {
    local version=${1:-$(juno-ext-libs-tbb-version)}
    case $version in
        2017)
            echo https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb2017_20160916oss_src.tgz
            ;;
        *) 
            echo https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb2017_20160916oss_src.tgz
            ;;
    esac
}

function juno-ext-libs-tbb-download-filename {
    local version=${1:-$(juno-ext-libs-tbb-version)}
    case $version in
        2017)
            echo tbb2017_20160916oss_src.tgz
            ;;
        *) 
            echo tbb2017_20160916oss_src.tgz
            ;;
    esac
}

function juno-ext-libs-tbb-tardst {
    local version=${1:-$(juno-ext-libs-tbb-version)}
    case $version in
        2017)
            echo tbb2017_20160916oss
            ;;
        *) 
            echo tbb2017_20160916oss
            ;;
    esac
}

function juno-ext-libs-tbb-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# get 
function juno-ext-libs-tbb-get {
    juno-ext-libs-PKG-get tbb
}

# conf

function juno-ext-libs-tbb-conf- {
    local msg="===== $FUNCNAME: "

    echo $msg ./configure --prefix=$(juno-ext-libs-tbb-install-dir)
    #./configure --prefix=$(juno-ext-libs-tbb-install-dir) || exit $?

}
function juno-ext-libs-tbb-conf {
    juno-ext-libs-PKG-conf tbb
}

# make 
function juno-ext-libs-tbb-make {
    juno-ext-libs-PKG-make tbb
}

# install
function juno-ext-libs-tbb-install- {
    pwd
    local prefix=$(juno-ext-libs-tbb-install-dir)
    install -d $prefix/include/serial
    install -d $prefix/include/serial/tbb
    install -t $prefix/include/serial/tbb include/serial/tbb/*.h
    install -d $prefix/include/tbb
    install -t $prefix/include/tbb include/tbb/*.h
    install -d $prefix/include/tbb/compat
    install -t $prefix/include/tbb/compat include/tbb/compat/*
    install -d $prefix/include/tbb/internal
    install -t $prefix/include/tbb/internal include/tbb/internal/*
    install -d $prefix/include/tbb/machine
    install -t $prefix/include/tbb/machine include/tbb/machine/*.h

    install -d $prefix/lib
    install -t $prefix/lib build/linux*/*.so*
}
function juno-ext-libs-tbb-install {
    juno-ext-libs-PKG-install tbb
}

# setup


function juno-ext-libs-tbb-setup {
    juno-ext-libs-PKG-setup tbb
}

# self check
function juno-ext-libs-tbb-self-check-list {
    # check one file is enough
    echo include/tbb/tbb.h

}
function juno-ext-libs-tbb-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check tbb
}

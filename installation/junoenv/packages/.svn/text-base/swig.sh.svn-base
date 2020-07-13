#!/bin/bash

# meta data
function juno-ext-libs-swig-name {
    echo SWIG
}

function juno-ext-libs-swig-version-default {
    echo 2.0.11
}
function juno-ext-libs-swig-version {
    echo $(juno-ext-libs-PKG-version swig)
}
# dependencies
function juno-ext-libs-swig-dependencies-list {
    echo python
}
function juno-ext-libs-swig-dependencies-setup {
    juno-ext-libs-dependencies-setup swig
}

# install dir
function juno-ext-libs-swig-install-dir {
    local version=${1:-$(juno-ext-libs-swig-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-swig-name)/$version
}
# download info
function juno-ext-libs-swig-download-url {
    local version=${1:-$(juno-ext-libs-swig-version)}
    case $version in
        2.0.11)
            echo http://downloads.sourceforge.net/project/swig/swig/swig-2.0.11/swig-2.0.11.tar.gz
            ;;
            *)
            echo http://downloads.sourceforge.net/project/swig/swig/swig-2.0.11/swig-2.0.11.tar.gz
            ;;
    esac
}
function juno-ext-libs-swig-download-filename {
    local version=${1:-$(juno-ext-libs-swig-version)}
    case $version in
        2.0.11)
            echo swig-2.0.11.tar.gz
            ;;
            *)
            echo swig-2.0.11.tar.gz
            ;;
    esac
}
function juno-ext-libs-swig-tardst {
    # install in root of external libraries
    local version=${1:-$(juno-ext-libs-swig-version)}
    case $version in
        2.0.11)
            echo swig-2.0.11
            ;;
            *)
            echo swig-2.0.11
            ;;
    esac
}

function juno-ext-libs-swig-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface
function juno-ext-libs-swig-get {
    juno-ext-libs-PKG-get swig
}
function juno-ext-libs-swig-conf-uncompress {
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
    tar -zxvf $tarname || exit $?
    if [ ! -d "$tardst" ]; then
        echo $msg "After Uncompress, can't find $tardst"
        exit 1
    fi
}
function juno-ext-libs-swig-conf- {
    local msg="===== $FUNCNAME: "
    # build pcre first
    if [ ! -f "pcre-8.33.tar.gz" ]; then
        echo $msg wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.33.tar.gz
        wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.33.tar.gz
    fi
    if [ ! -d "prce" ]; then
        echo $msg build prce
        bash Tools/pcre-build.sh
    fi
    pwd

    echo $msg ./configure --prefix=$(juno-ext-libs-swig-install-dir) 
    ./configure --prefix=$(juno-ext-libs-swig-install-dir) 
}
function juno-ext-libs-swig-conf {
    juno-ext-libs-PKG-conf swig
}
function juno-ext-libs-swig-make {
    juno-ext-libs-PKG-make swig
}
function juno-ext-libs-swig-install {
    juno-ext-libs-PKG-install swig
}
function juno-ext-libs-swig-setup {
    juno-ext-libs-PKG-setup swig
}

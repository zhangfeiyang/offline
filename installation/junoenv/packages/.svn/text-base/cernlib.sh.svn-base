#!/bin/bash
# THIS SCRIPT IS DESIGNED FOR SLC5.
# meta data
function juno-ext-libs-cernlib-name {
    echo CERNLIB
}

function juno-ext-libs-cernlib-version-default {
    echo 2006b
}
function juno-ext-libs-cernlib-version {
    echo $(juno-ext-libs-PKG-version cernlib)
}
# dependencies
function juno-ext-libs-cernlib-dependencies-list {
    echo 
}
function juno-ext-libs-cernlib-dependencies-setup {
    juno-ext-libs-dependencies-setup cernlib
}
# download info
function juno-ext-libs-cernlib-download-url {
    local version=${1:-$(juno-ext-libs-cernlib-version)}
    case $version in
        2006b)
            echo http://cernlib.web.cern.ch/cernlib/download/2006b_x86_64-slc5-gcc41-opt/tar
            ;;
        *)
            echo http://cernlib.web.cern.ch/cernlib/download/2006b_x86_64-slc5-gcc41-opt/tar
            ;;
    esac
}
function juno-ext-libs-cernlib-src-download-url {
    local version=${1:-$(juno-ext-libs-cernlib-version)}
    case $version in
        2006b)
            echo http://cernlib.web.cern.ch/cernlib/download/2006b_source/tar
            ;;
        *)
            echo http://cernlib.web.cern.ch/cernlib/download/2006b_source/tar
            ;;
    esac
}
function juno-ext-libs-cernlib-download-list {
    echo cernbin cernlib include
}
function juno-ext-libs-cernlib-src-download-list {
    case $version in
        2006b)
            echo 2006_src
            ;;
        *)
            echo 2006_src
            ;;
    esac
}
# install dir
function juno-ext-libs-cernlib-install-dir {
    local version=${1:-$(juno-ext-libs-cernlib-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-cernlib-name)/$version
}

# interface
function juno-ext-libs-cernlib-get {
    local msg="==== $FUNCNAME: "
    local version=${1:-$(juno-ext-libs-cernlib-version)}
    local downloadurl=$(juno-ext-libs-cernlib-download-url $version)

    juno-ext-libs-build-root-check || exit $?
    pushd $(juno-ext-libs-build-root) >& /dev/null
    local clpkg=""
    for clpkg in $(juno-ext-libs-cernlib-download-list)
    do
        if [ ! -f "cernlib-${clpkg}.tar.gz" ];then
            echo $msg get $clpkg
            if [ "$(juno-archive-check)" == "0" ]; then 
                wget -O cernlib-${clpkg}.tar.gz $(juno-ext-libs-cernlib-download-url)/${clpkg}.tar.gz
            else
                juno-archive-get cernlib-${clpkg}.tar.gz cernlib-${clpkg}.tar.gz || exit $?
            fi
        else
            echo $msg $clpkg already exists.
        fi
    done
    for clpkg in $(juno-ext-libs-cernlib-src-download-list)
    do
        if [ ! -f "cernlib-${clpkg}.tar.gz" ];then
            echo $msg get $clpkg
            if [ "$(juno-archive-check)" == "0" ]; then 
                wget -O cernlib-${clpkg}.tar.gz $(juno-ext-libs-cernlib-src-download-url)/${clpkg}.tar.gz
            else
                juno-archive-get cernlib-${clpkg}.tar.gz cernlib-${clpkg}.tar.gz || exit $?
            fi
        else
            echo $msg $clpkg already exists.
        fi
    done


    popd >& /dev/null
}

function juno-ext-libs-cernlib-conf {
    local msg="==== $FUNCNAME: "

    juno-ext-libs-build-root-check || exit $?
    pushd $(juno-ext-libs-build-root) >& /dev/null

    if [ -d "$(juno-ext-libs-cernlib-version)" ]; then
        echo $msg Already exist directory $(juno-ext-libs-cernlib-version)
    fi

    for clpkg in $(juno-ext-libs-cernlib-download-list)
    do
        if [ ! -f "cernlib-${clpkg}.tar.gz" ];then
            echo $msg Please get cernlib first
            exit 1
        fi
        echo $msg tar zxvf cernlib-${clpkg}.tar.gz
        tar zxvf cernlib-${clpkg}.tar.gz
    done
    for clpkg in $(juno-ext-libs-cernlib-src-download-list)
    do
        if [ ! -f "cernlib-${clpkg}.tar.gz" ];then
            echo $msg Please get cernlib first
            exit 1
        fi
        echo $msg tar zxvf cernlib-${clpkg}.tar.gz
        tar zxvf cernlib-${clpkg}.tar.gz
        echo $msg cp -r 2006/src 2006b
        cp -r 2006/src 2006b
    done

    popd >& /dev/null
}

function juno-ext-libs-cernlib-make {
    local msg="==== $FUNCNAME: "
}

function juno-ext-libs-cernlib-install {
    local msg="==== $FUNCNAME: "
    juno-ext-libs-build-root-check || exit $?
    pushd $(juno-ext-libs-build-root) >& /dev/null

    if [ ! -d "$(juno-ext-libs-cernlib-install-dir)" ]; then
        mkdir -p $(juno-ext-libs-cernlib-install-dir)
    fi

    if [ -d $(juno-ext-libs-cernlib-version)/x86_64-slc5-gcc41-opt ]; then
        echo $msg mv $(juno-ext-libs-cernlib-version)/x86_64-slc5-gcc41-opt $(juno-ext-libs-cernlib-install-dir)
        mv $(juno-ext-libs-cernlib-version)/x86_64-slc5-gcc41-opt $(juno-ext-libs-cernlib-install-dir)
    fi
    if [ -d $(juno-ext-libs-cernlib-version)/include ]; then
        echo $msg mv $(juno-ext-libs-cernlib-version)/include $(juno-ext-libs-cernlib-install-dir)/x86_64-slc5-gcc41-opt
        mv $(juno-ext-libs-cernlib-version)/include $(juno-ext-libs-cernlib-install-dir)/x86_64-slc5-gcc41-opt
    fi
    if [ -d $(juno-ext-libs-cernlib-version)/src ]; then
        echo $msg mv $(juno-ext-libs-cernlib-version)/src $(juno-ext-libs-cernlib-install-dir)/x86_64-slc5-gcc41-opt
        mv $(juno-ext-libs-cernlib-version)/src $(juno-ext-libs-cernlib-install-dir)/x86_64-slc5-gcc41-opt
    fi

    popd >& /dev/null
}

function juno-ext-libs-cernlib-generate-sh {
local pkg=$1
local install=$2
local cern=$(dirname $install)
local cernlevel=$(basename $install)/x86_64-slc5-gcc41-opt
cat << EOF > bashrc
export JUNO_EXTLIB_${pkg}_HOME=${install}
export CERN=$cern
export CERN_LEVEL=$cernlevel
export PATH=\$CERN/\$CERN_LEVEL/bin:\$PATH
EOF
}
function juno-ext-libs-cernlib-generate-csh {
local pkg=$1
local install=$2
local cern=$(dirname $install)
local cernlevel=$(basename $install)/x86_64-slc5-gcc41-opt
cat << EOF > tcshrc
setenv JUNO_EXTLIB_${pkg}_HOME ${install}
setenv CERN $cern
setenv CERN_LEVEL $cernlevel
setenv PATH \$CERN/\$CERN_LEVEL/bin:\$PATH
EOF
}

function juno-ext-libs-cernlib-setup {
    juno-ext-libs-PKG-setup cernlib
}

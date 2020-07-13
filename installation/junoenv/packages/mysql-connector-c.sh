#!/bin/bash

function juno-ext-libs-mysql-connector-c-name() {
    echo mysql-connector-c
}

function juno-ext-libs-mysql-connector-c-version-default {
    echo 6.1.9
    #echo 6.1.6
}
function juno-ext-libs-mysql-connector-c-version {
    echo $(juno-ext-libs-PKG-version mysql-connector-c)
}

# dependencies
function juno-ext-libs-mysql-connector-c-dependencies-list {
    echo cmake
}

function juno-ext-libs-mysql-connector-c-dependencies-setup {
    juno-ext-libs-dependencies-setup mysql-connector-c
}

# install dir
function juno-ext-libs-mysql-connector-c-install-dir {
    local version=${1:-$(juno-ext-libs-mysql-connector-c-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-mysql-connector-c-name)/$version
}

# download info
function juno-ext-libs-mysql-connector-c-download-url {
    local version=${1:-$(juno-ext-libs-mysql-connector-c-version)}
    case $version in
        6.1.9)
            echo https://dev.mysql.com/get/Downloads/Connector-C/mysql-connector-c-6.1.9-src.tar.gz
            ;;
        6.1.6)
            echo https://downloads.mysql.com/archives/get/file/mysql-connector-c-6.1.6-src.tar.gz
            ;;
        *)
            echo https://dev.mysql.com/get/Downloads/Connector-C/mysql-connector-c-${version}-src.tar.gz
            ;;
    esac

}
function juno-ext-libs-mysql-connector-c-download-filename {
    local version=${1:-$(juno-ext-libs-mysql-connector-c-version)}
    case $version in
        6.1.9)
            echo mysql-connector-c-6.1.9-src.tar.gz
            ;;
        *)
            echo mysql-connector-c-${version}-src.tar.gz
            ;;
    esac

}

# build info
function juno-ext-libs-mysql-connector-c-tardst {
    local version=${1:-$(juno-ext-libs-mysql-connector-c-version)}
    case $version in
        6.1.9)
            echo mysql-connector-c-6.1.9-src
            ;;
        *)
            echo mysql-connector-c-${version}-src
            ;;
    esac

}

function juno-ext-libs-mysql-connector-c-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface 
function juno-ext-libs-mysql-connector-c-get {
    juno-ext-libs-PKG-get mysql-connector-c
}

function juno-ext-libs-mysql-connector-c-conf- {
    local msg="===== $FUNCNAME: "
    # begin to configure
    if [ ! -d "mysql-connector-c-build" ]; then
        mkdir mysql-connector-c-build
    fi
    pushd mysql-connector-c-build
    cmake .. -DCMAKE_INSTALL_PREFIX:PATH=$(juno-ext-libs-mysql-connector-c-install-dir) \
             -DWITH_PIC:BOOL=ON \
             -DLIBMYSQL_OS_OUTPUT_NAME=mysqlclient
    popd
}

function juno-ext-libs-mysql-connector-c-conf {
    juno-ext-libs-PKG-conf mysql-connector-c
}

function juno-ext-libs-mysql-connector-c-make- {
    local msg="===== $FUNCNAME: "
    pushd mysql-connector-c-build
    echo $msg make $(juno-ext-libs-gen-cpu-num)
    make $(juno-ext-libs-gen-cpu-num)
    popd
}
function juno-ext-libs-mysql-connector-c-make {
    juno-ext-libs-PKG-make mysql-connector-c
}

function juno-ext-libs-mysql-connector-c-install- {
    local msg="===== $FUNCNAME: "
    pushd mysql-connector-c-build
    echo $msg make install
    make install
    popd
}
function juno-ext-libs-mysql-connector-c-install {
    juno-ext-libs-PKG-install mysql-connector-c
}

function juno-ext-libs-mysql-connector-c-setup {
    juno-ext-libs-PKG-setup mysql-connector-c
}
# self check
function juno-ext-libs-mysql-connector-c-self-check-list {
    # check one file is enough
    echo bin/mysql_config include/mysql.h

}
function juno-ext-libs-mysql-connector-c-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check mysql-connector-c
}

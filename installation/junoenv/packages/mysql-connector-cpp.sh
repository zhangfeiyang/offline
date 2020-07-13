#!/bin/bash

function juno-ext-libs-mysql-connector-cpp-name() {
    echo mysql-connector-cpp
}

function juno-ext-libs-mysql-connector-cpp-version-default {
    echo 1.1.8
}
function juno-ext-libs-mysql-connector-cpp-version {
    echo $(juno-ext-libs-PKG-version mysql-connector-cpp)
}

# dependencies
function juno-ext-libs-mysql-connector-cpp-dependencies-list {
    echo boost cmake mysql-connector-c
}

function juno-ext-libs-mysql-connector-cpp-dependencies-setup {
    juno-ext-libs-dependencies-setup mysql-connector-cpp
}

# install dir
function juno-ext-libs-mysql-connector-cpp-install-dir {
    local version=${1:-$(juno-ext-libs-mysql-connector-cpp-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-mysql-connector-cpp-name)/$version
}

# download info
function juno-ext-libs-mysql-connector-cpp-download-url {
    local version=${1:-$(juno-ext-libs-mysql-connector-cpp-version)}
    case $version in
        1.1.8)
            echo https://dev.mysql.com/get/Downloads/Connector-C++/mysql-connector-c++-1.1.8.tar.gz
            ;;
        *)
            echo https://dev.mysql.com/get/Downloads/Connector-C++/mysql-connector-c++-${version}.tar.gz
            ;;
    esac

}
function juno-ext-libs-mysql-connector-cpp-download-filename {
    local version=${1:-$(juno-ext-libs-mysql-connector-cpp-version)}
    case $version in
        1.1.8)
            echo mysql-connector-c++-1.1.8.tar.gz
            ;;
        *)
            echo mysql-connector-c++-${version}.tar.gz
            ;;
    esac

}

# build info
function juno-ext-libs-mysql-connector-cpp-tardst {
    local version=${1:-$(juno-ext-libs-mysql-connector-cpp-version)}
    case $version in
        6.1.9)
            echo  mysql-connector-c++-1.1.8
            ;;
        *)
            echo mysql-connector-c++-${version}
            ;;
    esac

}

function juno-ext-libs-mysql-connector-cpp-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface 
function juno-ext-libs-mysql-connector-cpp-get {
    juno-ext-libs-PKG-get mysql-connector-cpp
}

function juno-ext-libs-mysql-connector-cpp-conf- {
    local msg="===== $FUNCNAME: "
    # begin to configure
    if [ ! -d "mysql-connector-cpp-build" ]; then
        mkdir mysql-connector-cpp-build
    fi
    pushd mysql-connector-cpp-build
    cmake .. -DCMAKE_INSTALL_PREFIX:PATH=$(juno-ext-libs-mysql-connector-cpp-install-dir) \
        -DMYSQL_LIB:FILEPATH=$(juno-ext-libs-mysql-connector-c-install-dir)/lib/libmysqlclient.so \
        -DMYSQLCLIENT_STATIC_LINKING=1 \
        -DBOOST_ROOT=$(juno-ext-libs-boost-install-dir) \
        -DCMAKE_INSTALL_LIBDIR=lib
    popd
}

function juno-ext-libs-mysql-connector-cpp-conf {
    juno-ext-libs-PKG-conf mysql-connector-cpp
}

function juno-ext-libs-mysql-connector-cpp-make- {
    local msg="===== $FUNCNAME: "
    pushd mysql-connector-cpp-build
    echo $msg make $(juno-ext-libs-gen-cpu-num)
    make $(juno-ext-libs-gen-cpu-num)
    popd
}
function juno-ext-libs-mysql-connector-cpp-make {
    juno-ext-libs-PKG-make mysql-connector-cpp
}

function juno-ext-libs-mysql-connector-cpp-install- {
    local msg="===== $FUNCNAME: "
    pushd mysql-connector-cpp-build
    echo $msg make install
    make install
    popd
}
function juno-ext-libs-mysql-connector-cpp-install {
    juno-ext-libs-PKG-install mysql-connector-cpp
}

function juno-ext-libs-mysql-connector-cpp-setup {
    juno-ext-libs-PKG-setup mysql-connector-cpp
}
# self check
function juno-ext-libs-mysql-connector-cpp-self-check-list {
    # check one file is enough
    echo include/mysql_connection.h

}
function juno-ext-libs-mysql-connector-cpp-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check mysql-connector-cpp
}

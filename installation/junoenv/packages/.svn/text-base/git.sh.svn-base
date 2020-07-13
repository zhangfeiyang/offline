#!/bin/bash

# meta data

function juno-ext-libs-git-name {
    echo Git
}

function juno-ext-libs-git-version-default {
    echo 1.8.4.3
}
function juno-ext-libs-git-version {
    echo $(juno-ext-libs-PKG-version git)
}

# dependencies
function juno-ext-libs-git-dependencies-list {
    echo
}
function juno-ext-libs-git-dependencies-setup {
    juno-ext-libs-dependencies-setup git
}

# install dir
function juno-ext-libs-git-install-dir {
    local version=${1:-$(juno-ext-libs-git-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-git-name)/$version
}

# download info
function juno-ext-libs-git-download-url {
    local version=${1:-$(juno-ext-libs-git-version)}
    case $version in
        1.8.4.3)
            echo https://github.com/git/git/archive/v1.8.4.3.zip
            ;;
        *) 
            echo https://github.com/git/git/archive/v1.8.4.3.zip
            ;;
    esac
}

function juno-ext-libs-git-download-filename {
    local version=${1:-$(juno-ext-libs-git-version)}
    case $version in
        1.8.4.3)
            echo git-1.8.4.3.zip
            ;;
            *)
            echo git-1.8.4.3.zip
            ;;
    esac

}

# build info
function juno-ext-libs-git-tardst {
    local version=${1:-$(juno-ext-libs-git-version)}
    case $version in
        1.8.4.3)
            echo git-1.8.4.3
            ;;
            *)
            echo git-1.8.4.3
            ;;
    esac

}

function juno-ext-libs-git-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface

function juno-ext-libs-git-get {
    juno-ext-libs-PKG-get git
}
function juno-ext-libs-git-conf- {
    # begin to configure
    echo $msg make configure
    make configure || exit $?
    echo $msg ./configure --prefix=$(juno-ext-libs-git-install-dir)
    ./configure --prefix=$(juno-ext-libs-git-install-dir) || exit $?
}
function juno-ext-libs-git-conf {
    juno-ext-libs-PKG-conf git
}

function juno-ext-libs-git-make {
    juno-ext-libs-PKG-make git
}

function juno-ext-libs-git-install {
    juno-ext-libs-PKG-install git
}

function juno-ext-libs-git-setup {
    juno-ext-libs-PKG-setup git
}
# self check
function juno-ext-libs-git-self-check-list {
    # check one file is enough
    echo bin/git

}
function juno-ext-libs-git-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check git
}

#!/bin/bash

# meta data
function juno-ext-libs-hepmc-name {
    echo HepMC
}

function juno-ext-libs-hepmc-version-default {
    echo 2.06.09
}
function juno-ext-libs-hepmc-version {
    echo $(juno-ext-libs-PKG-version hepmc)
}

# dependencies
function juno-ext-libs-hepmc-dependencies-list {
    echo 
}
function juno-ext-libs-hepmc-dependencies-setup {
    juno-ext-libs-dependencies-setup hepmc
}
# install dir
function juno-ext-libs-hepmc-install-dir {
    local version=${1:-$(juno-ext-libs-hepmc-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-hepmc-name)/$version
}

# download info
function juno-ext-libs-hepmc-download-url {
    local version=${1:-$(juno-ext-libs-hepmc-version)}
    case $version in
        2.06.09)
            echo http://lcgapp.cern.ch/project/simu/HepMC/download/HepMC-2.06.09.tar.gz
            ;;
        *)
            echo http://lcgapp.cern.ch/project/simu/HepMC/download/HepMC-2.06.09.tar.gz
            ;;
    esac
}
function juno-ext-libs-hepmc-download-filename {
    local version=${1:-$(juno-ext-libs-hepmc-version)}
    case $version in
        2.06.09)
            echo HepMC-2.06.09.tar.gz
            ;;
        *)
            echo HepMC-2.06.09.tar.gz
            ;;
    esac
}
function juno-ext-libs-hepmc-tardst {
    # install in root of external libraries
    local version=${1:-$(juno-ext-libs-hepmc-version)}
    case $version in
        2.06.09)
            echo HepMC-2.06.09
            ;;
        *)
            echo HepMC-2.06.09
            ;;
    esac
}

function juno-ext-libs-hepmc-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface
function juno-ext-libs-hepmc-get {
    juno-ext-libs-PKG-get hepmc
}
function juno-ext-libs-hepmc-conf- {
    local msg="===== $FUNCNAME: "
    echo $msg ./configure --prefix=$(juno-ext-libs-hepmc-install-dir) --with-momentum=MEV --with-length=MM
    ./configure --prefix=$(juno-ext-libs-hepmc-install-dir) --with-momentum=MEV --with-length=MM
}
function juno-ext-libs-hepmc-conf {
    juno-ext-libs-PKG-conf hepmc
}

function juno-ext-libs-hepmc-make {
    juno-ext-libs-PKG-make hepmc
}

function juno-ext-libs-hepmc-install {
    juno-ext-libs-PKG-install hepmc
    # check the lib directory
    pushd $(juno-ext-libs-hepmc-install-dir)
    if [ -d "lib64" -a ! -d "lib" ]; then
        ln -s lib64 lib
    fi
    popd
}
function juno-ext-libs-hepmc-setup {
    juno-ext-libs-PKG-setup hepmc
}
# self check
function juno-ext-libs-hepmc-self-check-list {
    # check one file is enough
    echo include/HepMC/Version.h

}
function juno-ext-libs-hepmc-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check hepmc
}

#!/bin/bash
# meta

function juno-ext-libs-libmore-data-name {
    echo libmore-data
}

function juno-ext-libs-libmore-data-version-default {
    echo 20140630
}

function juno-ext-libs-libmore-data-version {
    echo $(juno-ext-libs-PKG-version libmore-data)
}

# dependencies
function juno-ext-libs-libmore-data-dependencies-list {
    echo libmore
}
function juno-ext-libs-libmore-data-dependencies-setup {
    juno-ext-libs-dependencies-setup libmore-data
}

function juno-ext-libs-libmore-data-install-dir {
    echo $(juno-ext-libs-libmore-install-dir $*)/com/more/ensdf
}

# download info
function juno-ext-libs-libmore-data-download-url {
    local version=${1:-$(juno-ext-libs-libmore-version)}
    case $version in
        20140630) 
            echo http://juno.ihep.ac.cn/software/offline/tarFiles/ensdf-files-20140630.tar
            ;;
        *) 
            echo http://juno.ihep.ac.cn/software/offline/tarFiles/ensdf-files-20140630.tar
            ;;
    esac
}

function juno-ext-libs-libmore-data-download-filename {
    local version=${1:-$(juno-ext-libs-libmore-version)}
    case $version in
        20140630)
            echo ensdf-files-20140630.tar
            ;;
        *) 
            echo ensdf-files-20140630.tar
            ;;
    esac
}


function juno-ext-libs-libmore-data-tardst {
    local version=${1:-$(juno-ext-libs-libmore-version)}
    case $version in
        0.8.3)
            echo ensdf
            ;;
        *) 
            echo ensdf
            ;;
    esac
}

function juno-ext-libs-libmore-data-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# get

function juno-ext-libs-libmore-data-get {
    juno-ext-libs-PKG-get libmore-data
}

# conf

function juno-ext-libs-libmore-data-conf-uncompress {
    local msg="===== $FUNCNAME: "
    tardst=$1
    tarname=$2
    echo $msg tar xvf $tarname
    tar xvf $tarname || exit $?
    if [ ! -d "$tardst" ]; then
        echo $msg "After Uncompress, can't find $tardst"
        exit 1
    fi
}

function juno-ext-libs-libmore-data-conf- {
    local msg="===== $FUNCNAME: "
}
function juno-ext-libs-libmore-data-conf {
    juno-ext-libs-PKG-conf libmore-data
}
# make 
function juno-ext-libs-libmore-data-make {
    local msg="===== $FUNCNAME: "
}

# install
function juno-ext-libs-libmore-data-install- {
    local msg="===== $FUNCNAME: "

    # if we are in the $tardst, copy files into install area
    rsync -avz . $(juno-ext-libs-libmore-data-install-dir)
}

function juno-ext-libs-libmore-data-install {
    juno-ext-libs-PKG-install libmore-data
}

# setup


function juno-ext-libs-libmore-data-setup {
    local msg="===== $FUNCNAME: "
}

# self check
function juno-ext-libs-libmore-data-self-check-list {
    # check one file is enough
    echo ar001.ens.bz2

}
function juno-ext-libs-libmore-data-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check libmore-data
}

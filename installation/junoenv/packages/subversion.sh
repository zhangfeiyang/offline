#!/bin/bash

# meta data
function juno-ext-libs-subversion-name {
    echo Subversion
}

function juno-ext-libs-subversion-version-default {
    echo 1.6.23
}
function juno-ext-libs-subversion-version {
    echo $(juno-ext-libs-PKG-version subversion)
}

# dependencies
function juno-ext-libs-subversion-dependencies-list {
    echo python swig
}
function juno-ext-libs-subversion-dependencies-setup {
    juno-ext-libs-dependencies-setup subversion
}

# install dir
function juno-ext-libs-subversion-install-dir {
    local version=${1:-$(juno-ext-libs-subversion-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-subversion-name)/$version
}

# download info
function juno-ext-libs-subversion-download-url {
    local version=${1:-$(juno-ext-libs-subversion-version)}
    case $version in
        1.6.23)
            echo http://archive.apache.org/dist/subversion/subversion-1.6.23.tar.gz
            ;;
            *)
            echo http://archive.apache.org/dist/subversion/subversion-1.6.23.tar.gz
            ;;
    esac
}
function juno-ext-libs-subversion-download-filename {
    local version=${1:-$(juno-ext-libs-subversion-version)}
    case $version in
        1.6.23)
            echo subversion-1.6.23.tar.gz
            ;;
            *)
            echo subversion-1.6.23.tar.gz
            ;;
    esac
}
function juno-ext-libs-subversion-tardst {
    local version=${1:-$(juno-ext-libs-subversion-version)}
    case $version in
        1.6.23)
            echo subversion-1.6.23
            ;;
            *)
            echo subversion-1.6.23
            ;;
    esac
}
function juno-ext-libs-subversion-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface
function juno-ext-libs-subversion-get {
    juno-ext-libs-PKG-get subversion
}

function juno-ext-libs-subversion-conf-uncompress {
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
function juno-ext-libs-subversion-conf- {
    local msg="===== $FUNCNAME: "
    # get the dependency first
    cd $(juno-ext-libs-subversion-tardst)
    ls 

    # set up the version of dependencies
    if [ ! -f "get-deps.sh.orig" ];
    then
        cp get-deps.sh{,.orig}
        sed -i 's/NEON=neon-0.28.3/NEON=neon-0.30.0/' get-deps.sh
    fi

    # download dependency
    local downloadpkgforsvn=""
    for downloadpkgforsvn in neon zlib serf sqlite-amalgamation 
    do
        echo $msg Check Dependency Package $downloadpkgforsvn
        if [ ! -d $downloadpkgforsvn ]; then
            bash get-deps.sh
        fi
    done
    echo $msg ./configure --prefix=$(juno-ext-libs-subversion-install-dir) --enable-shared --with-ssl
    ./configure --prefix=$(juno-ext-libs-subversion-install-dir) \
                --enable-shared --with-ssl --with-gnome-keyring \
                --disable-mod-activation
}
function juno-ext-libs-subversion-conf {
    juno-ext-libs-PKG-conf subversion
}
function juno-ext-libs-subversion-make- {
    local msg="===== $FUNCNAME: "
    cd $(juno-ext-libs-subversion-tardst)/
    echo $msg make $(juno-ext-libs-gen-cpu-num)
    make $(juno-ext-libs-gen-cpu-num)
}
function juno-ext-libs-subversion-make {
    juno-ext-libs-PKG-make subversion
}
function juno-ext-libs-subversion-install- {
    local msg="===== $FUNCNAME: "
    cd $(juno-ext-libs-subversion-tardst)
    echo $msg make install
    make install
}

function juno-ext-libs-subversion-install {
    juno-ext-libs-PKG-install subversion 
}

function juno-ext-libs-subversion-setup {
    juno-ext-libs-PKG-setup subversion
}

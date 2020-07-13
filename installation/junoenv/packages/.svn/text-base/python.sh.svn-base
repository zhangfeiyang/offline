#!/bin/bash

function juno-ext-libs-python-name {
    echo Python
}

function juno-ext-libs-python-version-default {
    echo 2.7.6
}

function juno-ext-libs-python-version {
    echo $(juno-ext-libs-PKG-version python)
}

function juno-ext-libs-python-dependencies-list {
    echo 
}
function juno-ext-libs-python-dependencies-setup {
    juno-ext-libs-dependencies-setup python
}

function juno-ext-libs-python-install-dir {
    local version=${1:-$(juno-ext-libs-python-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-python-name)/$version
}

function juno-ext-libs-python-download-url {
    local version=${1:-$(juno-ext-libs-python-version)}
    case $version in
        2.7.6)
            echo http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz
            ;;
        2.7.5)
            echo http://www.python.org/ftp/python/2.7.5/Python-2.7.5.tgz
            ;;
            *)
            echo http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz
            ;;
    esac

}

function juno-ext-libs-python-download-filename {
    local version=${1:-$(juno-ext-libs-python-version)}
    case $version in
        2.7.6)
            echo Python-2.7.6.tgz
            ;;
        2.7.5)
            echo Python-2.7.5.tgz
            ;;
            *)
            echo Python-2.7.6.tgz
            ;;
    esac

}

function juno-ext-libs-python-tardst {
    echo $(juno-ext-libs-python-name)-$(juno-ext-libs-python-version) 
}

function juno-ext-libs-python-file-check-exist {
    # if exists, return 0
    # else, return 1
    fn="$1"
    if [ -f "$fn" ]; then
        return 0
    else
        return 1
    fi
}

# interface

function juno-ext-libs-python-get {
    juno-ext-libs-PKG-get python
}

function juno-ext-libs-python-conf- {
    local msg="===== $FUNCNAME: "
    echo $msg ./configure --prefix=$(juno-ext-libs-python-install-dir) --enable-shared
    ./configure --prefix=$(juno-ext-libs-python-install-dir) --enable-shared \
                --enable-unicode=ucs4
    if [ "$?" != "0" ]; then
        echo $msg Configure Failed.
        exit 1
    fi
}

function juno-ext-libs-python-conf {
    juno-ext-libs-PKG-conf python
}

function juno-ext-libs-python-make {
    juno-ext-libs-PKG-make python
}

function juno-ext-libs-python-install {
    juno-ext-libs-PKG-install python
}
# for some specific site, need to setup PYTHONPATH
function juno-ext-libs-python-generate-sh {
    local pkg=$1
    local install=$2
    pushd $install
    # check the lib or lib64
    for lib in lib lib64
    do
        if [ ! -d $install/$lib ];
        then
            continue
        fi
        pushd $install/$lib
        find . -name lib-dynload
        local result=$(find . -name lib-dynload)
        popd
        if [ -n "$result" ]; then
cat << EOF >> bashrc
export PYTHONPATH=\${JUNO_EXTLIB_${pkg}_HOME}/$lib/$result:\$PYTHONPATH
EOF
        fi
    done
    popd
}

function juno-ext-libs-python-generate-csh {
    local pkg=$1
    local install=$2

    pushd $install
    # check the lib or lib64
    for lib in lib lib64
    do
        local result=$(find . -name lib-dynload)
        if [ -n "$result" ]; then
cat << EOF >> tcshrc
if ( \$?PYTHONPATH == 0 ) then
    setenv PYTHONPATH ""
endif
setenv PYTHONPATH \${JUNO_EXTLIB_${pkg}_HOME}/$lib/$result:\${PYTHONPATH}
EOF
        fi
    done
    popd
}
function juno-ext-libs-python-setup {
    juno-ext-libs-PKG-setup python
}

# self check
function juno-ext-libs-python-self-check-list {
    # check one file is enough
    echo bin/python

}
function juno-ext-libs-python-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check python
}

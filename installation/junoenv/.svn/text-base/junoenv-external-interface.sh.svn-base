#!/bin/bash

# meta data

function junoenv-EI-name {
    echo cmtlibs
}

function junoenv-EI-top-name {
    echo ExternalInterface
}

function junoenv-EI-version {
    local msg="==== $FUNCNAME"
    version=$1
    juno-svn-check-branches-name $version
    return $?
}

function junoenv-EI-url {
    local msg="==== $FUNCNAME: "
    local version=${1:-trunk}
    local branchesname=$(junoenv-EI-version $version)
    svnurl=$(juno-svn-top)/$(junoenv-EI-name)/${branchesname}
    juno-svn-check-repo-url $svnurl
    return $?
}

# checkout 
function junoenv-EI-revision-gen {
    juno-svn-revision-gen $*
}

function junoenv-EI-checkout {
    # checkout all code
    local msg="==== $FUNCNAME: "
    local svnurl=$1
    local dstname=$2
    local revision=$3
    echo $msg checkout the code $svnurl 
    # check
    local flag=$(junoenv-EI-revision-gen $revision)
    echo $msg svn co $flag $svnurl $dstname 
    svn co $flag $svnurl $dstname 
}

# check installation of run first
function junoenv-EI-check-preq {
    # only check cmt is installed
    local msg="==== $FUNCNAME: "
    local env_scripts_dir=$JUNOENVDIR/packages
    source $JUNOENVDIR/junoenv-external-libs.sh
    local deppkgs="cmt $(junoenv-external-libs-list cmtlibs)"
    local guesspkg=""
    for guesspkg in $deppkgs
    do
        echo $msg setup ${env_scripts_dir}/${guesspkg}.sh
        source ${env_scripts_dir}/${guesspkg}.sh

        # check the bashrc and tcshrc in the External Libraries
        local installdir=$(juno-ext-libs-${guesspkg}-install-dir)
        if [ -f "$installdir/bashrc" -a -f "$installdir/tcshrc" ]; then
            echo $msg setup $guesspkg
            source $installdir/bashrc
            echo $msg check again $guesspkg 
            which cmt || exit 1
        else
            echo $msg setup $guesspkg failed.
            echo Installation need terminate.
            exit 1
        fi
    done
    
}
# compile
function junoenv-EI-compile {
    local msg="==== $FUNCNAME: "
    pushd $(juno-top-dir) >& /dev/null
    if [ -f "$(junoenv-env-bashrc-name)" ]; then
        source $(junoenv-env-bashrc-name)
    else
        echo $msg Please use 'junoenv env' to generate runtime setup files. 1>&2
        exit 1
    fi
    if [ -d "$(junoenv-EI-top-name)" ]; then
        pushd $(junoenv-EI-top-name) >& /dev/null
        pushd EIRelease/cmt
        cmt br cmt config
        popd
        popd >& /dev/null

    else
        echo $msg $(junoenv-EI-top-name) does not exist. 1>&2
        echo $msg It seems the checkout failed. 1>&2
        exit 1
    fi
    popd >& /dev/null
}

# interface
# EI = External Interface
function junoenv-external-interface {
    local msg="=== $FUNCNAME: "
    # the main handler in this script
    local branchname=${1:-trunk}
    local revision=${2:-}
    # check version
    junoenv-EI-version $branchname
    if [ "$?" != "0" ]; then
        echo $msg branchesname ret: $?
        return 1
    fi

    local url=$(junoenv-EI-url $branchname) 
    echo $msg $?
    echo $msg URL: $url@$revision
    # change directory to $JUNOTOP
    pushd $JUNOTOP >& /dev/null
    junoenv-EI-checkout $url $(junoenv-EI-top-name) $revision
    # TODO
    # check the installation
    junoenv-EI-check-preq
    junoenv-EI-compile
    popd
}

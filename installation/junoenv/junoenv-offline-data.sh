#!/bin/bash
function junoenv-offline-data-name {
    echo offline-data
}

function junoenv-offline-data-top-name {
    echo data
}

function junoenv-offline-data-version {
    local msg="==== $FUNCNAME"
    version=$1
    juno-svn-check-branches-name $version
    return $?
}

function junoenv-offline-data-url {
    local msg="==== $FUNCNAME: "
    local version=${1:-trunk}
    local branchesname=$(junoenv-offline-data-version $version)
    svnurl=$(juno-svn-top)/$(junoenv-offline-data-name)/${branchesname}
    juno-svn-check-repo-url $svnurl
    return $?
}

function junoenv-offline-data-revision-gen {
    juno-svn-revision-gen $*
}

function junoenv-offline-data-checkout {
    # checkout all code
    local msg="==== $FUNCNAME: "
    local svnurl=$1
    local dstname=$2
    local revision=$3
    echo $msg checkout the code $svnurl 
    # check
    local flag=$(junoenv-offline-data-revision-gen $revision)
    echo $msg svn co $flag $svnurl $dstname 
    svn co $flag $svnurl $dstname 
}

function junoenv-offline-data {
    local msg="=== $FUNCNAME: "
    # the main handler in this script
    local branchname=${1:-trunk}
    local revision=${2:-}
    # check version
    junoenv-offline-data-version $branchname
    if [ "$?" != "0" ]; then
        echo $msg branchesname ret: $?
        return 1
    fi


    local url=$(junoenv-offline-data-url $branchname) 
    echo $msg $?
    echo $msg URL: $url
    # change directory to $JUNOTOP
    pushd $JUNOTOP >& /dev/null
    junoenv-offline-data-checkout $url $(junoenv-offline-data-top-name) $revision
    popd

}

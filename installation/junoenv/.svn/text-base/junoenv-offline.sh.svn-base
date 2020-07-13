#!/bin/bash
function junoenv-offline-name {
    echo offline
}

function junoenv-offline-version {
    local msg="==== $FUNCNAME"
    version=$1
    juno-svn-check-branches-name $version
    return $?
}

function junoenv-offline-url {
    local msg="==== $FUNCNAME: "
    local version=${1:-trunk}
    local branchesname=$(junoenv-offline-version $version)
    svnurl=$(juno-svn-top)/$(junoenv-offline-name)/${branchesname}
    juno-svn-check-repo-url $svnurl
    return $?
}

function junoenv-offline-revision-gen {
    juno-svn-revision-gen $*
}

function junoenv-offline-checkout {
    # checkout all code
    local msg="==== $FUNCNAME: "
    local svnurl=$1
    local dstname=$2
    local revision=$3
    echo $msg checkout the code $svnurl 
    # check
    local flag=$(junoenv-offline-revision-gen $revision)
    echo $msg svn co $flag $svnurl $dstname 
    svn co $flag $svnurl $dstname 
}

function junoenv-offline-preq {
    source $JUNOENVDIR/junoenv-env.sh
    local setupscript=$(juno-top-dir)/setup.sh
    if [ -f "$setupscript" ]; then
        pushd $(juno-top-dir) >& /dev/null
        source $setupscript
        popd
    else
        echo $msg Please using "junoenv env" to setup the environment first 1>&2
        exit 1
    fi
}

function junoenv-offline-compile {
    local msg="==== $FUNCNAME: "
    pushd $(juno-top-dir) >& /dev/null
    if [ -d "$(junoenv-offline-name)" ]; then
        pushd $(junoenv-offline-name)/JunoRelease/cmt >& /dev/null
        cmt br cmt config
        source setup.sh
        cmt br cmt make
        popd
    fi

    popd >& /dev/null

}

function junoenv-offline {
    local msg="=== $FUNCNAME: "
    # the main handler in this script
    local branchname=${1:-trunk}
    local revision=${2:-}
    # check version
    junoenv-offline-version $branchname
    if [ "$?" != "0" ]; then
        echo $msg branchesname ret: $?
        return 1
    fi


    local url=$(junoenv-offline-url $branchname) 
    echo $msg $?
    echo $msg URL: $url
    # change directory to $JUNOTOP
    pushd $JUNOTOP >& /dev/null
    junoenv-offline-checkout $url $(junoenv-offline-name) $revision
    junoenv-offline-preq
    junoenv-offline-compile
    popd

}

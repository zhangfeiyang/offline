#!/bin/bash
function junoenv-sniper-name {
    echo sniper
}

function junoenv-sniper-version {
    local msg="==== $FUNCNAME"
    version=$1
    juno-svn-check-branches-name $version
    return $?
}

function junoenv-sniper-url {
    local msg="==== $FUNCNAME: "
    local version=${1:-trunk}
    local branchesname=$(junoenv-sniper-version $version)
    svnurl=$(juno-svn-top)/$(junoenv-sniper-name)/${branchesname}
    juno-svn-check-repo-url $svnurl
    return $?
}

function junoenv-sniper-revision-gen {
    juno-svn-revision-gen $*
}

function junoenv-sniper-checkout {
    # checkout all code
    local msg="==== $FUNCNAME: "
    local svnurl=$1
    local dstname=$2
    local revision=$3
    echo $msg checkout the code $svnurl 
    # check
    local flag=$(junoenv-sniper-revision-gen $revision)
    echo $msg svn co $flag $svnurl $dstname 
    svn co $flag $svnurl $dstname 
}

function junoenv-sniper-check-preq {
    local msg="==== $FUNCNAME: "
    echo $msg Pre Requirement Check
    source $JUNOENVDIR/junoenv-env.sh
    local bashrcabspath=$(juno-top-dir)/$(junoenv-env-bashrc-name)
    if [ -f "$bashrcabspath" ]; then
        echo $msg source $bashrcabspath
        source $bashrcabspath
    else
        echo $msg Please using "junoenv env" to setup the environment first
        exit 1
    fi
}
function junoenv-sniper-compile {
    local msg="==== $FUNCNAME: "
    pushd $(juno-top-dir) >& /dev/null
    if [ -d "$(junoenv-sniper-name)" ]; then
        pushd $(junoenv-sniper-name)/SniperRelease/cmt >& /dev/null
        cmt br cmt config
        source setup.sh
        cmt br cmt make
        popd >& /dev/null
    else
        echo $msg $(junoenv-sniper-name) does not exist.
        echo $msg It seems the checkout failed.
    fi
    popd >& /dev/null
}

function junoenv-sniper {
    local msg="=== $FUNCNAME: "
    # the main handler in this script
    local branchname=${1:-trunk}
    local revision=${2:-}
    # check version
    junoenv-sniper-version $branchname
    if [ "$?" != "0" ]; then
        echo $msg branchesname ret: $?
        return 1
    fi


    local url=$(junoenv-sniper-url $branchname) 
    echo $msg $?
    echo $msg URL: $url
    # change directory to $JUNOTOP
    pushd $(juno-top-dir) >& /dev/null
    junoenv-sniper-checkout $url $(junoenv-sniper-name) $revision
    junoenv-sniper-check-preq
    junoenv-sniper-compile
    popd >& /dev/null

}

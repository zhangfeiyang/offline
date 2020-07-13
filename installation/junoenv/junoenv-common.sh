#!/bin/bash

function juno-top-dir {
    echo $JUNOTOP
}

function juno-svn-top {
    echo http://juno.ihep.ac.cn/svn
}

function juno-svn-check-branches-name {
    local msg="==== $FUNCNAME"
    version=$1
    case $version in
        trunk)
            echo $version
            return 0
            ;;
        tags/*)
            echo $version
            return 0
            ;;
        branches/*)
            echo $version
            return 0
            ;;
        *)
            echo $msg unknown version $version
            return 1
            ;;
    esac

}

function juno-svn-check-repo-url {
    local msg="==== $FUNCNAME: "
    svnurl=$1
    svn ls $svnurl >& /dev/null
    if [ "$?" = "0" ]; then
        echo $svnurl
        return 0
    else
        echo $msg $svnurl does not exist
        return 1
    fi

}

function juno-svn-revision-gen {
    local revision=$1
    if [ -z "$revision" ]; then
        echo 
    else
        echo '-r' $revision
    fi
}

# Archive Related
# Not only External Libs need, but also:
# * sniper
# * cmtlibs
# * offline

function juno-archive-check {
    # check if we should use archive mode
    # 0: don't use
    # 1: use
    local url=$(juno-archive-url)
    if [ -z "$url" ]; then
        echo 0
    else
        echo 1
    fi
}
function juno-archive-url {
    local url=${JUNOARCHIVEURL:-}
    echo $url
}

# different get methods.
# the interface will be same:
# get $src $dst
function juno-archive-get-via-ln {
    local msg="=== $FUNCNAME"
    local src=$1
    local dst=$2

    echo $msg ln -s $src $dst
    ln -s $src $dst
}

function juno-archive-get-via-cp {
    local msg="=== $FUNCNAME"
    local src=$1
    local dst=$2

    echo $msg cp $src $dst
    cp $src $dst
}

function juno-archive-get-via-scp {
    local msg="=== $FUNCNAME"
    local src=$1
    local dst=$2

    echo $msg scp $src $dst
    scp $src $dst
}

function juno-archive-get-via-wget {
    local msg="=== $FUNCNAME"
    local src=$1
    local dst=$2

    echo $msg scp $src $dst
    wget $src -O $dst
}

function juno-archive-get-method {
    # check use:
    # * ln -s
    # * cp
    # * scp
    # * wget
    # * curl
    local method=${JUNOARCHIVEGET:-scp}
    local url=$(juno-archive-url)
    # TODO magic HERE
    # change the method via url
    case $method in
        ln) ;;
        cp|scp) ;;
        wget) ;;
        *) method="scp" ;;
    esac

    echo juno-archive-get-via-$method
}

function juno-archive-get {
    local msg="== $FUNCNAME"
    local src=$1
    local dst=$2

    local srcfull="$src"
    if [ "$(juno-archive-check)" == "1" ]; then
        srcfull=$(juno-archive-url)/$srcfull
    fi

    echo $msg $(juno-archive-get-method) $srcfull $2
    $(juno-archive-get-method) $srcfull $2
    local rc=$?
    return $rc
}

# = detect the Linux Distro =
# Ref:
# * shtool, platform
# * devstack, functions-common
function juno-distro-detect-linux {
    local msg="=== $FUNCNAME"

    # * use lsb_release to detect
    if [[ -x $(which lsb_release 2>/dev/null) ]]; then
        # + 
        local os_vendor=$(lsb_release -i -s)

        case $os_vendor in
            "openSUSE project")
                echo opensuse
                ;;
            "SUSE LINUX")
                echo opensuse
                ;;
            Debian)
                echo debian
                ;;
            Ubuntu)
                echo ubuntu
                ;;
            Fedora)
                echo fedora
                ;;
            CentOS)
                echo centos
                ;;
            Scientific)
                echo sl
                ;;
            Scientific*)
                echo sl
                ;;
            *)
                echo unknown
                ;;
        esac
    # * use /etc/*release to detect
    elif [[ -r /etc/redhat-release ]]; then
        # +
        echo 
    elif [[ -r /etc/SuSE-release ]]; then
        # +
        grep openSUSE /etc/SuSE-release >/dev/null 2>&1
        if [ "$?" == "0" ]; then
            echo opensuse
        else
            echo "suselinux"
        fi
    fi
}

function juno-distro-detect {
    local msg="== $FUNCNAME"
    local uname_system=$(uname -s)

    case $uname_system in
        Linux)
            juno-distro-detect-linux
            ;;
        *)
            echo unknown
    esac
}

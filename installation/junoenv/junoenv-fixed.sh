# = helper =
function junoenv-fixed-dst-detect () {
    local dst=${1:-}
    if [ -n "$dst" ]; then
        echo $dst
        return
    fi
    # assume the parent directory of junoenv is the JUNOTOP
    local dirjunoenv=$JUNOENVDIR
    local dirjunotop=$(dirname $JUNOENVDIR)
    echo $dirjunotop
}

function junoenv-fixed-src-detect () {
    local msg="==== $FUNCNAME: "
    local src=${1:-}
    if [ -n "$src" ]; then
        echo $src
        return
    fi
    # assume the parent directory of junoenv is the JUNOTOP
    local dirjunoenv=$JUNOENVDIR
    local dirjunotop=$(dirname $JUNOENVDIR)
    # get the JUNOTOP from the old setup script
    local bashrcsh=$dirjunotop/bashrc.sh
    if [ -f "$bashrcsh" ]; then
        local result=$(grep JUNOTOP $bashrcsh)
        if [ "$?" == 0 -a -n "$result" ] ; then
            echo $result | cut -d '=' -f 2
            return 0
        fi
    fi
    echo $msg Can not detect the original JUNOTOP 1>&2
    exit 1
}

function junoenv-fixed-check-dst-src () {
    local msg="==== $FUNCNAME: "
    local dst=$1
    local src=$2
    # if the src and dst are same, don't do any thing.
    if [ "$src" == "$dst" ]; then
        return 1
    fi
    return 0
}

# = Replace the directories =
function junoenv-fiexed-shell-script-replace () {
    local script=$1
    local dst=$2
    local src=$3
    sed -i 's;'$src';'$dst';' $script
}

function junoenv-fiexed-list-all-script() {
    # find the common script first, .sh or .csh
    find . -name \*sh
    find . -name bashrc
    find . -name tcshrc
    # fix root
    find . -name \*rc -type f
    find . -name root-config
    find . -name \*.h
}

function junoenv-fixed-replace-all() {
    local dst=$1
    local src=$2
    pushd $(juno-top-dir)
    local script=""
    for script in $(junoenv-fiexed-list-all-script)
    do
        junoenv-fiexed-shell-script-replace $script $dst $src
    done
    popd
}

# = main =
function junoenv-fixed () {
    local msg="=== $FUNCNAME: "
    # chang the directory name in setup script.
    local dst=$(junoenv-fixed-dst-detect $1)
    local src=$(junoenv-fixed-src-detect $2)

    echo $msg SRC: $src 1>&2
    echo $msg DST: $dst 1>&2
    junoenv-fixed-check-dst-src $dst $src
    local st=$?
    if [ "$st" == "1" ]; then
        echo $msg src and dst are the same one, skip fixed. 1>&2
        return 0
    fi

    junoenv-fixed-replace-all $dst $src
}

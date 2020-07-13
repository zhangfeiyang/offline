# = deploy the different modules =
# == general helper to deploy the compressed data ==
function junoenv-deploy-XXX {
    local msg="==== $FUNCNAME: "
    local mod=$1
    local mod_tarname=""
    local mod_dirname=""
    # - check -
    # -- check tar name --
    if type -t junoenv-archive-$mod-tarname >& /dev/null; then
        mod_tarname=$(junoenv-archive-$mod-tarname)
    else
        echo $msg junoenv-archive-$mod-tarname not exist 1>&2
        exit 1
    fi
    # -- check dir name --
    if type -t junoenv-archive-$mod-dirname >& /dev/null; then
        mod_dirname=$(junoenv-archive-$mod-dirname)
    else
        echo $msg junoenv-archive-$mod-tarname not exist 1>&2
        exit 1
    fi
    # - begin -
    pushd $(juno-top-dir) >& /dev/null
    # -- check the existence of the tarballs --
    if [ ! -f "$mod_tarname" ]; then
        echo $msg $mod_tarname does not exist 1>&2
        exit 1
    fi
    # -- TODO checksum --
    # -- check the directory or file already exists or not --
    local m="" # the $mod_dirname may be a list of files or dirs
    local exists=true
    for m in $mod_dirname
    do
        if [ -e "$m" ]; then
            continue;
        else
            exists=false;
        fi
    done
    if  $exists = true ; then
        echo $msg $mod_dirname already exists, skip deploy 1>&2
    else 
        # -- finally, deploy the tarball --
        echo $msg begin: deploy $mod_dirname 1>&2
        tar zxvf $mod_tarname
        echo $msg end:   deploy $mod_dirname 1>&2
    fi
    popd >& /dev/null
}
# == libs ==
function junoenv-deploy-libs {
    local msg="=== $FUNCNAME: "
    junoenv-deploy-XXX libs
}
# == libs build ==
function junoenv-deploy-libsbuild {
    local msg="=== $FUNCNAME: "
    junoenv-deploy-XXX libsbuild
}
# == cmtlibs ==
function junoenv-deploy-cmtlibs {
    local msg="=== $FUNCNAME: "
    junoenv-deploy-XXX cmtlibs
}
# == sniper ==
function junoenv-deploy-sniper {
    local msg="=== $FUNCNAME: "
    junoenv-deploy-XXX sniper
}
# == offline ==
function junoenv-deploy-offline {
    local msg="=== $FUNCNAME: "
    junoenv-deploy-XXX offline
}
# == setup ==
function junoenv-deploy-setup {
    local msg="=== $FUNCNAME: "
    junoenv-deploy-XXX setup
}
# == all ==
function junoenv-deploy-all {
    local msg="=== $FUNCNAME: "
    local mods="libs cmtlibs sniper offline setup"
    local module=""

    for module in $mods
    do
        junoenv-deploy-$module
    done
}

# = main =
function junoenv-deploy {
    local msg="== $FUNCNAME: "
    local mods=$@
    if [ -z "$mods" ];
    then
        mods=all
    fi
    local module=""
    for module in $mods 
    do
        case $module in
            all)
                junoenv-deploy-all
                ;;
            setup)
                junoenv-deploy-setup
                ;;
            libs|cmtlibs|libsbuild)
                junoenv-deploy-$module
                ;;
            sniper)
                junoenv-deploy-sniper
                ;;
            offline)
                junoenv-deploy-offline
                ;;
        esac
    done
}

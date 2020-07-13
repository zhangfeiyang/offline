function junoenv-archive-doc {
cat << DOC
The archive mode is used to create archives from our juno offline software.

Supported modules to archive:
 * all (including libs, cmtlibs, sniper, offline), default module.
 * libs: Compiled external libraries
 * cmtlibs: External Interface
 * sniper: Sniper
 * offline: Offline Software
 * libsbuild: include compiled libraries and 
              the Source code and object files to build the external libraries.

After we already have the tar.gz file, we can deploy the environment again.
Ref: 
 * https://www.kernel.org/pub/software/scm/git/docs/git-archive.html
DOC
}
# = destination =
function junoenv-archive-dest {
    echo $(juno-top-dir)
}
# = archive different modules =
# == PKG named XXX, general function ==
function junoenv-archive-XXX {
    local msg="==== $FUNCNAME: "
    local mod=$1
    local mod_tarname=""
    local mod_dirname=""
    local str_exclude=""
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
    # -- exclude dir --
    if type -t junoenv-archive-$mod-exclude >& /dev/null; then
        local excludedir;
        for excludedir in $(junoenv-archive-$mod-exclude)
        do
            str_exclude="$str_exclude --exclude=$excludedir"
        done
    fi
    # - begin -
    pushd $(juno-top-dir) >& /dev/null
    if [ -f "$mod_tarname" ]; then
        echo $msg $mod_tarname already exists, skip create a new one. 1>&2
    else
        tar -zcvf $mod_tarname $mod_dirname $str_exclude
    fi
    # - checksum -
    local csmethod=""
    for csmethod in sha256 md5 
    do
        junoenv-archive-checksum-$csmethod $mod_tarname
    done
    popd >& /dev/null
}
# === helper: calculate the md5 or sha256 ===
function junoenv-archive-checksum-XXX {
    local msg="==== $FUNCNAME: "
    local method=${1:-md5}
    shift;
    local filename=${1:-}
    if [ -z "$filename" ]; then
        echo $msg Please input a filename to calculate $method 1>&2
        exit 1
    fi
    if [ ! -f "$filename" ]; then
        echo $msg Make sure $filename exists 1>&2
        exit 1
    fi
    local filewithchecksum=${filename}.${method}
    if [ -f $filewithchecksum ]; then
        echo $msg $filewithchecksum already exists, skip calculate 1>&2
        return 0
    fi
    local checksumexe=""
    if type -t junoenv-archive-checksum-$method-exe >& /dev/null; then
        checksumexe=$(junoenv-archive-checksum-$method-exe)
    else
        echo $msg junoenv-archive-checksum-$method-exe not exist 1>&2
        exit 1
    fi

    $checksumexe $filename > $filewithchecksum
}
# ==== sha256 ====
function junoenv-archive-checksum-sha256-exe {
    echo sha256sum
}
function junoenv-archive-checksum-sha256 {
    local filename=${1:-}
    junoenv-archive-checksum-XXX sha256 $filename
}
# ==== md5 ====
function junoenv-archive-checksum-md5-exe {
    echo md5sum
}
function junoenv-archive-checksum-md5 {
    local filename=${1:-}
    junoenv-archive-checksum-XXX md5 $filename
}
# == libs ==
function junoenv-archive-libs-tarname {
    echo libs.tar.gz
}
function junoenv-archive-libs-dirname {
    echo ExternalLibs
}
function junoenv-archive-libs-exclude {
    echo ExternalLibs/Build
}
function junoenv-archive-libs {
    local msg="==== $FUNCNAME: "
    junoenv-archive-XXX libs
}
# == libs build ==
function junoenv-archive-libsbuild-tarname {
    echo libsbuild.tar.gz
}
function junoenv-archive-libsbuild-dirname {
    echo ExternalLibs
}
function junoenv-archive-libsbuild-exclude {
    echo 
}
function junoenv-archive-libsbuild {
    local msg="==== $FUNCNAME: "
    junoenv-archive-XXX libsbuild
}
# == cmtlibs ==
function junoenv-archive-cmtlibs-tarname {
    echo cmtlibs.tar.gz
}
function junoenv-archive-cmtlibs-dirname {
    echo ExternalInterface
}
function junoenv-archive-cmtlibs-exclude {
    echo 
}
function junoenv-archive-cmtlibs {
    local msg="==== $FUNCNAME: "
    junoenv-archive-XXX cmtlibs
}
# == sniper ==
function junoenv-archive-sniper-tarname {
    echo sniper.tar.gz
}
function junoenv-archive-sniper-dirname {
    echo sniper
}
function junoenv-archive-sniper-exclude {
    echo 
}
function junoenv-archive-sniper {
    local msg="==== $FUNCNAME: "
    junoenv-archive-XXX sniper
}
# == offline ==
function junoenv-archive-offline-tarname {
    echo offline.tar.gz
}
function junoenv-archive-offline-dirname {
    echo offline
}
function junoenv-archive-offline-exclude {
    echo 
}
function junoenv-archive-offline {
    local msg="==== $FUNCNAME: "
    junoenv-archive-XXX offline
}
# == setup ==
function junoenv-archive-setup-tarname {
    echo setup.tar.gz
}
function junoenv-archive-setup-dirname {
    echo setup.sh setup.csh bashrc.sh tcshrc.csh
}
function junoenv-archive-setup-exclude {
    echo 
}
function junoenv-archive-setup {
    local msg="==== $FUNCNAME: "
    junoenv-archive-XXX setup
}
# == all ==
function junoenv-archive-all {
    local msg="=== $FUNCNAME: "
    local mods="libs cmtlibs sniper offline setup"
    local module=""

    for module in $mods
    do
        junoenv-archive-$module
    done
}
# = main =
function junoenv-archive {
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
                junoenv-archive-all
                ;;
            setup)
                junoenv-archive-setup
                ;;
            libs|cmtlibs|libsbuild)
                junoenv-archive-$module
                ;;
            sniper)
                junoenv-archive-sniper
                ;;
            offline)
                junoenv-archive-offline
                ;;
        esac
    done
}

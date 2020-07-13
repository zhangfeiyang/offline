#!/bin/bash

VALID_SUB_COMMAND="all get conf make install setup reuse"

function juno-ext-libs-gen-cpu-num {
    local cpus=$(grep -c ^processor /proc/cpuinfo)
    case cpus in
        1)
            echo ""
            ;;
        *)
            echo -j${cpus}
            ;;
    esac
}

function juno-ext-libs-check-sub-command {
    local msg="==== $FUNCNAME: "
    cmd=$1
    case $cmd in
        smart-install)
            return 0
            ;;
        all)
            return 0
            ;;
        get)
            return 0
            ;;
        conf)
            return 0
            ;;
        make)
            return 0
            ;;
        install)
            return 0
            ;;
        setup)
            return 0
            ;;
        reuse)
            return 0
            ;;
        list)
            return 0
            ;;
        *)
            if [ -n "$cmd" ]; then
                echo 1>&2 $msg unknown sub command $cmd
            fi
            # show the help
            1>&2 cat << EOF
Available sub commands:
* all
* get
* conf
* make
* install
* setup
* reuse
* list
EOF
            return 1
            ;;
    esac

}

function juno-ext-libs-generate-sh {
local pkg=$1
local install=$2
local lib=${3:-lib}
local install_wo_top=$(perl -e 'use File::Spec; print File::Spec->abs2rel(@ARGV) . "\n"' $install $JUNOTOP)

# avoid '-' in $pkg
pkg=${pkg//-/_}

cat << EOF > bashrc
if [ -z "\${JUNOTOP}" ]; then
export JUNO_EXTLIB_${pkg}_HOME=${install}
else
export JUNO_EXTLIB_${pkg}_HOME=\${JUNOTOP}/${install_wo_top}
fi

export PATH=\${JUNO_EXTLIB_${pkg}_HOME}/bin:\${PATH}
EOF

    # check the lib or lib64
    for lib in lib lib64
    do
cat << EOF >> bashrc
if [ -d \${JUNO_EXTLIB_${pkg}_HOME}/${lib} ];
then
export LD_LIBRARY_PATH=\${JUNO_EXTLIB_${pkg}_HOME}/${lib}:\${LD_LIBRARY_PATH}
fi
if [ -d \${JUNO_EXTLIB_${pkg}_HOME}/${lib}/pkgconfig ];
then
export PKG_CONFIG_PATH=\${JUNO_EXTLIB_${pkg}_HOME}/${lib}/pkgconfig:\${PKG_CONFIG_PATH}
fi
EOF
    done

cat << EOF >> bashrc
export CPATH=\${JUNO_EXTLIB_${pkg}_HOME}/include:\${CPATH}
export MANPATH=\${JUNO_EXTLIB_${pkg}_HOME}/share/man:\${MANPATH}
EOF
    # user defined generate
    type -t juno-ext-libs-${curpkg}-generate-sh >& /dev/null
    if [ "$?" = 0 ]; then
        echo $msg call juno-ext-libs-${curpkg}-generate-sh to generate user defined 
        juno-ext-libs-${curpkg}-generate-sh $@
    fi
}

function juno-ext-libs-generate-csh {
    local msg="==== $FUNCNAME: "
local pkg=$1
local install=$2
local lib=${3:-lib}

# avoid '-' in $pkg
pkg=${pkg//-/_}

local install_wo_top=$(perl -e 'use File::Spec; print File::Spec->abs2rel(@ARGV) . "\n"' $install $JUNOTOP)
cat << EOF > tcshrc
if ( \$?PATH == 0 ) then
    setenv PATH ""
endif
if ( \$?LD_LIBRARY_PATH == 0 ) then
    setenv LD_LIBRARY_PATH ""
endif
if ( \$?PKG_CONFIG_PATH == 0 ) then
    setenv PKG_CONFIG_PATH ""
endif
if ( \$?CPATH == 0 ) then
    setenv CPATH ""
endif
if ( \$?MANPATH == 0 ) then
    setenv MANPATH ""
endif
if ( \$?JUNOTOP == 0 ) then
setenv JUNO_EXTLIB_${pkg}_HOME ${install}
else
setenv JUNO_EXTLIB_${pkg}_HOME \${JUNOTOP}/${install_wo_top}
endif

setenv PATH \${JUNO_EXTLIB_${pkg}_HOME}/bin:\${PATH}
EOF

    # check the lib or lib64
    for lib in lib lib64
    do
cat << EOF >> tcshrc
if ( -d \${JUNO_EXTLIB_${pkg}_HOME}/${lib}) then
setenv LD_LIBRARY_PATH \${JUNO_EXTLIB_${pkg}_HOME}/${lib}:\${LD_LIBRARY_PATH}
endif
if ( -d \${JUNO_EXTLIB_${pkg}_HOME}/${lib}/pkgconfig) then
setenv PKG_CONFIG_PATH \${JUNO_EXTLIB_${pkg}_HOME}/${lib}/pkgconfig:\${PKG_CONFIG_PATH}
endif
EOF
cat << EOF >> tcshrc
setenv CPATH \${JUNO_EXTLIB_${pkg}_HOME}/include:\${CPATH}
setenv MANPATH \${JUNO_EXTLIB_${pkg}_HOME}/share/man:\${MANPATH}
EOF
    done

    # user defined generate
    type -t juno-ext-libs-${curpkg}-generate-csh >& /dev/null
    if [ "$?" = 0 ]; then
        echo $msg call juno-ext-libs-${curpkg}-generate-csh to generate user defined 
        juno-ext-libs-${curpkg}-generate-csh $@
    fi

}

function juno-ext-libs-check-init {
    local msg="==== $FUNCNAME: "
    # check the bootstrap script of pkg 
    local pkg=$1
    if [ -f "$(juno-ext-libs-init-scripts-dir)/$pkg.sh" ]; then
        source $(juno-ext-libs-init-scripts-dir)/$pkg.sh 
        # if it is *list mode*, don't need to really setup
        is_list_mode && return 0
        # setup the dependencies
        type -t juno-ext-libs-${pkg}-dependencies-setup >& /dev/null
        if [ "$?" = "0" ]; then
            echo $msg setup dependencies for $pkg
            juno-ext-libs-${pkg}-dependencies-setup
        else
            echo $msg no dependencies for $pkg
        fi
        return 0
    else
        echo $msg $(juno-ext-libs-init-scripts-dir)/$pkg.sh does not exist 1>&2 
        echo $msg If you want to install $pkg, please add the bootstrap script first. 1>&2
        return 1
    fi
}

function juno-ext-libs-check-is-reused {
    local msg="==== $FUNCNAME: "
    # just check the install prefix is a soft link or not
    local pkg=$1
    local newpath=$(juno-ext-libs-${pkg}-install-dir)
    if [[ -L "$newpath" && -d "$newpath" ]];
    then
        echo $msg The installation prefix for $pkg: \"$newpath\" is a soft link. 1>&2
        echo $msg It can be a reused library. 1>&2
        return 1
    else
        return 0
    fi
}

# create a function to override the default version
function juno-ext-libs-create-PKG-version {
    local msg="==== $FUNCNAME: "
    local pkg=$1
    local ver=$2
    # make sure $ver is not null
    if [ -z "$ver" ]; then
        echo $msg $pkg version is null. 1>&2
        echo $msg will not create juno-ext-libs-${pkg}-version- 1>&2
        return 1
    fi
    # create function
    eval "juno-ext-libs-${pkg}-version-(){ echo "$ver";}"

    echo $msg Create Function juno-ext-libs-${pkg}-version-
    echo $msg Call juno-ext-libs-${pkg}-version-: $(juno-ext-libs-${pkg}-version-)
}

function juno-ext-libs-PKG-version {
    local curpkg=$1
    # check override
    type -t juno-ext-libs-${curpkg}-version- >& /dev/null
    if [ "$?" = "0" ]; then
        # user defined 
        echo $(juno-ext-libs-${curpkg}-version-)
    else
        echo $(juno-ext-libs-${curpkg}-version-default)
    fi
}

function juno-ext-libs-file-check-exist {
    # if exists, return 0
    # else, return 1
    fn="$1"
    if [ -f "$fn" ]; then
        return 0
    else
        return 1
    fi
}

function juno-ext-libs-init-scripts-dir {
    echo "$JUNOENVDIR/packages"
}

function juno-ext-libs-install-root {
    echo "$JUNOTOP/ExternalLibs"
}

function juno-ext-libs-install-root-check {
    local msg="==== $FUNCNAME: "
    if [ ! -d "$(juno-ext-libs-install-root)" ]; then
        mkdir -p $(juno-ext-libs-install-root)
    fi
    if [ -d "$(juno-ext-libs-install-root)" ]; then
        return 0
    else
        echo $msg Create $(juno-ext-libs-install-root) Failed.
        return 1
    fi
}

function juno-ext-libs-build-root {
    echo "$JUNOTOP/ExternalLibs/Build"
}

function juno-ext-libs-build-root-check {
    local msg="==== $FUNCNAME: "
    if [ ! -d "$(juno-ext-libs-build-root)" ]; then
        mkdir -p $(juno-ext-libs-build-root)
    fi
    if [ -d "$(juno-ext-libs-build-root)" ]; then
        return 0
    else
        echo $msg Create $(juno-ext-libs-build-root) Failed.
        return 1
    fi
}

# dependencies setup (common structure)
#############################################################################
# new implementation using recursive 
#############################################################################
function juno-ext-libs-dependencies-setup-setup-one-package-init() {
    # this is used to load the dependencies list
    local deppkg=$1; shift;
    local depver=$1; shift;

    # create log directory for pkg
    if [ ! -d "$(juno-ext-libs-log-dir $deppkg)" ]; then
        echo $msg create log directory $(juno-ext-libs-log-dir $deppkg)
        mkdir -p $(juno-ext-libs-log-dir $deppkg)
        # check again
        [ ! -d "$(juno-ext-libs-log-dir $deppkg)" ] && exit -1
    fi

    # create version function
    echo $msg create function juno-ext-libs-${deppkg}-version- to override default
    if [ -n "$depver" ]; then
        juno-ext-libs-create-PKG-version $deppkg $depver
    fi 
    # init script
    # only after setup the init script, we can get the list of the dependencies.
    if [ -f "$(juno-ext-libs-init-scripts-dir)/${deppkg}.sh" ]; then
        echo $msg source $(juno-ext-libs-init-scripts-dir)/${deppkg}.sh
        source $(juno-ext-libs-init-scripts-dir)/${deppkg}.sh
        echo $msg After source: ${deppkg} ${depver}
    else
        echo $msg can not find $deppkg.sh 1>&2
        exit 1
    fi
}
function juno-ext-libs-dependencies-setup-setup-one-package-runtime-env() {
    # this is only called after the dependencies are source
    local optional=${1:-0}; shift
    local deppkg=$1; shift
    local depver=$1; shift
    # setup script
    if [ -f "$(juno-ext-libs-${deppkg}-install-dir)/bashrc" ]; then
        echo $msg source $(juno-ext-libs-${deppkg}-install-dir)/bashrc
        source $(juno-ext-libs-${deppkg}-install-dir)/bashrc
    elif [ "$optional" == "1" ]; then
        echo $msg $deppkg is not installed by junoenv, but it is optional.
        echo $msg SKIP setup $deppkg
    else
        # check smart mode
        juno-ext-libs-smart-install-mode || {
            # not smart mode, so just exit the whole program
            echo $msg can not find $(juno-ext-libs-${deppkg}-install-dir)/bashrc 1>&2
            echo $msg Please install $deppkg first. 1>&2
            exit 1
        }
        juno-ext-libs-smart-install $deppkg $depver
    fi
}
function juno-ext-libs-dependencies-setup-rec-impl {
    local _level=$1; shift
    local curpkg=$1; shift # this is the pkg to be intalled.
    local skipfn=$1;
    # remove the optional 
    local deppkgverarr=($(echo $curpkg | tr "@" "\n"))
    local deppkg=${deppkgverarr[0]}
    local depver=${deppkgverarr[1]}
    local optional=0
    case $deppkg in
        +*)
            optional=1
            deppkg=${deppkg:1}
            ;;
    esac
    local msg="==== $FUNCNAME: ${_level} setup $deppkg:"
    # check whether the package is setup already or not.
    # if the package is already setup, skip it
    # XXX: if the package is the current package (flag=skip), we need to skip this flag,
    #      else it will don't setup later.
    if [ -z "$skipfn" ]; then
        if type -t juno-ext-libs-${deppkg}-status-already-setup >& /dev/null; then
            echo $msg $deppkg already setup 1>&2
            return;
        else
            # create this function
            eval "juno-ext-libs-${deppkg}-status-already-setup(){ echo "1";}"
        fi
    fi
    # load the dependencies function
    juno-ext-libs-dependencies-setup-setup-one-package-init $deppkg $depver
    # handle all dependencies
    local deppkgver
    if type -t juno-ext-libs-${deppkg}-dependencies-list >& /dev/null ; then
        for deppkgver in $(juno-ext-libs-${deppkg}-dependencies-list)
        do
            juno-ext-libs-dependencies-setup-rec-impl "${_level}#" $deppkgver
        done
    fi
    # setup the runtime env
    # but if $skipfn is true, skip the following function
    if [ -z "$skipfn" ]; then
        echo $msg status: $optional $deppkg $depver 
        juno-ext-libs-dependencies-setup-setup-one-package-runtime-env $optional $deppkg $depver 
    fi
}
function juno-ext-libs-dependencies-setup {
    local curpkg=$1 # this is the pkg to be intalled.
    local _level="#"
    juno-ext-libs-dependencies-setup-rec-impl ${_level} $curpkg skip
}
#############################################################################
function juno-ext-libs-dependencies-setup-old {
    local curpkg=$1 # this is the pkg to be intalled.
    local msg="==== $FUNCNAME: setup $curpkg:"
    local deppkgver=""
    echo $msg Dependencies: $(juno-ext-libs-${curpkg}-dependencies-list)

    for deppkgver in $(juno-ext-libs-${curpkg}-dependencies-list)
    do
        echo $msg Handle Dependency: $deppkgver
        local deppkgverarr=($(echo $deppkgver | tr "@" "\n"))
        local deppkg=${deppkgverarr[0]}
        local depver=${deppkgverarr[1]}

        local optional=0
        # if start with '+', it means optional
        case $deppkg in
            +*)
                optional=1
                deppkg=${deppkg:1}
                ;;
        esac
        # create version function
        echo $msg create function juno-ext-libs-${deppkg}-version- to override default
        if [ -n "$depver" ]; then
            juno-ext-libs-create-PKG-version $deppkg $depver
        fi 
        # init script
        if [ -f "$(juno-ext-libs-init-scripts-dir)/${deppkg}.sh" ]; then
            echo $msg source $(juno-ext-libs-init-scripts-dir)/${deppkg}.sh
            source $(juno-ext-libs-init-scripts-dir)/${deppkg}.sh
            echo $msg After source: ${deppkg} ${depver}
        else
            echo $msg can not find $deppkg.sh
            exit 1
        fi
        # setup script
        if [ -f "$(juno-ext-libs-${deppkg}-install-dir)/bashrc" ]; then
            echo $msg source $(juno-ext-libs-${deppkg}-install-dir)/bashrc
            source $(juno-ext-libs-${deppkg}-install-dir)/bashrc
        elif [ "$optional" == "1" ]; then
            echo $msg $deppkg is not installed by junoenv, but it is optional.
            echo $msg SKIP setup $deppkg
        else
            echo $msg can not find $(juno-ext-libs-${deppkg}-install-dir)/bashrc
            echo $msg Please install $deppkg first.
            exit 1
        fi
    done
}
#############################################################################

# helper for get
function juno-ext-libs-PKG-get {
    local curpkg=$1 # this is the pkg to be intalled.
    shift
    local msg="===== $FUNCNAME: "
    local version=${1:-$(juno-ext-libs-${curpkg}-version)}
    local downloadurl=$(juno-ext-libs-${curpkg}-download-url $version)

    juno-ext-libs-build-root-check || exit $?
    pushd $(juno-ext-libs-build-root) >& /dev/null
        tarname=$(juno-ext-libs-${curpkg}-download-filename)
        juno-ext-libs-${curpkg}-file-check-exist $tarname 
        # already exists
        if [ "$?" = "0" ]; then
            echo $msg SKIP DOWNLOADING: $tarname already exists
        else
            echo $msg Download
            # TODO
            # a common tool to download
            if [ "$(juno-archive-check)" == "0" ]; then 
                wget -O $tarname $downloadurl || exit $?
            else
                juno-archive-get $tarname $tarname || exit $?
            fi
        fi
    popd >& /dev/null
}

# helper for conf
function juno-ext-libs-PKG-conf-uncompress() {
    local msg="===== $FUNCNAME: "
    local tardst=$1
    local tarname=$2

    case $tarname in
        *.tar.gz|*.tgz)
            echo $msg tar zxvf $tarname 
            tar zxvf $tarname || exit $?
            ;;
        *.zip)
            echo $msg unzip $tarname 
            unzip $tarname || exit $?
            ;;
        *.tar.bz2)
            echo $msg tar jxvf $tarname 
            tar jxvf $tarname || exit $?
            ;;
        *)
            echo $msg Can not uncompress the file $tarname 1>&2
            exit 1
            ;;
    esac

    if [ ! -d "$tardst" ]; then
        echo $msg "After Uncompress, can't find $tardst"
        exit 1
    fi
}
function juno-ext-libs-PKG-conf {
    local curpkg=$1 # this is the pkg to be intalled.
    shift
    local msg="===== $FUNCNAME: "
    juno-ext-libs-build-root-check || exit $?
    pushd $(juno-ext-libs-build-root) >& /dev/null

    local tarname=$(juno-ext-libs-${curpkg}-download-filename)
    juno-ext-libs-${curpkg}-file-check-exist $tarname
    # does not exist, so download
    if [ "$?" != "0" ]; then
        juno-ext-libs-${curpkg}-get
    fi
    # check again, if still not exist, exit
    juno-ext-libs-${curpkg}-file-check-exist $tarname || exit $?
    # unzip the file if the directory does not exist
    tardst=$(juno-ext-libs-${curpkg}-tardst)
    if [ ! -d "$tardst" ]; then
        echo $msg Uncompress the $tarname
        if type -t juno-ext-libs-${curpkg}-conf-uncompress >& /dev/null;
        then
            juno-ext-libs-${curpkg}-conf-uncompress $tardst $tarname
        else
            juno-ext-libs-PKG-conf-uncompress $tardst $tarname
        fi
    fi
    pushd $tardst >& /dev/null
    
    if [ ! -d "$(juno-ext-libs-${curpkg}-install-dir)" ]; then
        mkdir -p $(juno-ext-libs-${curpkg}-install-dir)
    fi

    juno-ext-libs-${curpkg}-conf- 

    popd >& /dev/null
    popd >& /dev/null

}

# helper for make
function juno-ext-libs-PKG-make {
    local curpkg=$1 # this is the pkg to be intalled.
    shift
    local msg="===== $FUNCNAME: "
    juno-ext-libs-build-root-check || exit $?
    pushd $(juno-ext-libs-build-root) >& /dev/null

    local tardst=$(juno-ext-libs-${curpkg}-tardst)
    pushd $tardst >& /dev/null
    if [ "$?" != "0" ]; then
        echo $msg Please configure the package first.
        exit 1
    fi

    # check the function exist
    type -t juno-ext-libs-${curpkg}-make- >& /dev/null
    if [ "$?" = "0" ]; then
        echo $msg call juno-ext-libs-${curpkg}-make-
        juno-ext-libs-${curpkg}-make-
    else
        echo $msg call default 
        echo $msg make $(juno-ext-libs-gen-cpu-num)
        make $(juno-ext-libs-gen-cpu-num) || exit $?
    fi

    popd >& /dev/null
    popd >& /dev/null
}

# helper for install
function juno-ext-libs-PKG-install {
    local curpkg=$1 # this is the pkg to be intalled.
    shift
    local msg="===== $FUNCNAME: "
    juno-ext-libs-build-root-check || exit $?
    pushd $(juno-ext-libs-build-root) >& /dev/null
    
    local tardst=$(juno-ext-libs-${curpkg}-tardst)
    pushd $tardst >& /dev/null
    if [ "$?" != "0" ]; then
        echo $msg Please configure the package first.
        exit 1
    fi

    # check the function exist
    type -t juno-ext-libs-${curpkg}-install- >& /dev/null
    if [ "$?" = "0" ]; then
        echo $msg call juno-ext-libs-${curpkg}-install-
        juno-ext-libs-${curpkg}-install-
    else
        echo $msg call default 
        echo $msg make install
        make install || exit $?
    fi
    
    popd >& /dev/null
    popd >& /dev/null

}


# helper for setup
function juno-ext-libs-PKG-setup {
    local curpkg=$1 # this is the pkg to be intalled.
    shift
    local msg="===== $FUNCNAME: "
    juno-ext-libs-install-root-check || exit $?
    pushd $(juno-ext-libs-install-root) >& /dev/null

    if [ ! -d "$(juno-ext-libs-${curpkg}-install-dir)" ]; then
        echo $msg Please install the Package first
        exit 1
    fi
    local install=$(juno-ext-libs-${curpkg}-install-dir)
    pushd $install
    juno-ext-libs-generate-sh $(juno-ext-libs-${curpkg}-name) ${install}
    juno-ext-libs-generate-csh $(juno-ext-libs-${curpkg}-name) ${install}
    popd
    
    popd >& /dev/null
}

# helper for self check
function juno-ext-libs-PKG-self-check {
    local curpkg=$1 # this is the pkg to be intalled.
    shift
    local msg="===== $FUNCNAME: "

    # check function exists or not
    type -t juno-ext-libs-${curpkg}-self-check-list >& /dev/null|| return 1
    is_list_mode || echo $msg function self check list exists

    local checkf
    local ok=0

    local installed_dir=$(juno-ext-libs-${curpkg}-install-dir)
    for checkf in $(juno-ext-libs-${curpkg}-self-check-list); do
        if [ ! -f "${installed_dir}/${checkf}" ]; then
            ok=1
        fi
    done

    return $ok
}

function juno-ext-libs-log-dir() {
    local pkg=$1; shift
    echo $JUNOENVDIR/logs/${pkg}
}

function juno-ext-libs-log-file() {
    local pkg=$1; shift
    local cmd=$1; shift
    echo $(juno-ext-libs-log-dir ${pkg})/${pkg}-${cmd}.log
}
# interface

function juno-ext-libs-get {
    local msg="==== $FUNCNAME: "
    local pkg=$1
    echo $msg
    juno-ext-libs-$pkg-get | sed 's/^/['"${pkg}"'-conf] /' | tee $(juno-ext-libs-log-file $pkg get)
}
function juno-ext-libs-conf {
    local msg="==== $FUNCNAME: "
    local pkg=$1
    echo $msg
    juno-ext-libs-$pkg-conf | sed 's/^/['"${pkg}"'-conf] /' | tee $(juno-ext-libs-log-file $pkg conf)
}
function juno-ext-libs-make {
    local msg="==== $FUNCNAME: "
    local pkg=$1
    echo $msg
    juno-ext-libs-$pkg-make | sed 's/^/['"${pkg}"'-make] /' | tee $(juno-ext-libs-log-file $pkg make)
}
function juno-ext-libs-install {
    local msg="==== $FUNCNAME: "
    local pkg=$1
    echo $msg
    juno-ext-libs-$pkg-install | sed 's/^/['"${pkg}"'-install] /' | tee $(juno-ext-libs-log-file $pkg install)
}
function juno-ext-libs-setup {
    local msg="==== $FUNCNAME: "
    local pkg=$1
    echo $msg
    juno-ext-libs-$pkg-setup | sed 's/^/['"${pkg}"'-setup] /' | tee $(juno-ext-libs-log-file $pkg setup)
}

function juno-ext-libs-all {
    local msg="==== $FUNCNAME: "
    local pkg=$1
    juno-ext-libs-get $pkg
    juno-ext-libs-conf $pkg
    juno-ext-libs-make $pkg
    juno-ext-libs-install $pkg
    juno-ext-libs-setup $pkg
}

function juno-ext-libs-reuse {
    local msg="==== $FUNCNAME: "
    # = check the environment variable $JUNO_EXTLIB_OLDTOP =
    if [ -z "$JUNO_EXTLIB_OLDTOP" ];
    then
        echo $msg Please set the ENVIRONMENT VARIABLE called \$JUNO_EXTLIB_OLDTOP first1>&2
        exit 1
    fi
    if [ ! -d "$JUNO_EXTLIB_OLDTOP" ];
    then
        echo $msg The \$JUNO_EXTLIB_OLDTOP \"$JUNO_EXTLIB_OLDTOP\" does not exist.
        exit 1
    fi
    local pkg=$1
    # = get the installation directory for PKG =
    # here is the dir with version
    local oldpath=$JUNO_EXTLIB_OLDTOP/$(juno-ext-libs-${pkg}-name)/$(juno-ext-libs-${pkg}-version)
    local newpath=$(juno-ext-libs-${pkg}-install-dir)
    echo $msg $pkg oldpath: $oldpath
    echo $msg $pkg newpath: $newpath
    local retst=0
    if [ ! -d "$oldpath" ];
    then
        echo $msg $pkg oldpath \"$oldpath\" does not exist. 1>&2
        retst=1
    fi
    if [ -d "$newpath" ];
    then
        echo $msg $pkg newpath \"$newpath\" already exists. 1>&2
        retst=1
    fi
    if [ "$retst" != "0" ];
    then
        return $retst
    fi
    # = prepare the external library path for the package =
    juno-ext-libs-install-root-check || exit $?
    # == ExternalLibs ==
    pushd $(juno-ext-libs-install-root) >& /dev/null
    # === PKG ===
    if [ ! -d $(juno-ext-libs-$pkg-name) ];
    then
        mkdir $(juno-ext-libs-$pkg-name)
    fi
    pushd $(juno-ext-libs-$pkg-name) >& /dev/null
    # ==== create link here ===
    ln -s $oldpath $newpath
    popd >& /dev/null
    popd >& /dev/null
}

function juno-ext-libs-list {
    local msg="==== $FUNCNAME: "
    local pkg=$1
    # is installed?
    local is_installed=' '
    ## if bashrc exists, the install may be correct
    if [ -f "$(juno-ext-libs-${pkg}-install-dir)/bashrc" ]; then
        is_installed='?'
    fi
    ## further self check
    type -t juno-ext-libs-${pkg}-self-check >& /dev/null && juno-ext-libs-${pkg}-self-check && {
        is_installed='x'
    }
    # dependencies
    local deps="$(juno-ext-libs-${pkg}-dependencies-list)"
    if [ -n "$deps" ]; then
        deps="-> $deps"
    fi

    # Format the output
    echo $msg [${is_installed}] ${pkg}@$(juno-ext-libs-${pkg}-version) "$deps"
}

function junoenv-external-libs-list { 
    local mode=$1 
    echo python boost cmake 
    if [ "$mode" == "cmtlibs" ] || [ "$mode" == "reuse" ]; 
    then 
        echo  
    else 
        echo git 
    fi
    echo xercesc 
    echo gsl fftw3
    echo cmt clhep ROOT hepmc geant4 
    echo libmore  
    if [ "$mode" == "cmtlibs" ] || [ "$mode" == "reuse" ]; 
    then 
        echo  
    else 
        echo libmore-data 
    fi 
    echo mysql-connector-c mysql-connector-cpp
} 

## helper
is_list_mode() { return 1; }

function junoenv-external-libs {
    local msg="=== $FUNCNAME: "
    local cmd=$1
    juno-ext-libs-check-sub-command $cmd || exit $?
    shift
    local packages=$@
    # if list mode, we just print useful info
    if [ "$cmd" = "list" ]; then
        eval "is_list_mode(){ return 0;}"
        # list all pkgs
        if [ -z "$packages" ]; then
            packages=allpkgs
        fi
    fi

    # smart install
    # note here:
    # if the mode is smart-install, create a function called 'juno-ext-libs-smart-install-mode' return 0
    case $cmd in
        smart-install)
            eval "juno-ext-libs-smart-install-mode(){ return 0;}"
            source junoenv-external-libs-smart-install.sh
            ;;
        *)
            eval "juno-ext-libs-smart-install-mode(){ return 1;}"
            ;;
    esac

    if [ "$packages" = "allpkgs" ]; 
    then 
        echo $msg allpkgs will be loaded 
        packages=$(junoenv-external-libs-list $cmd) 
        echo $msg $packages 
    fi 

    # check dir first

    echo $msg command: $cmd
    echo $msg packages: $packages
    local pkgver=""
    for pkgver in $packages 
    do
        # using @ to seperate pkg anv ver.
        local pkgverarr=($(echo $pkgver | tr "@" "\n"))
        local pkg=${pkgverarr[0]}
        local ver=${pkgverarr[1]}
        # create version function first
        is_list_mode || echo $msg create function juno-ext-libs-${pkg}-version- to override default
        if [ -n "$ver" ]; then
            juno-ext-libs-create-PKG-version $pkg $ver
        fi 
        # check the initial status
        is_list_mode || echo $msg juno-ext-libs-check-init $pkg
        juno-ext-libs-check-init $pkg || exit $?
        # check whether the library is reused or not.
        is_list_mode || echo $msg juno-ext-libs-check-is-reused $pkg
        juno-ext-libs-check-is-reused $pkg || is_list_mode || continue
        is_list_mode || echo $msg juno-ext-libs-$cmd $pkg
        juno-ext-libs-$cmd $pkg
    done

}

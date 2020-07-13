#!/bin/bash
# this script will be a little complicated.
# meta data
function juno-ext-libs-geant4-name {
    echo Geant4
}

function juno-ext-libs-geant4-version-default {
    echo 9.4.p04
}
function juno-ext-libs-geant4-version {
    echo $(juno-ext-libs-PKG-version geant4)
}
# dependencies
function juno-ext-libs-geant4-dependencies-list {
    echo python boost cmake xercesc +qt4 clhep ROOT
}
function juno-ext-libs-geant4-dependencies-setup {
    juno-ext-libs-dependencies-setup geant4
}
# install dir
function juno-ext-libs-geant4-install-dir {
    local version=${1:-$(juno-ext-libs-geant4-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-geant4-name)/$version
}


# download related
function juno-ext-libs-geant4-official-download-url {
    echo http://geant4.cern.ch/support/source/
}

## data list
function juno-ext-libs-geant4-data-list-9.4 {
    # if seq is "", it means this is the directory for data
    # elseif seq is ".", it means this is the tarball
    local seq=${1:-}
    echo G4NDL${seq}3.14
    echo G4EMLOW${seq}6.19
    if [ "${seq}" = "" ]; then
        echo PhotonEvaporation${seq}2.1
    else
        echo G4PhotonEvaporation${seq}2.1
    fi
    if [ "${seq}" = "" ]; then
        echo RadioactiveDecay${seq}3.3
    else
        echo G4RadioactiveDecay${seq}3.3
    fi
    echo G4ABLA${seq}3.0
    echo G4NEUTRONXS${seq}1.0
    echo G4PII${seq}1.2
    echo RealSurface${seq}1.0
}

function juno-ext-libs-geant4-data-list {
    local version=${1:-$(juno-ext-libs-geant4-version)}
    local seq=${2:-}

    case $version in
        9.4*)
            echo $(juno-ext-libs-geant4-data-list-9.4 $seq)
            ;;
        *)
            echo $(juno-ext-libs-geant4-data-list-9.4 $seq)
            ;;
    esac
}
function juno-ext-libs-geant4-get-data-dir {
    local msg="===== $FUNCNAME: "
    local version=${1:-$(juno-ext-libs-geant4-version)}
    echo $(juno-ext-libs-geant4-install-dir $version)/data-archive
}
function juno-ext-libs-geant4-get-data {
    local msg="===== $FUNCNAME: "
    echo $msg Download data for Geant4
    local version=${1:-$(juno-ext-libs-geant4-version)}
    local dataname=""
    datadir=$(juno-ext-libs-geant4-get-data-dir $version)
    test -d $datadir || mkdir -p $datadir
    pushd $datadir >& /dev/null
    for dataname in $(juno-ext-libs-geant4-data-list $version ".")
    do
        if [ ! -f "${dataname}.tar.gz" ]; then
            echo $msg wget $(juno-ext-libs-geant4-official-download-url)/${dataname}.tar.gz
            if [ "$(juno-archive-check)" == "0" ]; then 
                wget $(juno-ext-libs-geant4-official-download-url)/${dataname}.tar.gz || exit $?
            else
                juno-archive-get ${dataname}.tar.gz ${dataname}.tar.gz || exit $?
            fi
        else
            echo $msg ${datadir}/${dataname}.tar.gz already exists
        fi
    done
    popd
}
function juno-ext-libs-geant4-install-data-dir {
    local msg="===== $FUNCNAME: "
    local version=${1:-$(juno-ext-libs-geant4-version)}
    echo $(juno-ext-libs-geant4-install-dir $version)/data
}
function juno-ext-libs-geant4-install-data {
    local msg="===== $FUNCNAME: "
    echo $msg Install data for Geant4
    local version=${1:-$(juno-ext-libs-geant4-version)}
    local dataname=""
    installdir=$(juno-ext-libs-geant4-install-data-dir $version)
    [ -d "$installdir" ] || mkdir -p "$installdir"
    datadir=$(juno-ext-libs-geant4-get-data-dir $version)
    test -d $datadir || mkdir -p $datadir
    pushd $datadir >& /dev/null
    # new: unzip and check
    local tmptarsname=($(juno-ext-libs-geant4-data-list $version "."))
    local tmpdstname=($(juno-ext-libs-geant4-data-list $version))
    local count=${#tmptarsname[@]}
    local i=""
    for i in $(seq 1 $count)
    do
        local dataname=${tmptarsname[$i-1]}
        local installdatadir=${tmpdstname[$i-1]}
        if [ ! -f "${dataname}.tar.gz" ]; then
            echo $msg ${datadir}/${dataname}.tar.gz does not exist
            echo $msg Please get the data first
            exit 1
        else
            if [ -d "$installdir/$installdatadir" ]; then
                echo $msg Skip Uncompress the data ${datadir}/${dataname}.tar.gz
                echo $msg "$installdir/$installdatadir" already exists
            else
                echo $msg ${datadir}/${dataname}.tar.gz already exists
                echo $msg Uncompress the data ${datadir}/${dataname}.tar.gz
                tar -C $installdir -zxvf ${dataname}.tar.gz
            fi
        fi
    done
    popd
    # check again
    pushd $installdir >& /dev/null
    local installdatadir=""
    for installdatadir in $(juno-ext-libs-geant4-data-list $version)
    do
        if [ ! -d "$installdatadir" ]; then
            echo $msg It seems the data does not exist?
            echo $msg Please check $installdatadir
            exit 1
        else
            echo $msg CHECK $installdatadir: OK
        fi
    done
    popd
}

## source code
function juno-ext-libs-geant4-download-url {
    local version=${1:-$(juno-ext-libs-geant4-version)}
    case $version in
        9.4.p04)
            echo $(juno-ext-libs-geant4-official-download-url)/geant4.9.4.p04.tar.gz
            ;;
        *)
            echo $(juno-ext-libs-geant4-official-download-url)/geant4.9.4.p04.tar.gz
            ;;
    esac
}
function juno-ext-libs-geant4-download-filename {
    local version=${1:-$(juno-ext-libs-geant4-version)}
    case $version in
        9.4.p04)
            echo geant4.9.4.p04.tar.gz
            ;;
        *)
            echo geant4.9.4.p04.tar.gz
            ;;
    esac
}
function juno-ext-libs-geant4-tardst {
    local version=${1:-$(juno-ext-libs-geant4-version)}
    case $version in
        9.4.p04)
            echo geant4.9.4.p04
            ;;
        *)
            echo geant4.9.4.p04
            ;;
    esac
}

function juno-ext-libs-geant4-file-check-exist {
    juno-ext-libs-file-check-exist $@
    return $?
}

# interface
function juno-ext-libs-geant4-get {
    juno-ext-libs-PKG-get geant4
    juno-ext-libs-geant4-get-data 
}

function juno-ext-libs-geant4-conf-uncompress {
    local msg="===== $FUNCNAME: "
    local tardst=$1
    local tarname=$2
    echo tar zxvf $tarname
    tar zxvf $tarname || exit 1
    if [ ! -d "$tardst" ]; then
        echo $msg "After Uncompress, can't find $tardst"
        exit 1
    fi
}

function juno-ext-libs-geant4-qmake() {
    # detect user
    type -t juno-ext-libs-qt4-self-check >& /dev/null && juno-ext-libs-qt4-self-check >& /dev/null && qmake $* && return 0
    # detect system
    qmake-qt4 -query QT_INSTALL_HEADERS >& /dev/null && qmake-qt4 $* && return 0
    qmake -query QT_INSTALL_HEADERS >& /dev/null && qmake $* && return 0
}

function juno-ext-libs-geant4-qmake-cpath() {
    # detect system or user
    ## user
    type -t juno-ext-libs-qt4-self-check >& /dev/null && juno-ext-libs-qt4-self-check >& /dev/null && {
        local install=$(qmake -query QT_INSTALL_HEADERS)
        local qt4base=$(perl -e 'use File::Spec; print File::Spec->abs2rel(@ARGV) . "\n"' $install ${JUNOTOP})
        echo \${JUNOTOP}/$qt4base
        return
    }
    ## system
    juno-ext-libs-geant4-qmake -query QT_INSTALL_HEADERS
}

function juno-ext-libs-geant4-is-qt-ok {
    juno-ext-libs-geant4-qmake -v 2>/dev/null 1>&2
    local st=$?
    echo $st
}

function juno-ext-libs-geant4-conf-use-qt {
    # for some users, they don't want to use qt4.
    # * use qmake to check the qt4 is installed
    local st=$(juno-ext-libs-geant4-is-qt-ok)
    if [ "$st" == "0" ];
    then
        # qt may exist
        echo "-DGEANT4_USE_QT=ON"
    else
        echo "-DGEANT4_USE_QT=OFF"
    fi
}

function juno-ext-libs-geant4-conf-9.4 {
    local msg="===== $FUNCNAME: "
    echo $msg cmake .. -DCMAKE_INSTALL_PREFIX=$(juno-ext-libs-geant4-install-dir) \
        -DGEANT4_USE_GDML=ON \
        $(juno-ext-libs-geant4-conf-use-qt) \
        -DXERCESC_ROOT_DIR=$(juno-ext-libs-xercesc-install-dir)
    cmake .. -DCMAKE_INSTALL_PREFIX=$(juno-ext-libs-geant4-install-dir) \
        -DGEANT4_USE_GDML=ON \
        $(juno-ext-libs-geant4-conf-use-qt) \
        -DXERCESC_ROOT_DIR=$(juno-ext-libs-xercesc-install-dir)
    local st=$?
    echo $msg $st 1>&2
    if [ "$st" != "0" ]; then
        exit 1
    fi
}

function juno-ext-libs-geant4-conf- {
    local msg="===== $FUNCNAME: "
    test -d geant4-build || mkdir geant4-build
    pushd geant4-build
    local version=$(juno-ext-libs-geant4-version)
    case $version in
        9.4*)
            echo $msg configure geant4 9.4
            juno-ext-libs-geant4-conf-9.4
        ;;
        *)
            echo $msg unknown
            exit 1
    esac
    popd

}
function juno-ext-libs-geant4-conf {
    juno-ext-libs-PKG-conf geant4 
}

function juno-ext-libs-geant4-make- {
    local msg="===== $FUNCNAME: "
    pushd geant4-build
    echo $msg make $(juno-ext-libs-gen-cpu-num)
    make $(juno-ext-libs-gen-cpu-num)
    popd
}
function juno-ext-libs-geant4-make {
    juno-ext-libs-PKG-make geant4
}
function juno-ext-libs-geant4-install- {
    local msg="===== $FUNCNAME: "
    pushd geant4-build
    echo $msg make install
    make install
    popd
}

function juno-ext-libs-geant4-install {
    juno-ext-libs-PKG-install geant4
    juno-ext-libs-geant4-install-data
}

# generate the sh/csh scripts

function juno-ext-libs-geant4-generate-sh-9.4 {
    local pkg=$1
    local install=$2
    local lib=${3:-lib}
    
cat << EOF >> bashrc
source \${JUNO_EXTLIB_${pkg}_HOME}/share/geant4-9.4.4/config/geant4-9.4.4.sh
export G4LIB_BUILD_SHARED=1
export G4ABLADATA=\${JUNO_EXTLIB_${pkg}_HOME}/data/G4ABLA3.0
export G4LEDATA=\${JUNO_EXTLIB_${pkg}_HOME}/data/G4EMLOW6.19
export G4LEVELGAMMADATA=\${JUNO_EXTLIB_${pkg}_HOME}/data/PhotonEvaporation2.1
export G4NEUTRONHPDATA=\${JUNO_EXTLIB_${pkg}_HOME}/data/G4NDL3.14
export G4NEUTRONXSDATA=\${JUNO_EXTLIB_${pkg}_HOME}/data/G4NEUTRONXS1.0
export G4PIIDATA=\${JUNO_EXTLIB_${pkg}_HOME}/data/G4PII1.2
export G4RADIOACTIVEDATA=\${JUNO_EXTLIB_${pkg}_HOME}/data/RadioactiveDecay3.3
export G4REALSURFACEDATA=\${JUNO_EXTLIB_${pkg}_HOME}/data/RealSurface1.0
EOF
    # make sure the Qt4 is setup.
    local st=$(juno-ext-libs-geant4-is-qt-ok)
    if [ "$st" == "0" ]; then
cat << EOF >> bashrc
export CPATH=$(juno-ext-libs-geant4-qmake-cpath):\$CPATH
EOF

    fi
}
function juno-ext-libs-geant4-generate-csh-9.4 {
    local pkg=$1
    local install=$2
    local lib=${3:-lib}

cat << EOF >> tcshrc
source \${JUNO_EXTLIB_${pkg}_HOME}/share/geant4-9.4.4/config/geant4-9.4.4.csh
setenv G4LIB_BUILD_SHARED 1
setenv G4ABLADATA \${JUNO_EXTLIB_${pkg}_HOME}/data/G4ABLA3.0
setenv G4LEDATA \${JUNO_EXTLIB_${pkg}_HOME}/data/G4EMLOW6.19
setenv G4LEVELGAMMADATA \${JUNO_EXTLIB_${pkg}_HOME}/data/PhotonEvaporation2.1
setenv G4NEUTRONHPDATA \${JUNO_EXTLIB_${pkg}_HOME}/data/G4NDL3.14
setenv G4NEUTRONXSDATA \${JUNO_EXTLIB_${pkg}_HOME}/data/G4NEUTRONXS1.0
setenv G4PIIDATA \${JUNO_EXTLIB_${pkg}_HOME}/data/G4PII1.2
setenv G4RADIOACTIVEDATA \${JUNO_EXTLIB_${pkg}_HOME}/data/RadioactiveDecay3.3
setenv G4REALSURFACEDATA \${JUNO_EXTLIB_${pkg}_HOME}/data/RealSurface1.0
EOF
    # make sure the Qt4 is setup.
    local st=$(juno-ext-libs-geant4-is-qt-ok)
    if [ "$st" == "0" ]; then
cat << EOF >> tcshrc
setenv CPATH $(juno-ext-libs-geant4-qmake-cpath):\${CPATH}
EOF

    fi
}
# generate general
function juno-ext-libs-geant4-generate-sh {
    local version=$(juno-ext-libs-geant4-version)
    case $version in
        9.4*)
            echo $msg setup geant4 9.4
            juno-ext-libs-geant4-generate-sh-9.4 $@
        ;;
        *)
            echo $msg unknown version $version
            exit 1
    esac
}
function juno-ext-libs-geant4-generate-csh {
    local version=$(juno-ext-libs-geant4-version)
    case $version in
        9.4*)
            echo $msg setup geant4 9.4
            juno-ext-libs-geant4-generate-csh-9.4 $@
        ;;
        *)
            echo $msg unknown version $version
            exit 1
    esac
}

function juno-ext-libs-geant4-setup {
    juno-ext-libs-PKG-setup geant4
}
# self check
function juno-ext-libs-geant4-self-check-list {
    # check one file is enough
    echo bin/geant4-config

}
function juno-ext-libs-geant4-self-check {
    local msg="===== $FUNCNAME: "
    juno-ext-libs-PKG-self-check geant4
}

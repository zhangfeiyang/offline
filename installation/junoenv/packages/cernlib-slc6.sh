#!/bin/bash
# THIS SCRIPT IS DESIGNED FOR SLC6.
# meta data
function juno-ext-libs-cernlib-slc6-name {
    echo CERNLIB
}

function juno-ext-libs-cernlib-slc6-version-default {
    echo 2005
}
function juno-ext-libs-cernlib-slc6-version {
    echo $(juno-ext-libs-PKG-version cernlib-slc6)
}
# dependencies
function juno-ext-libs-cernlib-slc6-dependencies-list {
    echo 
}
function juno-ext-libs-cernlib-slc6-dependencies-setup {
    juno-ext-libs-dependencies-setup cernlib-slc6
}
# download info
function juno-ext-libs-cernlib-slc6-download-url {
    local version=${1:-$(juno-ext-libs-cernlib-slc6-version)}
    case $version in
        2005)
            echo www-zeuthen.desy.de/linear_collider/cernlib/new
            ;;
        *)
            echo www-zeuthen.desy.de/linear_collider/cernlib/new
            ;;
    esac
}

function juno-ext-libs-cernlib-slc6-download-url-src {
    echo cernlib-2005-all-new.tgz 
}
function juno-ext-libs-cernlib-slc6-download-url-patch {
    local m=$1
    case $m in
    real)
        echo cernlib.2005.corr.tgz
        ;;
       *)
        echo cernlib.2005.corr.2010.08.01.tgz
        ;;
    esac
}
function juno-ext-libs-cernlib-slc6-download-url-install {
    echo cernlib.2005.install.2010.08.01.tgz
}

function juno-ext-libs-cernlib-slc6-download-list {
    echo src patch install 
}

# install dir
function juno-ext-libs-cernlib-slc6-install-dir {
    local version=${1:-$(juno-ext-libs-cernlib-slc6-version)}
    echo $(juno-ext-libs-install-root)/$(juno-ext-libs-cernlib-slc6-name)/$version
}

# interface
function juno-ext-libs-cernlib-slc6-get {
    local msg="==== $FUNCNAME: "
    local version=${1:-$(juno-ext-libs-cernlib-slc6-version)}
    local downloadurl=$(juno-ext-libs-cernlib-slc6-download-url $version)

    juno-ext-libs-build-root-check || exit $?
    pushd $(juno-ext-libs-build-root) >& /dev/null
    local clpkglable=""
    local clpkg=""
    for clpkglabel in $(juno-ext-libs-cernlib-slc6-download-list)
    do
        clpkg=$(juno-ext-libs-cernlib-slc6-download-url-$clpkglabel)
        if [ ! -f "${clpkg}" ];then
            echo $msg get $clpkg
            if [ "$(juno-archive-check)" == "0" ]; then 
                wget -O ${clpkg} $(juno-ext-libs-cernlib-slc6-download-url)/${clpkg}
            else
                juno-archive-get ${clpkg} ${clpkg} || exit $?
            fi
        else
            echo $msg $clpkg already exists.
        fi
    done

    popd >& /dev/null
}

function juno-ext-libs-cernlib-slc6-conf-prelude {
    # I am at CERNLIB INSTALL TOP LEVEL
    local versiontmp=$(juno-ext-libs-cernlib-slc6-version)
    if [ -L $versiontmp/src/include/freetype ];
    then
        return
    fi
    mkdir -p $versiontmp/src/include
    ln -s /usr/include/freetype2/freetype $versiontmp/src/include/
}

function juno-ext-libs-cernlib-slc6-conf-unpack-quick-copy {
    local s=$1
    local d=$2
    if [ ! -f "$d" ];
    then
        cp $s $d
    fi
    cmp -s $s $d >& /dev/null
    local cmpresult=$?
    if [ "$cmpresult" != "0" ]
    then
        # make sure the file are same.
        cp $s $d
    fi

}
function juno-ext-libs-cernlib-slc6-conf-unpack-src {
    local s=$(juno-ext-libs-build-root)/$(juno-ext-libs-cernlib-slc6-download-url-src)
    local d=$(juno-ext-libs-cernlib-slc6-download-url-src)
    juno-ext-libs-cernlib-slc6-conf-unpack-quick-copy $s $d
    tar zxvf $d
}
function juno-ext-libs-cernlib-slc6-conf-unpack-patch {
    local s=$(juno-ext-libs-build-root)/$(juno-ext-libs-cernlib-slc6-download-url-patch)
    # TODO the file is fixed!
    local d=$(juno-ext-libs-cernlib-slc6-download-url-patch real)
    juno-ext-libs-cernlib-slc6-conf-unpack-quick-copy $s $d
}
function juno-ext-libs-cernlib-slc6-conf-unpack-install {
    local s=$(juno-ext-libs-build-root)/$(juno-ext-libs-cernlib-slc6-download-url-install)
    local d=$(juno-ext-libs-cernlib-slc6-download-url-install)
    juno-ext-libs-cernlib-slc6-conf-unpack-quick-copy $s $d
    tar zxvf $d
}
function juno-ext-libs-cernlib-slc6-conf-fix-code {
    local msg="===== $FUNCNAME: "
    local versiontmp=$(juno-ext-libs-cernlib-slc6-version)
    local thecode=$versiontmp/src/pawlib/paw/cpaw/bugrep.c
    echo MAYBE FIX $thecode

}
function juno-ext-libs-cernlib-slc6-conf-quick-install-src {
    local msg="===== $FUNCNAME: "
    export CERN=$(pwd)
    echo CERN=$CERN
    local versiontmp=$(juno-ext-libs-cernlib-slc6-version)
    if [ -f $versiontmp/src/Imakefile ];
    then
        echo $msg Already Has the source code
        return
    fi
    ./Install_cernlib_src
}


function juno-ext-libs-cernlib-slc6-conf {
    local msg="==== $FUNCNAME: "

    juno-ext-libs-build-root-check || exit $?
    pushd $(juno-ext-libs-build-root) >& /dev/null

    # create directory cern
    if [ ! -d "$(juno-ext-libs-cernlib-slc6-name)" ]; then
        mkdir "$(juno-ext-libs-cernlib-slc6-name)"
    fi
    #################### IN CERNLIB NOW #####################
    pushd $(juno-ext-libs-cernlib-slc6-name) >& /dev/null

    if [ ! -d "$(juno-ext-libs-cernlib-slc6-version)" ]; then
        mkdir $(juno-ext-libs-cernlib-slc6-version)
    fi

    juno-ext-libs-cernlib-slc6-conf-prelude 
    juno-ext-libs-cernlib-slc6-conf-unpack-src
    juno-ext-libs-cernlib-slc6-conf-unpack-patch
    juno-ext-libs-cernlib-slc6-conf-unpack-install

    # TODO
    juno-ext-libs-cernlib-slc6-conf-quick-install-src
    juno-ext-libs-cernlib-slc6-conf-fix-code
    popd >& /dev/null
    popd >& /dev/null
}

function juno-ext-libs-cernlib-slc6-make-conf {
# COPY FROM Install_cernlib_and_lapack
echo "===================="
echo "CERNLIB installation"
echo "===================="

# Define the cern root directory

export CERN=$PWD
export CERN_LEVEL=`gunzip -c src_Imakefile.tar.gz | tar tf - | awk -F/ '{print $1}'`

ARCH=`uname -m`
cat > comptest.F <<EOF
      program comptest
      a = 0
      end
EOF
GCCVSN=`cpp -dM comptest.F | grep __VERSION__ | cut -d" " -f3 | cut -c 2`
FC=" "
[ "$GCCVSN" = "3" ]&&FC=g77
[ "$GCCVSN" = "4" ]&&FC=gfortran
if [ "$GCCVSN" = " " ]; then
  echo " "
  echo "====================================="
  echo "Expected GCC compiler suite not found"
  echo "====================================="
  rm -f comptest.*
  exit 1
else
  check="Checking for Fortran Compiler... "
  $FC -c comptest.F >/dev/null 2>&1
  if test -s comptest.o; then
    echo "${check}${FC}"
  else
    echo "${check} no"
    rm -f comptest.*
    exit 1
  fi
fi
rm -f comptest.*
export ARCH
export FC


echo "======================================"
echo "Configuration summary"
echo "---------------------"
echo "Architecture is: "$ARCH
echo "Fortran compiler used: "$FC
echo "CERN_LEVEL is: "$CERN_LEVEL
echo "======================================"
}

function juno-ext-libs-cernlib-slc6-make-lapack {
echo "installing lapack and blas libraries"

./Install_lapack

if [ -f ${CERN}/LAPACK/lapack_${ARCH}.a ] && [ -f ${CERN}/LAPACK/blas_${ARCH}.a ]; then
  cp -p ${CERN}/LAPACK/blas_${ARCH}.a ${CERN}/${CERN_LEVEL}/lib/libblas.a
  cp -p ${CERN}/LAPACK/lapack_${ARCH}.a ${CERN}/${CERN_LEVEL}/lib/liblapack3.a
else
  echo "The libraries blas_${ARCH}.a and lapack_${ARCH}.a are not found in ${CERN}/LAPACK/"
  exit 1
fi

}

function juno-ext-libs-cernlib-slc6-make {
    local msg="==== $FUNCNAME: "

    juno-ext-libs-build-root-check || exit $?
    pushd $(juno-ext-libs-build-root) >& /dev/null

    # create directory cern
    if [ ! -d "$(juno-ext-libs-cernlib-slc6-name)" ]; then
        mkdir "$(juno-ext-libs-cernlib-slc6-name)"
    fi
    #################### IN CERNLIB NOW #####################
    pushd $(juno-ext-libs-cernlib-slc6-name) >& /dev/null
    juno-ext-libs-cernlib-slc6-make-conf

    echo $msg "installing cernlib libraries"
    ./Install_cernlib_lib

    juno-ext-libs-cernlib-slc6-make-lapack

# Test the cernlib libraries

    echo "testing cernlib libraries"

    ./Install_cernlib_test


# Install the executables

    echo "installing cernlib executables"

    ./Install_cernlib_bin


# Install the old patchy 4 executables

    echo "installing the old patchy 4 executables"

    ./Install_old_patchy4


# Install the patchy 5 executables

    echo "installing the patchy 5 executables"

    ./Install_cernlib_patchy


# Install cernlib "includes"

    echo "installing cernlib includes"

    ./Install_cernlib_include


    echo "fixing known installation problems"

    ./Install_cernlib_fixes


# All done

    echo "Complete cernlib installation finished"
    echo "Check the log files in the build/log directory"

    popd >& /dev/null
}

function juno-ext-libs-cernlib-slc6-install {
    local msg="==== $FUNCNAME: "
    juno-ext-libs-build-root-check || exit $?
    pushd $(juno-ext-libs-build-root) >& /dev/null

    echo $msg INSTALLATION DIR: $(juno-ext-libs-cernlib-slc6-install-dir)
    if [ ! -d "$(juno-ext-libs-cernlib-slc6-install-dir)" ]; then
        mkdir -p $(juno-ext-libs-cernlib-slc6-install-dir)
    fi
    #################### IN CERNLIB NOW #####################
    pushd $(juno-ext-libs-cernlib-slc6-name) >& /dev/null
    pushd $(juno-ext-libs-cernlib-slc6-version)

    local destdir=$(juno-ext-libs-cernlib-slc6-install-dir)
    rsync -avz bin lib src include $destdir

    popd >& /dev/null
    rsync -avz patchy $(dirname $destdir)
    popd >& /dev/null
    popd >& /dev/null
}

function juno-ext-libs-cernlib-slc6-generate-sh {
local pkg=$1
local install=$2
local cern=$(dirname $install)
local cernlevel=$(basename $install)
cat << EOF > bashrc
export JUNO_EXTLIB_${pkg}_HOME=${install}
export CERN=$cern
export CERN_LEVEL=$cernlevel
export PATH=\$CERN/\$CERN_LEVEL/bin:\$PATH
EOF
}
function juno-ext-libs-cernlib-slc6-generate-csh {
local pkg=$1
local install=$2
local cern=$(dirname $install)
local cernlevel=$(basename $install)
cat << EOF > tcshrc
setenv JUNO_EXTLIB_${pkg}_HOME ${install}
setenv CERN $cern
setenv CERN_LEVEL $cernlevel
setenv PATH \$CERN/\$CERN_LEVEL/bin:\$PATH
EOF
}

function juno-ext-libs-cernlib-slc6-setup {
    juno-ext-libs-PKG-setup cernlib-slc6
}

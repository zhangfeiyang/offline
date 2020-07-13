#!/bin/bash

function junoenv-env-bashrc-name {
    echo bashrc.sh
}
function junoenv-env-tcshrc-name {
    echo tcshrc.csh
}

function junoenv-env-setup-sh-name {
    echo setup.sh
}

function junoenv-env-setup-csh-name {
    echo setup.csh
}

function junoenv-env-script-check {
    local msg="=== $FUNCNAME: "
    local retcode=0
    pushd $(juno-top-dir) >& /dev/null
    for name in $(junoenv-env-bashrc-name) $(junoenv-env-tcshrc-name)
    do
        if [ -f "$name" ]; then
            echo $msg $name already exists in $(juno-top-dir)
            retcode=1
        fi
    done
    popd >& /dev/null
    return $retcode
}

function junoenv-env-setup-check {
    local msg="=== $FUNCNAME: "
    junoenv-env-script-check
    if [ "$?" = "0" ];then
        echo $msg Checking OK
    else
        echo $msg The setup scripts seems already exists.
        echo $msg If you want to resetup, please use 
        echo $msg ==== $ junoenv env resetup
        echo $msg first, it will rename your setup scripts. Then use
        echo $msg ==== $ junoenv env
        echo $msg to resetup.
        exit 1
    fi
}
# JUNOTOP
function junoenv-env-setup-junotop {
    local msg="=== $FUNCNAME: "
    echo $msg
    pushd $(juno-top-dir)>& /dev/null

    echo $msg Create $(junoenv-env-bashrc-name)
cat << SHCMTPP >> $(junoenv-env-bashrc-name)
export JUNOTOP=$(juno-top-dir)
SHCMTPP

    echo $msg Create $(junoenv-env-tcshrc-name)
cat << CSHCMTPP >> $(junoenv-env-tcshrc-name)
setenv JUNOTOP $(juno-top-dir)
CSHCMTPP
    popd >& /dev/null


}
# CMTPROJECTPATH
function junoenv-env-setup-cmtprojectpath {
    local msg="=== $FUNCNAME: "
    pushd $(juno-top-dir)>& /dev/null

    echo $msg Append $(junoenv-env-bashrc-name)
cat << SHCMTPP >> $(junoenv-env-bashrc-name)
export CMTPROJECTPATH=$(juno-top-dir):\${CMTPROJECTPATH}
SHCMTPP

    echo $msg Append $(junoenv-env-tcshrc-name)
cat << CSHCMTPP >> $(junoenv-env-tcshrc-name)
if ( \$?CMTPROJECTPATH == 0 ) then
    setenv CMTPROJECTPATH ""
endif
setenv CMTPROJECTPATH $(juno-top-dir):\${CMTPROJECTPATH}
CSHCMTPP
    popd >& /dev/null

}
# External Libraries
# TODO
function junoenv-env-setup-external-libraries-list {
    # Here is a little complicated.
    # The output should be clean
    local guesspkg=""
    local env_scripts_dir=$JUNOENVDIR/packages
    source $JUNOENVDIR/junoenv-external-libs.sh
    for guesspkg in python boost cmake git xercesc qt4 gsl fftw3 cmt clhep ROOT hepmc geant4 libmore mysql-connector-c mysql-connector-cpp
    do
        guesspkg=$env_scripts_dir/${guesspkg}.sh
        source $guesspkg
        local pkg_short_name=$(basename $guesspkg)
        pkg_short_name="${pkg_short_name%.*}"

        # check the bashrc and tcshrc in the External Libraries
        local installdir=$(juno-ext-libs-${pkg_short_name}-install-dir)
        if [ -f "$installdir/bashrc" -a -f "$installdir/tcshrc" ]; then
            echo $installdir
        fi
    done
}
function junoenv-env-setup-external-libraries {
    local msg="=== $FUNCNAME: "
    local extlibinjuno=""
    pushd $(juno-top-dir)>& /dev/null
    for  extlibinjuno in $(junoenv-env-setup-external-libraries-list)
    do

    echo $msg Append $(junoenv-env-bashrc-name): ${extlibinjuno}
cat << SHCMTPP >> $(junoenv-env-bashrc-name)
source ${extlibinjuno}/bashrc
SHCMTPP

    echo $msg Append $(junoenv-env-tcshrc-name): ${extlibinjuno}
cat << CSHCMTPP >> $(junoenv-env-tcshrc-name)
source ${extlibinjuno}/tcshrc
CSHCMTPP

    done

    popd >& /dev/null
}

# == whole env, include setup offline ==
function junoenv-env-setup-runtime-offline-sh {
cat << SETUPSH > $(junoenv-env-setup-sh-name)
export JUNOTOP=$(juno-top-dir)
pushd \$JUNOTOP >& /dev/null
    source bashrc.sh

    pushd ExternalInterface/EIRelease/cmt/ >& /dev/null
    source setup.sh
    popd >& /dev/null

    pushd sniper/SniperRelease/cmt/ >& /dev/null
    source setup.sh
    popd >& /dev/null

    # setup offline
    # pushd offline/JunoRelease/cmt/ >& /dev/null
    # source setup.sh
    # popd >& /dev/null

    # setup tutorial 
    if [ -z "\${JUNO_OFFLINE_OFF:-}" ];
    then
        echo Setup Official Offline Software
        pushd offline/Examples/Tutorial/cmt/ >& /dev/null
        source setup.sh
        popd >& /dev/null
    fi
popd >& /dev/null

SETUPSH
}

function junoenv-env-setup-runtime-offline-csh {
cat << SETUPCSH > $(junoenv-env-setup-csh-name)
setenv JUNOTOP $(juno-top-dir)
pushd \$JUNOTOP >& /dev/null
    source tcshrc.csh

    pushd ExternalInterface/EIRelease/cmt/ >& /dev/null
    source setup.csh
    popd >& /dev/null

    pushd sniper/SniperRelease/cmt/ >& /dev/null
    source setup.csh
    popd >& /dev/null

    # setup offline
    # pushd offline/JunoRelease/cmt/ >& /dev/null
    # source setup.csh
    # popd >& /dev/null

    # setup tutorial 
    if ( \$?JUNO_OFFLINE_OFF == 0 ) then
        echo Setup Official Offline Software
        pushd offline/Examples/Tutorial/cmt/ >& /dev/null
        source setup.csh
        popd >& /dev/null
    endif
popd >& /dev/null

SETUPCSH
}

function junoenv-env-setup-runtime-offline {
    pushd $(juno-top-dir) >& /dev/null
    junoenv-env-setup-runtime-offline-sh
    junoenv-env-setup-runtime-offline-csh
    popd >& /dev/null
}

# = sub command =
# == resetup ==
function junoenv-env-resetup {
    local msg="=== $FUNCNAME: "
    # remove the existed:
    # * bashrc, tcshrc
    pushd $(juno-top-dir) >& /dev/null
    for name in $(junoenv-env-bashrc-name) $(junoenv-env-tcshrc-name)
    do
        echo $msg remove $name 1>&2 
        rm $name 
    done
    popd >& /dev/null

    # * external related libraries
    junoenv-env-setup-check 
    echo $msg setup the whole system
    junoenv-env-setup-junotop
    junoenv-env-setup-cmtprojectpath
    junoenv-env-setup-external-libraries
    # * whole setup
    junoenv-env-setup-runtime-offline
}

# main interface

function junoenv-env {
    local msg="== $FUNCNAME: "
    local subcommand=$1
    shift
    # If there is any sub command
    if [ -n "$subcommand" ]; then
        junoenv-env-$subcommand
    else
        junoenv-env-setup-check 
        echo $msg setup the whole system
        junoenv-env-setup-junotop
        junoenv-env-setup-cmtprojectpath
        junoenv-env-setup-external-libraries
        junoenv-env-setup-runtime-offline
    fi
}

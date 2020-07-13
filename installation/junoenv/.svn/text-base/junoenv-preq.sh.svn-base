# = Database =
# == ubuntu ==
function junoenv-preq-check-os-ubuntu-version-detect {
    lsb_release -r -s
}
function junoenv-preq-check-os-ubuntu-version {
    local osversion=${1:-}
    if [ -z "$osversion" ];
    then
        # detect the version number
        osversion=$(junoenv-preq-check-os-ubuntu-version-detect)
    fi
    echo $osversion
}
function junoenv-preq-check-os-ubuntu {
    local msg="==== $FUNCNAME: "
    local osversion=$(junoenv-preq-check-os-ubuntu-version $1)
    echo $msg OS version: $osversion 1>&2

    case $osversion in
        12.04*)
            echo true
            ;;
        14.04*)
            echo true
            ;;
        *)
            echo false
    esac

}

# * for 12.04
function junoenv-preq-load-ubuntu-1204 {
    echo libboost-all-dev
    echo libbz2-dev
    echo git dpkg-dev make g++ gcc binutils libx11-dev libxpm-dev 
    echo libxft-dev libxext-dev
    echo gfortran libssl-dev libpcre3-dev 
    echo xlibmesa-glu-dev libglew1.5-dev libftgl-dev 
    echo libmysqlclient-dev libfftw3-dev cfitsio-dev 
    echo graphviz-dev libavahi-compat-libdnssd-dev 
    echo libldap2-dev python-dev libxml2-dev libkrb5-dev 
    echo libgsl0-dev libqt4-dev
    echo libgl1-mesa-dev libglu1-mesa-dev 
    echo libxt-dev libXmu-dev libXi-dev zlib1g-dev libgl2ps-dev
    echo libexpat1-dev libxerces-c-dev
    echo 'cernlib*' xutils-dev
    echo autoconf
    echo subversion subversion-tools
    echo git gitk git-svn 
    echo gettext
    echo unzip
    echo lsb-release
}
function junoenv-preq-load-ubuntu {
    local osversion=$(junoenv-preq-check-os-ubuntu-version $1)
    case $osversion in
        12.04*)
            junoenv-preq-load-ubuntu-1204
            ;;
        14.04*)
            junoenv-preq-load-ubuntu-1204
            ;;
    esac
}

function junoenv-preq-install-ubuntu {
    sudo apt-get install $@
}

# == debian ==
function junoenv-preq-check-os-debian-version-detect {
    lsb_release -r -s
}
function junoenv-preq-check-os-debian-version {
    local osversion=${1:-}
    if [ -z "$osversion" ];
    then
        # detect the version number
        osversion=$(junoenv-preq-check-os-debian-version-detect)
    fi
    echo $osversion
}
function junoenv-preq-check-os-debian {
    local msg="==== $FUNCNAME: "
    local osversion=$(junoenv-preq-check-os-debian-version $1)
    echo $msg OS version: $osversion 1>&2

    case $osversion in
        7.*)
            echo true
            ;;
        *)
            echo false
    esac

}

# * for 7.x
function junoenv-preq-load-debian-7 {
    echo libboost-all-dev
    echo libbz2-dev
    echo git dpkg-dev make g++ gcc binutils libx11-dev libxpm-dev 
    echo libxft-dev libxext-dev
    echo gfortran libssl-dev libpcre3-dev 
    echo xlibmesa-glu-dev libglew1.5-dev libftgl-dev 
    echo libmysqlclient-dev libfftw3-dev cfitsio-dev 
    echo graphviz-dev libavahi-compat-libdnssd-dev 
    echo libldap2-dev python-dev libxml2-dev libkrb5-dev 
    echo libgsl0-dev libqt4-dev
    echo libgl1-mesa-dev libglu1-mesa-dev 
    echo libxt-dev libXmu-dev libXi-dev zlib1g-dev libgl2ps-dev
    echo libexpat1-dev libxerces-c-dev
    echo 'cernlib*' xutils-dev
    echo autoconf
    echo subversion subversion-tools
    echo git gitk git-svn 
    echo gettext libncurses5-dev tk-dev libreadline-dev libsqlite3-dev
    echo unzip
}
function junoenv-preq-load-debian {
    local osversion=$(junoenv-preq-check-os-debian-version $1)
    case $osversion in
        7.*)
            junoenv-preq-load-debian-7
            ;;
    esac
}

function junoenv-preq-install-debian {
    sudo apt-get install $@
}
# == SL or SLC ==
function junoenv-preq-check-os-sl-version-detect {
    lsb_release -r -s
}
function junoenv-preq-check-os-sl-version {
    local osversion=${1:-}
    if [ -z "$osversion" ];
    then
        # detect the version number
        osversion=$(junoenv-preq-check-os-sl-version-detect)
    fi
    echo $osversion
}
function junoenv-preq-check-os-sl {
    local msg="==== $FUNCNAME: "
    local osversion=$(junoenv-preq-check-os-sl-version $1)
    echo $msg OS version: $osversion 1>&2

    case $osversion in
        5*)
            echo true
            ;;
        6*)
            echo true
            ;;
        7*)
            echo true
            ;;
        *)
            echo false
    esac

}
# * for SL 5
function junoenv-preq-load-sl-5 {
    # copy from root
    echo git make gcc-c++ gcc binutils 
    echo libX11-devel libXpm-devel libXft-devel libXext-devel
    echo gcc-gfortran openssl-devel pcre-devel 
    echo mesa-libGL-devel glew-devel ftgl-devel mysql-devel
    echo fftw-devel cfitsio-devel graphviz-devel
    echo avahi-compat-libdns_sd-devel libldap-dev python-devel
    echo libxml2-devel gsl-static gsl-devel
    echo qt-devel
    # others
    echo bzip2-devel imake patch ncurses-devel readline-devel
    echo sqlite-devel tk-devel openldap-devel
    echo motif motif-devel openmotif openmotif-devel
    echo wget curl libcurl-devel unzip bzip2

}
# * for SL 6
function junoenv-preq-load-sl-6 {
    # copy from root
    echo git make gcc-c++ gcc binutils 
    echo libX11-devel libXpm-devel libXft-devel libXext-devel
    echo gcc-gfortran openssl-devel pcre-devel 
    echo mesa-libGL-devel glew-devel ftgl-devel mysql-devel
    echo fftw-devel cfitsio-devel graphviz-devel
    echo avahi-compat-libdns_sd-devel libldap-dev python-devel
    echo libxml2-devel gsl-static gsl-devel
    echo qt-devel
    # others
    echo bzip2-devel imake patch ncurses-devel readline-devel
    echo sqlite-devel tk-devel openldap-devel
    echo motif motif-devel openmotif openmotif-devel
    echo wget curl libcurl-devel unzip bzip2

}
# * for SL 7
function junoenv-preq-load-sl-7 {
    # copy from root
    echo git make gcc-c++ gcc binutils 
    echo libX11-devel libXpm-devel libXft-devel libXext-devel
    echo gcc-gfortran openssl-devel pcre-devel 
    echo mesa-libGL-devel glew-devel ftgl-devel mysql-devel
    echo fftw-devel cfitsio-devel graphviz-devel
    echo avahi-compat-libdns_sd-devel libldap-dev python-devel
    echo libxml2-devel gsl-static gsl-devel
    echo qt-devel
    # others
    echo bzip2-devel imake patch ncurses-devel readline-devel
    echo sqlite-devel tk-devel openldap-devel
    echo motif motif-devel openmotif openmotif-devel
    echo wget curl libcurl-devel unzip bzip2

}
function junoenv-preq-load-sl {
    local osversion=$(junoenv-preq-check-os-sl-version $1)
    case $osversion in
        5*)
            junoenv-preq-load-sl-5
            ;;
        6*)
            junoenv-preq-load-sl-6
            ;;
        7*)
            junoenv-preq-load-sl-7
            ;;
    esac
}

function junoenv-preq-install-sl {
    sudo yum install $@
}
# == fedora ==
function junoenv-preq-check-os-fedora-version-detect {
    lsb_release -r -s
}
function junoenv-preq-check-os-fedora-version {
    local osversion=${1:-}
    if [ -z "$osversion" ];
    then
        # detect the version number
        osversion=$(junoenv-preq-check-os-fedora-version-detect)
    fi
    echo $osversion
}
function junoenv-preq-check-os-fedora {
    local msg="==== $FUNCNAME: "
    local osversion=$(junoenv-preq-check-os-fedora-version $1)
    echo $msg OS version: $osversion 1>&2

    case $osversion in
        20*)
            echo true
            ;;
        *)
            echo false
    esac

}

# * for fedora 20
function junoenv-preq-load-fedora-20 {
    # copy from root
    echo git make gcc-c++ gcc binutils 
    echo libX11-devel libXpm-devel libXft-devel libXext-devel
    echo gcc-gfortran openssl-devel pcre-devel 
    echo mesa-libGL-devel glew-devel ftgl-devel mysql-devel
    echo fftw-devel cfitsio-devel graphviz-devel
    echo avahi-compat-libdns_sd-devel libldap-dev python-devel
    echo libxml2-devel gsl-static gsl-devel
    echo qt-devel
    # others
    echo bzip2-devel imake patch ncurses-devel readline-devel
    echo sqlite-devel tk-devel
    echo motif motif-devel

}
function junoenv-preq-load-fedora {
    local osversion=$(junoenv-preq-check-os-fedora-version $1)
    case $osversion in
        20*)
            junoenv-preq-load-fedora-20
            ;;
    esac
}

function junoenv-preq-install-fedora {
    sudo yum install $@
}

# == centos ==
function junoenv-preq-check-os-centos-version-detect {
    lsb_release -r -s
}
function junoenv-preq-check-os-centos-version {
    local osversion=${1:-}
    if [ -z "$osversion" ];
    then
        # detect the version number
        osversion=$(junoenv-preq-check-os-centos-version-detect)
    fi
    echo $osversion
}
function junoenv-preq-check-os-centos {
    local msg="==== $FUNCNAME: "
    local osversion=$(junoenv-preq-check-os-centos-version $1)
    echo $msg OS version: $osversion 1>&2

    case $osversion in
        6*)
            echo true
            ;;
        7*)
            echo true
            ;;
        *)
            echo false
    esac

}

# * for centos 6
function junoenv-preq-load-centos-6 {
    # copy from root
    echo git make gcc-c++ gcc binutils 
    echo libX11-devel libXpm-devel libXft-devel libXext-devel
    echo gcc-gfortran openssl-devel pcre-devel 
    echo mesa-libGL-devel glew-devel ftgl-devel mysql-devel
    echo fftw-devel cfitsio-devel graphviz-devel
    echo avahi-compat-libdns_sd-devel libldap-dev python-devel
    echo libxml2-devel gsl-static gsl-devel
    echo qt-devel
    # others
    echo bzip2-devel imake patch ncurses-devel readline-devel
    echo sqlite-devel tk-devel openldap-devel
    echo motif motif-devel openmotif openmotif-devel
    echo wget curl libcurl-devel unzip

}
# * for centos 7
function junoenv-preq-load-centos-7 {
    # copy from root
    echo git make gcc-c++ gcc binutils 
    echo libX11-devel libXpm-devel libXft-devel libXext-devel
    echo gcc-gfortran openssl-devel pcre-devel 
    echo mesa-libGL-devel glew-devel ftgl-devel mysql-devel
    echo fftw-devel cfitsio-devel graphviz-devel
    echo avahi-compat-libdns_sd-devel libldap-dev python-devel
    echo libxml2-devel gsl-static gsl-devel
    echo qt-devel
    # others
    echo bzip2-devel imake patch ncurses-devel readline-devel
    echo sqlite-devel tk-devel openldap-devel
    echo motif motif-devel openmotif openmotif-devel
    echo wget curl libcurl-devel unzip bzip2

}
function junoenv-preq-load-centos {
    local osversion=$(junoenv-preq-check-os-centos-version $1)
    case $osversion in
        6*)
            junoenv-preq-load-centos-6
            ;;
        7*)
            junoenv-preq-load-centos-7
            ;;
    esac
}

function junoenv-preq-install-centos {
    sudo yum install $@
}
# == opensuse ==
function junoenv-preq-check-os-opensuse-version-detect {
    lsb_release -r -s
}
function junoenv-preq-check-os-opensuse-version {
    local osversion=${1:-}
    if [ -z "$osversion" ];
    then
        # detect the version number
        osversion=$(junoenv-preq-check-os-opensuse-version-detect)
    fi
    echo $osversion
}
function junoenv-preq-check-os-opensuse {
    local msg="==== $FUNCNAME: "
    local osversion=$(junoenv-preq-check-os-opensuse-version $1)
    echo $msg OS version: $osversion 1>&2

    case $osversion in
        12.*)
            echo true
            ;;
        42.*)
            echo true
            ;;
        *)
            echo false
    esac

}
# * for 12.*
function junoenv-preq-load-opensuse-12 {
    echo git bash make gcc-c++ gcc binutils 
    echo xorg-x11-libX11-devel xorg-x11-libXpm-devel xorg-x11-devel 
    echo xorg-x11-proto-devel xorg-x11-libXext-devel
    echo openmotif openmotif-devel
    echo gcc-fortran libopenssl-devel
    echo pcre-devel Mesa glew-devel pkg-config libmysqlclient-devel
    echo fftw3-devel libcfitsio-devel graphviz-devel
    echo libdns_sd avahi-compat-mDNSResponder-devel
    echo openldap2-devel
    echo python-devel libxml2-devel krb5-devel gsl-devel libqt4-devel
    echo libbz2-devel ed patch
}

# * for 42.*
function junoenv-preq-load-opensuse-42 {
    echo git bash make gcc-c++ gcc binutils 
    echo xorg-x11-libX11-devel xorg-x11-libXpm-devel xorg-x11-devel 
    echo xorg-x11-proto-devel xorg-x11-libXext-devel
    echo openmotif openmotif-devel
    echo freeglut-devel
    echo gcc-fortran libopenssl-devel
    echo pcre-devel Mesa glew-devel pkg-config libmysqlclient-devel
    echo fftw3-devel libcfitsio-devel graphviz-devel
    echo libdns_sd avahi-compat-mDNSResponder-devel
    echo openldap2-devel
    echo python-devel libxml2-devel krb5-devel gsl-devel libqt4-devel
    echo libbz2-devel ed patch
}
function junoenv-preq-load-opensuse {
    local osversion=$(junoenv-preq-check-os-opensuse-version $1)
    case $osversion in
        12.*)
            junoenv-preq-load-opensuse-12
            ;;
        42.*)
            junoenv-preq-load-opensuse-42
            ;;
    esac
}

function junoenv-preq-install-opensuse {
    sudo zypper install $@
}

# = Helper =
function junoenv-preq-check-root-perm {
    local msg="=== $FUNCNAME: "
    # * ROOT User?
    if [ "$(id -u)" == "0" ];
    then
        return 0;
    fi
    # * sudo user?
    sudo -v
    local st=$?
    if [ "$st" == "0" ];
    then
        return 0;
    fi

    # * not OK return 1
    return 1;
}

function junoenv-preq-check-os {
    local msg="==== $FUNCNAME: "
    local os=${1:-SL}
    local osversion=${2:-}
    echo $msg check the os 1>&2
    # use tr to small case all words
    os=$(echo $os|tr '[:upper:]' '[:lower:]')
    # below is only for bash 4+
    #os=${os,,}
    case $os in
        ubuntu)
            junoenv-preq-check-os-ubuntu $osversion
            ;;
        debian)
            junoenv-preq-check-os-debian $osversion
            ;;
        sl*)
            junoenv-preq-check-os-sl $osversion
            ;;
        opensuse)
            junoenv-preq-check-os-opensuse $osversion
            ;;
        fedora)
            junoenv-preq-check-os-fedora $osversion
            ;;
        centos)
            junoenv-preq-check-os-centos $osversion
            ;;
        *)
            echo $msg Unsupported OS [$os][$osversion] now 1>&2
            echo false
            ;;
    esac
}

# = Main =
function junoenv-preq {
    local msg="=== $FUNCNAME: "
    local os=${1:-}      # Operating System
    local osversion=${2:-} # Version

    if [ -z $os ]; then
        os=$(juno-distro-detect)
        echo $msg Auto Detect Distro: $os 1>&2
    fi

    # use tr to small case all words
    os=$(echo $os|tr '[:upper:]' '[:lower:]')
    # below is only for bash 4+
    #os=${os,,}

    # * find the action
    local st=$(junoenv-preq-check-os $os $osversion)
    if [ "$st" != "true" ];
    then
        echo $msg $os is not supported 1>&2
        exit 1
    fi
    # * load the data
    local sftlist=$(junoenv-preq-load-$os $osversion)
    echo $msg Software list: $sftlist
    # * trigger the action 
    junoenv-preq-install-$os $sftlist
}

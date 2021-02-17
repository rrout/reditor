#!/bin/bash
set -e
HN=`hostname`
DN=`/usr/bin/domainname`

PROG=`basename "$0"`

VSCODEINSTALLPATH="/data/users/rrout/VSCODE/"

function usage {
    echo "Usage : $PROG -option < -vnc | -novnc | -wetty | -jupyter | -vscodeserver | -all >"
    echo "Example"
    echo "        : $PROG -vnc"
    echo "        : $PROG -wetty"
    echo "        : $PROG -jupyter"
    echo "        : $PROG -novnc"
    echo "        : $PROG -vscodeserver"
    echo "        : $PROG -all (This excludes -vnc)"
}


if [ $# != 1 ]; then
    usage
    exit 0
fi

if [ "$1" == "-vnc" ] || [ "$1" == "-wetty" ] || [ "$1" == "-novnc" ] ||
    [ "$1" == "-jupyter" ] || [ "$1" ==  "-vscodeserver" ] || [ "$1" == "-all" ]; then
    echo $1
else
    echo "Unknown option --- $1"
    usage
fi

if [ "$1" == "-vnc" ];then
    echo -e "\n=====> Checking VNC SERVER In path: ${HOME}"
    if type vncserver > /dev/null; then
        echo "========= VNC SERVER LIST =========="
        echo "VNC server `vncserver -list`"
        cat ~/.vnc/xstartup
        echo -e "\n=====>Starting vncserver at :5903"
        vncserver :3
    else
        echo "VNC server not Installed"
    fi
fi

if [ "$1" == "-novnc" ] || [ "$1" == "-all" ];then
    echo -e "\n=====> Checking noVNC In path: ${HOME}"
    if [ -d ~/noVNC/noVNC-1.1.0 ]; then
        echo 'NOTE:  ~/noVNC/noVNC-1.1.0  exists'
        cd  ~/noVNC/noVNC-1.1.0
        ./utils/launch.sh --vnc localhost:5903 &
        echo -e "\n=====> noVNC is Started: You can log in to: http://$HN.$DN:6080/vnc.html?host=$HN&port=6080" >&2
    else
cat<<EOF
        Install noVNC in ${HOME}
        Steps:
        Start vncserver :
        $ vncserver :3
        Get noVNC:
        mkdir ~/noVNC
        cd ~/noVNC
        $ wget https://github.com/novnc/noVNC/archive/v1.1.0.zip
        $ extract the tarfile 
        $ cd ~/noVNC/noVNC-1.1.0/
        Start noVNC
        ./utils/launch.sh --vnc localhost:5903 &
        Fallow instructions
EOF
    exit 0
    fi
fi

echo -e "\n=====> Checking Node.js In path: ${HOME}"
if [ -d ~/.nvm ]; then
    echo 'NOTE: ~/.nvm exists'
    #nvm -h
    #npm -h
else
    echo "Install npm and nvm : Read : https://github.com/krishnasrinivas/wetty.git"
    exit 0
fi

if [ "$1" == "-wetty" ] || [ "$1" == "-all" ];then
    echo -e "\n=====> Checking Wetty In path ${HOME}"
    if  [ -x "$(command -v wetty)" ]; then
        echo 'NOTE: wetty is installed.' >&2
        echo "Starting Wetty"
        wetty &
        echo -e "\n=====> Wetty is Started: You can log in to: http://$HN.$DN:3000" >&2
    else
cat<<EOF
        install Wetty
            Read Got hub:  git clone https://github.com/krishnasrinivas/wetty.git
            $ npm i -g wetty.js
        Start Wettty
            $ wetty
EOF
    exit 0
    fi
fi

echo -e "\n=====> Checking ~/.local directory In path: ${HOME}"
if [ -d ~/.local ]; then
    echo 'Error: ~/.local exists'
    echo "=====> Exporting ~/.local/bin to Global Env Path: $PATH"
    export PATH=~/.local/bin:$PATH
else
    exit 0
fi

echo -e "\n=====> Checking python3 directory In path"
if [ -x "$(command -v python3)" ]; then
     echo "NOTE: python3  exists @ $(command -v python3)"
else
cat<<EOF
Install Python 3.7
    wget https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz
    tar zxvf Python-3.6.2.tgz
    ./configure --prefix=$HOME/.local
    make;make install
Export The path
    export PATH=~/.local/bin:$PATH
EOF
    exit 0
fi


echo -e "\n=====> Checking PIP3 directory In path"
if [ -x "$(command -v pip3)" ]; then
    echo "NOTE: pip3  exists @ $(command -v pip3)"
    echo -e "\n=====> Listing PIP3 modules"
    pip3 list
else
cat<<EOF
Install pip3 OR Upgrade pip3
    pip3 install  pip --user
    OR
    pip3 install --upgrade pip --user

Check pip3 version
    pip3 --version
EOF
    exit 0
fi

if [ "$1" == "-jupyter" ] || [ "$1" == "-all" ];then
    echo -e "\n=====> Checking Jupyter In path ${HOME}"
    if  [ -x "$(command -v jupyter)" ]; then
        echo 'jupyter is installed.' >&2
        cd /data/users/rrout/
        echo 'Starting Jupyter......' >&2
        jupyter lab --ip=0.0.0.0 --no-browser &
        echo -e "\n=====> Jupyter is Started: You can log in to: http://$HN.$DN:3001" >&2
    else
cat<<EOF
    Install jupyterlab
        export PATH=~/.local/bin:$PATH
        pip3 install --user jupyterlab
        pip3 list

    Start jupyter lab
        jupyter lab --ip=0.0.0.0 --no-browser
EOF
    fi
fi

if [ "$1" == "-vscodeserver" ] || [ "$1" == "-all" ];then
    echo -e "\n=====> Checking VscodeServer In path ${HOME}"
    if [ -d ${VSCODEINSTALLPATH}/VSCODE/code-server-3.8.0-linux-amd64 ]; then
        echo 'VscodeServer Doesnt Exist.' >&2
        cd ${VSCODEINSTALLPATH}/VSCODE/code-server-3.8.0-linux-amd64
        echo 'Starting VscodeServer......' >&2
        ./code-server &
        echo -e "\n=====> VscodeServer is Started: You can log in to: http://$HN.$DN:6085" >&2
    else
cat<<EOF
    Install VscodeServer
        cd ${VSCODEINSTALLPATH}
        wget https://github.com/cdr/code-server/releases/download/v3.8.0/code-server-3.8.0-linux-amd64.tar.gz
        tar -xvzf code-server-3.8.0-linux-amd64.tar.gz
        cd ${VSCODEINSTALLPATH}/VSCODE/code-server-3.8.0-linux-amd64

    Start Vscode Server
        ./code-server &
EOF
    fi
fi




echo -e "\nInstalled the reditor configuration successfully! Enjoy :-)"





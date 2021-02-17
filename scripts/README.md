# Setup Reditor Environment
This environment creates so mant useful settings which make bash and vim super useful.
It also starts couple of editing servers for the GUI users

## Whats in Bash setup
```
```

## Whats in Vim Setup
```
```

## What are the editing servers
```
Wetty
Jupyterlab
noVNC
Visual Studio Code Server
```
## One Time setup in a fresh Linux,Solaris and MacOs Devices
To set reditor environment use the fallowing scripts. This juat one time job to set bash and vim set up.
```
reditor_bash_install.sh

This installs useful bash functions aliases and manymore
```

```
reditor_vim_install.sh

This script installs a vrey fresh look to Vim, installs super useful plugins and many more
```

```
reditor_vim_clone_bundle.sh
This clones external vim buldles to be added pathogen runtime path
```
 
## Setup after each reload
```
reditor_setup_dev_env.sh

This lunches couple remote editing servers and the editing servers for the GUI users
```

## Remote editing and GUI servers
Before setting up emote editing servers , you must download and install them.
Currently it is not done automatically

### Setup noVNC
```
Install noVNC
        mkdir ~/noVNC
        cd ~/noVNC
        $ wget https://github.com/novnc/noVNC/archive/v1.1.0.zip
        $ extract the tarfile
        $ cd ~/noVNC/noVNC-1.1.0/
        Start noVNC
        ./utils/launch.sh --vnc localhost:5903 &
```
### Setup Python3, npn, nvm
```
Install Python 3.7
    wget https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz
    tar zxvf Python-3.6.2.tgz
    ./configure --prefix=$HOME/.local
    make;make install
Export The path
    export PATH=~/.local/bin:$PATH


Install pip3 OR Upgrade pip3
    pip3 install  pip --user
    OR
    pip3 install --upgrade pip --user

Check pip3 version
    pip3 --version

Install Node.js, npn,nvm
```
### Setup Jupyterlab
```
Install jupyterlab
        export PATH=~/.local/bin:$PATH
        pip3 install --user jupyterlab
        pip3 list

Start jupyter lab
        jupyter lab --ip=0.0.0.0 --no-browser
```
### Setup Wetty
```
install Wetty
        Read Got hub:  git clone https://github.com/krishnasrinivas/wetty.git
        $ npm i -g wetty.js
Start Wettty
        $ wetty &
```
### Setup Visual Studio Code Server
```
Install Vscode Server
        cd ${INSTALLPATH}
        wget https://github.com/cdr/code-server/releases/download/v3.8.0/code-server-3.8.0-linux-amd64.tar.gz
        tar -xvzf code-server-3.8.0-linux-amd64.tar.gz
        cd ${INSTALLPATH}/VSCODE/code-server-3.8.0-linux-amd64

Start Vscode Server
        ./code-server &

Vscode Server Configurations
    All Vscode Server configuration present in ~/.config
        Config Password: Modify ~/.config/code-server/config.yaml
    Extenssion
        C,C++:
        Download Latest extension from
             https://github.com/microsoft/vscode-cpptools/releases/download/1.1.3/cpptools-linux.vsix
        Open command platelet
        Write "Extensios:Install from VSIX"
        Chose the VSIX file
        Done
        Configure C/C++ Intellisense Extension:
            Open command platelet
            Write "C/C++:Extensios:Ecit Configuratuins (UI)"
            Set Intellisense DB for faster database build and indexing      
```
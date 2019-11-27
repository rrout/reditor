# Install sources

LOGFILE="$HOME/reditor/utils/sources/buildlog.log"
INSTALL_DIR="$HOME/reditor/utils"
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALL_DIR/lib

Step 1:
    Edit "DownloadUrlList.txt" amd make sure the sources you need to install

Step 2:
    Build Installer script

    Usage : buildInstaller.sh option < -do | -del >

Step 3:
    Download the sources
        Note : this will Download and extrace sources to the Directory written in "DownloadUrlList.txt"

    Usage : install.sh option < -get | -del | -install | -uninstall | -clean>

Step 4:
    Install the sources
    it will make and make install in the Install Directory
        

#Uninstall

#!/bin/bash
set -e

DBG=no
LOGFILE=""
LOGFILE="$HOME/reditor/utils/sources/buildlog.log"

export INSTALL_DIR="$HOME/reditor/utils"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALL_DIR/lib

PROG=`basename "$0"`
function usage {
    echo "Usage : $PROG option < -get | -del | -install | -uninstall | -clean> <CMD> <URL> < -dbg >"
}

function exicute_cmd {
    if [ "$DBG" == "yes" ];then
        echo "DBG=$DBG [cmd] : $@"
        return
    fi
    echo "Execute     : $@"
    if [ "${LOGFILE}" != "" ];then
        $@ >> $LOGFILE
        return
    fi
    $@
}

DWNLD_CMD=$2
SRC_URL=$3
DIR=`echo $PROG | sed -e 's/\.sh$//g'`
SRC=$DIR.tar.gz


if [ $# == 0 ]; then
    usage
    exit 0
fi

if [ "$1" == "-get" ] || [ "$1" == "-del" ] || [ "$1" == "-install" ] || [ "$1" == "-uninstall" ] || [ "$1" == "-clean" ]; then
    echo "./$PROG $@"
else
    echo "Unknown option --- $1"
    usage
    exit 0
fi

if [ "$4" == "-dbg" ]; then
    DBG=yes
fi

exicute_cmd echo "Executing Script......$PROG as : $PROG $@"
if [ "$1" == "-get" ];then
    if [ $# != 3 ]; then
        echo "Please provide Download URL"
        echo "Usage : $PROG -get <wget|git> <URL>"
        exit
    fi
    if [ "$DWNLD_CMD" != "wget" ] && [ "$DWNLD_CMD" != "git" ];then
        echo "Please provide Download command <wget> OR <get>"
        echo "Usage : $PROG -get <wget|git> <URL>"
        exit
    fi
    exicute_cmd echo "Downloading  : $SRC_URL"
    if [ "$DWNLD_CMD" == "wget" ];then
        SRC_DIR=`echo "$SRC_URL" | sed -e 's/^.*\///g' | sed -e 's/\.tar.gz$//g'`
        SRC_GZ=`echo "$SRC_URL" | sed -e 's/^.*\///g'`
        exicute_cmd $DWNLD_CMD $SRC_URL
        exicute_cmd mv -f $SRC_GZ $SRC
        exicute_cmd rm -rf $DIR
        exicute_cmd tar zxvf $SRC
        exicute_cmd mv -f $SRC_DIR $DIR
    else
        DWNLD_CMD="git clone"
        SRC_GITDIR=`echo "$SRC_URL" | sed -e 's/^.*\///g' | sed -e 's/\.git$//g'`
        exicute_cmd $DWNLD_CMD $SRC_URL
        exicute_cmd rm -rf $DIR
        exicute_cmd mv -f $SRC_GITDIR $DIR
    fi
elif [ "$1" == "-del" ];then

    exicute_cmd echo "Deleting : $SRC $DIR"
    exicute_cmd rm -rf $SRC
    exicute_cmd rm -rf $DIR

elif [ "$1" == "-install" ];then

    exicute_cmd echo "Installing : $SRC"
    exicute_cmd cd $DIR
    #./configure --prefix="$HOME/reditor/utils"
    if [ "$DIR" = "AG" ];then
        ./autogen.sh
    fi
    if [ "$DIR" = "UCTAGS" ];then
        ./autogen.sh
    fi
    if [ "$DIR" = "TMUX" ];then
        exicute_cmd ./configure --prefix=$INSTALL_DIR CPPFLAGS="-I$INSTALL_DIR/include-I$INSTALL_DIR/include/ncurses" LDFLAGS="-L$INSTALL_DIR/lib" CFLAGS="-I$INSTALL_DIR/include"
    elif [ "$DIR" = "GLOBAL" ];then
        #exicute_cmd ./configure --prefix=$INSTALL_DIR --with-sqlite3 --disable-gtagscscope --with-exuberant-ctags=${HOME}/utils/reditor/bin/ctags --enable-static --disable-shared CFLAGS="-g -O0 --static ${CFLAGS} " LDFLAGS=" --static ${LDFLAGS}
        exicute_cmd ./configure --prefix=$INSTALL_DIR --disable-gtagscscope
    else
        exicute_cmd ./configure --prefix=$INSTALL_DIR
    fi
    exicute_cmd make -j
    exicute_cmd make install

elif [ "$1" == "-uninstall" ];then

    exicute_cmd echo "Uninstalling : $SRC"
    exicute_cmd cd $DIR
    exicute_cmd make uninstall
elif [ "$1" == "-clean" ];then

    exicute_cmd echo "Cleaning : $SRC"
    exicute_cmd cd $DIR
    exicute_cmd make clean

else
    echo "Unknown Command --- $1"
fi


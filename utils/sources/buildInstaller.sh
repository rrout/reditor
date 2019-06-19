#!/bin/bash
#set -x
#set -f
DBG=no
LOGFILE=
LOGFILE="buildlog.log"


PROG=`basename "$0"`
function usage {
    echo "Usage : $PROG option < -do | -del >"
}

function exicute_cmd {
    if [ "$DBG" == "yes" ];then
        echo "DBG=$DBG [cmd] : $@"
        return
    fi
    echo "Execute   : $@"
    if [ "${LOGFILE}" != "" ];then
        $@ >>$LOGFILE
        return
    fi
    $@
}


if [ $# == 0 ]; then
    usage
    exit 0
fi

if [ "$1" == "-do" ] || [ "$1" == "-del" ]; then
    echo "./$PROG $@"
else
    echo "Unknown option --- $1"
    usage
    exit 0
fi

if [ "$2" == "-dbg" ];then
    DBG=yes
fi

input="${HOME}/reditor/utils/sources/DownloadUrlList.txt"
while IFS= read -r line
do
    if [ -z "${line}" ]; then
        continue
    fi
    [[ "$line" =~ ^#.*$ ]] && continue

    [[ "$line" =~ \#.* ]] && continue

    LINE=$line
    DWNLD_SCRIPT=`echo $LINE|awk '{print $1}'`
    DWNLD_CMD=`echo $LINE|awk '{print $2}'`
    DWNLD_URL=`echo $LINE|awk '{print $3}'`
    echo "READ LINE : $line"
    if [ "$1" == "-do" ];then
        exicute_cmd cp INSTALL_TEMPLATE.sh $DWNLD_SCRIPT.sh
    elif [ "$1" == "-del" ];then
        exicute_cmd rm -rf $DWNLD_SCRIPT.sh
    else
       echo "Unknown option --- $1"
    fi
done < "$input"



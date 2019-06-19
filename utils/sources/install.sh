#!/bin/bash
#set -x

DBG=no               # [ yes | no ]
LOGFILE=
LOGFILE="buildlog.log"

PROG=`basename "$0"`
function usage {
    echo "Usage : $PROG option < -get | -del | -install | -uninstall | -clean>"
}

function exicute_cmd {
    if [ "$DBG" == "yes" ];then
        echo "DBG=$DBG [cmd] : $@"
        return
    fi
    echo "Execute     : $@"
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

if [ "$1" == "-get" ] || [ "$1" == "-del" ] || [ "$1" == "-install" ] || [ "$1" == "-uninstall" ] || [ "$1" == "-clean" ]; then
    echo "./$PROG $@"
else
    echo "Unknown option --- $1"
    usage
    exit 0
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
    echo $DWNLD_SCRIPT $DWNLD_CMD $DWNLD_URL
    echo "READ LINE    : $line"
    exicute_cmd bash $DWNLD_SCRIPT.sh $1 $DWNLD_CMD $DWNLD_URL
done < "$input"



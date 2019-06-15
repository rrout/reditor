#!/bin/bash

GDBINIT_FILE=GDBINIT

BASEDIR=`basename "$PWD"`
if [[ $BASEDIR != "gdb" ]];then
    echo "You are not on gdb (REDITOR) Directory"
    exit 0
fi

if [ -f $GDBINIT_FILE ];then
    echo "Deleting old $GDBINIT_FILE"
    rm -rf $GDBINIT_FILE
fi

echo "Creating $GDBINIT_FILE file @ ${PWD}"
touch $GDBINIT_FILE

echo "Making $GDBINIT_FILE"

cat gdbinit-base.gdb >  $GDBINIT_FILE
cat gdbinit-cpp-butify.gdb >> $GDBINIT_FILE
cat gdbinit-tips.gdb  >> $GDBINIT_FILE

echo "$GDBINIT_FILE @  ${PWD} is ready to use"
echo "Kindly Rename $GDBINIT_FILE to .gdbinit and place in  working OR HOME directory..... Enjoy "

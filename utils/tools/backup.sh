#!/bin/sh

cd ~
rm -rf  ~/.vim/tmp/*

tar -zcvf config.tar.gz .vim* .bash*  .global* .input*  bin* .custom* --exclude=.bash_history --exclude=.vimyankring_history_v2.txt --exclude=*.o --exclude=*.exe --exclude=*.gz --exclude=*.tare --exclude=*.gz --exclude=*.tare --exclude=*.gz --exclude=*.tar  --exclude=*.a  --exclude=*.so --exclude=binary

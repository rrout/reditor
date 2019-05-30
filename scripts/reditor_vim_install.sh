#!/bin/sh
set -e

cd ~/reditor/vim
touch ~/.vimrc
mkdir -p ~/.vim
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/tmp

echo 'set runtimepath+=~/reditor/vim/.vim
source ~/reditor/vim/.vimrc

try

catch

endtry' >> ~/.vimrc

echo "Installed the reditor Vim configuration successfully! Enjoy :-)"


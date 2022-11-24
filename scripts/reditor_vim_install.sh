#!/bin/sh
set -e

cd ~/reditor/vim
touch ~/.vimrc
mkdir -p ~/.vim
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/tmp
mkdir -p ~/.vim/syntax

[[ -e ~/.vim/syntax/c.vim ]] && cp ~/.vim/syntax/c.vim ~/.vim/syntax/c.vim.bkp
cp -r ~/reditor/vim/.vim/syntax/c.vim ~/.vim/syntax/c.vim

echo 'set runtimepath+=~/reditor/vim/.vim
source ~/reditor/vim/.vimrc

try

catch

endtry' >> ~/.vimrc

echo "Installed the reditor Vim configuration successfully! Enjoy :-)"


#! /bin/sh
cd ~
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

wget https://raw.githubusercontent.com/Filo01/system_settings/master/.vimrc
vim +PluginInstall +qall

~/.vim/bundle/YouCompleteMe/install.py

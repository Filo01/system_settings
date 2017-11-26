#! /bin/sh
echo 'export TERM=xterm-256color' >> ~/.bashrc
cd ~
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
curl https://raw.githubusercontent.com/Filo01/system_settings/master/.vimrc > ~/.vimrc
vim +PluginInstall +qall

curl https://raw.githubusercontent.com/Filo01/system_settings/master/.tmux.conf > ~/.tmux.conf
sudo pip install virtualenvwrapper
export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh
export PROJECT_HOME=~/PythonProjects
echo "pip install pylint" >> $WORKON_HOME/postmkproject
echo "pip install autopep8" >> $WORKON_HOME/postmkproject
echo "if [ -n \"\$VIRTUAL_ENV\" ]; then
    source \$VIRTUAL_ENV/bin/activate;
    fi" >> ~/.bashrc
echo "if [[ -n \"\$TMUX\" ]]; then
    tmux set-environment VIRTUAL_ENV \$VIRTUAL_ENV
    fi" >> ~/.tmux.conf

git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv
echo 'source ~/.autoenv/activate.sh' >> ~/.bashrc

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

#!/bin/bash
echo "Setting up folder structure in ~/.vim/"
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/bundle

echo "Installing autoload of pathogen.vim"
curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

echo "Installing bundle plugins"
if [ ! -d ~/.vim/bundle/ctrlp.vim ] ; then
	git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
fi

if [ ! -d ~/.vim/bundle/neocomplcache.vim ] ; then
	git clone https://github.com/Shougo/neocomplcache.vim ~/.vim/bundle/neocomplcache.vim
fi

if [ ! -d ~/.vim/bundle/vim-fugitive.vim ] ; then
	git clone git://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive.vim
fi

if [ ! -d ~/.vim/bundle/vim-airline.vim ] ; then
	git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline.vim
fi

if [ ! -d ~/.vim/bundle/vim-sensible ] ; then
	git clone git://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible
fi

VIMRC=~/.vimrc
if [ ! -h $VIMRC ] ; then
	if [  -e $VIMRC ] ; then
		BACKUP_FILE=~/.vimrc_backup_`date +%s`
		echo "Making backup of old $VIMRC to $BACKUP_FILE"
		mv $VIMRC $BACKUP_FILE
	fi
	echo "Symlinking ~/.vim/vimrc to $VIMRC"
	ln -s ~/.vim/vimrc $VIMRC
fi

echo "Done"

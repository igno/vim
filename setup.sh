#!/bin/bash
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/bundle
curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

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

VIMRC=~/.vimrc
if [ ! -h $VIMRC ] ; then
	echo "no link file"
	if [  -e $VIMRC ] ; then
		echo "found vimrc, backup"
		mv $VIMRC ~/.vimrc_backup_`date +%s`
	fi
	echo "do soft link"
	ln -s ~/.vim/vimrc $VIMRC
fi

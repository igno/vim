#!/bin/bash
set -e
VIM_DIR=~/.vim
SCRIPT_DIR=$(dirname $(readlink -f "$0"))

echo "Setting up folder structure in $VIM_DIR/"
mkdir -p $VIM_DIR/backup $VIM_DIR/undo $VIM_DIR/swp $VIM_DIR/autoload $VIM_DIR/bundle

echo "Installing autoload of pathogen.vim"
curl -LSso $VIM_DIR/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

echo -n "Installing bundle plugins... "
BUNDLE_PLUGINS="kien/ctrlp.vim tpope/vim-fugitive bling/vim-airline tpope/vim-sensible scrooloose/nerdtree fholgado/minibufexpl.vim dougireton/vim-chef editorconfig/editorconfig-vim fatih/vim-go scrooloose/syntastic mrk21/yaml-vim junegunn/vim-easy-align hashivim/vim-terraform neoclide/coc.nvim derekwyatt/vim-scala henrik/vim-indexed-search"

for PLUGIN in $BUNDLE_PLUGINS; do
	PLUGIN_NAME=`basename $PLUGIN`
	PLUGIN_DIR="$VIM_DIR/bundle/$PLUGIN_NAME"
	echo -n "$PLUGIN_NAME "
	if [ -d $PLUGIN_DIR ] ; then
		cd $PLUGIN_DIR && git pull &>/dev/null && cd - &>/dev/null
	else
		git clone https://github.com/${PLUGIN}.git $VIM_DIR/bundle/$PLUGIN_NAME
	fi
done
echo "done."

echo "Copying conf files under conf/"
cp -r $SCRIPT_DIR/conf/* $VIM_DIR/

VIMRC=~/.vimrc
if [ ! -h $VIMRC ] ; then
	if [  -e $VIMRC ] ; then
		BACKUP_FILE=~/.vimrc_backup_`date +%s`
		echo "Making backup of old $VIMRC to $BACKUP_FILE"
		mv $VIMRC $BACKUP_FILE
	fi
	VIMRC_SOURCE=$SCRIPT_DIR/vimrc
	echo "Symlinking $VIMRC to $VIMRC_SOURCE"
	ln -sf $VIMRC_SOURCE $VIMRC
fi

echo "all done \\o/"

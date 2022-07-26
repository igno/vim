#!/bin/bash
[[ "${TRACE}" ]] && set -x
set -eou pipefail
shopt -s nullglob

VIM_DIR=~/.vim
BUNDLE_DIR="${VIM_DIR}/bundle"
SCRIPT_DIR=$(dirname $(readlink -f "$0"))

echo "Setting up folder structure in $VIM_DIR/"
mkdir -p $VIM_DIR/backup $VIM_DIR/undo $VIM_DIR/swp $VIM_DIR/autoload $VIM_DIR/bundle

echo "Installing autoload of pathogen.vim"
curl -LSso $VIM_DIR/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

echo -n "Installing bundle plugins... "
BUNDLE_PLUGINS="ctrlpvim/ctrlp.vim tpope/vim-fugitive bling/vim-airline tpope/vim-sensible scrooloose/nerdtree bling/vim-bufferline editorconfig/editorconfig-vim fatih/vim-go dense-analysis/ale mrk21/yaml-vim junegunn/vim-easy-align hashivim/vim-terraform neoclide/coc.nvim derekwyatt/vim-scala henrik/vim-indexed-search joshdick/onedark.vim iamcco/markdown-preview.nvim"
for PLUGIN in $BUNDLE_PLUGINS; do
	PLUGIN_NAME=`basename $PLUGIN`
	PLUGIN_DIR="$BUNDLE_DIR/$PLUGIN_NAME"
	echo -n "$PLUGIN_NAME "
	if [ -d $PLUGIN_DIR ] ; then
		cd $PLUGIN_DIR && git pull &>/dev/null && cd - &>/dev/null
	else
		git clone https://github.com/${PLUGIN}.git $BUNDLE_DIR/$PLUGIN_NAME
	fi
done
echo "done."

echo "removing unused plugins"
for installed_plugin in $(ls -d $BUNDLE_DIR/*/); do
  found=0
  for plugin_to_install in $BUNDLE_PLUGINS; do
    if [[ "$(basename $installed_plugin)" == "$(basename $plugin_to_install)" ]]; then
      found=1
    fi
  done
  if [ $found -eq 0 ]; then
    old_plugins="${VIM_DIR}/old_plugins"
    if [ ! -d $old_plugins ]; then
      mkdir $old_plugins
    fi
    echo "  moving ${installed_plugin} to ${old_plugins}"
    mv "${installed_plugin}" "${old_plugins}/$(basename $installed_plugin)"
  fi
done

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

hash go &>/dev/null
if [[ $? == 0 ]]; then
  export GO111MODULE=on
  go get golang.org/x/tools/gopls@latest
else
  echo "To get coc integration working with golang, install go and rerun this script."
fi

echo "To initialize coc run ':call coc#util#install()' in vim."
echo "Install bash language server: 'sudo npm i -g bash-language-server'"
echo "all done \\o/"

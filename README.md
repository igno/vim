# My vim collection

This is my personal vim configuration. It basically just bundles a few plugins and configures them the way i prefer it.

Feel free to use it but be aware that It's tailored to my personal preferences.

## Installation
There is a convenince shell script `setup.sh` which will install everything under ~/.vim and ~/.vimrc

Make sure you have curl and git installed (and preferably vim) and run:

<pre><code>$ mv ~/.vim ~/.vim_backup_igno && git clone https://github.com/igno/vim ~/vim && ~/vim/setup.sh
</code></pre>

In order to initialize [coc](https://github.com/neoclide/coc.nvim/) open up vim and run:

<pre><code>:call coc#util#install()
</code></pre>

Extensions:
<pre><code>:CocInstall coc-python
:CocInstall coc-metals
:CocInstall coc-json
:CocInstall coc-yaml
</code></pre>

Language servers:
<pre><code>$ sudo npm i -g bash-language-server
$ GO111MODULE=on go get golang.org/x/tools/gopls@latest
</code></pre>

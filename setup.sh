#!/bin/bash
set -e

for file in $(find . -name '.*' | grep -v "^.$" | xargs basename)
do
    ln -fs $(pwd)/${file} ${HOME}/${file}
done
if [ ! -d ~/.vim/bundle ]
then
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    echo "run: vim -c ':NeoBundleInstall'"
fi

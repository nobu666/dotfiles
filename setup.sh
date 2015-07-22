#!/bin/bash
set -e

for file in $(find . -name '.*' | grep -v "^.$" | xargs basename)
do
    ln -fs $(pwd)/${file} ${HOME}/${file}
done
sudo cp p4merge /usr/local/bin/p4merge
sudo chmod +x /usr/local/bin/p4merge
if [ ! -d ~/.vim/bundle ]
then
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    echo "run: vim -c ':NeoBundleInstall'"
fi

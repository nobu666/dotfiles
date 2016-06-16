#!/bin/bash
set -e

for file in $(find . -name '.*' | grep -v "^.$" | xargs basename)
do
    ln -fs $(pwd)/${file} ${HOME}/${file}
done
if ! PATH=~/bin:$PATH type -P diff-highlight >/dev/null 2>&1; then
    (
    for d in /usr/local/share /usr/share; do
        if [[ -x $d/git-core/contrib/diff-highlight/diff-highlight ]]; then
            [[ -d ~/bin ]] || mkdir ~/bin
            ln -sfn "$d/git-core/contrib/diff-highlight/diff-highlight" ~/bin/
            exit
        fi
    done
    )
fi
sudo cp p4merge /usr/local/bin/p4merge
sudo chmod +x /usr/local/bin/p4merge
if [ ! -d ~/.vim/bundle ]
then
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    echo "run: vim -c ':NeoBundleInstall'"
fi

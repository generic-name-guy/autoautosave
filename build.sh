#!/bin/bash

name=autoautosave
git log --date=short --pretty=format:"-%d %ad %s%n" | \
    grep -v "^$" | \
    sed "s/HEAD -> master, //" | \
    sed "s/, origin\/master//" | \
    sed "s/ (HEAD -> master)//" | \
    sed "s/ (origin\/master)//"  |\
    sed "s/- (tag: \(v\?[0-9.]*\))/\n\1\n-/" \
    > changelog.txt \
&& \
rm -f $name.pk3 \
&& \
./gen-files.sh \
&& \
zip $name.pk3 \
    *.txt \
    *.md \
    sounds/*.ogg \
&& \
cp -f $name.pk3 $name-$(git describe --abbrev=0 --tags).pk3 \
&& \
gzdoom -glversion 3 \
       -file \
       $name.pk3 \
       ~/Programs/Games/wads/maps/DOOMTEST.wad \
       "$1" "$2" \
       +map test \
       -nomonsters

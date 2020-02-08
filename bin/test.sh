#!/bin/bash

FILES=/mnt/Learn/Info/programming/torrent/*
FOLDER=$(ls $FILES)
echo $FOLDER
for f in $FILES
do
    echo "$f"
done
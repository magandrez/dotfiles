#!/usr/bin/env bash
#
# Author: Manuel González <manuel@manuel.is> -  22.10.2024
#
# Requirements
#
# - ffmpeg
#
# Description
#
# FLAC mass converter from m4a into FLAC utilizing ffmpeg

for file in *.m4a; do
    echo "Converting $file to flac";
    ffmpeg -i "$file" -c:a flac "`basename "$file" .m4a`.flac";
done

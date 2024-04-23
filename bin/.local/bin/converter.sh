#!/bin/sh

for file in *.m4a; do
    echo "Converting $file to flac";
    ffmpeg -i "$file" -c:a flac "`basename "$file" .m4a`.flac";
done

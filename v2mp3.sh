#!/bin/bash

TEMP="/tmp/v2mp3.tmp"

if [ "$#" -ne 2 ]; then
  echo "Usage: v2mp3 [url] [name]";
  exit
fi

youtube-dl $1 -o "$TEMP"

avconv -i "$TEMP" -acodec libmp3lame "$2"

rm $TEMP

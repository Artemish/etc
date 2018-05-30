#!/bin/bash

getmusic() {
    if [ $# -ne 1 ]; then
        echo "Usage: getmusic <youtube_url>" 1>&2
        exit 1
    fi

    pushd ~/what
    youtube-dl -x "$1" -o '%(title)s.%(ext)s'
    popd
}

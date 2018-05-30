#!/usr/bin/env bash
DISPLAY=unix:0.0

delayed_message() {
    if [ $# -lt 2 ]; then
        echo "Usage: delayed_message [time] [message]" 1>&2
        exit 1
    fi

    sleep "$1" && notify-send "$2"
}

alias steep='delayed_message 240 "Steep levels at 100% and rising"'

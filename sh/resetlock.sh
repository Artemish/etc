#!/bin/bash

resetlock() {
    export LOCKER="i3lock -i /home/mitch/.config/i3/lock.png -c 000000"
    pkill xautolock; nohup xautolock -time 5 -locker "$LOCKER" &
}

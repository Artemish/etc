#!/bin/bash

nuke_chrome () {
  pkill chrome
  sleep 1
  rm -rf ~/.cache/chromium/Default/*
  sleep 1
  chrome
}

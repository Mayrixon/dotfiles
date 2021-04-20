#!/usr/bin/sh

PWD=$(pwd)
COMMON_FILES="./common-files"
INDI_FILES="./indi-files"

CONFIG="$HOME/.config"

NVIM="nvim"

if [ ! -d "NVIM_DIR" ]; then
    mkdir -p "$CONFIG/$NVIM"
fi

ln -sf "$PWD/$COMMON_FILES/$NVIM"/* "$CONFIG/$NVIM/"

cp -r "$PWD/$INDI_FILES/$NVIM/." "$CONFIG/$NVIM/"

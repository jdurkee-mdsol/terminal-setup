#!/bin/bash

BIN_DIR=$(dirname $0)

echo $BIN_DIR

BASE_DIR="${BIN_DIR}/.."

mkdir -p ~/.tmux

cp ${BASE_DIR}/tmux/tmux.conf ~/.tmux
cp ${BASE_DIR}/tmux/log-view ~/.tmux

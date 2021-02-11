#!/usr/bin/env bash

setup_dir="$(dirname $(readlink -f $0))"
cd $setup_dir

git_root=$(git rev-parse --show-toplevel)
cd $git_root

git pull

./setup.sh

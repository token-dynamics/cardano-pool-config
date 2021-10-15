#!/usr/bin/env bash

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

curl https://dl.haskellworks.io/binaries/libsodium/23.3.0/libsodium.tar.gz | tar zxvf - -C /usr

mkdir /usr/local/cardano-node-1.31.1

curl https://hydra.iohk.io/build/7739415/download/1/cardano-node-1.30.1-linux.tar.gz | tar zxvf - -C /usr/local/cardano-node-1.31.1

ln -sf /usr/local/cardano-node-1.31.1 /usr/local/cardano-node

ln -sf /usr/local/cardano-node/cardano-node /usr/local/bin/cardano-node
ln -sf /usr/local/cardano-node/cardano-cli  /usr/local/bin/cardano-cli

cardano-node version

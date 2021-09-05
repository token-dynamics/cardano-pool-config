#!/usr/bin/env bash

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

curl https://dl.haskellworks.io/binaries/libsodium/23.3.0/libsodium.tar.gz | tar zxvf - -C /usr

mkdir /usr/local/cardano-node-1.29.0

curl https://dl.haskellworks.io/binaries/cardano-node/cardano-node-1.29.0-linux.tar.gz | tar zxvf - -C /usr/local/cardano-node-1.29.0

ln -sf /usr/local/cardano-node-1.29.0 /usr/local/cardano-node

ln -sf /usr/local/cardano-node/cardano-node /usr/local/bin/cardano-node
ln -sf /usr/local/cardano-node/cardano-cli  /usr/local/bin/cardano-cli

cardano-node version

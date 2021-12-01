#!/usr/bin/env bash

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

node_version=1.31.0

curl https://dl.haskellworks.io/binaries/libsodium/23.3.0/libsodium.tar.gz | tar zxvf - -C /usr

mkdir -p /usr/local/cardano-node-${node_version}

curl https://hydra.iohk.io/build/8110920/download/1/cardano-node-${node_version}-linux.tar.gz | tar zxvf - -C /usr/local/cardano-node-${node_version}

rm -f /usr/local/cardano-node

ln -sf /usr/local/cardano-node-${node_version} /usr/local/cardano-node

ln -sf /usr/local/cardano-node/cardano-node /usr/local/bin/cardano-node
ln -sf /usr/local/cardano-node/cardano-cli  /usr/local/bin/cardano-cli

cardano-node version

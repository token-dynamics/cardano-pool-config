#!/usr/bin/env bash

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

docker pull quay.io/tokendynamics/docker-cardano-node
docker run --rm -v $tmpdir:/mnt/data -i quay.io/tokendynamics/docker-cardano-node sh << CMD
mkdir -p /mnt/data/usr/lib
mkdir -p /mnt/data/usr/include
mkdir -p /mnt/data/usr/local/bin
cp -P -R /usr/lib/libsodium* /mnt/data/usr/lib/
cp -P -R /usr/include/sodium* /mnt/data/usr/include/
cp /root/.local/bin/* /mnt/data/usr/local/bin/
CMD
cp -P -R $tmpdir/usr/* /usr/
rm -rf "$tmpdir"

docker rmi quay.io/tokendynamics/docker-cardano-node

cardano-node version

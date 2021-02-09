#!/usr/bin/env bash

export slotsPerKESPeriod=$(cat /opt/instance/config/mainnet-shelley-genesis.json | jq -r '.slotsPerKESPeriod')
echo "slotsPerKESPeriod: ${slotsPerKESPeriod}"

export slotNo=$(sudo docker run \
  -e CARDANO_NODE_SOCKET_PATH=/data/instance/db/socket \
  -v /data/instance/db/socket:/data/instance/db/socket \
  -ti \
  --entrypoint /bin/cardano-cli \
  inputoutput/cardano-node \
  query tip --mainnet | jq -r '.slotNo')
echo "slotNo: ${slotNo}"

kesPeriod=$((${slotNo} / ${slotsPerKESPeriod}))
echo "kesPeriod: ${kesPeriod}"

startKesPeriod=${kesPeriod}
echo "startKesPeriod: ${startKesPeriod}"

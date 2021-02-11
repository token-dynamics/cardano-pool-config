#!/usr/bin/env bash

export slotsPerKESPeriod=$(cat /opt/cardano-node/config/mainnet-shelley-genesis.json | jq -r '.slotsPerKESPeriod')
echo "slotsPerKESPeriod: ${slotsPerKESPeriod}"

export slotNo=$(CARDANO_NODE_SOCKET_PATH=/opt/cardano-node/socket cardano-cli query tip --mainnet | jq -r '.slotNo')
echo "slotNo: ${slotNo}"

kesPeriod=$((${slotNo} / ${slotsPerKESPeriod}))
echo "kesPeriod: ${kesPeriod}"

startKesPeriod=${kesPeriod}
echo "startKesPeriod: ${startKesPeriod}"

#!/usr/bin/env bash

slotsPerKESPeriod=$(cat /opt/instance/config/mainnet-shelley-genesis.json | jq -r '.slotsPerKESPeriod')
echo "slotsPerKESPeriod: ${slotsPerKESPeriod}"

slotNo=$(sudo docker run -ti --entrypoint /bin/cardano-cli inputoutput/cardano-node query tip --mainnet | jq -r '.slotNo')
echo "slotNo: ${slotNo}"

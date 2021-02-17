#!/bin/bash

source /opt/cardano-node/machine.env

curl -s -f \
  "https://api.clio.one/htopology/v1/fetch/?max=10&magic=764824073&customPeers=core.${WORKSPACE}.tokendynamics.net:3001" \
  | jq . > "/opt/cardano-node/config/relay-topology.json"

curl -s -f \
  "https://api.clio.one/htopology/v1/fetch/?max=10&magic=764824073&customPeers=relay.${WORKSPACE}.tokendynamics.net:3001" \
  | jq . > "/opt/cardano-node/config/core-topology.json"

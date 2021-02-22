#!/bin/bash

source /opt/cardano-node/machine.env

curl -s -f \
  "https://api.clio.one/htopology/v1/fetch/?max=20&magic=764824073&customPeers=core.${WORKSPACE}.tokendynamics.net:3001" \
  | jq . > "/opt/cardano-node/config/relay-topology.json"

cat > "/opt/cardano-node/config/core-topology.json" <<EOF
{
  "Producers": [
    {
      "addr": "relay.${WORKSPACE}.tokendynamics.net",
      "port": 3001,
      "valency": 1
    }
  ]
}
EOF

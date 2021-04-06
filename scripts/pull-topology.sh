#!/bin/bash

source /opt/cardano-node/machine.env

mkdir -p /opt/cardano-node/config/backup

if [ -f /opt/cardano-node/config/relay-topology.json ]; then
  backup="$(mktemp /opt/cardano-node/config/backup/relay-topology.json.XXXXXX)"
  echo "Backing up to $backup"
  cp /opt/cardano-node/config/relay-topology.json "$backup"
fi

if [ -f /opt/cardano-node/config/core-topology.json ]; then
  backup="$(mktemp /opt/cardano-node/config/backup/core-topology.json.XXXXXX)"
  echo "Backing up to $backup"
  cp /opt/cardano-node/config/core-topology.json "$backup"
fi

echo "Generating /opt/cardano-node/config/relay-topology.json"

curl -s -f \
  "https://api.clio.one/htopology/v1/fetch/?max=20&magic=764824073&customPeers=core.${WORKSPACE}.tokendynamics.net:3001" \
  | jq . > "/opt/cardano-node/config/relay-topology.json"

echo "Generating /opt/cardano-node/config/core-topology.json"

cat > "/opt/cardano-node/config/core-topology.json" <<EOF
{
  "Producers": [
    {
      "addr": "relay.${WORKSPACE}.tokendynamics.net",
      "port": 3001,
      "valency": 1
    },
    {
      "addr": "relay-1.${WORKSPACE}.tokendynamics.net",
      "port": 3001,
      "valency": 1
    },
    {
      "addr": "relay-2.${WORKSPACE}.tokendynamics.net",
      "port": 3001,
      "valency": 1
    }
  ]
}
EOF

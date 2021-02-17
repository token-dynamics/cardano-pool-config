#!/bin/bash
# shellcheck disable=SC2086,SC2034
 
USERNAME=$(whoami)
NODE_CONFIG=mainnet
CNODE_PORT=3001
CNODE_HOSTNAME="relay.ace.tokendynamics.net"  # optional. must resolve to the IP you are requesting from
CNODE_BIN="/usr/local/bin"
CNODE_HOME="/opt/cardano-node"
CNODE_LOG_DIR="/opt/cardano-node/logs"
GENESIS_JSON="/opt/cardano-node/config/${NODE_CONFIG}-shelley-genesis.json"
NETWORKID=$(jq -r .networkId $GENESIS_JSON)
CNODE_VALENCY=1   # optional for multi-IP hostnames
NWMAGIC=$(jq -r .networkMagic < $GENESIS_JSON)
[[ "${NETWORKID}" = "Mainnet" ]] && HASH_IDENTIFIER="--mainnet" || HASH_IDENTIFIER="--testnet-magic ${NWMAGIC}"
[[ "${NWMAGIC}" = "764824073" ]] && NETWORK_IDENTIFIER="--mainnet" || NETWORK_IDENTIFIER="--testnet-magic ${NWMAGIC}"

export PATH="${CNODE_BIN}:${PATH}"
export CARDANO_NODE_SOCKET_PATH="/data/instance/db/socket"

blockNo=$(/usr/local/bin/cardano-cli query tip ${NETWORK_IDENTIFIER} | jq -r .blockNo )
 
# Note:
# if you run your node in IPv4/IPv6 dual stack network configuration and want announced the
# IPv4 address only please add the -4 parameter to the curl command below  (curl -4 -s ...)
if [ "${CNODE_HOSTNAME}" != "CHANGE ME" ]; then
  T_HOSTNAME="&hostname=${CNODE_HOSTNAME}"
else
  T_HOSTNAME=''
fi

if [ ! -d /opt/cardano-node/logs ]; then
  mkdir -p /opt/cardano-node/logs;
fi
 
curl -s "https://api.clio.one/htopology/v1/?port=${CNODE_PORT}&blockNo=${blockNo}&valency=${CNODE_VALENCY}&magic=${NWMAGIC}${T_HOSTNAME}" | tee -a /opt/cardano-node/logs/topologyUpdater_lastresult.json
EOF

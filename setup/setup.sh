#!/usr/bin/env bash

source /opt/cardano-node/machine.env

setup_dir="$(dirname $(readlink -f $0))"
env_dir="$(readlink -f $setup_dir/../env)"
config_dir="$(readlink -f $setup_dir/../config)"

case "$NODE_TYPE" in
  "relay") ;;
  "core") ;;
  *)
    echo "invalid node type ($NODE_TYPE), only 'relay' or 'core' are supported."
    exit 1 ;;
esac

log() {
  echo "$NODE_TYPE: $@"
}

log "Setup scripts are in: $setup_dir"
log "Config templates are in: $config_dir"

grep "source $env_dir/$NODE_TYPE.sh" /home/ubuntu/.bashrc ||
  echo "source $env_dir/$NODE_TYPE.sh" >> /home/ubuntu/.bashrc

log "Installing cardano-node"
sudo sh $setup_dir/install-cardano-node.sh

log "Testing cardano-node installation"
cardano-node version

NODE_CONFIG=mainnet

mkdir -p /data/cardano-node/db

cp -r $config_dir /opt/cardano-node/

cat <<EOF > /opt/cardano-node/cardano-node.env
CONFIG="/opt/cardano-node/config/mainnet-config.json"
TOPOLOGY="/opt/cardano-node/config/$NODE_TYPE-topology.json"
DBPATH="/data/instance/db"
SOCKETPATH="/opt/cardano-node/socket"
HOSTADDR="0.0.0.0"
PORT="3001"
KES=/opt/cardano-node/keys/kes.skey
VRF=/opt/cardano-node/keys/vrf.skey
CERT=/opt/cardano-node/keys/node.cert
EOF

log "Configuring systemd"
sudo cp $setup_dir/cardano-$NODE_TYPE.service /etc/systemd/system/cardano-node.service
sudo chmod 644 /etc/systemd/system/cardano-node.service
sudo systemctl daemon-reload

log "Starting relay server"
sudo systemctl enable cardano-node
sudo systemctl reload-or-restart cardano-node

log "Done."

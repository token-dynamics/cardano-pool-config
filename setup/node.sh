#!/usr/bin/env bash

apt-get install -y docker.io
apt-get install -y awscli

docker pull amazon/aws-cli
docker pull quay.io/tokendynamics/docker-cardano-node

# Download configs
docker run --rm \
  -v "/opt/instance:/opt/instance" \
  -i amazon/aws-cli \
  s3 sync \
  ${config_path}/ \
  /opt/instance/

NODE_CONFIG=mainnet

# Run the node
sudo docker run -ti \
  -v "/opt/instance:/opt/instance" \
  -e CARDANO_NODE_SOCKET_PATH="/opt/instance/db/socket" \
  -p 0.0.0.0:3001:3001 \
  -i inputoutput/cardano-node \
  run \
  --topology "/opt/instance/config/core-topology.json" \
  --database-path /opt/instance/db \
  --socket-path /opt/instance/db/socket \
  --host-addr 0.0.0.0 \
  --port 3001 \
  --config "/opt/instance/config/mainnet-config.json"

#!/usr/bin/env bash

apt-get install -y docker.io
apt-get install -y awscli

docker pull amazon/aws-cli
docker pull quay.io/tokendynamics/docker-cardano-node

# Download configs
docker run --rm \
  -v "/opt/instances:/opt/instances" \
  -i amazon/aws-cli \
  s3 sync \
  ${config_path}/ \
  /opt/instances/

# Run the node
docker run -d \
  -v "/opt/instances:/opt/instances" \
  -i quay.io/tokendynamics/docker-cardano-node \
  cardano-node version

#!/usr/bin/env bash

/usr/local/bin/cardano-node run \
  --config $CONFIG \
  --topology $TOPOLOGY \
  --database-path $DBPATH \
  --socket-path $SOCKETPATH \
  --host-addr $HOSTADDR \
  --port $PORT \
  $(if [ -f "$KES" ]; then echo "--shelley-kes-key $KES"; fi) \
  $(if [ -f "$VRF" ]; then echo "--shelley-vrf-key $VRF"; fi) \
  $(if [ -f "$CERT" ]; then echo "--shelley-operational-certificate $CERT"; fi)

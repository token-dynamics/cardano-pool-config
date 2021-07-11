#!/usr/bin/env bash

MYPOOLID=$(cat /opt/cardano-node/keys/stake-pool-id)

echo "LeaderLog - POOLID $MYPOOLID"

SNAPSHOT=$(/usr/local/bin/cardano-cli query stake-snapshot --stake-pool-id $MYPOOLID --mainnet)
echo "SNAPSHOT: $SNAPSHOT"
POOL_STAKE=$(jq .poolStakeMark <<< $SNAPSHOT)
ACTIVE_STAKE=$(jq .activeStakeMark <<< $SNAPSHOT)
MYPOOL=$(
  /usr/local/bin/cncli leaderlog \
    --pool-id $MYPOOLID \
    --pool-vrf-skey /opt/cardano-node/keys/vrf.skey \
    --byron-genesis /opt/cardano-node/config/mainnet-byron-genesis.json \
    --shelley-genesis /opt/cardano-node/config/mainnet-shelley-genesis.json \
    --pool-stake $POOL_STAKE \
    --active-stake $ACTIVE_STAKE \
    --ledger-set $EPOCH)

EPOCH=`jq .epoch <<< $MYPOOL`
echo "\`Epoch $EPOCH\` 🧙🔮:"

SLOTS=`jq .epochSlots <<< $MYPOOL`
IDEAL=`jq .epochSlotsIdeal <<< $MYPOOL`
PERFORMANCE=`jq .maxPerformance <<< $MYPOOL`
echo "\`MYPOOL - $SLOTS \`🎰\`,  $PERFORMANCE% \`🍀max, \`$IDEAL\` 🧱ideal"

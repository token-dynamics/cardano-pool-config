#!/usr/bin/env bash
set -e

source /opt/cardano-node/cardano-node.env

AWS_REGION=`curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region`

for metric in $(curl -s -H 'Accept: application/json' "http://localhost:12788/"  | jq -rc --arg POOL_NAME "$POOL_NAME" --arg NODE_TYPE "$NODE_TYPE" '.
  | [leaf_paths as $path
  | {"key": $path
  | join("."), "value": getpath($path)}
  | select(.key | endswith(".val"))
  | select(.value | type=="number")
  | { MetricName: .key | sub("^cardano.node.metrics."; "") | sub(".val$"; ""),
      Value: .value,
      Dimensions: [
        { "Name": "poolName", "Value": $POOL_NAME },
        { "Name": "nodeType", "Value": $NODE_TYPE }
      ]
    }]
  | _nwise(19)'); do
    aws cloudwatch put-metric-data --region "$AWS_REGION" --namespace "CARDANO/POOL" --metric-data "$metric"
done

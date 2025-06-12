#!/bin/bash

case "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_GNOSIS" in
"gnosis-beacon-chain-prysm.dnp.dappnode.eth")
    echo "Using gnosis-beacon-chain-prysm.dnp.dappnode.eth"
    JWT_PATH="/security/prysm/jwtsecret.hex"
    ;;
"lighthouse-gnosis.dnp.dappnode.eth")
    echo "Using lighthouse-gnosis.dnp.dappnode.eth"
    JWT_PATH="/security/lighthouse/jwtsecret.hex"
    ;;
"nimbus-gnosis.dnp.dappnode.eth")
    echo "Using nimbus-gnosis.dnp.dappnode.eth"
    JWT_PATH="/security/nimbus/jwtsecret.hex"
    ;;
"teku-gnosis.dnp.dappnode.eth")
    echo "Using teku-gnosis.dnp.dappnode.eth"
    JWT_PATH="/security/teku/jwtsecret.hex"
    ;;
"lodestar-gnosis.dnp.dappnode.eth")
    echo "Using lodestar-gnosis.dnp.dappnode.eth"
    JWT_PATH="/security/lodestar/jwtsecret.hex"
    ;;
*)
    echo "Using default"
    JWT_PATH="/security/default/jwtsecret.hex"
    ;;
esac

# Print the jwt to the dappmanager
JWT=$(cat $JWT_PATH)
curl -X POST "http://my.dappnode/data-send?key=jwt&data=${JWT}"

DATADIR="/data"
PORT="${P2P_PORT:=30303}"

exec reth node \
    --chain gnosis \
    --metrics 0.0.0.0:6060 \
    --datadir "${DATA_DIR}" \
    --addr 0.0.0.0 \
    --port "${P2P_PORT}" \
    --http \
    --http.addr 0.0.0.0 \
    --http.port 8545 \
    --http.corsdomain "*" \
    --ws \
    --ws.addr 0.0.0.0 \
    --ws.port 8546 \
    --ws.origins "*" \
    --authrpc.addr 0.0.0.0 \
    --authrpc.port 8551 \
    --authrpc.jwtsecret=${JWT_PATH}
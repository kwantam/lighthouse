#!/bin/bash

KDP_OFFSET=$1
VALIDATOR_NUM=$2
if [ -z "$KDP_OFFSET" ]; then
    echo ERROR KDP_OFFSET required
    echo "Usage: $0 <KDP_OFFSET> <VALIDATOR_NUM>"
    exit
fi
if [ -z "$VALIDATOR_NUM" ]; then
    echo ERROR VALIDATOR_NUM required
    echo "Usage: $0 <KDP_OFFSET> <VALIDATOR_NUM>"
    exit
fi

MNEMONIC_INFO="$(./1_mnemonic_validator.sh $KDP_OFFSET $VALIDATOR_NUM)"
DEPOSIT_DATA="$(jq .data[0].eth1_deposit_tx_data <<< "$MNEMONIC_INFO")"
PUBKEY="$(jq .data[0].voting_pubkey <<< "$MNEMONIC_INFO")"
if [ "$PUBKEY" == "null" ] || [ "$DEPOSIT_DATA" == "null" ]; then
    echo ERROR did not get deposit back. Got:
    jq . <<< $MNEMONIC_INFO
    exit
fi
echo "New mnemonic generated:"
jq . <<< $MNEMONIC_INFO

CALL_RESULT="$(./2_beacon_call.sh "$DEPOSIT_DATA")"
ERR="$(jq .error <<< "$CALL_RESULT")"
if [ "$ERR" != "null" ]; then
    echo ERROR sending deposit txn:
    jq . <<< "$CALL_RESULT"
    exit
fi
echo "Sent deposit transaction:"
jq . <<< $CALL_RESULT

while /bin/true; do
    DEP_CACHE="$(curl -s http://localhost:8001/lighthouse/eth1/deposit_cache)"
    if grep -q "$PUBKEY" <(jq '.data[].deposit_data.pubkey' <<< "$DEP_CACHE"); then
        echo Success! Beacon node reports deposit:
        jq . <<< "$DEP_CACHE"
        break
    else
        echo Deposit not yet seen
    fi
    sleep 1
done

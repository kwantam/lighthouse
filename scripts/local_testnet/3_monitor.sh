#!/bin/bash

while true; do
    date
    echo -n "BLOCK NUMBER: "
    curl -s -X POST --data '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest",false],"id":1}' http://localhost:8545 | jq .result.number | perl -e '$_ = <STDIN>; $_ =~ s/"//g; print hex($_), "\n";'
    curl -s http://localhost:8001/lighthouse/eth1/deposit_cache | jq
    sleep 10
done

#!/bin/bash

DATA="$1"
if [ -z "$DATA" ]; then
    echo ERROR no depositdata provided
    exit
fi

curl -s -X POST \
    --header "Content-type: application/json" \
    --header "Accept: application/json" \
    --data '{
    "jsonrpc": "2.0",
    "method": "eth_sendTransaction",
    "params": [ {
        "from": "0x891688f60750cff39f55401b7ca632a1e79426a5",
        "to": "0x8c594691c0e592ffa21f153a16ae41db5befcaaa",
        "gas": "0x50000",
        "gasPrice": "0x9184e72a000",
        "value": "0x1bc16d674ec800000",
        "data": '$DATA'
    } ]
}' http://localhost:8545

#!/bin/bash

KDP_OFFSET=$1
VNUM=$2
PORT=$((7000 + $2))
if [ -z "$KDP_OFFSET" ]; then
    echo ERROR KDP_OFFSET required
    exit
fi
if [ -z "$PORT" ]; then
    echo ERROR PORT required
    exit
fi
BEARER_TOKEN=$(cat /home/kwantam/.lighthouse/local-testnet/node_${VNUM}/validators/api-token.txt)

curl -s -X POST \
	--header "Authorization: Bearer $BEARER_TOKEN" \
    --header "Content-type: application/json" \
    --header "Accept: application/json" \
    --data '{
    "mnemonic": "theme onion deal plastic claim silver fancy youth lock ordinary hotel elegant balance ridge web skill burger survey demand distance legal fish salad cloth",
    "key_derivation_path_offset": '$KDP_OFFSET',
    "validators": [
        {
            "enable": true,
            "description": "validator_one",
            "deposit_gwei": "32000000000"
        }
    ]
}' http://localhost:${PORT}/lighthouse/validators/mnemonic

# {"data":[{"enabled":true,"description":"validator_one","voting_pubkey":"0xa062f95fee747144d5e511940624bc6546509eeaeae9383257a9c43e7ddc58c17c2bab4ae62053122184c381b90db380","eth1_deposit_tx_data":"0x22895118000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000001206cb082314682ed0de5cc609b750f8d315ade7dbc07f594cda6550297375eae690000000000000000000000000000000000000000000000000000000000000030a062f95fee747144d5e511940624bc6546509eeaeae9383257a9c43e7ddc58c17c2bab4ae62053122184c381b90db3800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200046e4199f18102b5d4e8842d0eeafaa1268ee2c21340c63f9c2cd5b03ff19320000000000000000000000000000000000000000000000000000000000000060b20e7727a5aa6a2709523539de529b7664f848021cda8b49a92f0b2d25f60738fc3e28de88178e0d57d38eb920bded7918624772350568aa4c57416ea6c62b54e24d6798fbea10bb036f97c9b69dd68c47075df93ad0e90d2611b828d4c581b8","deposit_gwei":"32000000000"}]}
# {"data":[{"enabled":true,"description":"validator_one","voting_pubkey":"0xac19684158a5c2caa02a10ec32b148f6411e69872bd3567843b294271d078aca423f8da1da256935df634f052c5ba730","eth1_deposit_tx_data":"0x22895118000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000e00000000000000000000000000000000000000000000000000000000000000120671d4d179808f3cdc48f405a4be664b2d5c7c04aa664af40ac17fde419eafe680000000000000000000000000000000000000000000000000000000000000030ac19684158a5c2caa02a10ec32b148f6411e69872bd3567843b294271d078aca423f8da1da256935df634f052c5ba73000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000485bbc2c2367cb6102bf45d1ea533876593c16abc9fc2bcd92319a0595b53800000000000000000000000000000000000000000000000000000000000000608d100c7eb8bb9bc5b19c4dced2167a34a342dc5ec71db3a4fb2d7f33a78d1fd61a9d219b5af6d20b05a4246df34e80530318c99c7badcb5b4526f0b8a857d8e708abefe7db2b713d4bdd0115a2ee7442ebe7aa869bbdb81ef16b20bc26f76186","deposit_gwei":"32000000000"}]}

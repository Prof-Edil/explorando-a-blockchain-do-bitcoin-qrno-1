# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

# set -eux

TXID=37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517
RAW_TRANSACTION=$(bitcoin-cli getrawtransaction "$TXID")
TRANSACTION=$(bitcoin-cli decoderawtransaction "$RAW_TRANSACTION")

PK_0=$(echo "$TRANSACTION" | jq -r ".vin[0].txinwitness[1]")
PK_1=$(echo "$TRANSACTION" | jq -r ".vin[1].txinwitness[1]")
PK_2=$(echo "$TRANSACTION" | jq -r ".vin[2].txinwitness[1]")
PK_3=$(echo "$TRANSACTION" | jq -r ".vin[3].txinwitness[1]")

MULTISIG=$(bitcoin-cli createmultisig 1 "[\"$PK_0\", \"$PK_1\", \"$PK_2\", \"$PK_3\"]")
echo "$MULTISIG" | jq -r ".address"

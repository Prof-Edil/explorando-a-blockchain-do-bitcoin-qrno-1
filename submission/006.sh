# Which tx in block 257,343 spends the coinbase output of block 256,128?

# set -eux

FROM_IDX=256128
FROM_BH=$(bitcoin-cli getblockhash "$FROM_IDX")
FROM=$(bitcoin-cli getblock "$FROM_BH")
COINBASE_TXID=$(echo "$FROM" | jq -r ".tx[0]")

TO_IDX=257343
TO_BH=$(bitcoin-cli getblockhash "$TO_IDX")
TO=$(bitcoin-cli getblock "$TO_BH" 2)
NTX=$(echo "$TO" | jq ".nTx")

for idx in $(seq 0 $((NTX-1)))
do
  TXID=$(echo "$TO" | jq -r ".tx[$idx].txid")
  TX_VIN=$(echo "$TO" | jq -r ".tx[$idx].vin[].txid")
  for vin in $TX_VIN
  do
    if [[ "$vin" = "$COINBASE_TXID" ]]
    then
      echo "$TXID"
    fi
  done
done

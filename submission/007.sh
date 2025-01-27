# Only one single output remains unspent from block 123,321. What address was it sent to?

# set -eux

IDX=123321
BH=$(bitcoin-cli getblockhash "$IDX")
BLOCK=$(bitcoin-cli getblock "$BH" 2)

TX=$(echo "$BLOCK" | jq -r ".tx")
NTX=$(echo "$BLOCK" | jq -r ".nTx")

for idx in $(seq 0 $((NTX-1)))
do
  TXID=$(echo "$TX" | jq -r ".[$idx].txid")
  VOUT=$(echo "$TX" | jq -r ".[$idx].vout")
  LEN=$(echo "$VOUT" | jq -r "length")
  for out_idx in $(seq 0 $((LEN-1)))
  do
    TXOUT=$(bitcoin-cli gettxout "$TXID" "$out_idx")
    # This seems to be ok, it just doesn't print anything when it goes wrong
    echo "$TXOUT" | jq -r ".scriptPubKey.address"
  done
done

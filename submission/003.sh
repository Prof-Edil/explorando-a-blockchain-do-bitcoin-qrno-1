# How many new outputs were created by block 123,456?

HASH=$(bitcoin-cli getblockhash 123456)
BLOCK=$(bitcoin-cli getblock "$HASH" 2)
echo "$BLOCK" | jq ".tx | map(.vout) | map(length) | add"

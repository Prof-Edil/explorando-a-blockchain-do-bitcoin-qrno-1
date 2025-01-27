# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`

# set -eux

XPUB="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"
INDEX=100
DESCRIPTOR=$(bitcoin-cli getdescriptorinfo "tr($XPUB/0/$INDEX)" | jq -r ".descriptor")
ADDRESS=$(bitcoin-cli deriveaddresses "$DESCRIPTOR" | jq -r '.[0]')

echo "$ADDRESS"

# echo XPUB "$XPUB"
# echo INDEX "$INDEX"
# echo DESCRIPTOR "$DESCRIPTOR"
# echo ADDRESS "$ADDRESS"

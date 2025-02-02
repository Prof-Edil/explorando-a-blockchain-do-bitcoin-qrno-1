# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

# set -eux

TXID="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
TRANSACTION=$(bitcoin-cli getrawtransaction "$TXID" 1)
SCRIPT=$(echo "$TRANSACTION" | jq -r ".vin[0].txinwitness[2]")
KEY=$(echo "$SCRIPT" | cut -c 5-70)
echo "$KEY"

# Solution Notes:
# Checked on https://mempool.space/tx/e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163

# P2WSH witness script:
# OP_IF
# OP_PUSHBYTES_33 025d524ac7ec6501d018d322334f142c7c11aa24b9cffec03161eca35a1e32a71f
# OP_ELSE
# OP_PUSHBYTES_2 9000
# OP_CSV
# OP_DROP
# OP_PUSHBYTES_33 02ad92d02b7061f520ebb60e932f9743a43fee1db87d2feb1398bf037b3f119fc2
# OP_ENDIF
# OP_CHECKSIG

# Witness:
# 3044022050b45d29a3f2cf098ad0514dff940c78046c377a7e925ded074ad927363dc2dd02207c8a8ca7d099483cf3b50b00366ad2e2771805d6be900097c2c57bc58b4f34a501
# 01
# 6321025d524ac7ec6501d018d322334f142c7c11aa24b9cffec03161eca35a1e32a71f67029000b2752102ad92d02b7061f520ebb60e932f9743a43fee1db87d2feb1398bf037b3f119fc268ac

# Because of the 01, we take the first path on the OP_IF implying the first public key signed the input

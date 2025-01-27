# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

set -eux

TXID="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
TRANSACTION=$(bitcoin-cli getrawtransaction "$TXID" 1)

# What am I allowed to do in this solution?
# I supposed I'm not expected to decode the script itself
# Can I just cut the right part?

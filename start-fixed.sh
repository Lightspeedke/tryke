#!/bin/bash

# Use Railway's PORT environment variable or default to 8545
PORT=${PORT:-8545}

echo "🚀 Starting XYBERCHAIN with FORCED Chain ID"
echo "==========================================="
echo "Chain ID: 9194 (0x23EA)"
echo "Network ID: 9194"
echo "Port: $PORT"

# Remove old data completely
rm -rf ./data

# Initialize with correct genesis
echo "📦 Initializing blockchain with Chain ID 9194..."
geth --datadir ./data init genesis-correct.json

# Import account
echo "🔑 Importing account..."
echo "4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d" | geth --datadir ./data account import --password password.txt

# Start with explicit network and chain ID
echo "🚀 Starting Geth..."
exec geth --datadir ./data \
     --networkid 9194 \
     --http \
     --http.addr "0.0.0.0" \
     --http.port $PORT \
     --http.corsdomain "*" \
     --http.vhosts "*" \
     --http.api "eth,net,web3,personal,admin,miner,clique" \
     --ws \
     --ws.addr "0.0.0.0" \
     --ws.port $((PORT + 1)) \
     --ws.api "eth,net,web3,personal,admin,miner,clique" \
     --ws.origins "*" \
     --allow-insecure-unlock \
     --nodiscover \
     --mine \
     --miner.etherbase "0x6eF461F0cbBff97d3BdFd35076B28D5D30a6d513" \
     --unlock "0x6eF461F0cbBff97d3BdFd35076B28D5D30a6d513" \
     --password password.txt \
     --verbosity 3 \
     --syncmode "full" \
     --gcmode "archive"

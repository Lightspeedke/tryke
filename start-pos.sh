#!/bin/bash

echo "🚀 Starting XYBERCHAIN (PoS Compatible)"
echo "======================================"

# Clean start
pkill -f geth
rm -rf ./data
sleep 2

# Initialize blockchain
echo "📦 Initializing PoS blockchain..."
geth --datadir ./data init genesis-pos.json

# Import account
echo "🔑 Importing account..."
echo "4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d" > temp_key.txt
geth --datadir ./data account import --password password.txt temp_key.txt
rm temp_key.txt

# Start blockchain (PoS mode - no mining)
echo "🚀 Starting PoS blockchain..."
geth --datadir ./data \
     --networkid 9194 \
     --http \
     --http.addr "0.0.0.0" \
     --http.port 8545 \
     --http.corsdomain "*" \
     --http.vhosts "*" \
     --http.api "eth,net,web3,personal,admin" \
     --ws \
     --ws.addr "0.0.0.0" \
     --ws.port 8546 \
     --ws.api "eth,net,web3" \
     --ws.origins "*" \
     --nodiscover \
     --verbosity 3

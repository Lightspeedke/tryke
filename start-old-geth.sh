#!/bin/bash

echo "🚀 Starting XYBERCHAIN (Old Geth)"
echo "================================="

# Clean start
pkill -f geth
rm -rf ./data
sleep 2

# Initialize blockchain
echo "📦 Initializing blockchain..."
./geth-old --datadir ./data init genesis.json

# Import account
echo "🔑 Importing account..."
echo "4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d" > temp_key.txt
./geth-old --datadir ./data account import --password password.txt temp_key.txt
rm temp_key.txt

# Start blockchain
echo "🚀 Starting blockchain..."
./geth-old --datadir ./data \
     --networkid 9194 \
     --http \
     --http.addr "0.0.0.0" \
     --http.port 8545 \
     --http.corsdomain "*" \
     --http.vhosts "*" \
     --http.api "eth,net,web3,personal,admin,miner" \
     --allow-insecure-unlock \
     --nodiscover \
     --mine \
     --miner.etherbase "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1" \
     --unlock "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1" \
     --password password.txt \
     --verbosity 3

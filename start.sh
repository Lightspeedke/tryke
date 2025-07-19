#!/bin/bash

echo "🚀 Starting XYBERCHAIN"
echo "====================="

# Clean start
rm -rf ./data

# Initialize blockchain
echo "📦 Initializing blockchain..."
geth --datadir ./data init genesis.json

# Create private key file for import
echo "4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d" > private_key.txt

# Import account
echo "🔑 Importing account..."
geth --datadir ./data account import --password password.txt private_key.txt

# Clean up private key file
rm private_key.txt

# Start blockchain
echo "🚀 Starting blockchain..."
geth --datadir ./data \
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

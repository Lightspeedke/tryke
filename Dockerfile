FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PORT=8545

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Download and install Geth
RUN wget -q https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.13.15-c5ba367e.tar.gz \
    && tar -xzf geth-linux-amd64-1.13.15-c5ba367e.tar.gz \
    && mv geth-linux-amd64-1.13.15-c5ba367e/geth /usr/local/bin/ \
    && rm -rf geth-linux-amd64-1.13.15-c5ba367e* \
    && chmod +x /usr/local/bin/geth

# Copy configuration files
COPY genesis.json .
COPY password.txt .
COPY start.sh .

# Make start script executable
RUN chmod +x start.sh

# Initialize blockchain
RUN geth --datadir ./data init genesis.json

# Import the account
RUN echo "4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d" | geth --datadir ./data account import --password password.txt

# Create data directory with proper permissions
RUN mkdir -p ./data && chmod -R 755 ./data

# Expose the port
EXPOSE $PORT

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:$PORT || exit 1

# Start the blockchain
CMD ["./start.sh"]

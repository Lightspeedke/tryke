#!/bin/bash

case "$1" in
    start)
        echo "🚀 Starting XYBERCHAIN..."
        nohup ./start.sh > xyberchain.log 2>&1 &
        echo $! > xyberchain.pid
        echo "✅ Started with PID: $(cat xyberchain.pid)"
        ;;
    stop)
        echo "⏹️  Stopping XYBERCHAIN..."
        if [ -f xyberchain.pid ]; then
            kill $(cat xyberchain.pid) 2>/dev/null
            rm xyberchain.pid
            echo "✅ Stopped"
        else
            pkill -f geth
            echo "✅ Force stopped"
        fi
        ;;
    status)
        if [ -f xyberchain.pid ] && kill -0 $(cat xyberchain.pid) 2>/dev/null; then
            echo "✅ XYBERCHAIN is running (PID: $(cat xyberchain.pid))"
        elif pgrep -f geth > /dev/null; then
            echo "✅ XYBERCHAIN is running (found geth process)"
        else
            echo "❌ XYBERCHAIN is not running"
        fi
        ;;
    logs)
        if [ -f xyberchain.log ]; then
            tail -f xyberchain.log
        else
            echo "❌ No log file found"
        fi
        ;;
    test)
        echo "🧪 Testing XYBERCHAIN..."
        curl -X POST -H "Content-Type: application/json" \
          --data '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}' \
          http://localhost:8545
        ;;
    *)
        echo "Usage: $0 {start|stop|status|logs|test}"
        ;;
esac

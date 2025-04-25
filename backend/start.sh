#!/bin/bash
set -e

echo "Starting backend server..."

cd /home/ec2-user/backend

# Optional: kill previous Node server (use with caution in prod)
pkill node || true

# Start server in background
nohup node server.js > app.log 2>&1 &

echo "Server started."
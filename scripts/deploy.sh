#!/bin/bash

echo "Running deploy.sh"

cd /home/ec2-user/backend

# Kill existing Node.js server (if running)
pkill -f "node server.js" || true

# Install dependencies and restart backend
npm install

# Run the app (or use PM2 or systemd for production)
nohup node server.js > server.log 2>&1 &
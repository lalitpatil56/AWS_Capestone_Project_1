#!/bin/bash

# Extract the backend.zip file
echo "Extracting the application..."
unzip /tmp/backend/backend.zip -d /tmp/backend

# Navigate to the extracted directory
cd /tmp/backend

# Install dependencies and start the server
echo "Installing dependencies..."
npm install

echo "Starting the Node.js application..."
pm2 stop server.js || true # Stop any running instance
pm2 start server.js      # Start the server
#!/bin/bash

# Backend
echo "Deploying backend..."
cd /home/ec2-user/backend
npm install
pm2 stop all || true
pm2 start server.js --name backend

# Frontend is just static in /var/www/html
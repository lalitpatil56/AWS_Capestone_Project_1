#!/bin/bash

export NVM_DIR="/home/ec2-user/.nvm"
. "$NVM_DIR/nvm.sh"

cd /home/ec2-user/backend
npm install
pm2 start server.js --name backend-app
pm2 save
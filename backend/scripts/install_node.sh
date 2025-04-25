#!/bin/bash

export NVM_DIR="/home/ec2-user/.nvm"
. "$NVM_DIR/nvm.sh"

echo "Installing PM2 globally..."
npm install -g pm2
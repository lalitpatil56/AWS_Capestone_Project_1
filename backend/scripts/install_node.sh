#!/bin/bash
export NVM_DIR="/home/ec2-user/.nvm"

# Install NVM if not already present
if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Source nvm script
export NVM_DIR="/home/ec2-user/.nvm"
. "$NVM_DIR/nvm.sh"

# Install Node.js 16 (compatible with Amazon Linux 2)
nvm install 16
nvm use 16
nvm alias default 16

# Install pm2 globally
npm install -g pm2
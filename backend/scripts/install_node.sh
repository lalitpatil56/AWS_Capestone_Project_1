#!/bin/bash

echo "Installing NVM and Node.js..."

# Install dependencies
sudo yum install -y gcc-c++ make

# Install NVM
export NVM_DIR="/home/ec2-user/.nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load NVM into current shell
export NVM_DIR="/home/ec2-user/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js 16 and set it as default
nvm install 16
nvm use 16
nvm alias default 16

# Verify
echo "Verifying Node.js and npm installation..."
node -v
npm -v
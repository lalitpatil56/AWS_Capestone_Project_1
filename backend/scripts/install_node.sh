#!/bin/bash

echo "Installing Node.js 16 from Amazon Linux Extras..."
sudo yum clean all
sudo yum update -y
sudo amazon-linux-extras enable nodejs16
sudo yum install -y nodejs

# Refresh shell path in non-interactive script
export PATH=$PATH:/usr/bin

echo "Verifying Node.js installation..."
which node
node -v
which npm
npm -v
#!/bin/bash
set -e

echo "Installing backend dependencies..."

# Update and install Node.js if not already present
sudo yum update -y
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs

# Move to app directory (make sure CodeDeploy puts files in correct location)
cd /home/ec2-user/backend

# Install node modules
npm install

echo "Install complete."
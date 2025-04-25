#!/bin/bash
echo "Installing Node.js 16 from Amazon Linux Extras..."
sudo yum clean all
sudo yum update -y
sudo amazon-linux-extras enable nodejs16
sudo yum install -y nodejs

echo "Verifying Node.js installation..."
node -v
npm -v
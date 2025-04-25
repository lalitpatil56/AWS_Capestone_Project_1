#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install Node.js 18 from NodeSource
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs

# Check version
node -v
npm -v
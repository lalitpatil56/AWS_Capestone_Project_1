#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras enable nodejs16
sudo yum install -y nodejs


# Check version
node -v
npm -v
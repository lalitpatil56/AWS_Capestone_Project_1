#!/bin/bash

echo "Running install script..."

# Install httpd if not already installed
if ! command -v httpd &> /dev/null; then
  echo "Installing Apache (httpd)..."
  sudo yum install -y httpd
  sudo systemctl enable httpd
fi

# Restart the web server
sudo systemctl restart httpd
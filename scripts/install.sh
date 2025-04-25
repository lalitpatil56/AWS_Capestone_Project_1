#!/bin/bash

echo "Running install script..."

# Install httpd if not installed
if ! command -v httpd &> /dev/null; then
  echo "Installing Apache (httpd)..."
  sudo yum install -y httpd
  sudo systemctl enable httpd
fi

# Get public IP
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# Write HTML file with IP address
echo "<h1>Deployment Test Successful 🚀</h1><p>EC2 Public IP: `$PUBLIC_IP`</p>" > /var/www/html/index.html

# Start/restart the web server
sudo systemctl restart httpd
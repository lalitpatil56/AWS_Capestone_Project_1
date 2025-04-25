#!/bin/bash
echo "Running install script..."
sudo systemctl restart httpd || sudo systemctl restart nginx
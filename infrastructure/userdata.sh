#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
echo "<h1>Hello from Auto Scaling Group EC2!</h1>" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
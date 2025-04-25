#!/bin/bash
cd /home/ec2-user/backend
nohup node server.js > app.log 2>&1 &